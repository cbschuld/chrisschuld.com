---
title: Redirecting a Domain to Another Domain on AWS with CloudFormation
categories: [AWS]
layout: post
tags: aws cloudformation
---

There are many reasons you might need to redirect one domain to another: rebranding, consolidating properties, or retiring an old domain while preserving traffic. On AWS you can do this entirely with infrastructure as code using CloudFormation, combining S3, CloudFront, ACM, and Route53 into a single stack.

## How It Works

The pattern is similar to a [www-to-root redirect](/posts/redirecting-www-to-the-root-domain/) but the source and destination are completely different domains:

1. **S3 Bucket** - configured to redirect all requests from the source domain (e.g., `domain.net`) to the destination domain (e.g., `domain.com`) over HTTPS.
2. **ACM Certificate** - provisions an SSL certificate for the source domain with DNS validation.
3. **CloudFront Distribution** - provides the HTTPS endpoint in front of the S3 redirect bucket.
4. **Route53 Record** - creates an A record alias for the source domain pointing to CloudFront.

## The Easy Way

Run the automated script which handles everything interactively:

```sh
curl -s https://raw.githubusercontent.com/cbschuld/aws-cf-redirect-to-another-domain/main/create-redirect-to-another-domain.sh > /tmp/create-redirect-to-another-domain.sh && bash /tmp/create-redirect-to-another-domain.sh && rm /tmp/create-redirect-to-another-domain.sh
```

The script prompts for your AWS profile, region, source domain, destination domain, and stack name.

## The CloudFormation Template

Here is the full template for manual deployment:

```yml
AWSTemplateFormatVersion: '2010-09-09'
Description: Redirect domain.net to domain.com with HTTPS

Parameters:
  SourceDomainName:
    Type: String
    Description: The source domain name (e.g., domain.net)
  DestinationDomainName:
    Type: String
    Description: The destination domain name (e.g., domain.com)
  HostedZoneId:
    Type: String
    Description: The Route 53 Hosted Zone ID for the SourceDomainName

Resources:
  RedirectBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub "${SourceDomainName}"
      WebsiteConfiguration:
        RedirectAllRequestsTo:
          HostName: !Ref DestinationDomainName
          Protocol: https
  Certificate:
    Type: AWS::CertificateManager::Certificate
    Properties:
      DomainName: !Ref SourceDomainName
      ValidationMethod: DNS
      DomainValidationOptions:
        - DomainName: !Ref SourceDomainName
          HostedZoneId: !Ref HostedZoneId
  CloudFrontDistribution:
    Type: AWS::CloudFront::Distribution
    Properties:
      DistributionConfig:
        Aliases:
          - !Ref SourceDomainName
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
        Comment: !Sub "Redirect ${SourceDomainName} to ${DestinationDomainName}"
        Enabled: true
        ViewerCertificate:
          AcmCertificateArn: !Ref Certificate
          SslSupportMethod: sni-only
  Route53Record:
    Type: AWS::Route53::RecordSetGroup
    Properties:
      HostedZoneId: !Ref HostedZoneId
      RecordSets:
        - Name: !Ref SourceDomainName
          Type: A
          AliasTarget:
            DNSName: !GetAtt CloudFrontDistribution.DomainName
            HostedZoneId: Z2FDTNDATAQYW2
          Weight: 1
          SetIdentifier: "Redirect"

Outputs:
  CertificateArn:
    Value: !Ref Certificate
    Export:
      Name: !Sub "${AWS::StackName}-CertificateArn"
  DomainName:
    Description: The CloudFront Distribution DNS name for the redirect
    Value: !GetAtt CloudFrontDistribution.DomainName
  CloudFrontDistributionID:
    Description: The CloudFront Distribution ID for the redirect
    Value: !Ref CloudFrontDistribution
```

## Prerequisites

Retrieve the Hosted Zone ID for the **source** domain (the one you are redirecting away from):

```sh
PROFILE_NAME="your-profile"
DOMAIN_NAME="domain.net"

aws route53 list-hosted-zones-by-name --profile=$PROFILE_NAME | \
  jq --arg name "$DOMAIN_NAME." \
  -r '.HostedZones | .[] | select(.Name=="\($name)") | .Id'
```

## Manual Deployment

Deploy the stack with the source domain, destination domain, and hosted zone ID:

```sh
aws cloudformation create-stack --stack-name domain-redirect \
  --template-body file://redirect-to-another-domain.yml \
  --parameters \
  ParameterKey=SourceDomainName,ParameterValue=domain.net \
  ParameterKey=DestinationDomainName,ParameterValue=domain.com \
  ParameterKey=HostedZoneId,ParameterValue=Z1UVA2VESUQ1UN \
  --region=us-east-1 \
  --profile=your-profile
```

The source domain must be hosted in Route53 for DNS validation and the alias record to work. The destination domain can be hosted anywhere.

## Related

For redirecting `www` to the root of the same domain, see [Redirecting WWW to the Root Domain on AWS with CloudFormation](/posts/redirecting-www-to-the-root-domain/). For creating standalone SSL certificates, see [Creating an SSL Certificate in AWS with CloudFormation](/posts/create-certificate-in-aws-with-cloudformation/).

This CloudFormation template is [managed in source control on GitHub](https://github.com/cbschuld/aws-cf-redirect-to-another-domain).
