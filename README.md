# DevOpsDemo
DevOpsDemo featuring a production-grade setup of Kubernetes and Spinnaker on Azure.

## Architecture ##

#### Overall deployment process: ####
1. Git tag
2. Trigger Azure DevOps pipeline
3. Build Docker image
4. Run unit tests
5. Run API tests
6. Publish to Docker registry
7. Trigger Spinnaker pipeline 
8. Automated deployment to DEV stage
9. Automated deployment to further stages (optionally after manual validation)
10. Monitoring, log analysis, alerting via Azure Log Analytics

#### Process for new service: ####
1. Clone service template into new Git repository
2. Create new Azure DevOps pipeline for repository (TODO: automate)
3. Create additional infrastructure for the service (database, blob storage, etc)
4. Create new Spinnaker pipeline with configuration for the service


### Multiple deployment stages ###
* DEV, TEST, PROD, etc (configurable)
* Stages are deployed and configured via Terraform
* Each stage has its own Kubernetes cluster and Docker container registry
  * Ensures changes in infrastructure can be tested safely before applying to production
  * Promotion of Docker images between stages

### Other features ###
* Continuous deployment of infrastructure via Terraform
* Continuous deployment of services via Spinnaker
* Continuous integration of Docker images via service templates and Azure DevOps
* Unit-testing via service templates and Azure DevOps
* Integration (API) tests via service templates, docker-compose, and Azure DevOps
* Service auto-scaling via Kubernetes
* Cluster auto-scaling via AKS
* Service discovery via Kubernetes
* Service configuration via Spinnaker, Kubernetes, and service templates
* Credential storage via Kubernetes
* Structured logging via service templates
* Log analytics via Azure Log Anaytics
* Metrics exposure via service templates
* Metrics analytics and alerts via Azure Log Analytics
* Service health-check/readiness probe via service templates and Kubernetes
* External traffic routing via Nginx ingress controller
* SSL termination via Nginx ingress controller, certificate manager and Let's encrypt
* CORS handling via Nginx ingress controller
* Authentication via Nginx ingress controller and OAuth2 Proxy

### Components ###

#### Terraform ####
* Used for continuous deployment of infrastructure and base services
* Declarative HCL language
* Updates state of infrastructre/services to desired state
* Can be used for management of additional infrastructure for the services (databases, blob storage, 

#### Kubernetes Cluster ####
* Deployed with Terraform to AKS (Azure Kubernetes Service)
* Handles cross-cutting concerns of services like discovery, scaling, resources, networking/routing, logging
* Enabled RBAC (role-based access control) for intra-cluster security
* Nginx ingress controllers
  * External traffic routing
  * SSL termination with Let's encrypt certificates
  * CORS handling
  * Authentication possible with OAuth2 Proxy
* Metrics scraping with Azure Metrics Collector

#### Spinnaker ####
* Deployed with Terraform/Helm to DEV environment
* Handles updates of services with different configurable strategies
* Multi-stage deployment pipeline e.g. DEV -> STAGE -> PROD
* Promotion of Docker images between registries
* Optional manual validation stage before promotion
* Pre-configured Spinnaker pipeline templates

#### Service templates ####
* Build in multi-stage Docker container
  * Minimum size
  * Maximum security by not including unnecessary binaries in image
  * Run as non-root user
* Configuration via environment variables
* State passed to API handlers
* Structure logging in JSON
* Health-check endpoint
* Prometheus metrics
* Unit tests with JUnit-compatible output
* API/integration tests with docker-compose

### Modules ###
* [Azure Kubernetes cluster](https://github.com/DevOpsDemoTF/DevOpsDemo-k8s/)
* [Spinnaker deployment](https://github.com/DevOpsDemoTF/DevOpsDemo-Spinnaker/)
* [Micro-service template for F#](https://github.com/DevOpsDemoTF/DevOpsDemo-template-FSharp/)
* [Micro-service template for Go](https://github.com/DevOpsDemoTF/DevOpsDemo-template-Go/)
* [Micro-service template for Java (Spring Boot)](https://github.com/DevOpsDemoTF/DevOpsDemo-template-Java/)
* [Micro-service template for JavaScript (Node.js)](https://github.com/DevOpsDemoTF/DevOpsDemo-template-JavaScript/)
* [Micro-service template for Kotlin](https://github.com/DevOpsDemoTF/DevOpsDemo-template-Kotlin/)
* [Micro-service template for Python](https://github.com/DevOpsDemoTF/DevOpsDemo-template-Python/)
* [Micro-service template for Rust](https://github.com/DevOpsDemoTF/DevOpsDemo-template-Rust/)
