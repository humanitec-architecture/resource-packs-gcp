# GCP resource pack

---

:construction: __This pack is experimental and currently not recommended for production usage.__ :construction:

---

The GCP Resource Pack contains various reference implementation of connecting GCP with [the Humanitec Platform Orchestrator](https://developer.humanitec.com/platform-orchestrator/overview/).

You can find more details about Resource Packs and how to use them [inside the Humanitec documentation](https://developer.humanitec.com/platform-orchestrator/resources/resource-packs/).

The following resources are included:

* [dns/basic](./humanitec-resource-defs/dns/basic): GCP Cloud DNS `dns` resource.
* [gcp-iam-policy-binding/basic](./humanitec-resource-defs/gcp-iam-policy-binding/basic): Define role bindings for a GCP service account.
* [gcp-pubsub-subscription/basic](./humanitec-resource-defs/gcp-pubsub-subscription/basic): A `gcp-pubsub-subscription` Resource Definition creating an GCP Pub/Sub Subscription.
* [gcp-pubsub-topic/basic](./humanitec-resource-defs/gcp-pubsub-topic/basic): A `gcp-pubsub-topic` Resource Definition creating an GCP Pub/Sub Topic.
* [gcs/basic](./humanitec-resource-defs/gcs/basic): A `gcs` Resource Definition creating a GCP Cloud Storage Bucket.
* [k8s-service-account/workload](./humanitec-resource-defs/k8s-service-account/workload): A `k8s-service-account` resource that supports GCP role bindings.
* [mysql/basic](./humanitec-resource-defs/mysql/basic): A `mysql` resource using GCP CloudSQL.
* [mysql-instance/basic](./humanitec-resource-defs/mysql-instance/basic): A `mysql-instance` resource using GCP CloudSQL.
* [postgres/basic](./humanitec-resource-defs/postgres/basic): A `postgres` resource using GCP CloudSQL.
* [postgres/workload-identity](./humanitec-resource-defs/postgres/workload-identity): A `postgres` resource using GCP CloudSQL with Workload Identity.
* [postgres-instance/basic](./humanitec-resource-defs/postgres-instance/basic): A `postgres-instance` resource using GCP CloudSQL.
* [redis/basic](./humanitec-resource-defs/redis/basic): GCP Memorystore `redis` resource.
* [workload/service-account](./humanitec-resource-defs/workload/service-account): Inject a k8s service account into a `workload`.

The `humanitec-resource-defs` directory includes the respective Resource Definitions.

The `modules` directory includes the Terraform modules used by the [Humanitec Terraform Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/) to provision the actual resources.

Checkout `examples/` for example usage of the Resource Definitions listed above.
