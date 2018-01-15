### An ansible playbook repository to manage different workload on an OpenStack certified public cloud


It currently fully support the following workload:
+ ![Progress](http://progressed.io/bar/100)   [docker](/roles/docker) - A basic docker installation
+ ![Progress](http://progressed.io/bar/100)   [docker-swarm](/roles/docker-swarm) - A swarm installation (using latest docker version)
+ ![Progress](http://progressed.io/bar/100)   [docker-registry](/roles/docker-registry) - A docker registry installation (using latest docker version)
+ ![Progress](http://progressed.io/bar/100)   [stable-docker](/roles/stable-docker)  - The current stable version of docker installation
+ ![Progress](http://progressed.io/bar/20)    [ha-docker-swarm](/roles/ha-docker-swarm) - A high-availability docker swarm installation
+ ![Progress](http://progressed.io/bar/40)    [keepalived](/roles/keepalived) - A high-availability basic keepalived setup
+ ![Progress](http://progressed.io/bar/20)    [rancher](/roles/rancher) - A rancher mode installation
+ ![Progress](http://progressed.io/bar/40)    [maas](/roles/maas)  - A basic Ubuntu MaaS installation for inventory management

You can see the support details by clicking the workload name.

## What does it do ?
It really depends of the workload you want to deploy, but bundled, by default, you get :
- full dynamic inventory from OpenStack, allowing you to grow or shrink your deployment as needed
- unless specified otherwise, a specific ssh key to the deployment, ensuring only
people having this key can access the deployed nodes
- a separation between 'public nodes' who are internet exposed and hardened to
avoid any unneeded exposure and the 'private nodes' who are only communicating
through the local customer-specific network
- a bridge (bastion technically), for you to be able to access the private nodes securely
- a proxy configuration, for the private nodes to be able to do updates and install new packages

## How to use
> **Note:** These are currently configured to be used with an Internap Agile Cloud account.

1. First, install Ansible:
   * On Ubuntu
   ```bash
   sudo apt-get install ansible
   ```
   * On CentOS
   ```bash
   sudo yum install ansible
   ```
   * On MacOSX (you need to have brew installed)
   ```bash
   brew install ansible
   ```
2. Clone this repo :
  ```bash
   git clone https://github.com/internap/ansible-ansible-heat
  ```
3. Make sure your clouds.yaml file is configured properly:
    ```
    cat ~/.config/openstack/clouds.yaml
    ```
    it should look something like :
      ```text
        clouds:
          inap-AMSDemo1:
            profile: internap
            auth:
              auth_url:       https://identity.api.cloud.iweb.com/v3
              project_name:   inap-12345
              domain_name:    default
              username:       api-RANDOM_NUMBER_GIVENTOYOU
              password:       YOUR_PASSWORD
            region_name:      ams01
      ```

    * To find your project name, user name and password
      * Go to your Internap account ([login.internap.com](https://login.internap.com)),
      * Click the 'My Infrastructure > Horizon and API Access' tab in the menu on the top
      * Your project name is displayed in the "Option 2 : API" description under the field 'Tenant Name'
      * For your username and password
        * If you never got any API Username and Password, you can click on the 'Get New API Credentials' button
        * BEWARE : If you did but don't remember them, clicking that button will regenerate new credentials and expire the old one, blocking any other access with them, including any application that would use those old credentials
        * When you click the button, simply copy and paste both information into your clouds.yaml file, do not forget to store those credentials somewhere where you can retrieve them later

  3. Adapt your Openstack config file to your account and your needs:
    ```
    cat config/openstack-config.yaml
    ```    
    it should look something like :
      ```text
        openstack_config:
          image_name:         Ubuntu 16.04 LTS (Xenial Xerus)    #this is the OS image we'll be using
          flavor_name:        A1.1                               #this is the default flavor we'll be using
          controller_flavor:  A1.1                               #this is the flavor we'll be using for 'controller' node (see specifif role for details)
      ```

5. You can now launch the Ansible playbook using :
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=<THE_WORKLOAD_NAME>
  ```

### Optional parameters:
* node_count= the total number of node you want to create/maintain
* public_node_count= the number of node you want to be public facing
* action= a non-default action to trigger, that can be :
 - delete: the script will then delete all existing instances
 - delete_all: the script will delete instance, local config files and keys in OS
 - delete_all_includinguserkey: the script will wipe keys and instances both in OS and locally
 - skip_setup: the script will execute only the docker role and it's dependencies and skip all creation and setup of instance 
* key_filename= explicit SSH key file name to use

##### Which would mean, for a 4 node docker swarm cluster using a shared ssh key stored in /tmp/blabla:
* using Ansible:
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=<THE_WORKLOAD_NAME> -e node_count=4 -e key_filename=/tmp/blabla
  ```

# Contributing
Feel free to raise issues and send some pull request, we'll be happy to look at them!
We also would love to have other provider adding their own workload and configuration
to make it a repository of generic, hardened, IaaS recipe.  
