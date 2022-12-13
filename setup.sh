#!/bin/bash
PROJECT_ID= <paste here your project ID>
echo ${PROJECT_ID}

#enable apis for cloud build, deploy, artifact registry and container
gcloud services enable cloudbuild.googleapis.com clouddeploy.googleapis.com artifactregistry.googleapis.com container.googleapis.com

#Add “clouddeploy.jobRunner” permission on your compute service account
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
    --role="roles/clouddeploy.jobRunner"

#Add “container.developer” permission on your compute service account
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
    --role="roles/container.developer"


#Add “artifactregistry.admin” permission on your Cloud Build service account\
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")@cloudbuild.gserviceaccount.com \
    --role="roles/artifactregistry.writer"


#Add “artifactregistry.reader” permission on your compute service account
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
    --role="roles/artifactregistry.reader"


#Add “clouddeploy.releaser” permission on your Cloud Build service account
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")@cloudbuild.gserviceaccount.com \
    --role="roles/clouddeploy.releaser"



#Add “clouddeploy.releaser” permission on your compute service account
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
    --role="roles/clouddeploy.releaser"


#Add “clouddeploy.serviceAgent” permission on your Cloud Build service account
gcloud iam service-accounts add-iam-policy-binding  $(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")-compute@developer.gserviceaccount.com \
    --member=serviceAccount:$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")@cloudbuild.gserviceaccount.com \
    --role="roles/clouddeploy.serviceAgent"



#Create an autopilot GKE cluster
gcloud container clusters create-auto cluster-1 --project=${PROJECT_ID} --region=us-central1

#Create an Artifact Registery Repo
gcloud artifacts repositories \
     create my-docker-repo \
     --repository-format=docker \
     --location=us-central1 \
     --description="Docker repository"

