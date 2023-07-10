provider "google" {
  project = ""
  region = "europe-west2-a"
  credentials = "${file("project-filename.json")}"
}
