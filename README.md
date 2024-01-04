# GCP resource pack

---

:construction: __This pack is experimental and currently not recommended for production usage.__ :construction:

---

A collection of GCP resources ready to be used with [Humanitec](https://humanitec.com/).

The following resources are included:

* [gcs/basic](./humanitec-resource-defs/gcs/basic): A basic cloud storage bucket.
* [pubsub-topic/basic](./humanitec-resource-defs/pubsub-topic/basic): A basic cloud Pub/Sub topic.

The `humanitec-resource-defs` directory includes the respective resource definitions.

The `modules` directory includes the Terraform modules used by the [Humanitec Terraform Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/) to provision the actual resources.
