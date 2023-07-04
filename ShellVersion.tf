# main.tf

 

# Configure the Google Cloud provider
provider "google" {
  credentials = file("path/to/your/keyfile.json")
  project     = "playground-s-11-98574d2b"
  region      = "us-central1"
  zone        = "us-central1-c"
}

 

# Create a Google Cloud Storage bucket
resource "google_storage_bucket" "private_bucket" {
  name          = "my-private-bucket"
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

 

# Create a BigQuery dataset
resource "google_bigquery_dataset" "dataset" {
  dataset_id = "my_dataset"
  project    = "your-project-id"
}

 

# Create a BigQuery table with sample data
resource "google_bigquery_table" "table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "my_table"
  project    = "your-project-id"

 

  schema {
    # Define the table schema here
  }

 

  time_partitioning {
    type = "DAY"
  }

 

  range_partitioning {
    field     = "date"
    interval  = 1
  }
}

 

# Configure BigQuery query optimization
resource "google_bigquery_dataset_iam_policy" "policy" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  project    = "your-project-id"

 

  policy_data = <<EOF
{
  "bindings": [
    {
      "role": "roles/bigquery.jobUser",
      "members": [
        "serviceAccount:your-notebook-service-account@your-project-id.iam.gserviceaccount.com"
      ]
    }
  ]
}
EOF
}

 

# Create a Vertex AI Notebook instance
resource "google_notebooks_instance" "notebook_instance" {
  name         = "my-notebook-instance"
  location     = "us-central1-a"
  machine_type = "n1-standard-2"

 

  boot_disk {
    initialize_params {
      image = "projects/deeplearning-platform-release/global/images/pytorch-1-8-cu111-notebooks-ubuntu-18-04"
    }
  }

 

  metadata = {
    "proxy-mode" = "service_account"
  }

 

  service_account {
    email  = "your-notebook-service-account@your-project-id.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
