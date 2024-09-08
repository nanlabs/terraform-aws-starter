# Terraform AWS Starter Kit 🔥 🚀

Welcome to the Terraform AWS Starter Kit! This comprehensive and robust starter kit will empower you to quickly and confidently set up your AWS infrastructure. With secure state management, scalable VPC configuration, enhanced security features, database provisioning, secrets management, SSM parameter store integration, and GitHub Actions integration, this starter kit incorporates proven best practices for building reliable and maintainable AWS environments.

<div align="center">

📖 CLICK OR TAP ❲☰❳ TO SHOW TABLE-OF-CONTENTS 📖

</div> <!-- center -->

## Motivation

The Terraform AWS Starter Kit solves the most challenging aspect of AWS infrastructure building by providing a powerful solution for our clients. Our goal is to simplify the process of setting up a reliable and scalable AWS environment, allowing you to focus on developing and deploying your applications swiftly and confidently.

## Key Features

### Secure State Management 🔒

The Terraform AWS Starter Kit includes secure state management configurations. Your Terraform state is stored in an S3 bucket with a DynamoDB table for state locking. This ensures the security of your infrastructure's state and facilitates easy management and sharing among team members.

### Scalable VPC Configuration 🌐

Our starter kit provisions a Virtual Private Cloud (VPC) with public and private subnets across three availability zones. This scalable VPC configuration enables the segregation of application and database resources, providing high availability for your infrastructure components.

### Enhanced Security 🔐

The starter kit implements security groups for the bastion host and database instances, ensuring controlled access to your resources. The bastion host allows secure access to private resources within the VPC, providing an additional layer of security.

### Database Provisioning 🗃️

We have included configurations to provision an RDS PostgreSQL instance, RDS Aurora cluster, MSK cluster, MongoDB Atlas cluster, and more. These configurations enable you to set up and manage your databases with ease, ensuring optimal performance and reliability for your applications.

### Kubernetes Cluster Provisioning 🚢

Our starter kit includes configurations to provision an Amazon Elastic Kubernetes Service (EKS) cluster. This enables you to deploy and manage containerized applications using Kubernetes, leveraging the scalability and flexibility of AWS for your workloads.

### Secrets Management 🔑

The Terraform AWS Starter Kit integrates with AWS Secrets Manager to securely store and manage your database credentials. This ensures that sensitive information, such as usernames and passwords, is not exposed in your Terraform code or version control system.

### Parameter Management 🔧

Our starter kit leverages AWS Systems Manager (SSM) Parameter Store to store and manage various parameters required for your infrastructure, such as VPC ID, subnet IDs, and other configuration details. This centralizes the management of configuration parameters, making it easier to update and maintain your infrastructure as it evolves.

### GitHub Actions Integration 🚀

We have preconfigured GitHub Actions workflows that provide linting, security checks, and more for your Terraform code. This integration enables automated checks and validation, ensuring adherence to coding standards and identifying potential security vulnerabilities early in the development process.

