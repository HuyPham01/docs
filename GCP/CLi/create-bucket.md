# list bucket
```
gcloud storage ls
```
# create bucket
logs `403 Access denied` 

```
gcloud storage buckets create gs://bucket-name --location=asia-southeast1 --log-http --verbosity=debug
```
fix
```
gcloud projects add-iam-policy-binding hiepnn-linux11111 \
  --member serviceAccount:id-compute@developer.gserviceaccount.com \
  --role=roles/storage.admin
```
