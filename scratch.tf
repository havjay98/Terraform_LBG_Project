# A private Google cloud storage bucket with a retention policy

resource "google_storage_bucket" "private" {
	count = 1
	name = ""
	public_access_prevention = "enforced"  #This is what makes the bucket private.
	location = "US" 
	storage_class = "STANDARD"

uniform_bucket_level_access = true   #object access determined by bucket permissions.
  
retention_policy {
	retention_period = 3000000 # objects in the bucket can only be deleted or replaced once the age is greater than 3000000 seconds.
  }
}




# A user managed vertex AI Notebook
# All environments use JupyterLab 3 by default and have latest Nvidia GPU and Intel libraries and drivers installed.

resource "google_notebooks_instance" "basic" {
 	name = ""
  	region = "us-central1"
	zone = "us-central1-a"
  	machine_type = "e2-medium"
  vm_image {
    	project      = ""
    	image_family = "tf-latest-cpu"
  	}
}


 
