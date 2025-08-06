# https://github.com/confluentinc/terraform-provider-confluent/tree/master/examples/configurations/connectors/managed-datagen-source-connector

resource "confluent_connector" "customer_telephone_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "customer-telephone-datagen-connector"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.my_service_account.id
    "kafka.topic"              = confluent_kafka_topic.customer_telephone_datagen.topic_name
    "output.data.format"       = "AVRO"
    "schema.keyfield"          = "customer_number"
    "schema.string"            = file("./schemas/avro/customer_telephone.avsc")
    "tasks.max"                = "1"
    "max.interval"             = "1000"
  }

  depends_on = [
    confluent_kafka_acl.write-basic-cluster
  ]

  lifecycle {
    prevent_destroy = false
  }
}

resource "confluent_connector" "customer_addresses_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "customer-addresses-datagen-connector"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.my_service_account.id
    "kafka.topic"              = confluent_kafka_topic.customer_addresses.topic_name
    "output.data.format"       = "AVRO"
    "schema.keyfield"          = "customer_number"
    "schema.string"            = file("./schemas/avro/customer_addresses.avsc")
    "tasks.max"                = "1"
    "max.interval"             = "1000"
  }

  depends_on = [
    confluent_kafka_acl.write-basic-cluster
  ]

  lifecycle {
    prevent_destroy = false
  }
}

resource "confluent_connector" "customer_info_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "customer-info-datagen-connector"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.my_service_account.id
    "kafka.topic"              = confluent_kafka_topic.customer_info_datagen.topic_name
    "output.data.format"       = "AVRO"
    "schema.keyfield"          = "customer_number"
    "schema.string"            = file("./schemas/avro/customer_info.avsc")
    "tasks.max"                = "1"
    "max.interval"             = "1000"
  }

  depends_on = [
    confluent_kafka_acl.write-basic-cluster
  ]

  lifecycle {
    prevent_destroy = false
  }
}

resource "confluent_connector" "customer_balances_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "customer-balances-datagen-connector"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.my_service_account.id
    "kafka.topic"              = confluent_kafka_topic.customer_balances_datagen.topic_name
    "output.data.format"       = "AVRO"
    "schema.keyfield"          = "customer_number"
    "schema.string"            = file("./schemas/avro/customer_balances.avsc")
    "tasks.max"                = "1"
    "max.interval"             = "1000"
  }

  depends_on = [
    confluent_kafka_acl.write-basic-cluster
  ]

  lifecycle {
    prevent_destroy = false
  }
}

resource "confluent_connector" "customer_relations_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "customer-relations-datagen-connector"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.my_service_account.id
    "kafka.topic"              = confluent_kafka_topic.customer_relations_datagen.topic_name
    "output.data.format"       = "AVRO"
    "schema.keyfield"          = "customer_number"
    "schema.string"            = file("./schemas/avro/customer_relations.avsc")
    "tasks.max"                = "1"
    "max.interval"             = "1000"
  }

  depends_on = [
    confluent_kafka_acl.write-basic-cluster
  ]

  lifecycle {
    prevent_destroy = false
  }
}