- Pull Request validation with [Danger](https://danger.systems/js), markdown linting, and more! ✅
- Linter validation with [Mega-Linter](https://github.com/oxsecurity/megalinter)! 📝
- Terraform Format validation with [Terraform Fmt](https://www.terraform.io/docs/commands/fmt.html). 🔄
- Terraform Security validation with [Terraform Security](https://github.com/aquasecurity/tfsec). 🔒
- Terraform Docs update with [terraform-docs](https://terraform-docs.io/). 📝
- TODOs to GitHub Issues with [TODOs to Issues](https://github.com/alstr/todo-to-issue-action). 📌

By using the Terraform AWS Starter Kit, you can expedite the initial setup of your AWS infrastructure while incorporating proven best practices. It empowers you to focus on building and deploying your applications while providing a solid foundation for scalability, security, and maintainability.

We welcome contributions and feedback to improve this starter kit further, making it a valuable resource for the community.

## Prerequisites

- [Direnv](https://direnv.net/) for loading environment variables.
- [Terraform](https://www.terraform.io/downloads.html) for infrastructure provisioning.
- [TFswitch](https://tfswitch.warrensbox.com/) to switch between Terraform versions easily.

## Quick Start

To get started, clone this repository and navigate to the desired directory:

```sh
git clone git@github.com:nanlabs/terraform-aws-starter.git
cd terraform-aws-starter
```

Then set up the environment variables using `direnv`:

```sh
# Create a new .envrc file in the root directory
cp .envrc.example .envrc

# Update the .envrc file with your environment variables

# Load the environment variables
direnv allow
```

After that, explore the available live modules and scripts, and follow the instructions provided in their respective README files. For a more hands-on introduction, you can start with the examples provided in the [**Live Infrastructure**](#live-infrastructure) and [**Infra Tools**](#infra-tools-and-scripts) sections.

## Live Infrastructure

The `live` directory houses our active infrastructure configurations. These configurations are organized by domain, allowing you to manage different parts of your infrastructure separately.

| Module                                                                | Description                                                                             |
| :-------------------------------------------------------------------- | :-------------------------------------------------------------------------------------- |
| [Terraform Backend Configuration](./live/terraform-backend/README.md) | Set up the Terraform backend with an S3 bucket and DynamoDB table for state management. |
| [AWS IAM Management](./live/iam-management/README.md)                 | Manage IAM roles and policies.                                                          |
| [Core Networking](./live/core-networking/README.md)                   | Manage core networking components such as VPCs, subnets, and security groups.           |
| [Services Platform](./live/services-platform/README.md)               | Manage services platform components, including EKS clusters.                            |
| [Common Infrastructure](./live/common-infra/README.md)                | Manage common infrastructure components such as RDS instances and DocumentDB clusters.  |

## Terraform Modules

Our custom Terraform modules are located in the `modules` directory. These modules are reusable and help you bootstrap various parts of your infrastructure.

| Module                                               | Description                                                   |
| :--------------------------------------------------- | :------------------------------------------------------------ |
| [Amplify App](./modules/amplify-app/README.md)       | Bootstrap an Amplify app.                                     |
| [Bastion](./modules/bastion/README.md)               | Bootstrap a bastion host.                                     |
| [DocumentDB Cluster](./modules/docdb/README.md)      | Bootstrap a DocumentDB cluster.                               |
| [EKS](./modules/eks/README.md)                       | Bootstrap an EKS cluster.                                     |
| [AWS IAM Role](./modules/iam-role/README.md)         | Bootstrap an AWS IAM role.                                    |
| [MongoDB Atlas Cluster](./modules/mongodb/README.md) | Bootstrap a MongoDB Atlas cluster.                            |
| [MSK Cluster](./modules/msk/README.md)               | Bootstrap an MSK cluster.                                     |
| [RDS Instance](./modules/rds/README.md)              | Bootstrap an RDS Instance.                                    |
| [RDS Aurora Cluster](./modules/rds-aurora/README.md) | Bootstrap an RDS Aurora Cluster.                              |
| [VPC](./modules/vpc/README.md)                       | Bootstrap a VPC for shared infrastructure.                    |
| [VPC Endpoint](./modules/vpc-endpoint/README.md)     | Bootstrap VPC endpoints for S3, DynamoDB, and other services. |

In case you need to create a new module, you can use the [Terraform Module Template](./modules/__template__/README.md) as a starting point.

For reference, you can also check the [Terraform Registry](https://registry.terraform.io/) for additional modules.

## Apps and Services

In addition to infrastructure provisioning, we have included a few apps and services to help you get started. These are located in the `apps` directory and provide useful examples of how to use the infrastructure we have provisioned.

| Service                                                         | Description                                                                               |
| :-------------------------------------------------------------- | :---------------------------------------------------------------------------------------- |
| [Start and Stop EC2 Instance](./apps/start-stop-ec2-instances/) | A Serverless Framework-based project to start and stop EC2 instances based on a schedule. |

## Infra Tools and Scripts

This section contains additional tools and scripts that complement our Terraform modules, helping you manage specific tasks.

**What tools and scripts are available?**

- Bastion Host Connection script: Connect to an AWS Bastion host securely.
- Generate `kubeconfig` script: Generate a `kubeconfig` file for an EKS Cluster.
- Tunnel to EKS Cluster script: Create a tunnel to an EKS Cluster for `kubectl` access.
- and more!

Refer to the [Infra Tools and Scripts README](./scripts/README.md) for more details and usage examples!

## Best practices

- We recommend using automated code scanning tools to improve security and quality of the code. This pattern was scanned using [Checkov](https://www.checkov.io/) - a static code analysis tool for infrastructure-as-code. It scans cloud infrastructure code defined using Terraform, CloudFormation, Kubernetes, Helm, ARM Templates and Serverless framework platforms and detects security and compliance misconfigurations.
- Additionally, we recommend at minimum to perform basic validation and formatting checks using `terraform validate` and `terraform fmt -check -recursive` Terraform commands.
- It’s a good practice to add automated tests for infrastructure code. You can refer to this Terraform Blog post to learn more about different approaches to testing Terraform code.

## Contributing

We appreciate contributions from the open-source community. Any contributions you make are **truly appreciated**. Please refer to our [contribution guidelines](./CONTRIBUTING.md) for more information.

## Contributors

[![Contributors](https://contrib.rocks/image?repo=nanlabs/terraform-aws-starter)](https://github.com/nanlabs/terraform-aws-starter/graphs/contributors)

Made with [contributors-img](https://contrib.rocks).
