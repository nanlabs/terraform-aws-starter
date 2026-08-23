# Connecting to private RDS using EC2 Instance Connect Endpoint (EICE)?
An EC2 Instance Connect Endpoint (EICE) is an AWS-managed VPC service feature that allows secure TCP connectivity to private instances and resources in your VPC—without needing a public IP, a Internet Gateway (IGW), or a dedicated bastion host running 24/7.

It acts as an on-demand, serverless private bridge inside your subnets. When you request a connection via the AWS CLI, AWS establishes a secure WebSocket tunnel between your local machine and the endpoint inside your VPC, which then forwards the connection to your destination (like private RDS).


# Key Aspect:

| Feature / Aspect | Traditional EC2 Bastion Host | EC2 Instance Connect Endpoint (EICE) |
| :--- | :--- | :--- |
| **Cost** | Runs 24/7 (EC2 compute, EBS storage, Elastic IP fees). | Zero compute cost (No EC2 instances; free hourly usage, pay standard data transfer). |
| **Maintenance** | Requires OS patching, security updates, and key management. | Fully managed by AWS (no OS or software to manage/patch). |
| **Access Control** | SSH keys (.pem files), vulnerable to key leaks and poor rotation. | IAM & STS based (short-lived temporary credentials, fine-grained access policies). |
| **Network Attack Surface** | Publicly accessible IP listening on port 22. | No public IP required on target resources or endpoint; lives entirely inside the private VPC. |
| **Auditability** | Manual SSH log tracking on the instance. | Native integration with AWS CloudTrail for auditing tunnel requests. |


# How to connect to RDS: 
![alt text](<Screenshot 2026-07-26 224054.png>)

Step 1: Find the Private IP of Your RDS Instance
The AWS CLI tunnel command requires a target IPv4 address. Retrieve it via DNS lookup or from your Terraform output:

```
nslookup <your-rds-endpoint.cxxxxx.us-east-1.rds.amazonaws.com>
```

Step 2: Open the Secure Tunnel
Run the following AWS CLI command in your terminal:

```
aws ec2-instance-connect open-tunnel `
  --instance-connect-endpoint-id eice-0123456789abcdef0 `
  --private-ip-address 10.0.1.45 `
  --local-port 5432 `
  --remote-port 5432
```

Leave this terminal process running in the background. It listens on 127.0.0.1:5432 and tunnels all incoming local traffic over WebSocket to your private RDS instance.

Step 3: Connect using standard DB Clients / GUI Tools <br>
In a separate terminal or SQL client tool (such as DBeaver, PgAdmin, VS Code extensions, or psql), connect using:

* Host: 127.0.0.1 (or localhost)
* Port: 5432
* Database: myappdb
* User: dbadmin

```
psql -h 127.0.0.1 -p 5432 -U dbadmin -d myappdb
```

