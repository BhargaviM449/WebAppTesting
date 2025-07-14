#!/bin/bash

#variables
S3_BUCKET="your-s3-bucket-name"
SOURCE_DIR="/home/ec2-user/myfiles"
DEST_DIR="backup"  # Optional: subfolder in S3
LOG_FILE="/home/ec2-user/upload_to_s3.log"
AWS_PROFILE="default"  # Change if using named AWS CLI profiles
DATE=$(date)

# Sync files to S3
echo "${DATE} Starting sync..." >> "$LOG_FILE"
aws s3 sync "$SOURCE_DIR" "s3://${S3_BUCKET}/${DEST_DIR}" --profile "$AWS_PROFILE" >> "$LOG_FILE" 2>&1

DATE=$(date)
if [ $? -eq 0 ]; then
    echo "${DATE} Sync completed successfully." >> "$LOG_FILE"
else
    echo "${DATE} Sync failed." >> "$LOG_FILE"
fi

#need to setup schedule using crontab -e
#based on the schedule it will send files to s3 bucket
#crontab -e
#30 2 * * * /home/ec2-user/upload_to_s3.sh
#chmod +x upload_to_s3.sh
#./upload_to_s3.sh
