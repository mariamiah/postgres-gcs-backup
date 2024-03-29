### postgres-gcs-backup
This project aims to provide a simple way to perform a PostgreSQL server/db backup using pg_dump and to upload it to Google Cloud Storage. 

#### Contains
- kubernetes cronJob to execute the backup script at a given time
- Script with the necesary steps to backup database and upload to GCS

#### Steps
- The script creates a bucket in Google Cloud Storage to upload backups
- The script create Google cloud service account with credentials and access permisions for GCS (Storage Object Creator, Storage Object Viewer): https://cloud.google.com/kubernetes-engine/docs/tutorials/authenticating-to-cloud-platform
##### Run locally
- Add a settings.conf file to your root directory
- Populate te settings.conf file with details as illustrated in `settings.conf.sample` file
- Run `chmod +x backup.sh` to make the script executable
- Finally run `./backup.sh`
#### Run within Kubernetes
- Authenticate with GCS
- Using the gcloud CLI
If you are running the script locally, the easiest solution is to sign in to the google account associated with your Google Cloud Storage data:
- gcloud init --console-only
- More information on how to setup gsutil locally [here](https://cloud.google.com/storage/docs/gsutil_install).


