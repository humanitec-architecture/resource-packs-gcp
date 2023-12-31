# GCP resource pack

---

:construction: __This pack is experimental and currently not recommended for production usage.__ :construction:

---

A collection of GCP resources ready to be used with [Humanitec](https://humanitec.com/).

The following resources are included:

* [dns/basic](./humanitec-resource-defs/dns/basic): GCP Cloud DNS `dns` resource.
* [redis/basic](./humanitec-resource-defs/redis/basic): GCP Memorystore `redis` resource.

The `humanitec-resource-defs` directory includes the respective resource definitions.

The `modules` directory includes the Terraform modules used by the [Humanitec Terraform Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/) to provision the actual resources.
