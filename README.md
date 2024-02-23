# GCP resource pack

---

:construction: __This pack is experimental and currently not recommended for production usage.__ :construction:

---

A collection of GCP resources ready to be used with [Humanitec](https://humanitec.com/).

The following resources are included:

* [dns/basic](./humanitec-resource-defs/dns/basic): GCP Cloud DNS `dns` resource.
* [gcp-pubsub-subscription/basic](./humanitec-resource-defs/gcp-pubsub-subscription/basic): A `gcp-pubsub-subscription` Resource Definition creating an GCP Pub/Sub Subscription.
* [gcp-pubsub-topic/basic](./humanitec-resource-defs/gcp-pubsub-topic/basic): A `gcp-pubsub-topic` Resource Definition creating an GCP Pub/Sub Topic.
* [gcs/basic](./humanitec-resource-defs/gcs/basic): A `gcs` Resource Definition creating a GCP Cloud Storage Bucket.
* [mysql/basic](./humanitec-resource-defs/mysql/basic): A `mysql` resource using GCP CloudSQL.
* [postgres/basic](./humanitec-resource-defs/postgres/basic): A `postgres` resource using GCP CloudSQL.
* [redis/basic](./humanitec-resource-defs/redis/basic): GCP Memorystore `redis` resource.

The `humanitec-resource-defs` directory includes the respective resource definitions.

The `modules` directory includes the Terraform modules used by the [Humanitec Terraform Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/) to provision the actual resources.
