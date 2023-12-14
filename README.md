# Terraform AWS Starter Kit 🔥 🚀

Welcome to the Terraform AWS Starter Kit! This comprehensive and robust starter kit will empower you to quickly and confidently set up your AWS infrastructure. With secure state management, scalable VPC configuration, enhanced security features, database provisioning, secrets management, SSM parameter store integration, and GitHub Actions integration, this starter kit incorporates proven best practices for building reliable and maintainable AWS environments.

<div align="center">

📖 CLICK OR TAP ❲☰❳ TO SHOW TABLE-OF-CONTENTS 📖

</div> <!-- center -->

## Motivation

The Terraform AWS Starter Kit solves the most challenging aspect of AWS infrastructure building by providing a powerful solution for our clients. Our goal is to simplify the process of setting up a reliable and scalable AWS environment, allowing you to focus on developing and deploying your applications swiftly and confidently.

<picture>
  <source media="(prefers-color-scheme: dark)" alt="" align="right" width="400px" srcset="./tools/dac/live_prod_infrastructure.png"/>
  <img alt="" align="right" width="400px" src="./tools/dac/live_prod_infrastructure.png"/>
</picture>

## Key Features

### Secure State Management 🔒

The Terraform AWS Starter Kit includes secure state management configurations. Your Terraform state is stored in an S3 bucket with a DynamoDB table for state locking. This ensures the security of your infrastructure's state and facilitates easy management and sharing among team members.

### Scalable VPC Configuration 🌐

Our starter kit provisions a Virtual Private Cloud (VPC) with public and private subnets across three availability zones. This scalable VPC configuration enables the segregation of application and database resources, providing high availability for your infrastructure components.

### Enhanced Security 🔐

The starter kit implements security groups for the bastion host and database instances, ensuring controlled access to your resources. The bastion host allows secure access to private resources within the VPC, providing an additional layer of security.

### Database Provisioning 🗃️

We have included configurations to provision an RDS PostgreSQL instance and other database resources. This allows you to easily set up and manage your database infrastructure in a consistent and reproducible manner.

### Secrets Management 🔑

The Terraform AWS Starter Kit integrates with AWS Secrets Manager to securely store and manage your database credentials. This ensures that sensitive information, such as usernames and passwords, is not exposed in your Terraform code or version control system.

### Parameter Management 🔧

Our starter kit leverages AWS Systems Manager (SSM) Parameter Store to store and manage various parameters required for your infrastructure, such as VPC ID, subnet IDs, and other configuration details. This centralizes the management of configuration parameters, making it easier to update and maintain your infrastructure as it evolves.

### GitHub Actions Integration 🚀

We have preconfigured GitHub Actions workflows that provide linting, security checks, and more for your Terraform code. This integration enables automated checks and validation, ensuring adherence to coding standards and identifying potential security vulnerabilities early in the development process.

- Pull Request validation with [Danger](https://danger.systems/js), markdown linting, and more! ✅
- Linter validation with [Super-Linter](https://github.com/super-linter/super-linter)! 📝
- Terraform Format validation with [Terraform Fmt](https://www.terraform.io/docs/commands/fmt.html). 🔄
- Terraform Security validation with [Terraform Security](https://github.com/aquasecurity/tfsec). 🔒
- Terraform Docs update with [terraform-docs](https://terraform-docs.io/). 📝
- TODOs to GitHub Issues with [TODOs to Issues](https://github.com/alstr/todo-to-issue-action). 📌

By using the Terraform AWS Starter Kit, you can expedite the initial setup of your AWS infrastructure while incorporating proven best practices. It empowers you to focus on building and deploying your applications while providing a solid foundation for scalability, security, and maintainability.

We welcome contributions and feedback to improve this starter kit further, making it a valuable resource for the community.

## Quick Start

Check the [Live Infrastructure](#live-infrastructure) section for more information about existing infrastructure modules and how to use them.

Once you have chosen the infrastructure module you want to use, move to the module directory and follow the instructions in the README file.

## Live Infrastructure

The `live` directory houses our live infrastructure. This is where you'll find our Terraform variables, backend configuration, and Terraform root modules.

It is recommended to create a separate directory for each environment (e.g., `dev`, `staging`, `prod`) and region (e.g., `us-east-1`, `us-west-2`, `eu-west-1`). This allows you to easily manage and deploy your infrastructure.

| Module                                                                           | Description                                           |
| :------------------------------------------------------------------------------- | :---------------------------------------------------- |
| [Prod App Infrastructure (us-west-2)](./live/prod/us-west-2/app/README.md)       | Terraform root module for our prod infrastructure.    |
| [Staging App Infrastructure (us-west-2)](./live/staging/us-west-2/app/README.md) | Terraform root module for our staging infrastructure. |

## Terraform Modules

We have created custom Terraform modules to bootstrap our infrastructure, which are located in the `modules` directory.

| Module                                               | Description                                                                                                                                             |
| :--------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [Amplify App](./modules/amplify-app/README.md)       | Terraform module for bootstrapping an Amplify app.                                                                                                      |
| [Bastion](./modules/bastion/README.md)               | Terraform module for bootstrapping a bastion host.                                                                                                      |
| [MongoDB Atlas Cluster](./modules/mongodb/README.md) | Terraform module for bootstrapping a MongoDB Atlas Cluster. It makes it possible to create a VPC Peering between the VPC and the MongoDB Atlas Cluster. |
| [RDS Instance](./modules/rds/README.md)              | Terraform module for bootstrapping an RDS Instance.                                                                                                     |
| [RDS Aurora Cluster](./modules/rds-aurora/README.md) | Terraform module for bootstrapping an RDS Aurora Cluster.                                                                                               |
| [VPC](./modules/vpc/README.md)                       | Terraform module for bootstrapping a VPC for use with our shared infrastructure.                                                                        |

## Apps and Services

In addition to infrastructure provisioning, we have included a few apps and services to help you get started.

These apps and services are located in the `apps` directory. In there you can find useful examples of how to use the infrastructure we have provisioned.

| Service                                                         | Description                                                                                       |
| :-------------------------------------------------------------- | :------------------------------------------------------------------------------------------------ |
| [Start and Stop EC2 Instance](./apps/start-stop-ec2-instances/) | This is a Serverless Framework based project to start and stop EC2 instances based on a schedule. |

## Contributing

We appreciate contributions from the open-source community. Any contributions you make are **truly appreciated**. Please refer to our [contribution guidelines](./CONTRIBUTING.md) for more information.

## Contributors

[![Contributors](https://contrib.rocks/image?repo=nanlabs/terraform-aws-starter)](https://github.com/nanlabs/terraform-aws-starter/graphs/contributors)

Made with [contributors-img](https://contrib.rocks).
