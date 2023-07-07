terraform {
  required_providers {
  google = {   
  source = "hashicorp/google"
    version = "~> 4.60.0"
    }
  }
}

provider "google" {
  project = ""
  region = "europe-west2-a"
  credentials = "${file("filename.json")}"
}
