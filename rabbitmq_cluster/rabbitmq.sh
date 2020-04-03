rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster --ram rabbitmq3@rabbitmq3
rabbitmqctl start_app