### An ansible template to install and manage keepalived

See [the main documentation](/) for installation instruction and details.

+ ![Progress](http://progressed.io/bar/100)   (Ubuntu) Keepalived installation and configuration (from source)
+ ![Progress](http://progressed.io/bar/100)   (Ubuntu) Security hardening
+ ![Progress](http://progressed.io/bar/0)     (Ubuntu) High-availability (redundancy, backup and monitoring)

## What does it do ?
Adding to the basic workload features, this template/recipe add the installation
and configuration of keepalived on all publicly exposed nodes and configure them
to use VRRP on a virtual neutron port. This allows this neutron port IP to be
high-available : a failure of one of the public_node will have no impact on the
overall availability.

### Private / public nodes split
- If don't specify the public_node_count parameters during the deployment, we will
automatically push for 2 public nodes to be keepalived
- All public_nodes will be keepalived.

## How to use
> **Note:** These are currently configured to be used with an Internap Agile Cloud account.

### Installing/adding keepalived on 4 nodes:
* using Ansible:
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=keepalived -e node_count=4
  ```

# Contributing
Feel free to raise issues and send some pull request, we'll be happy to look at them!
We also would love to have other provider adding their own workload and configuration
to make it a repository of generic, hardened, IaaS recipe.  
