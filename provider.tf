provider "google" {
  project = ""
  region = "europe-west2-a"
  credentials = "${file("filename.json")}"
}
