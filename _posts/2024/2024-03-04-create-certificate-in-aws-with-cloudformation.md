---
title: Creating an SSL Certificate in AWS with CloudFormation
categories: [AWS]
layout: post
tags: aws ssl
---

Creating and managing SSL certificates in AWS is crucial for securing API Gateway, ALB, or ELB-based applications. While manual certificate creation is an option, it lacks the scalability and integration benefits that AWS [CloudFormation](https://aws.amazon.com/cloudformation/) offers. This post will guide you through the process of automating SSL certificate creation and management in AWS using CloudFormation, ensuring a secure and efficient deployment. Learn how to leverage CloudFormation to not only create but also seamlessly reference SSL certificates in your AWS Stacks, enhancing your application's security and your infrastructure's manageability.

You can create them with CloudFormation using the following YAML file:

```yml
AWSTemplateFormatVersion: "2010-09-09"
Parameters:
  DomainName:
    Description: "Domain for which you are requesting a cert"
    Type: String
    Default: example.com # Put your own domain name here
  HostedZoneId:
    Description: "hosted zone id in which CNAME record for the validation needs to be added"
    Type: String
    Default: XYZABCDERYH # Put the hosted zone id in which CNAME record for the validation needs to be added

Resources:
  Certificate:
    Type: AWS::CertificateManager::Certificate
    Properties:
      DomainName: !Ref DomainName
      SubjectAlternativeNames:
        - !Sub "*.${DomainName}"
      DomainValidationOptions:
        - DomainName: !Ref DomainName
          HostedZoneId: !Ref HostedZoneId
      ValidationMethod: DNS
Outputs:
  CertificateArn:
    Value: !Ref Certificate
    Export:
      Name: !Sub "${AWS::StackName}-CertificateArn"
```

You will need the `HostedZoneId` which you can get from the command line or from the AWS UI/UX.  This does require `jq` and `cut` which you may need to install.

```sh
REGION=us-east-1
PROFILE_NAME="getsixdegrees"
DOMAIN_NAME="getsixdegrees.com"
STACK_NAME=$(echo "$DOMAIN_NAME" | sed 's/\./-/g')-certificate
HOSTED_ZONE=$(aws route53 list-hosted-zones-by-name --profile="$PROFILE_NAME" |
  jq --arg name "$DOMAIN_NAME." -r '.HostedZones | .[] | select(.Name==$name) | .Id' |
  cut -d'/' -f3)
echo $HOSTED_ZONE
```

You can upload [this YAML file](https://raw.githubusercontent.com/cbschuld/aws-cf-static-website-hosting-s3-cloudfront-route53/main/certificate.yml) via CloudFront's UI/UX or you can run it via command line:

```sh
wget -O certificate.yml https://raw.githubusercontent.com/cbschuld/aws-cf-static-website-hosting-s3-cloudfront-route53/main/certificate.yml
aws cloudformation create-stack --stack-name $STACK_NAME \
--template-body file://certificate.yml \
--parameters \
ParameterKey=DomainName,ParameterValue=$DOMAIN_NAME \
ParameterKey=HostedZoneId,ParameterValue=$HOSTED_ZONE \
--region=$REGION \
--profile=$PROFILE_NAME
```


After the Stack is complete and successful you can get the certificate's ARN value.  This command will return just the value of the CertificateArn output parameter from the specified stack, without any additional formatting or information.

```sh
aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --query "Stacks[0].Outputs[?OutputKey=='CertificateArn'].OutputValue" \
  --output text \
  --region=$REGION \
  --profile=$PROFILE_NAME
```

This certificate YAML file is [managed in change control on github](https://github.com/cbschuld/aws-cf-static-website-hosting-s3-cloudfront-route53).