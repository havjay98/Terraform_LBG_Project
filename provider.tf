terraform {
  required_providers {
  google = {   
  source = "hashicorp/google"
    version = "~> 1.5.2"
    }
  }
}

provider "google" {
  project = ""
  region = "EUROPE-WEST2"
  credentials = "${file("filename.json")}"
}
