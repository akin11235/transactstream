transactstream/
├── README.md                     # Project overview, setup, usage
├── pyproject.toml                 # Build system (PEP 517/518) for packaging as wheel
├── requirements.txt              # Python dependencies (PySpark, Faker, etc.)
│
├── src/                           # Python source (packaged as wheel)
│   └── transactstream/
│       ├── __init__.py
│       ├── faker/                 # Faker-based synthetic data generator
│       │   └── generate_faker.py
│       ├── utils/                 # Shared helper functions
│       │   └── common_utils.py
│       ├── bronze/                # Ingestion logic
│       │   └── ingest_bronze.py
│       ├── silver/                # Cleansing & transformations
│       │   └── transform_silver.py
│       └── gold/                  # Aggregations / ML-ready features
│           ├── config_gold.py     # Config-driven summary table generation
│           └── ml_gold_features.py
│
├── configs/                       # Configurations (YAML)
│   ├── bronze_config.yaml         # Bronze ingestion schemas, paths
│   ├── silver_config.yaml         # Silver rules (dedup, null handling)
│   └── gold_config.yaml           # Gold aggregations + summary tables
│
├── notebooks/                     # Databricks Notebooks (for interactive dev)
│   ├── bronze/ingest_bronze.py
│   ├── silver/transform_silver.py
│   ├── gold/config_gold.py
│   └── gold/ml_gold_features.py
│
├── jobs/                          # Job wrappers for orchestration
│   ├── bronze_job.py
│   ├── silver_job.py
│   └── gold_job.py
│
├── pipelines/                     # Orchestration definitions
│   └── transactstream_pipeline.json   # Databricks Workflow / Airflow DAG
│
├── terraform/                     # IaC for infra provisioning
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/                   # Reusable infra modules
│   │   ├── databricks_cluster/
│   │   ├── s3_bucket/
│   │   ├── adls_container/
│   │   └── iam_roles/
│   └── envs/                      # Per-environment configs
│       ├── dev/
│       ├── staging/
│       └── prod/
│
├── ci_cd/                         # GitHub Actions workflows
│   └── pipeline.yml
│
├── docker/                        # Docker setup
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── data/                          # Sample synthetic data
│   └── financial_transactions.csv
│
├── tests/                         # Pytest-based unit & integration tests
│   ├── test_faker.py
│   ├── test_bronze.py
│   ├── test_silver.py
│   └── test_gold.py
│
└── docs/                          # Documentation & diagrams
    ├── architecture.drawio
    └── lineage.png
