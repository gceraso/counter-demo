# Task Work

I was given an assignment, create and deploy our sweet new counter app. We'll also want to have a docker-compose option so we can continue development. In deploying the app we'll want to make sure we both store our counts in a simple redis database, but also monitor.

## Original Tasks

**TASK 1: Python build**  
Ensure we have proper requirements.txt

**TASK 2: Docker build**  
Create a Dockerfile which builds using above requiremnets.

**TASK 3: docker-compose**  
Build out a docker compose with required services

**TASK 4: Prometheus**  
Create a /metrics endpoint to expose metrics from the flask app

**TASK 5: Deployment**  
Write Kubernetes objects to deploy the application

**TASK 6: Automate Deployment**  
Write a shell script that deploys your application and Prometheus

## Original Code

```python
from flask import Flask
import redis
import os

app = Flask(__name__)

@app.route('/')
def index():
    username = os.environ['REDIS_USERNAME']
    password = os.environ['REDIS_PASSWORD']
    host = os.environ['REDIS_HOST']
    port = os.environ['REDIS_PORT']
    db = os.environ['REDIS_DB']
    
    client = redis.Redis(username=username, password=password, host=host, port=port, db=db)
    key = 'HIT_COUNT'
    
    count = int(client.get(key)) or 0
    response = f'Hello FELFEL. The count is: {count}'
    client.set(key, count + 1)
    
    return response

app.run(host='0.0.0.0', port=8080)
```

## Readjusting 
While this is a great exercise, I decided to improve upon the original goal. So I added a few new tasks for myself

- Why bother deploying a manual image, why not add some CI/CD. So I added a GitHub Actions pipeline to build and deploy the docker image to GitHub's package repo.
- Why not package the Kubernetes manifests into a helm chart, granted there's not much to variabilize, but hey let's be tidy.
- Let's not use shell scripts for deployment. I've been wanting to test out ArgoCD for a while so why not automate deployments with GitOps! So fun. 
- It turns out on first run the application will fail since it does not create the key, it assumes it's already there. Normally this would be handled with DB migrations and such, but we're talking NoSQL. So I added logic to create on first deploy. 
- Let's also write some Terraform to really deploy everything outside of Kubernetes because why not? 
- We'll also make this closer to real world and deploy using an ingress controller and TLS certs. 

## What's Deployed? 

![argo-shot](https://github.com/gceraso/felfel/assets/8634134/0b721309-2a84-4d93-b366-189398c6787e)

## Why use what? 

**Linode/LKE** - Simply put, it's cheap and easy. Great for testing and demoing personal projects.  
**NGINX Ingress** - Simple and standard, especially for a simple example. I've been a fan of Kong for deeper usage of an ingress.  
**LetsEncrypt** - Easily to automate cert generation, and free.  

## Lessons Learned

- Turns out LKE is dead simple, so Terraform for it was also dead simple. Not as exciting of a showcase as I had expected. 
- Linode really doesn't have a place to save Terrafrom state and lock files.
- Found a tool called act(https://github.com/nektos/act) which allows you to run github actions locally. Makes testing so much easier.

## TODO

- Move /metrics to another port/route 
- Automate Terraform deployments.
- Add actual tests for python GitHub Actions.
- While I was able to back up and restore all of ArgoCD, I'd like to be able to save YAMLs based on each application and/or project.
- Build either Prometheus graphs or frontend it with Grafana. 
- Turns out there's a lot of bots out there that are already scraping the new app. I want to add log aggregation to see if I can find some interesting patterns.