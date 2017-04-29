## TEMPLATE Terraform APP project
# PROMOTE THE APP USING GIT BRANCHES

## CONSUMPTION

#### GIT Branch Model:

* master  = DEV
* qat = QAT
* stg = STG
* etc,.,

## CONTRIBUTION

* Changes are to be made as feature branch with pull request created
* Changes are to be peer reviewed
* Purpose of change or ticket number associated to be listed below

## USAGE

1. configure your secrets file - Optional

#### Where secrets-dev.tfvars is something like:

```
# provider core reqs
account_id = "<Replace Me>"
aws_profile = "aws_account_name"
shared_credentials_file = "/Users/<Replace Me/.aws/credentials"
keypair = "<Replace Me>"
on_prem_gw = "900.900.900.900"

log_access_key = "key"
log_secret_key = "pass"
```

2. Configure terraform for remote:

#### S3 will automatically create path in bucket for this file, no manual intervention required.
#### Make required substitutions below

```
$ Enter directory of this project
$ terraform remote config \
    -backend=s3 \
    -backend-config="bucket=<Replace Me>" \
    -backend-config="key=APP/<Replace Me>/<environment>/terraform.tfstate" \
    -backend-config="region=us-west-1" \
    -backend-config="profile=<Profile Name>"
```

e.g
terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=APP/tf-template/cmn/terraform.tfstate" -backend-config="region=us-east-1"


3. execute terraform

#### Assuming project location is parallel to tf-base project
#### Based on the GIT branch *cmn* needs to be changed, this defines the environment for the app.

```
terraform plan  
-var-file="../../infra/infra.tfvars" \
-var-file="../../infra/cmn/cmn.tfvars" \
-var-file="stack.tfvars"
```
