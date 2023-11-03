
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# RabbitMQ Queue Backlog Incident
---

A RabbitMQ Queue Backlog Incident refers to a situation where the RabbitMQ message queue is experiencing a backlog of messages. This means that the messages are not being processed as quickly as they are being received, leading to a buildup of messages in the queue. This can cause delays in message delivery and processing, which can impact the performance of applications that rely on RabbitMQ for message passing.

### Parameters
```shell
export CONNECTION_PID="PLACEHOLDER"

export BATCH_SIZE="PLACEHOLDER"

export CONCURRENCY_LEVEL="PLACEHOLDER"

export RABBITMQ_CONFIG_FILE_PATH="PLACEHOLDER"

export PREFETCH_COUNT="PLACEHOLDER"
```

## Debug

### Check RabbitMQ status
```shell
sudo systemctl status rabbitmq-server
```

### Check if the RabbitMQ service is running
```shell
sudo rabbitmqctl status
```

### Check the number of messages in the queue
```shell
sudo rabbitmqctl list_queues name messages_ready messages_unacknowledged
```

### Check the number of connections to RabbitMQ
```shell
sudo rabbitmqctl list_connections
```

### Check the number of channels for each connection
```shell
sudo rabbitmqctl list_channels ${CONNECTION_PID}
```

### Check the number of consumers for each queue
```shell
sudo rabbitmqctl list_consumers
```

### Check the number of exchanges
```shell
sudo rabbitmqctl list_exchanges
```

### Check the number of bindings
```shell
sudo rabbitmqctl list_bindings
```

### Check the number of nodes in the RabbitMQ cluster
```shell
sudo rabbitmqctl cluster_status
```

## Repair

### Tune RabbitMQ configuration - Tweaking the configuration of RabbitMQ based on the specific requirements of your system can help to optimize its performance and reduce the queue backlog issue.
```shell
bash

#!/bin/bash



# Set the RabbitMQ configuration file path

RABBITMQ_CONF="${RABBITMQ_CONFIG_FILE_PATH}"



# Set the configuration parameters to be tuned

PREFETCH_COUNT="${PREFETCH_COUNT}"

BATCH_SIZE="${BATCH_SIZE}"

CONCURRENCY_LEVEL="${CONCURRENCY_LEVEL}"



# Stop the RabbitMQ service

sudo systemctl stop rabbitmq-server



# Update the configuration file with the new parameters

sudo sed -i "s/^prefetch_count = .*/prefetch_count = $PREFETCH_COUNT/" $RABBITMQ_CONF

sudo sed -i "s/^batch_size = .*/batch_size = $BATCH_SIZE/" $RABBITMQ_CONF

sudo sed -i "s/^concurrency = .*/concurrency = $CONCURRENCY_LEVEL/" $RABBITMQ_CONF



# Start the RabbitMQ service

sudo systemctl start rabbitmq-server



echo "RabbitMQ configuration has been tuned successfully."


```