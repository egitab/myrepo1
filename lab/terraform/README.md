# REQUIREMENTS
AWS: Setup Programmatic Access
==============================

1) Login to AWS Console -> Services -> IAM
  Perform the following steps
    a) Add new user and key in the UserName
    b) Attach Existing Policies and Select Admin
    c) Complete and download "Access key ID" and "Secret access key"

### Config files:
~/.aws/config (perm: 400)
```
[profile default]
region = myregion
output = json
[profile myprofile1]
region = myregion1
output = json
...
```
~/.aws/credentials (perm: 400)
```
[default]
aws_access_key_id = ABCDEFGHILMNOPQRSTUV
aws_secret_access_key = abcdefghilmnopqrstuvxwz01234567890/98767
[myprofile1]
aws_access_key_id = ABCDEFGHILMNOPQRSTUV
aws_secret_access_key = abcdefghilmnopqrstuvxwz01234567890/98767
...
```
### Download and Install Terraform CLI
### Terraform steps to deploy:
```
terraform init
terraform validate
terraform plan
terraform apply
```


