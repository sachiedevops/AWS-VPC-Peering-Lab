#!/bin/bash
# AWS VPC Peering Lab - Connectivity Test
# Run on EC2-2 to test HTTP communication with EC2-1.

set -u

# Replace with EC2-1's private IP address.
EC2_1_PRIVATE_IP="12.0.1.83"

echo "Testing HTTP communication through the private IP..."
echo "Destination: ${EC2_1_PRIVATE_IP}"

if curl --connect-timeout 5 -fsS "http://${EC2_1_PRIVATE_IP}"; then
    echo
    echo "SUCCESS: HTTP communication is working."
else
    echo
    echo "FAILED: Check VPC peering routes, security groups, network ACLs, and Apache."
    exit 1
fi
