variable "scc_notification_configs" {
  description = <<EOT
Map of scc_notification_configs, attributes below
Required:
    - config_id
    - organization
    - pubsub_topic
    - streaming_config (block):
        - filter (required)
Optional:
    - deletion_policy
    - description
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    config_id       = string
    organization    = string
    pubsub_topic    = string
    deletion_policy = optional(string)
    description     = optional(string)
    streaming_config = object({
      filter = string
    })
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.scc_notification_configs : (
        v.description == null || (length(v.description) >= 0 && length(v.description) <= 1024)
      )
    ])
    error_message = "must be between 0 and 1024 characters"
  }
}

