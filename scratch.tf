# A private Google cloud storage bucket with a retention policy

resource "google_storage_bucket" "private" {
 name          = ""
 location      = "US"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true   #object access determined by bucket permissions.
  
retention_policy {
  retention_period = 3000000 # objects in the bucket can only be deleted or replaced once the age is greater than 3000000 seconds.
  }
}

  
Take 2
# A private Google cloud storage bucket with a retention policy

resource "google_storage_bucket" "bucket" {
count         = 1 
name          = ""
 location      = "europe-west2"
 storage_class = "REGIONAL"

 uniform_bucket_level_access = true   #object access determined by bucket permissions.
  
retention_policy {
  retention_period = 3000000 # objects in the bucket can only be deleted or replaced once the age is greater than 3000000 seconds.
  }
}

  
