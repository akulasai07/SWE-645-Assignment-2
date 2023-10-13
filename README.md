# Project Name: SWE645 Instructions file for extended installation steps and supported screenshots

## Description

This README provides step-by-step instructions for setting up a development and deployment environment for your project. The environment involves technologies like Docker, Kubernetes, Jenkins, and GitHub. 

## Table of Contents

- [Initial Setup](#initial-setup)
- [Ubuntu Server / Docker](#ubuntu-server--docker)
- [Kubernetes Registration, Cluster Creation, and Deployment](#kubernetes-registration-cluster-creation-and-deployment)
- [Automating Build and Release using Jenkins](#automating-build-and-release-using-jenkins)

### Demo Videos
#### Installation video
https://gmuedu-my.sharepoint.com/:v:/g/personal/psharm24_gmu_edu/EUOEQ5rCf8FPuqOZi__b_fsBcXzFEWY17IiIplys5i6xjg?e=eJkWib

#### Demo Video
https://gmuedu-my.sharepoint.com/:v:/g/personal/mraval_gmu_edu/EYuFnHbuHh1Bh1TjcyLDx0gBFrhUCOaczepkDZSus7MsFQ?e=f06jHq4
## Initial Setup

### 1. GitHub Repository

- Create a GitHub repository for your project. [Example Repo](https://github.com/pranay-sharma793/CS-645-Assignment)

### 2. Docker Hub

- Create a repository on Docker Hub where you will push your `.war` file. [Docker Hub Repo](https://hub.docker.com/repository/docker/pranaysharma793/surveyformcd/general)

## Ubuntu Server / Docker

### 1. Start EC2 Instance

- Start an EC2 instance with the Ubuntu AMI. [Rancher Dashboard](https://ec2-34-198-210-248.compute-1.amazonaws.com/dashboard/home)

### 2. Install Docker

- Install Docker on the EC2 instance.

### 3. Run Rancher

- Run Rancher on the EC2 instance. Verify its status with `sudo docker ps`.

### 4. Access Rancher Dashboard

- Access the Rancher dashboard at the public DNS address of the EC2 instance.

### 5. Create a Custom Cluster

- Create a custom cluster in Rancher.

## Kubernetes Registration, Cluster Creation, and Deployment

### 1. Setup Kubernetes Server

- Create another EC2 instance with sufficient storage (minimum 25GB) and an Ubuntu AMI. [Example K8s Server](ec2-54-147-49-153.compute-1.amazonaws.com)

### 2. Install Docker

- Install Docker on the new EC2 instance.

### 3. Register Cluster Nodes

- Register the nodes for your cluster on the new instance using the provided command.

### 4. Create Deployments

- Create two deployments, one as NodePort and one as LoadBalancer.

### 5. Download KubeConfig

- Download the KubeConfig file for your cluster and save it.

### 6. Deploy the Application

- Provide the Docker Hub repository address for this deployment to pull the image and deploy.
- Verify that the pods are created and their status is 'running'.
- Check the logs for the pod using `kubectl logs <pod_name>` to ensure the `.war` file was successfully loaded.
- Access the 'Student Survey' form from the deployed services address.

## Automating Build and Release using Jenkins

### 1. Setup Jenkins

- Create another EC2 instance to host Jenkins. [Example Jenkins](http://ec2-54-211-13-48.compute-1.amazonaws.com:8080)

### 2. Install Jenkins

- Install Java on this instance and then install Jenkins.

### 3. Configure KubeConfig

- Create a directory named `/.kube` and copy the contents of the 'KubeConfig' file into a new file named 'config'.
- Verify the current context using `kubectl config current-context` to ensure it returns the cluster name created in Rancher.

### 4. Set Up Jenkins Pipeline

- Create a Jenkins pipeline and install necessary plugins, such as CloudBees Docker and Rancher.

### 5. Configure the Pipeline

- Configure the pipeline with your GitHub repository as the source.
- Set up polling of the SCM every minute and provide access to the JenkinsFile stored in the GitHub repository.

### 6. JenkinsFile

- Create and push a 'JenkinsFile' containing stages for building, pushing to Docker Hub, and deploying on Rancher (both single-node and multi-node).

### 7. Automation

- Once the pipeline is set up, any code changes pushed to GitHub will trigger a new build.
- Verify that the new build is pushed to Docker Hub and the image is updated in Rancher deployments.

