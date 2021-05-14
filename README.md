# Monitoring-cluster
I have collected tools for monitoring your Kubernetes cluster with Prometheus and you can deploy them by using Terraform. It's easily, manageable, deployable and configurable in infrastructures.

# Tools
* [Prometheus](https://github.com/prometheus/prometheus)
* [grafana](https://github.com/grafana/grafana)
* [Kube-state-metrics](https://github.com/kubernetes/kube-state-metrics)
* [Alertmanager](https://github.com/prometheus/alertmanager)
* [Prometheus-adaptor](https://github.com/DirectXMan12/k8s-prometheus-adapter)
* [Prometheus-node-exporter](https://github.com/prometheus/node_exporter)
* [Realoader](https://github.com/stakater/Reloader)

# Prometheus diagram
[Prometheus](https://prometheus.io/) is an open-source systems monitoring and alerting toolkit originally built at SoundCloud.

Features :
* A multi-dimensional data model with time series data identified by metric name and key/value pairs
* PromQL, a flexible query language to leverage this dimensionality
* No reliance on distributed storage; single server nodes are autonomous
* Time series collection happens via a pull model over HTTP
* Pushing time series is supported via an intermediary gateway
* Targets are discovered via service discovery or static configuration
* Multiple modes of graphing and dashboarding support

# Usage
```tf
provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "monitoring-cluster" {
  source  = "dritux/monitoring-cluster/kubernetes"
  version = "1.1.0"
  storage_class_name = "managed-nfs-storage" # your storageclass
  monitoring_name_space = "kube-monitor"
}

```

# Input

| Name                      | Description                                         | Type   | Default     |
|---------------------------|-----------------------------------------------------|--------|-------------|
| grafana_service_type      | type of kubernetes service for grafana              | string | NodePort    |
| grafana_replica           | number of grafana replicas                          | number | 1           |
| alertmanager_service_type | type of kubernetes service for alertmanager         | string | NodePort    |
| alertmanager_replica      | number of alertmanager replicas                     | number | 1           |
| kubestate_replica         | number of kube-state-metrics replicas               | number | 1           |
| prometheus_replica        | number of proemtheus replicas                       | number | 2           |
| monitoring_name_space     | defualt namespaace for monitoring management tooles | string | monitoring  |
| reloader_name_space       | defualt namespaace for config reloader              | string | kube-system |
| kubestate_name_space      | defualt namespaace for metrics collector            | string | kube-system |
| alertmanager_node_port      | port to expose alertmanager service            | number | 31000 |
| grafana_node_port      | port to expose grafana service            | number | 32000 |
| grafana_persistent_volume_claim_storage      | grafana storage size            | string | 1Gi |
| storage_class_name      | storageClass for dynamically provisioning            | string | standard |
| prometheus_node_port      | port to expose prometheus service            | number | 30000 |
| prometheus_service_type      | type of kubernetes service for prometheus            | string | NodePort |
| prometheus_persistent_volume_claim_storage      | proemtheus storage size            | string | 3Gi |

