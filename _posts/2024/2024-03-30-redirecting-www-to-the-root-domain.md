---
title: Redirecting WWW to the Root Domain on AWS with CloudFormation
categories: [AWS]
layout: post
tags: aws cloudformation
---

When running a website it is common to want `www.example.com` to redirect to `example.com`. On AWS this requires coordinating several services: an S3 bucket for the redirect rule, a CloudFront distribution for SSL termination, an ACM certificate for HTTPS, and Route53 for DNS. A CloudFormation template ties it all together into a single deployable stack.

## How It Works

The architecture uses four AWS resources working together:

1. **S3 Bucket** - configured with `RedirectAllRequestsTo` pointing at the root domain over HTTPS. S3 handles the actual 301 redirect.
2. **ACM Certificate** - provisions an SSL certificate for `www.example.com` with DNS validation via Route53.
3. **CloudFront Distribution** - sits in front of the S3 bucket, providing the HTTPS endpoint and global edge caching.
4. **Route53 Record** - creates an A record alias for `www.example.com` pointing to the CloudFront distribution.

## The Easy Way

You can run the automated script which handles hosted zone lookup, certificate creation, and stack deployment:

```sh
curl -s https://raw.githubusercontent.com/cbschuld/aws-cf-redirect-www-to-root/main/create-redirect-www-to-root.sh > /tmp/create-redirect-www-to-root.sh && bash /tmp/create-redirect-www-to-root.sh && rm /tmp/create-redirect-www-to-root.sh
```

The script prompts for your AWS profile, region, domain, and stack name, then deploys everything automatically.

## The CloudFormation Template

If you prefer to deploy manually, here is the full template:

```yml
AWSTemplateFormatVersion: '2010-09-09'
Description: Redirect www.mydomain.com to mydomain.com with HTTPS

Parameters:
  DomainName:
    Type: String
    Description: The primary domain name (e.g., mydomain.com)
  HostedZoneId:
    Type: String
    Description: The Route 53 Hosted Zone ID for the DomainName

Resources:
  RedirectBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub "www.${DomainName}"
      WebsiteConfiguration:
        RedirectAllRequestsTo:
          HostName: !Ref DomainName
          Protocol: https
  Certificate:
    Type: AWS::CertificateManager::Certificate
    Properties:
      DomainName: !Sub "www.${DomainName}"
      ValidationMethod: DNS
      DomainValidationOptions:
        - DomainName: !Sub "www.${DomainName}"
          HostedZoneId: !Ref HostedZoneId
  CloudFrontDistribution:
    Type: AWS::CloudFront::Distribution
    Properties:
      DistributionConfig:
        Aliases:
          - !Sub "www.${DomainName}"
        Origins:
          - Id: S3-RedirectOrigin
            DomainName: !Select [1, !Split ["http://", !GetAtt RedirectBucket.WebsiteURL]]
            CustomOriginConfig:
              HTTPPort: 80
              HTTPSPort: 443
              OriginProtocolPolicy: http-only
              OriginSSLProtocols:
                - TLSv1.2
        DefaultCacheBehavior:
          TargetOriginId: S3-RedirectOrigin
          ForwardedValues:
            QueryString: false
          ViewerProtocolPolicy: redirect-to-https
        Comment: !Sub "Redirect www.${DomainName} to ${DomainName}"
        Enabled: true
        ViewerCertificate:
          AcmCertificateArn: !Ref Certificate
          SslSupportMethod: sni-only
  Route53Record:
    Type: AWS::Route53::RecordSetGroup
    Properties:
      HostedZoneId: !Ref HostedZoneId
      RecordSets:
        - Name: !Sub "www.${DomainName}."
          Type: A
          AliasTarget:
            DNSName: !GetAtt CloudFrontDistribution.DomainName
            HostedZoneId: Z2FDTNDATAQYW2
          Weight: 1
          SetIdentifier: "wwwRedirect"

Outputs:
  CertificateArn:
    Value: !Ref Certificate
    Export:
      Name: !Sub "${AWS::StackName}-CertificateArn"
  DomainName:
    Description: The CloudFront Distribution DNS name for the www redirect
    Value: !GetAtt CloudFrontDistribution.DomainName
  CloudFrontDistributionID:
    Description: The CloudFront Distribution ID for the www redirect
    Value: !Ref CloudFrontDistribution
```

## Prerequisites

You need the Hosted Zone ID for your domain. You can retrieve it with the AWS CLI (requires `jq`):

```sh
PROFILE_NAME="your-profile"
DOMAIN_NAME="example.com"

aws route53 list-hosted-zones-by-name --profile=$PROFILE_NAME | \
  jq --arg name "$DOMAIN_NAME." \
  -r '.HostedZones | .[] | select(.Name=="\($name)") | .Id'
```

## Manual Deployment

With the hosted zone ID in hand, deploy the stack:

```sh
aws cloudformation create-stack --stack-name www-redirect \
  --template-body file://redirect-www-to-root.yml \
  --parameters \
  ParameterKey=DomainName,ParameterValue=example.com \
  ParameterKey=HostedZoneId,ParameterValue=Z1UVA2VESUQ1UN \
  --region=us-east-1 \
  --profile=your-profile
```

The stack takes a few minutes to complete as CloudFront provisions the distribution and the ACM certificate validates via DNS.

## Related

If you need to create a standalone SSL certificate for use with other services, see [Creating an SSL Certificate in AWS with CloudFormation](/posts/create-certificate-in-aws-with-cloudformation/). For hosting a full static site or SPA, see [Deploying Secure and Scalable Single Page Applications on AWS](/posts/deploy-a-secure-andscalable-single-page-applications-on-aws/).

This CloudFormation template is [managed in source control on GitHub](https://github.com/cbschuld/aws-cf-redirect-www-to-root).
