# et_openswan cookbook

# Requirements

# Usage

Steps that must be performed on ec2
-----------------------------------

  1. Create a new VPC instance. This will become your VPN Gateway.  Be sure to assign an elastic IP to the instance.
  1. Disable source/destination check on the VPN Gateway instance.
  1. Define the gateway's security group(s) to allow incoming UDP/500 and UDP/4500.
  1. Create a new VPC.  This VPC will be dedicated to remote VPN hosts and is needed for the next step to work.  Its address pool should be the same as `node['openswan']['address_pool']` and of course it cannot be the same as any existing VPC pools.
  1. Define a subnet for the virtual IP pool. Its address pool should be the same as above.
  1. In the "Route Tables" list, for any hosts that you want to be able to reach from the VPN, add a routing rule that routes all traffic destined to the pool's subnet through the gateway by pulling down the "Target" menu and selecting the instance ID of the VPN.
  1. Allow any incoming traffic from the pool's subnet into all VPC instances. For example, by adding an "all traffic" rule for your VPN pool's subnet to all of the security groups in your VPC.

# Attributes

# Recipes

# Author

Author:: EverTrue, Inc. (<eric.herot@evertrue.com>)
