data "confluent_schema_registry_cluster" "essentials" {
  environment {
    id = confluent_environment.my_environment.id
  }

  depends_on = [
    confluent_kafka_cluster.kafka-cluster
  ]
}


resource "confluent_schema" "avro-customer-telephone" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.essentials.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.essentials.rest_endpoint
  subject_name = "${confluent_kafka_topic.customer_telephone_datagen.topic_name}-value"
  format = "AVRO"
  schema = file("./schemas/avro/customer_telephone.avsc")
  credentials {
    key    = confluent_api_key.my-schema-registry-api-key.id
    secret = confluent_api_key.my-schema-registry-api-key.secret
  }

  lifecycle {
    prevent_destroy = false
  }
  depends_on = [confluent_role_binding.environment-admin, data.confluent_schema_registry_cluster.essentials]
}


resource "confluent_schema" "avro-customer-addresses" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.essentials.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.essentials.rest_endpoint
  subject_name = "${confluent_kafka_topic.customer_addresses.topic_name}-value"
  format = "AVRO"
  schema = file("./schemas/avro/customer_addresses.avsc")
  credentials {
    key    = confluent_api_key.my-schema-registry-api-key.id
    secret = confluent_api_key.my-schema-registry-api-key.secret
  }

  lifecycle {
    prevent_destroy = false
  }
  depends_on = [confluent_role_binding.environment-admin, data.confluent_schema_registry_cluster.essentials]
}


resource "confluent_schema" "avro-customer-info" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.essentials.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.essentials.rest_endpoint
  subject_name = "${confluent_kafka_topic.customer_info_datagen.topic_name}-value"
  format = "AVRO"
  schema = file("./schemas/avro/customer_info.avsc")
  credentials {
    key    = confluent_api_key.my-schema-registry-api-key.id
    secret = confluent_api_key.my-schema-registry-api-key.secret
  }

  lifecycle {
    prevent_destroy = false
  }
  depends_on = [confluent_role_binding.environment-admin, data.confluent_schema_registry_cluster.essentials]
}


resource "confluent_schema" "avro-customer-balances" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.essentials.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.essentials.rest_endpoint
  subject_name = "${confluent_kafka_topic.customer_balances_datagen.topic_name}-value"
  format = "AVRO"
  schema = file("./schemas/avro/customer_balances.avsc")
  credentials {
    key    = confluent_api_key.my-schema-registry-api-key.id
    secret = confluent_api_key.my-schema-registry-api-key.secret
  }

  lifecycle {
    prevent_destroy = false
  }
  depends_on = [confluent_role_binding.environment-admin, data.confluent_schema_registry_cluster.essentials]
}


resource "confluent_schema" "avro-customer-relations" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.essentials.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.essentials.rest_endpoint
  subject_name = "${confluent_kafka_topic.customer_relations_datagen.topic_name}-value"
  format = "AVRO"
  schema = file("./schemas/avro/customer_relations.avsc")
  credentials {
    key    = confluent_api_key.my-schema-registry-api-key.id
    secret = confluent_api_key.my-schema-registry-api-key.secret
  }

  lifecycle {
    prevent_destroy = false
  }
  depends_on = [confluent_role_binding.environment-admin, data.confluent_schema_registry_cluster.essentials]
}

