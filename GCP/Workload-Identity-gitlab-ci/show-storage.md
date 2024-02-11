# Demo show storage bucket
file `.gitlab-ci.yml`  
Cần 2 biến env `GCP_PROJECT_NAME = values` `GCP_PROJECT_NUMBER = values`  
```
#Update the $GCP_PROJECT_NAME and $GCP_PROJECT_NUMBER values
variables:
  GCP_PROJECT_NAME: $GCP_PROJECT_NAME
  GCP_WORKLOAD_IDENTITY_PROVIDER: "projects/$GCP_PROJECT_NUMBER/locations/global/workloadIdentityPools/gitlab-demo-wip/providers/gitlab-identity-provider"
  SERVICE_ACCOUNT_EMAIL: "gitlab-wif-demo@$GCP_PROJECT_NAME.iam.gserviceaccount.com"

stages:
  - gcp_wif_demo

.gcp_wif_auth: &gcp_wif_auth
  #id_tokens to create JSON web tokens (JWT) to authenticate with third party services.This replaces the CI_JOB_JWT_V2
  id_tokens:
    GITLAB_OIDC_TOKEN:
      aud: https://gitlab.com
  before_script:
    - apt-get update && apt-get install -yq jq
    #Get temporary credentials using the ID token
    - |
      PAYLOAD=$(cat <<EOF
      {
      "audience": "//iam.googleapis.com/${GCP_WORKLOAD_IDENTITY_PROVIDER}",
      "grantType": "urn:ietf:params:oauth:grant-type:token-exchange",
      "requestedTokenType": "urn:ietf:params:oauth:token-type:access_token",
      "scope": "https://www.googleapis.com/auth/cloud-platform",
      "subjectTokenType": "urn:ietf:params:oauth:token-type:jwt",
      "subjectToken": "${GITLAB_OIDC_TOKEN}"
      }
      EOF
      )
    - |
      FEDERATED_TOKEN=$(curl -s -X POST "https://sts.googleapis.com/v1/token" \
      --header "Accept: application/json" \
      --header "Content-Type: application/json" \
      --data "${PAYLOAD}" \
      | jq -r '.access_token'
      )
    #Use the federated token to impersonate the service account linked to workload identity pool
    #The resulting access token is stored in CLOUDSDK_AUTH_ACCESS_TOKEN environment variable and this will be passed to the gcloud CLI
    - |
      export CLOUDSDK_AUTH_ACCESS_TOKEN=$(curl -s -X POST "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/${SERVICE_ACCOUNT_EMAIL}:generateAccessToken" \
      --header "Accept: application/json" \
      --header "Content-Type: application/json" \
      --header "Authorization: Bearer ${FEDERATED_TOKEN}" \
      --data '{"scope": ["https://www.googleapis.com/auth/cloud-platform"]}' \
      | jq -r '.accessToken'
      )

gcloud_test:
  <<: *gcp_wif_auth
  stage: gcp_wif_demo
  image: gcr.io/google.com/cloudsdktool/google-cloud-cli:441.0.0
  script:
    - gcloud config set project ${GCP_PROJECT_NAME}
    - gcloud storage ls
```
