---
title: Creating a user in Cognito quickly with a verified password
categories: [Development, AWS]
layout: post
tags: vscode
---

Creating a user in cognito takes a bit of time and I find myself needing to do it for testing a lot.  Here is a nice utility script that I use for creating the user quickly.

Th script collects user input via `read` for various details including AWS profile, Cognito User Pool ID, email, first name, last name, and password, and then uses these details to create a user in AWS Cognito with the email verified and a permanent password, you can follow the script template below.

Before running this script, ensure you have the AWS CLI installed and configured on your system. The script assumes that you have the necessary permissions to manage Cognito user pools and users.

```shell
#!/bin/zsh

# Prompt for user input
echo "Enter AWS CLI Profile Name:"
read profile

echo "Enter Cognito User Pool ID:"
read poolId

echo "Enter User Email:"
read email

echo "Enter First Name:"
read firstName

echo "Enter Last Name:"
read lastName

echo "Enter Password (input will be hidden):"
read -s password

# Create user in Cognito User Pool
aws cognito-idp admin-create-user \
    --profile=$profile \
    --user-pool-id $poolId \
    --username $email \
    --user-attributes Name="email",Value="$email" Name="email_verified",Value="true" Name="given_name",Value="$firstName" Name="family_name",Value="$lastName" \
    --temporary-password "TempPass1!" \
    --message-action "SUPPRESS"

# Update user attributes if necessary (e.g., to ensure email_verified is true)
# This step is optional since we already set email_verified during creation
aws cognito-idp admin-update-user-attributes \
    --profile=$profile \
    --user-pool-id $poolId \
    --username $email \
    --user-attributes Name="email_verified",Value="true"

# Set user password to permanent (and thus, no need for a forced change on first login)
aws cognito-idp admin-set-user-password \
    --profile=$profile \
    --user-pool-id $poolId \
    --username $email \
    --password "$password" \
    --permanent

echo "User creation and configuration completed."
```