resource "confluent_tableflow_topic" "customer_telephone_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  display_name = confluent_kafka_topic.customer_telephone_datagen.topic_name
  table_formats = ["ICEBERG"]

  // Use BYOB AWS storage
  byob_aws {
    bucket_name             = aws_s3_bucket.my_bucket.bucket
    provider_integration_id = confluent_provider_integration.main.id
  }

  credentials {
    key = confluent_api_key.my-tableflow-api-key.id
    secret = confluent_api_key.my-tableflow-api-key.secret
  }

  # Ensure the topic and schema are created first
  depends_on = [
    confluent_schema.avro-customer-telephone,
    aws_iam_role.s3_access_role
  ]
}

resource "confluent_tableflow_topic" "customer_addresses" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  display_name = confluent_kafka_topic.customer_addresses.topic_name
  table_formats = ["ICEBERG"]

  // Use BYOB AWS storage
  byob_aws {
    bucket_name             = aws_s3_bucket.my_bucket.bucket
    provider_integration_id = confluent_provider_integration.main.id
  }

  credentials {
    key = confluent_api_key.my-tableflow-api-key.id
    secret = confluent_api_key.my-tableflow-api-key.secret
  }

  # Ensure the topic and schema are created first
  depends_on = [
    confluent_schema.avro-customer-addresses,
    aws_iam_role.s3_access_role
  ]
}

resource "confluent_tableflow_topic" "customer_info_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  display_name = confluent_kafka_topic.customer_info_datagen.topic_name
  table_formats = ["ICEBERG"]

  // Use BYOB AWS storage
  byob_aws {
    bucket_name             = aws_s3_bucket.my_bucket.bucket
    provider_integration_id = confluent_provider_integration.main.id
  }

  credentials {
    key = confluent_api_key.my-tableflow-api-key.id
    secret = confluent_api_key.my-tableflow-api-key.secret
  }

  # Ensure the topic and schema are created first
  depends_on = [
    confluent_schema.avro-customer-info,
    aws_iam_role.s3_access_role
  ]
}

resource "confluent_tableflow_topic" "customer_balances_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  display_name = confluent_kafka_topic.customer_balances_datagen.topic_name
  table_formats = ["ICEBERG"]

  // Use BYOB AWS storage
  byob_aws {
    bucket_name             = aws_s3_bucket.my_bucket.bucket
    provider_integration_id = confluent_provider_integration.main.id
  }

  credentials {
    key = confluent_api_key.my-tableflow-api-key.id
    secret = confluent_api_key.my-tableflow-api-key.secret
  }

  # Ensure the topic and schema are created first
  depends_on = [
    confluent_schema.avro-customer-balances,
    aws_iam_role.s3_access_role
  ]
}

resource "confluent_tableflow_topic" "customer_relations_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  display_name = confluent_kafka_topic.customer_relations_datagen.topic_name
  table_formats = ["ICEBERG"]

  // Use BYOB AWS storage
  byob_aws {
    bucket_name             = aws_s3_bucket.my_bucket.bucket
    provider_integration_id = confluent_provider_integration.main.id
  }

  credentials {
    key = confluent_api_key.my-tableflow-api-key.id
    secret = confluent_api_key.my-tableflow-api-key.secret
  }

  # Ensure the topic and schema are created first
  depends_on = [
    confluent_schema.avro-customer-relations,
    aws_iam_role.s3_access_role
  ]
}