### An ansible template to install and manage Docker installation (latest)

See [the main documentation](/) for installation instruction and details.

+ ![Progress](http://progressed.io/bar/100)   (Ubuntu) Docker installation and configuration
+ ![Progress](http://progressed.io/bar/80)    (Ubuntu) Security hardening
+ ![Progress](http://progressed.io/bar/0)     (Ubuntu) High-availability (redundancy, backup and monitoring)

## What does it do ?
Adding to the basic workload features, this template/recipe add the installation
and configuration of the docker client on all host.

### Private / public nodes split
- If don't specify the public_node_count parameters during the deployment, we will
automatically elect the first node as the one, publicly exposed, bridge
- Otherwise, we will use the remainder left after instantiating the number of public node
specified in the public_node_count parameter as private nodes.

## How to use
> **Note:** These are currently configured to be used with an Internap Agile Cloud account.

### Installing/adding docker on 4 nodes:
* using Ansible:
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=docker -e node_count=4
  ```

# Contributing
Feel free to raise issues and send some pull request, we'll be happy to look at them!
We also would love to have other provider adding their own workload and configuration
to make it a repository of generic, hardened, IaaS recipe.  
