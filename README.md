# DevOps-challenge

For the first part of the task, I have to write a simple static HTML page. You can find it on the following path: DevOps-challenge\webPage.

I've chosen to use virtual machines in GCP to host our web page; for this reason, I have written a Terraform configuration.
The main.tf file contains information about the cloud provider, region, project, and credentials for login.

The firewall.tf file contains information about the network configuration. In our case, we have opened ports 80, 8080, and 443. The VMs are accessible from all addresses.

The web-vm.tf file provides information about the VMs that we are going to use to host our web page. We have Ubuntu distributions, and once the VMs are created, we have a script that will install, start, and enable the Nginx web server. Also, we have parameter count, which we can use to define how many VMs we want to create.

The vars.tf file defines a variable ssh_keys that is meant to hold a list of SSH keys and associated users.

The output-tf file contains configuration that will provide the IPs of the created VMs.

The jenkins-vm.tf file contains configuration for a virtual machine that we can use as a Jenkins server. We can use Jenkins jobs to automate the process of deploying our project using a Jenkins file.


Scaling mechanisms:
For our project, we can use vertical scaling, which involves adding more resources to the instance, or horizontal scaling, which involves adding more instances to distribute the load.


For the second part of the task, I've written a Python script that lists all VPCs and Subnets in the project and saves the data in the database as it is required.
The script is loaded into the GCP cloud function.