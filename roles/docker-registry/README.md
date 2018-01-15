### An ansible template to install and manage a Docker Registry (v2)

See [the main documentation](/) for installation instruction and details.

+ ![Progress](http://progressed.io/bar/100)   (Ubuntu) Docker Registry installation and configuration
+ ![Progress](http://progressed.io/bar/90)    (Ubuntu) Security hardening
+ ![Progress](http://progressed.io/bar/0)     (Ubuntu) High-availability (redundancy, backup and monitoring)

## What does it do ?
Adding to the basic workload features, this template/recipe add the installation
and configuration of a secured Docker Registry. All docker nodes be configured to use
this registry as default, the registry will be place on the last private node.
If no SSL certificate key path is specified, a self-signed certificate will be generate
and the registry will be available using the last private node IP.

### Private / public nodes split
- If don't specify the public_node_count parameters during the deployment, only
one public node will be created, and all the other nodes will be secured inside the
LAN network
- We will automatically elect the last node as the one, privately secured, registry
- We will use the remainder left after instantiating the registry to install
docker on them.

## How to use
> **Note:** These are currently configured to be used with an Internap Agile Cloud account.

### Creating/adding 4 nodes to the Swarm:
* using Ansible:
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=docker-registry -e node_count=4
  ```

### Optional parameters:
  * ca_privatekey_filepath= the custom Certificate Authority private key to use
  * ca_publickey_filepath= the custom Certificate Authority public key to use
  * server_privatekey_filepath= the custom registry key to use
  * server_csr_filepath= the custom Certificate Request file to use
  * server_publickey_filepath= the custom registry certificate to use

# Contributing
Feel free to raise issues and send some pull request, we'll be happy to look at them!
We also would love to have other provider adding their own workload and configuration
to make it a repository of generic, hardened, IaaS recipe.  
