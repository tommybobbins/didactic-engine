# Provision a Google Cloud GCP GKE Autopilot Cluster for CAPA (Certified Argo Project Associate)

## Not for production use.


### Deployment

Check that all the APIs are enabled
```
$ gcloud services list --enabled
NAME                                 TITLE
appengine.googleapis.com             App Engine Admin API
appenginereporting.googleapis.com    App Engine
autoscaling.googleapis.com           Cloud Autoscaling API
bigquerystorage.googleapis.com       BigQuery Storage API
certificatemanager.googleapis.com    Certificate Manager API
cloudapis.googleapis.com             Google Cloud APIs
cloudbuild.googleapis.com            Cloud Build API
cloudresourcemanager.googleapis.com  Cloud Resource Manager API
cloudscheduler.googleapis.com        Cloud Scheduler API
cloudtrace.googleapis.com            Cloud Trace API
compute.googleapis.com               Compute Engine API
container.googleapis.com             Kubernetes Engine API
containerregistry.googleapis.com     Container Registry API
datastore.googleapis.com             Cloud Datastore API
deploymentmanager.googleapis.com     Cloud Deployment Manager V2 API
iam.googleapis.com                   Identity and Access Management (IAM) API
iamcredentials.googleapis.com        IAM Service Account Credentials API
logging.googleapis.com               Cloud Logging API
monitoring.googleapis.com            Cloud Monitoring API
oslogin.googleapis.com               Cloud OS Login API
secretmanager.googleapis.com         Secret Manager API
servicemanagement.googleapis.com     Service Management API
serviceusage.googleapis.com          Service Usage API
```

Create a tofu.tfvars file containing something similar to the following:

    credentials_file  = "wibbly-flibble-stuff-morestuff.json"
    project           = "wibble-flibble-numbers"
    region            = "europe-west2"

Create the service account keys which will be used for tofu wibbly-flibble-stuff-morestuff.json using:

````
    $ gcloud iam service-accounts keys create gcp_deployment_creds.json  \
    --iam-account=tofu-deployer@wibble-flibble-123456.iam.gserviceaccount.com
created key [123456abcdef1234] of type [json] as [gcp_deployment_creds.json] for [tofu-deployer@wibble-flibble-123456.iam.gserviceaccount.com]
````

Run the standard terraform deployment:
   ```
   $ tofu init
   $ tofu plan
   $ tofu apply
   $ export KUBECONFIG=~/.kube/config
   ```


This will create everything except the kubectl_manifests which must be created after getting the cluster credentials These will be generated on a second tofu apply once the kubernetes cluster credentials have been found.
Run the below command to populate the ~/.kube/config:

    $ gcloud container clusters get-credentials <project_name>-gke --region europe-west2

Set the kubeconfig for Helm
 
    $ export KUBE_CONFIGFILE=$KUBECONFIG

Run tofu apply again which should output:

```
helm_release.argocd: Still creating... [3m20s elapsed]
helm_release.argocd: Creation complete after 3m24s [id=argocd]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_cluster_host = "1.2.3.4"
kubernetes_cluster_name = "wibbly-bibbly-12235-gke"
project = "wibbly-bibbly-12235"
region = "europe-west2"
```
### Lab 3.1  Installing ArgoCD
Enable ArgoCD
````
$ echo "argocd_enabled = true" >> terraform.tfvars
$ tofu apply
````
````
$ kubectl port-forward svc/argocd-server -n argocd 8080:443
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
````
### Lab 4.1  Installing Argo Workflows

Enable Argo workflows by editing the terraform.tfvars so that is looks like the below:
````
argocd_enabled        = false
argoworkflows_enabled = true
````

Port forward to the workflows server
````
$ kubectl -n argo port-forward deployment/argo-workflows-server 2746:2746
````
