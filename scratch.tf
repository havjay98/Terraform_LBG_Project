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


 
