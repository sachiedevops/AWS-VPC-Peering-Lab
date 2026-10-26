# AWS VPC Peering Lab

## Objective
Connect two AWS VPCs using VPC Peering and test private communication between EC2 instances.

## Architecture
- VPC-A: EC2 Instance 1
- VPC-B: EC2 Instance 2
- VPC Peering connection between VPC-A and VPC-B
- Ubuntu EC2 instances
- Apache2 web server for HTTP testing

## Services Used
- Amazon VPC
- VPC Peering
- Amazon EC2
- Route Tables
- Security Groups
- Ubuntu Linux
- Apache2
- SSH

## Implementation Steps

### 1. Create Two VPCs
Create two VPCs with non-overlapping IPv4 CIDR blocks.

### 2. Launch EC2 Instances
Launch one Ubuntu EC2 instance in each VPC and configure SSH access.

### 3. Create VPC Peering
Create a peering connection between VPC-A and VPC-B and accept the request.

### 4. Configure Route Tables
Add routes in both VPCs:
- VPC-A route table: destination VPC-B CIDR, target VPC peering connection.
- VPC-B route table: destination VPC-A CIDR, target VPC peering connection.

### 5. Configure Security Groups
Allow the required traffic from the other VPC's CIDR. For HTTP testing, allow inbound TCP port 80 on the destination instance.

### 6. Connect to EC2 Using SSH
Connect to each Ubuntu instance using its SSH key and public IP.

### 7. Install Apache2
Run these commands on the instance hosting the website:

```bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable --now apache2
```

### 8. Create a Server Details Page

```bash
echo "<h1>Server Details</h1><p>Hostname: $(hostname)</p><p>Private IP: $(hostname -I | awk '{print $1}')</p>" | sudo tee /var/www/html/index.html
```

### 9. Test Private Communication
From EC2-2, access the web server on EC2-1 using its private IP:

```bash
curl http://EC2_1_PRIVATE_IP
```

Expected result: HTML containing the server hostname and private IP.

## Test Results
- SSH access to both EC2 instances: Successful
- HTTP request from EC2-2 to EC2-1 using the private IP: Successful
- ICMP ping: Failed in both directions; investigate ICMP security rules and network ACLs if ping is required.

## Key Learnings
- VPC Peering enables private communication between two VPCs.
- Both VPC route tables need routes to the other VPC.
- Security groups and network ACLs control network traffic.
- SSH provides secure remote terminal access.
- Apache2 hosts the test webpage.
- curl can verify HTTP connectivity between instances.

## Security and Cleanup
- Never upload private SSH keys or AWS credentials.
- Restrict SSH and HTTP access to trusted sources where possible.
- Delete unused EC2 instances and other lab resources to avoid unnecessary AWS charges.
- Remove temporary public access rules after testing.

## Conclusion
Successfully configured AWS VPC Peering and verified HTTP communication between two EC2 instances using private IP addressing.
