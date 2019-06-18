#!/bin/bash
# Shell script to backup PostgreSQL database
GCLOUD_DEV_PROJECT="$(gcloud config get-value project)"
CLOUDSQL_DEV_BUCKET="cloudsql-devbucket-$(whoami)"
# Utility functions
get_log_date () {
    date +[%Y-%m-%d\ %H:%M:%S]
}

echo "set up gcloud authentication "
gcloud auth activate-service-account --key-file=google-service-key.json
echo ".............................................................."
echo "Creating bucket to store the dump file"
gsutil ls -b gs://$CLOUDSQL_DEV_BUCKET || 
gsutil mb -c nearline -l eu \
     -p $GCLOUD_DEV_PROJECT gs://$CLOUDSQL_DEV_BUCKET
echo ".............................................................."
echo "create a sql dump file"
sudo PGPASSWORD=$DB_PASSWORD pg_dump -h $DB_HOST -U $username -d $CLOUDSQL_DB_NAME > /tmp/db-backup-`date +"%Y"`-`date +"%m"`-`date +"%d"`.sql;
# Copy to Google Cloud Storage
echo ".............................................................."
echo "Copy the backup file to the gcs bucket"
gsutil cp /tmp/db-*.sql gs://$CLOUDSQL_DEV_BUCKET/db-backups/;
# Clean
echo ".............................................................."
echo "Remove the temporary backup file"
sudo rm -rf /tmp/db-backup-*;
# FINISH
echo "$(get_log_date) Copying finished"