from diagrams import Diagram, Cluster
from diagrams.aws.compute import EC2, Lambda
from diagrams.aws.database import RDS
from diagrams.aws.network import VPC, NATGateway, InternetGateway, APIGateway
from diagrams.aws.security import SecretsManager
from diagrams.aws.mobile import Amplify
from diagrams.onprem.network import Internet
from diagrams.aws.management import Cloudwatch

with Diagram("Live Prod Infrastructure", show=False):
    with Cluster("AWS Region"):
        with Cluster("VPC"):
            with Cluster("Public Subnet"):
                bastion_host = EC2("Bastion Host")
                nat_gateway = NATGateway("NAT Gateway")

            with Cluster("Private Subnet"):
                lambda_func = Lambda("Lambda")
                rds = RDS("RDS Postgres")

                lambda_func >> rds

                cloudwatch_logs = Cloudwatch("CloudWatch")
                lambda_func >> cloudwatch_logs

            lambda_func >> nat_gateway

        api_gateway = APIGateway("API Gateway")
        internet_gateway = InternetGateway("Internet Gateway")

        secrets_manager = SecretsManager("Secrets Manager")
        amplify = Amplify("React App")

        api_gateway - lambda_func
        rds - secrets_manager
        amplify >> api_gateway
        nat_gateway >> internet_gateway
        internet_gateway >> bastion_host
