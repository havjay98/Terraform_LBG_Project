#required terraform version
terraform {
    required_version = ">=0.13"
}


 
#provider block
provider "google" {
 credentials = "${file("./key.json")}"  #currently no available key
 project = "sichuwayproject"
 region = "europe-west2"
 zone = "europe-west2a"
  }




#private google storage bucket with a retention policy
resource "google_storage_bucket" "private" {
 name = "jamestf_bucket"
 public_access_prevention = "enforced"  #privatize
 location = "EU" 
 storage_class = "STANDARD"
 uniform_bucket_level_access = true   #object access determined by bucket permissions.
  
 retention_policy {
  retention_period = 30 # can delete after 30 seconds
  }
}



# bigquery dataset with sample data which optimises query performance
resource "google_bigquery_dataset" "tf_ds" { 
 dataset_id = "tfds1"
 location = "EU"
 }


resource "google_bigquery_table" "series_empty" {           #empty table with partitioning
 table_id = "series_empty"	
 dataset_id = google_bigquery_dataset.tf_ds.dataset_id
 deletion_protection = "false" # allows deletion

time_partitioning {
    type = "DAY" #partition the updates 
    field = "timestamp"
expiration_ms = 100
  }

labels = {
    env = "default"
  }

    schema = <<EOF
      [
        {
            "name":"seriesid",
            "type": "INTEGER",
            "mode": "NULLABLE",
            "description": "ID number for the show"
        },
         {
            "name":"title",
            "type": "STRING",
            "mode": "NULLABLE",
            "description": "title of the series"
        },
         {
            "name":"genre",
            "type": "STRING",
            "mode": "NULLABLE",
            "description": "genre of the series"
        },
         {
            "name":"timestamp",
            "type": "TIMESTAMP",
            "mode": "NULLABLE",
            "description": "the timestamp"
        }

 

      ]
      EOF

}

resource "google_bigquery_table" "tf_tb" {           #table with sample data
 table_id = "tftb1"	
 dataset_id = google_bigquery_dataset.tf_ds.dataset_id
 deletion_protection = "false" # allows deletion
 
labels = {
    env = "default"
  }

schema = file("schema.json") 

external_data_configuration {   
    autodetect    = true
    source_format = "GOOGLE_SHEETS" 
google_sheets_options {
    skip_leading_rows = 1
}
    source_uris = [
      "https://docs.google.com/spreadsheets/d/1WM0X3pTZ58j5ZlxWflGldZHENBx9w52nRI1svr61p84/edit#gid=1121058407",
     ]
   }

}


#google notebook instance
resource "google_project_service" "notebooks" {
 provider           = google
 service            = "notebooks.googleapis.com"
 disable_on_destroy = false
}


resource "google_notebooks_instance" "basic_instance" {
 project      = "sichuwayproject"
 name         = "tfnotebook"
 provider     = google
 location     = "europe-west2-a"
 machine_type = "g1-small" # cheapest for demonstration purposes
	
 vm_image {
  project      = "deeplearning-platform-release"  # public project by google for deep learning special machine images
  image_family = "tf-ent-2-9-cu113-notebooks"
  }
	
 depends_on = [
	 google_project_service.notebooks
 ]
}
