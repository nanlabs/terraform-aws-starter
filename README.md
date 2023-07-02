# Terraform AWS Starter Kit

This is a starter kit for creating AWS infrastructure using Terraform. It
contains a VPC, RDS instance, and a bastion host.

## Live

We keep our live infrastructure in the `live` directory. This is where we keep
our Terraform variables, backend configuration, and our Terraform root modules.

| Module                                       | Description                                        |
| :------------------------------------------- | :------------------------------------------------- |
| [Core Infrastructure](./live/core/README.md) | Terraform root module for our core infrastructure. |

## Terraform Modules

We have custom Terraform modules that we use to bootstrap our infrastructure. We
keep them in the `modules` directory.

| Module                                             | Description                                                                 |
| :------------------------------------------------- | :-------------------------------------------------------------------------- |
| [VPC](./modules/vpc/README.md)                     | Terraform module to bootstrap a VPC for use with our shared infrastructure. |
| [RDS Postgres](./modules/rds-postgresql/README.md) | Terraform module to bootstrap a RDS Postgres instance.                      |
| [Bastion](./modules/bastion/README.md)             | Terraform module to bootstrap a bastion host.                               |

## Services

We may have some services that run to maintain our infrastructure. Here we have some ideas
you can have in there!

| Service                                                                                                                          | Description                                     |
| :------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------- |
| [Start and Stop EC2 Instance](https://github.com/nanlabs/devops-reference/tree/main/examples/serverless-start-stop-ec2-instance) | Lambda function to start and stop EC2 instance. |

## Contributing

- Contributions make the open source community such an amazing place to learn, inspire, and create.
- Any contributions you make are **truly appreciated**.
- Check out our [contribution guidelines](./CONTRIBUTING.md) for more information.

## Contributors

<a href="https://github.com/nanlabs/terraform-aws-starter/contributors">
  <img src="https://contrib.rocks/image?repo=nanlabs/terraform-aws-starter"/>
</a>

Made with [contributors-img](https://contrib.rocks).
