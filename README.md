Intent Recognition Model Using Rasa's DIET architecture
        ┌──────────────┐         ┌──────────────┐
        │  Raw data    │  -----> │  Labeling    │  (intents, entities)
        └─────┬────────┘         └─────┬────────┘
              │                        │
              ▼                        ▼
        ┌──────────────┐         ┌──────────────┐
        │  Data store  │         │  Feature     │  (tokenizers, featurizers)
        │  (S3/DB)     │         │  pipeline    │
        └─────┬────────┘         └─────┬────────┘
              │                        │
              ▼                        ▼
        ┌─────────────────────────────────────────┐
        │         Rasa NLU (DIETClassifier)       │
        │  - Multi-intent classification          │
        │  - Entity extraction                    │
        └───────────┬─────────────────────────────┘
                    │
           logs/metrics/artifacts
                    │
                    ▼
        ┌─────────────────────────┐
        │    MLflow Tracking      │  (params, metrics, artifacts)
        │  + MLflow Model Registry│  (staging → production)
        └───────────┬─────────────┘
                    │
           model binaries to S3
                    │
                    ▼
        ┌─────────────────────────┐
        │   Deployment layer      │  (Rasa server / FastAPI wrapper / Docker / K8s)
        └───────────┬─────────────┘
                    │
                    ▼
        ┌─────────────────────────┐
        │   Monitoring & A/B      │  (real-time metrics, drift detection)
        └─────────────────────────┘
