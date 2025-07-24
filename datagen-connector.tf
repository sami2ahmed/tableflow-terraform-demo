# https://github.com/confluentinc/terraform-provider-confluent/tree/master/examples/configurations/connectors/managed-datagen-source-connector
resource "confluent_connector" "stock_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "DatagenSourceConnector_0"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.my_service_account.id
    "kafka.topic"              = confluent_kafka_topic.stock_trades.topic_name
    "output.data.format"       = "AVRO"
    "quickstart"               = "STOCK_TRADES"
    "tasks.max"                = "1"
    "max.interval"             = "10"
  }

  depends_on = [
    confluent_kafka_acl.write-basic-cluster
  ]

  lifecycle {
    prevent_destroy = false
  }
}

resource "confluent_connector" "users_datagen" {
  environment {
    id = confluent_environment.my_environment.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.kafka-cluster.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name"                     = "DatagenSourceConnector_1"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.my_service_account.id
    "kafka.topic"              = confluent_kafka_topic.users.topic_name
    "output.data.format"       = "AVRO"
    "quickstart"               = "USERS"
    "tasks.max"                = "1"
    "max.interval"             = "10"
  }

  depends_on = [
    confluent_kafka_acl.write-basic-cluster
  ]

  lifecycle {
    prevent_destroy = false
  }
}

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
    "schema.string"            = jsonencode({
      "type": "record",
      "name": "CustomerTelephone",
      "fields": [
        {
          "name": "customer_number",
          "type": {
            "type": "string",
            "arg.properties": {
              "options": [
                "123456789", "123456790", "123456791", "123456792", "123456793", "123456794",
                "123456795", "123456796", "123456797", "123456798", "123456799", "123456800"
              ]
            }
          }
        },
        {
          "name": "customer_name",
          "type": {
            "type": "string",
            "arg.properties": {
              "options": [
                "Gayle Fisher", "Napoleon Keith", "Carmella Schaefer", "Ronald Duncan", "Francis Stout",
                "Scottie Knox", "Rosa Delgado", "Ana Larson", "Willian Best", "John Smith", "Jane Doe", "Michael Johnson"
              ]
            }
          }
        },
        {
          "name": "telephone",
          "type": {
            "type": "string",
            "arg.properties": {
              "options": [
                "63488686", "67200789", "62928181", "68874074", "64674415", "62551633",
                "64414489", "63624606", "68966982", "65123456", "67654321", "69876543"
              ]
            }
          }
        }
      ]
    })
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

