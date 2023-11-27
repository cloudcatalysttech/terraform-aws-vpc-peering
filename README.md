# AWS VPC Peering  Terraform module
VPC (Virtual Private Cloud) peering is a networking connection between two Virtual Private Clouds in a cloud computing environment, typically provided by a cloud service provider like Amazon Web Services (AWS), Google Cloud Platform (GCP), or Microsoft Azure. VPC peering allows these separate VPCs to communicate with each other as if they were on the same private network, even though they may belong to different accounts or regions within the cloud provider's infrastructure.

## Key Points about VPC Peering

- **Isolation and Segmentation:** VPCs are logically isolated private networks within a cloud provider's infrastructure. They can be used to segment different workloads, applications, or customers. VPC peering enables secure communication and data transfer between these isolated VPCs.

- **Interconnectivity:** Once VPC peering is established, instances and resources in one VPC can communicate directly with instances and resources in the other VPC using private IP addresses. This connectivity is often referred to as "peered" VPCs.

- **Transitive Peering:** In a typical VPC peering setup, the connection is not transitive. This means that if VPC A is peered with VPC B and VPC B is peered with VPC C, VPC A and VPC C are not automatically peered. Additional peering connections would be required to enable communication between VPC A and VPC C.

- **Security:** VPC peering does not rely on the public internet; communication between peered VPCs is done privately within the cloud provider's infrastructure. Security groups, network access control lists (NACLs), and route tables can be used to control and secure traffic between VPCs.

- **Use Cases:** VPC peering is commonly used for various purposes, including:
  - Sharing resources and data between different departments or teams within an organization.
  - Creating multi-tiered architectures where different VPCs represent different tiers of an application (e.g., web, application, database).
  - Enabling cross-account communication, allowing multiple AWS accounts to share resources securely.
  - Facilitating disaster recovery and high availability by replicating data or resources across geographically separated VPCs.

- **Limitations:** There may be limitations and considerations to keep in mind when implementing VPC peering, such as IP address range conflicts, routing challenges, and the need to modify security group and NACL rules to allow traffic between VPCs.

- **Data Transfer Costs:** Depending on the cloud provider, there may be data transfer costs associated with VPC peering, especially if data is transferred between VPCs located in different regions or across different cloud providers.

VPC peering is a valuable feature for creating complex and interconnected network architectures within a cloud environment while maintaining security and isolation between different VPCs. It helps organizations design scalable and flexible cloud infrastructure solutions.


## Usage

```hcl
module "vpc-peering" {
  source = "git::https://github.com/cloudcatalysttech/terraform-aws-vpc-peering.git///?ref=v1.2.0"



  name               = "${local.environment}-peering-${random_id.peering_name.hex}"
  requester_vpc_id   = "vpc-xxxxxxxxxxxxxxxxx" # Replace with your desired requester VPC ID
  accepter_vpc_id    = "vpc-xxxxxxxxxxxxxxxxx" # Replace with your desired accepter VPC ID
  accepter_role_arn  = "arn:aws:iam::xxxxxxxxxxxx:role/vpc-peering" # Replace with your desired accepter role ARN
  requester_role_arn = "arn:aws:iam::xxxxxxxxxxxx:role/vpc-peering" # Replace with your desired requester role ARN
  auto_accept        = true
  requester_vpc_cidr = "10.0.0.0/8"
  accepter_vpc_cidr  = "10.0.0.0/8"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
```
## IAM role
In a typical VPC peering setup, you may have two VPCs: the requester VPC and the accepter VPC. IAM roles are associated with these VPCs to grant the necessary permissions.

### Requester VPC Role

- The IAM role associated with the requester VPC is responsible for initiating the peering request.
- It should have permissions to create and manage peering connections, accepter VPC routes, and any necessary networking configurations.
- Common permissions may include:
  - `ec2:CreateVpcPeeringConnection`
  - `ec2:AcceptVpcPeeringConnection`
  - `ec2:ModifyVpcPeeringConnectionOptions`
  - `ec2:DescribeVpcPeeringConnections`
  - `ec2:DescribeVpcs`
  - `ec2:DescribeRouteTables`
  - `ec2:DescribeNetworkInterfaces`

### Accepter VPC Role

- The IAM role associated with the accepter VPC is responsible for accepting peering connections and configuring the accepter side.
- It should have permissions to accept peering connections, modify route tables, and configure security groups or NACLs as needed.
- Common permissions may include:
  - `ec2:AcceptVpcPeeringConnection`
  - `ec2:ModifyNetworkInterfaceAttribute`
  - `ec2:DescribeVpcPeeringConnections`
  - `ec2:DescribeVpcs`
  - `ec2:DescribeRouteTables`

## IAM Policy Examples

Here are example IAM policies for the requester and accepter VPC roles. Customize these policies based on your specific requirements and security policies.

### Requester VPC Role Policy

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateVpcPeeringConnection",
                "ec2:DescribeVpcPeeringConnections",
                "ec2:DescribeVpcs",
                "ec2:DescribeRouteTables",
                "ec2:DescribeNetworkInterfaces"
            ],
            "Resource": "*"
        }
    ]
}
```
### Accepter VPC Role Policy
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AcceptVpcPeeringConnection",
                "ec2:ModifyNetworkInterfaceAttribute",
                "ec2:DescribeVpcPeeringConnections",
                "ec2:DescribeVpcs",
                "ec2:DescribeRouteTables"
            ],
            "Resource": "*"
        }
    ]
}
```
## Usage

1. **Create IAM Roles:**
   - Create IAM roles in the AWS Identity and Access Management (IAM) console for your VPCs.
   
2. **Attach Policies:**
   - Attach the appropriate policies to these roles based on your specific requirements.
   
3. **Role Assumption:**
   - Ensure that instances or services within the VPCs assume the roles as needed to perform VPC peering-related actions.

## Security Considerations

- **Principle of Least Privilege:** Follow the principle of least privilege when defining IAM roles and permissions to enhance the security of your VPC peering setup.

- **Regular Audits:** Regularly review and audit IAM roles and permissions to maintain security and compliance.

## License

This documentation is provided under the MIT License.