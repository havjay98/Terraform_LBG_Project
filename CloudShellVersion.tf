# main.tf

 

# Configure the Google Cloud provider
provider "google" {
 project     = ""
  region      = "us-central1"
  zone        = "us-central1-c"
}

 

# Create a Google Cloud Storage bucket
resource "google_storage_bucket" "private_bucket" {
  name          = ""
  location      = "us-central1"
  storage_class = "STANDARD"

 

  lifecycle_rule {
    condition {
      age = 30 # Retain objects for 30 days
    }
    action {
      type = "Delete"
    }
  }
}

