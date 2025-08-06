# Tableflow Project

This project contains Terraform scripts to provision and configure resources for a data pipeline using AWS and Confluent Cloud. The pipeline integrates Kafka topics, IAM roles, S3 storage, and Confluent Tableflow for managing data streams and schemas. **This project is designed for demonstration purposes and supports integration with Snowflake for downstream data processing.**

## Overview

The Terraform scripts in this project perform the following tasks:
- Create Kafka topics in Confluent Cloud.
- Configures multiple Datagen Source Connector to generate sample data for each of the topics.
- Set up an S3 bucket and IAM roles/policies for BYOB (Bring Your Own Bucket) integration with Confluent Tableflow.
- Provision Confluent Tableflow topics to surface that data in Iceberg table format in Snowflake.
- Manage API keys for Kafka and Tableflow access.

## Prerequisites

Before using these scripts, ensure you have:
1. **AWS Account**: Required for S3 bucket and IAM role creation.
2. Make sure you configure your aws account locally by running `aws configure`
3. **Confluent Cloud Account**: Required for Kafka, Tableflow, and connector provisioning.

## Required Variables

You need to define the following variables in a `variables.tf` file or provide them via environment variables or a `.tfvars` file. Refer to the sample-tfvars.txt for how to configure them. 
Please note that you can only configure 1 catalog per confluent cluster. 

- **Confluent Variables**:
  - `confluent_cloud_api_key`: Your Confluent Cloud API Key
  - `confluent_cloud_api_secret`: Your Confluent Cloud API Key
  - `environment_display_name`: What you want the name of your environment to be

- **Snowflake Variables**:
Please make a note of the following from your Snowflake open data catalog (Polaris). **Whatever is the name of the Default Base Location of your S3 bucket in Polaris must match the name of your s3 bucket in the `s3-bucket.tf` file**

  - `polaris_client_id`: Client ID for Snowflake Open Data Account
  - `polaris_client_secret`: Secret key for Snowflake Open Data Account
  - `snowflake_endpoint`: Endpoint for Tableflow to write to Snowflake Open Data Catalog
  - `snowflake_warehouse`: The name of your open data catalog
  - `snowflake_allowed_scope`: In the format of PRINCIPAL_ROLE:<my-principal-role>, the permission scope when writing to snowflake.

## Deployment Steps

1. Clone this repository and navigate to the project directory.
2. Define the required variables in a `variables.tf` file or a `.tfvars` file.
3. Run `terraform init` to initialize the Terraform project.
4. Run `terraform plan` to preview the changes.
5. Run `terraform apply` to provision the resources.

## Post deployment (terraform apply) steps
After running `terraform apply` you will need to edit your trust policy of the storage_aws_role created by terraform so that you can run Snowflake queries against it. 

## Outputs

After deployment, the following outputs will be available from std out:
- `kafka_api_key`: The Kafka API key.
- `kafka_api_secret`: The Kafka API secret (sensitive).
- `s3_access_role_arn`: The ARN of the S3 access role.
- `s3_bucket_name`: The name of the S3 bucket.

1. After `terraform apply`, take a look at the Terraform `Outputs` printed to std out. You can grab the `your_polaris_s3_config` and `your_s3_access_role_arn` from the Output to insert into step #2. You get the `snowflake-external-id` from you Polaris catalog in the `external ID` field.
2. Go to your snowflake, create a SQL Worksheet, and run: 
```sql
CREATE OR REPLACE EXTERNAL VOLUME iceberg_external_volume
   STORAGE_LOCATIONS =
      (
         (
            NAME = 'my-iceberg-external-volume'
            STORAGE_PROVIDER = 'S3'
            STORAGE_BASE_URL = '<your_polaris_s3_config>'
            STORAGE_AWS_ROLE_ARN = '<your_s3_access_role_arn>'
            STORAGE_AWS_EXTERNAL_ID = '<snowflake-external-id-from-polaris>'
         )
      );
 ```
Example: 
```sql
CREATE OR REPLACE EXTERNAL VOLUME iceberg_external_volume
   STORAGE_LOCATIONS =
      (
         (
            NAME = 'my-iceberg-external-volume'
            STORAGE_PROVIDER = 'S3'
            STORAGE_BASE_URL = 's3://my-bucket'
            STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::829250932323:role/my-tableflow-role-4220'
            STORAGE_AWS_EXTERNAL_ID = 'my-snowflake-extid'
         )
      );
```
3. Then in snowflake run:
```sql
DESC EXTERNAL VOLUME iceberg_external_volume;
SELECT SYSTEM$VERIFY_EXTERNAL_VOLUME('iceberg_external_volume');
```
4. Copy down the storage ARN e.g. ```sql 
STORAGE_AWS_IAM_USER_ARN: arn:aws:iam::996704095571:user/pdq31222-s
```
5. Go back to AWS UI and find the role created by terraform i.e. ```sql 
my-tableflow-role-4220
```
(You can find the above from your terraform output `s3_access_role_arn`)
6. Hit edit trust policy and add new statement 
```json
{
   "Sid": "",
   "Effect": "Allow",
   "Principal": {
      "AWS": "arn:aws:iam::996704095571:user/abc41000-s"
   },
   "Action": "sts:AssumeRole",
   "Condition": {
      "StringEquals": {
         "sts:ExternalId": "snowflake-xyz"
      }
   }
}
```
8. change the AWS ARN line to the `storage_aws_iam_user_arn` you copied in step 4 e.g. 
```json
{
   "Sid": "",
   "Effect": "Allow",
   "Principal": {
      "AWS": "arn:aws:iam::996704095571:user/pdq31222-s"
   },
   "Action": "sts:AssumeRole",
   "Condition": {
      "StringEquals": {
         "sts:ExternalId": "snowflake-xyz"
      }
   }
}
```
9. save the trust policy

## Notes

- Ensure that your AWS and Confluent credentials are properly configured before running the scripts.
- The `prevent_destroy` lifecycle rule is set to `false` for API keys to allow re-creation if needed.
- Review the `depends_on` blocks to understand resource dependencies and avoid circular dependencies.
- This project supports integration with AWS Glue or Snowflake for downstream data processing.

For more details, refer to the individual `.tf` files in the project.
