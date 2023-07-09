# VPC Network
resource "google_compute_network" "temp_vpc_network" {
	name = "temp-terraform-network"
	auto_create_subnetworks = true
}	


# A private Google cloud storage bucket with a retention policy

resource "google_storage_bucket" "private" {
	count = 1
	name = ""
	public_access_prevention = "enforced"  #This is what makes the bucket private.
	location = "US" 
	storage_class = "STANDARD"

uniform_bucket_level_access = true   #object access determined by bucket permissions.
  
retention_policy {
	retention_period = 2678400 # objects in the bucket can only be deleted or replaced once the age is greater than 31 days.
  }
}



# A user managed vertex AI Notebook
# All environments use JupyterLab 3 by default and have latest Nvidia GPU and Intel libraries and drivers installed. In Sandbox Notebooks API must be enabled first.

resource "google_notebooks_instance" "basic" {
 	name = ""
  	location = "us-central1-a"
  	machine_type = "e2-standard-2" # E2 for general purpose day-to-day computing at lower cost.
  vm_image {
    	project      = ""
    	image_family = "tf-ent-latest-cpu" # TensorFlow latest CPU.
  	}
}



 
# A BigQuery dataset (empty or with sample data) which includes a configured optimisation that could speed up queries

resource "google_bigquery_dataset" "temp_dataset" { 
  	dataset_id = "temp_dataset1"
	location = "US"
  	default_table_expiration_ms = 3600000  # 1 hour minimum value. Default lifetime of all tables in dataset
}
resource "google_bigquery_table" "temp_table_tf" {
	table_id = "temptablet1"
	dataset_id = "temp_dataset1"
	location = "US" 
	deletion_protection = "false" # allows deletion

  labels = {
    "priority" = "interactive"
# default_table_expiration_ms = 3600000  # 1 hour minimum value. Default lifetime of all tables in dataset
  }  
}
