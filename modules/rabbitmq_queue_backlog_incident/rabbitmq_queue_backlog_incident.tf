resource "shoreline_notebook" "rabbitmq_queue_backlog_incident" {
  name       = "rabbitmq_queue_backlog_incident"
  data       = file("${path.module}/data/rabbitmq_queue_backlog_incident.json")
  depends_on = [shoreline_action.invoke_config_tuner]
}

resource "shoreline_file" "config_tuner" {
  name             = "config_tuner"
  input_file       = "${path.module}/data/config_tuner.sh"
  md5              = filemd5("${path.module}/data/config_tuner.sh")
  description      = "Tune RabbitMQ configuration - Tweaking the configuration of RabbitMQ based on the specific requirements of your system can help to optimize its performance and reduce the queue backlog issue."
  destination_path = "/tmp/config_tuner.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_config_tuner" {
  name        = "invoke_config_tuner"
  description = "Tune RabbitMQ configuration - Tweaking the configuration of RabbitMQ based on the specific requirements of your system can help to optimize its performance and reduce the queue backlog issue."
  command     = "`chmod +x /tmp/config_tuner.sh && /tmp/config_tuner.sh`"
  params      = ["PREFETCH_COUNT","BATCH_SIZE","CONCURRENCY_LEVEL","RABBITMQ_CONFIG_FILE_PATH"]
  file_deps   = ["config_tuner"]
  enabled     = true
  depends_on  = [shoreline_file.config_tuner]
}

