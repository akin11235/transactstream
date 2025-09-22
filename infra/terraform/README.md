└── terraform/
    ├── modules/
    │   ├── databricks_cluster/
    │   │   ├── main.tf
    │   │   ├── variables.tf
    │   │   └── outputs.tf
    │   ├── s3_bucket/
    │   │   ├── main.tf
    │   │   ├── variables.tf
    │   │   └── outputs.tf
    │   ├── adls_container/
    │   │   ├── main.tf
    │   │   ├── variables.tf
    │   │   └── outputs.tf
    │   └── iam_roles/
    │       ├── main.tf
    │       ├── variables.tf
    │       └── outputs.tf
    │
    ├── envs/
    │   ├── dev/
    │   │   ├── main.tf
    │   │   ├── providers.tf
    │   │   ├── variables.tf
    │   │   ├── outputs.tf
    │   │   └── backend.tf
    │   ├── staging/
    │   │   ├── main.tf
    │   │   ├── providers.tf
    │   │   ├── variables.tf
    │   │   ├── outputs.tf
    │   │   └── backend.tf
    │   └── prod/
    │       ├── main.tf
    │       ├── providers.tf
    │       ├── variables.tf
    │       ├── outputs.tf
    │       └── backend.tf
    │
    └── README.md                     # Optional: documentation for Terraform usage
