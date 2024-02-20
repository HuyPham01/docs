There are two types of service accounts for Compute Engine.  
1. The `default service account` is assigned to the instance.  
2. The `Compute Engine Service Agent` is used by Google services to manage your resources.
You assigned the role to the service account.
The Compute Engine Service Agent has the following format:
```
service-PROJECT_NUMBER@compute-system.iam.gserviceaccount.com
```
## Step 1: Create role 
Login to the Google Cloud Console  
To to `IAM & Admin` 
Select `Role`  
Click `Create Role`
Click `Title` v.v.v  
Click `Add permissions` -> `Filter`: `[compute.instances.start,compute.instances.stop]`  
Click `Save`

## Giải pháp
Login to the Google Cloud Console  
To to IAM & Admin  
Select IAM in the left panel  
Click the box `Include Google-provided` role grants on the right side of the window. This enables showing Google-managed service accounts.  

Click the `pencil` icon to edit the service account.  
Click `ADD ANOTHER ROLE`  
In the role filter enter `Compute`. Select `role name title step1`.  
Click `SAVE`  
