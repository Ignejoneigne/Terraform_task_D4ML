#!/bin/bash

while true; do
  if aws s3 sync "/opt" "s3://${S3_BUCKET_NAME}/" --delete; then
    echo "Backup completed successfully at $(date)"
  else
    echo "Backup failed at $(date)"
  fi
  sleep 60
done
