resource "confluent_kafka_topic" "customer_telephone_datagen" {
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  topic_name         = "customer-telephone-datagen"
  rest_endpoint      = confluent_kafka_cluster.kafka-cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka-api-key.id
    secret = confluent_api_key.kafka-api-key.secret
  }
}

resource "confluent_kafka_topic" "customer_addresses" {
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  topic_name         = "customer-addresses"
  rest_endpoint      = confluent_kafka_cluster.kafka-cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka-api-key.id
    secret = confluent_api_key.kafka-api-key.secret
  }
}

resource "confluent_kafka_topic" "customer_info_datagen" {
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  topic_name         = "customer-info-datagen"
  rest_endpoint      = confluent_kafka_cluster.kafka-cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka-api-key.id
    secret = confluent_api_key.kafka-api-key.secret
  }
}

resource "confluent_kafka_topic" "customer_balances_datagen" {
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  topic_name         = "customer-balances-datagen"
  rest_endpoint      = confluent_kafka_cluster.kafka-cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka-api-key.id
    secret = confluent_api_key.kafka-api-key.secret
  }
}

resource "confluent_kafka_topic" "customer_relations_datagen" {
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }
  topic_name         = "customer-relations-datagen"
  rest_endpoint      = confluent_kafka_cluster.kafka-cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka-api-key.id
    secret = confluent_api_key.kafka-api-key.secret
  }
}