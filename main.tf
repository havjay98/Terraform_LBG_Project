# VPC Network
resource "google_compute_network" "temp_vpc_network" {
	name = "temp-terraform-network"
	auto_create_subnetworks = true
}	


# A private Google cloud storage bucket with a retention policy
resource "google_storage_bucket" "private" {
	name = "temp-terraform-bucket"
	public_access_prevention = "enforced"  #This is what makes the bucket private.
	location = "US" 
	storage_class = "STANDARD"
	uniform_bucket_level_access = true   #object access determined by bucket permissions.
  
retention_policy {
	retention_period = 2678400 # objects in the bucket can only be deleted or replaced once the age is greater than 31 days.
  }
}



# A BigQuery dataset (empty or with sample data) which includes a configured optimisation that could speed up queries

resource "google_bigquery_dataset" "dataset" { 
  	dataset_id = "temp-terraform-dataset1"
	location = "US"
  	default_table_expiration_ms = 3600000  # 1 hour minimum value. Default lifetime of all tables in dataset
labels = {
    env = "default"
  }
access {
	role = "OWNER"
	user_by_email = google_service_account.bqowner.email
  }
}

resource "google_bigquery_table" "table1" {
	dataset_id = "temp-terraform-dataset1"
	table_id = "temp-terraform-table1"
	deletion_protection = "false" # allows deletion
labels = {
    env = "default"
  }  
}





# A user managed vertex AI Notebook

resource "google_project_service" "notebooks" {
	provider           = google
	service            = "notebooks.googleapis.com"
	disable_on_destroy = false
}


resource "google_notebooks_instance" "basic_instance" {
	project      = ""
	name         = ""
	provider     = google
	location     = "us-central1-c"
	machine_type = "e2-medium"
	container_image = "gcr.io/deeplearning-platform-release/base-cpu:latest"

boot_disk_size_gb = 100
 
metadata = {
    "proxy-mode" = ""

vm_image {
	project      = ""
	image_family = "tf-ent-2-9-cu113-notebooks"
  }
	
depends_on = [
	 google_project_service.notebooks
 ]
}
