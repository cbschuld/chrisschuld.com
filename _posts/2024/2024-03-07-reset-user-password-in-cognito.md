---
title: Reset User Password in Cognito (with easy to use script)
categories: [Development, AWS]
layout: post
tags: vscode
---

You can reset a password for a user in Amazon Cognito using the AWS Command Line Interface (CLI). To perform this action, you'll typically use the admin-set-user-password command. This command allows you to set a new password for a user in the specified user pool and mark it as permanent or temporary (forcing a password change on the next login).

This script just makes it easier for re-use.  It will ask for the profile (for the AWS named profiles), the AWS Cognito Pool ID, the username and the new password.

Before running this script, ensure you have the AWS CLI installed and configured on your system. The script assumes that you have the necessary permissions to manage Cognito user pools and users.

```shell
#!/bin/zsh

# Prompt for user input
echo "Enter AWS CLI Profile Name:"
read profile

echo "Enter Cognito User Pool ID:"
read poolId

echo "Enter Username:"
read username

echo "Enter Password (input will be hidden):"
read -s password

# Reset user password
aws cognito-idp admin-set-user-password \
    --profile=$profile \
    --user-pool-id $poolId \
    --username $username \
    --password $password \
    --permanent

echo "User password reset."
```