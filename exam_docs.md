# Terms and definitions for CAPA

# ArgoCD

## Components

- ArgoCD API Server - Manage applications and status updates, triggers, git repos for version, kubernetes credentials, SSO, RBAC, WebUI/CLI/Events/CICD.
- ArgoCD Repository Server - Poll git and retrieve the desired state.
- ArgoCD Application Controller - reconcile the deployment with the desired state. Rollouts.


## Resource hooks

- PreSync
- Sync - Do actions on the manifests.
- PostSync
- Skip - skip application
- SyncFail - cleanup

A sync wave allows syncs to be ordered and goes from negative->positive values. It is applied to applications using the annotation:

````
argocd.argoproj.io/sync-wave: "5"
````

## Order of deployment

- Resource hook phase annotation
- Sync wave annotation
- Kubernetes resource type (e.g. namespaces first)
- Name

Default 2 second delay between each sync wave - ARGO_SYNC_WAVE_DELAY

## Simplifying Application Management

- Application - base unit of an application instance.
- AppProject - collection of applications.
- RepositoryCredentials - git access
- ClusterCredentials - Access to other clusters.

## Plugins

e.g Notifications plugin for slack - configured via configmap.

# Argo Workflows

Workflow are defined as a series of tasks, processes or steps executed in a particular sequence. CRD.

-  Entrypoint: template that is entrypoint for workflow. 
-  Templates: step or task in the workflow which will be run.

## Templates

- Container - step in workflow to run a container.
- Resource - create/modify/delete k8s resource.
- Script - inline script (e.g. python).
- Suspend - suspend via delay.
- DAG - graph of dependencies. Complex workflows.
- Steps - multiple steps to be executed sequentially.

## Outputs

Argo workflows - outputs define and capture outputs to be accessed by subsequent steps.

## WorkflowTemplate

Shareable and reusable allows users to encapsulate workflow logic, parameters and metadata.  {{inputs.parameters.msg}}

## Workflow Components

- Argo Server: REST API/Central component overall resources, state and interactions.
- Workflow Controller: Managers the lifecycle of workflows, scanning API server for changes. 
- Argo UI

Workflows can run in any namespace, but the Argo server, workflow controller and UI run in the argocd namespace (cf argocd).

## Workflow Overview

Each step and DAG causes the generation of a Pod which consists of 3 containers.

- init: startup
- main : executes primary process
- wait : cleanup/saving/artifacts

## Where to use Argo Workflow

- Data processing pipelines - ETL.
- Machine Learning projects.
- CICD Pipelines - build/test/deploy in kubernetes.
- Batch processing.  cron scheduling/intervals.

# Argo Rollouts

CD/Gitops tool - Allows Canary/AB testing/Feature flags/Phased rollouts (Progressive delivery)

- Rollout controller manages rollout resources (ensures desired cluster state)-> Rollout resource (howto deploy)
- Analysis template->AnalysisRun-> Prometheus - optional feature of Argo Rollouts - automation of promotions and rollouts. Metric Query and measure to determine success. AnalysisRuns is based on AnalysisTemplate (cf Kubernetes Job)
- Metric provider - native integration for prometheus/other monitoring.

## Migrate existing

Use spec.workloadRef instead of spec.template to refer to import/migrate an existing deployment - the original deployment can then be removed.
Pod Template Hashes are used to uniquely define pods (blue/green/canary) so the traffic can be managed to those backends.

# Argo Events

Argo Events - event driven architecture within k8s (cf. kafka/SQS)

Event Driven Architecture

- Event Source - Generation.
- Sensor - listeners in Argo Events.
- EventBus - backbone for event distribution.
- Trigger - mechanism to respond to sensor events
