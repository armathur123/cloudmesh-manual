VM Providers (outdated)
=======================

Cloudmesh works straight forward with a number of cloud providers under
the assumption you have accounts on these clouds. We demonstrate here
how to start a single vm on each of these providers and to test if they
have been creatdd we will also list the vm on each of the clouds.
Defaults form the a configuration file that is located in
``~/.cloudmesh/cloudmesh.yaml`` are used to select images and flavors.
These defaults can naturally be changed.

In order for you to follow this example you will have to edit the yaml
file and make appropriat emodifications.

General Cloud Providers Access
------------------------------

We are using the python library `Apache
Libcloud <https://libcloud.apache.org>`__ to interact with cloud service
providers. Currently, in ``cms``, we could access:

-  `AWS <https://aws.amazon.com>`__
-  `AZURE <https://azure.microsoft.com/en-us/>`__
-  any cloud service providers using *OpenStack*. For example,
   `Chameleon <https://www.chameleoncloud.org>`__ and
   `Jetstream <https://jetstream-cloud.org>`__

By using the *Apache Libcloud* API, we could do these operations for
nodes in above cloud service providers:

-  Start the node
-  Stop the node
-  Resume the node
-  Suspend the node
-  Destory the node
-  Create the node

**Improvement**: Sometimes adjustments to nodes are necessary (switch
between different images/OS and service sizes). Cm4 also allow users to
customize their instances across multiple providers by using refactor
functions to support their management tasks.

-  Resize the node
-  Rebuild(with different image) the node
-  Rename the node
-  Revert previous operations to the node

General Interface
-----------------

.. code:: bash

   $ cms set cloud=<cloudname as defined in the ~/.cloudmesh/cloudmesh.yaml>
   $ cms vm start
   $ cms vm list

   $ cms flavor="medium"
   $ cms image="ubuntu19.04"

   $ cms vm start

Explicit Use with Options
-------------------------

.. code:: bash

   $ cms vm start --cloud=chameleon --image=ubuntu19.04 --flavor=medium --key=~/.ssh/id_rsa.bub

Vagrant
-------

TODO

.. code:: bash

   $ cms set cloud=vagrant
   $ cms vm start
   $ cms vm list

AWS
---

Setup and Configuration
~~~~~~~~~~~~~~~~~~~~~~~

Amazon Web Service (**AWS**) provided by Amazon is a secure cloud
service platform, users could start any instances with selected images.

Before users use the **cms** platform to access **EC2**, they have to
finish these preparations:

1. EC2 account, more information is
   `here <https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/>`__

2. Log in the EC2 account, update your **Access Key**.

   **Access Keys** has two parts: **Access Key ID** and **Secret Access
   Key**. These **Access Keys** are the only way you could authentically
   access the AWS though AWS API requests. (create new Access Key:
   Account (right upper corner) > My Security Credentials > Access Keys
   > Create New Access Key)

3. **Private Key file** is a key pairs to encrypt and decrypt login
   information. While using **Private Key file**, there is no need to
   use username or password to login the instance of AWS. For sshing the
   instance, the ssh client would use the **private key file** instead
   of credential information. (create new key pairs: Network & Security
   (left column bar) > Key Pairs > Create Key Pair)

4. **Security Group** acts as a virtual firewall for the instance. When
   you launch a instance, we have to attach the **Security Group** to it
   for controlling the traffic in and out. So before you are using any
   nodes in AWS, you have to pre-define the **Security Group** that you
   will use. (create new Security Group: Network $ Security (left column
   bar) > Security Group > Create Security Group)

5. **Region** is the service location where you start the instance. AWS
   hosts services in different regions, you should select the region
   where you want to start you instance.

When you finish all above things, you should update information into the
block ‘aws’ of **cloudmesh.yaml** file in **ETC** folder

**EC2** provides On-Demand Pricing cloud services based on different
CPU, Memory and Storage selections. Please visit this
`page <https://aws.amazon.com/ec2/pricing/on-demand/>`__ for more
information. In default setting, we use the latest **Ubuntu** image
filled in default.image field. If you want to use other images, please
update the Image ID into it.

.. code:: bash

   $ cms set cloud=aws
   $ cms vm start
   $ cms vm list

Azure
-----

Uses `LibCloud’s Azure ARM Compute
Driver <https://libcloud.readthedocs.io/en/latest/compute/drivers/azure_arm.html>`__

.. _setup-and-configuration-1:

Setup and Configuration
~~~~~~~~~~~~~~~~~~~~~~~

**Install Azure CLI**

`Download and install according to your
platform. <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest>`__

**Make sure subscription is registered for compute services**

::

   az provider register --namespace Microsoft.Compute

**Service principal**

`Full documentation on creating service
principals. <https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest>`__
The Azure ARM Driver does not appear to support certificate based
principals at this time.

Create Principal

::

   az ad sp create-for-rbac --name cm-admin-pw --password <SECRET>

Add ``Owner`` role.

::

   az role assignment create --assignee <APP_ID> --role Owner

*Note:* ``<APP_ID>`` is provided in the output when the principal is
created

.. code:: bash

   $ cms set cloud=azure
   $ cms vm start
   $ cms vm list

OpenStack
---------

OpenStack is an Infrastructure service that allows users to utilize
computing resource in cloud service platform through virtual
environments.

`Chameleon Cloud <https://www.chameleoncloud.org/>`__ provides an
OpenStack installation of version 2015.1 (Kilo) using the KVM
virtualization technology at the KVM@TACC site. It is important to make
sure you are visiting the
`KVM@TACC <https://openstack.tacc.chameleoncloud.org/>`__ site so as to
get proper installation. Learn more
`here <https://chameleoncloud.readthedocs.io/en/latest/technical/kvm.html>`__
to properly set up yout account before proceed to your journey with
**cms**.

Jetstream
~~~~~~~~~

TODO

.. code:: bash

   $ cms set cloud=jetstream
   $ cms vm start
   $ cms vm list

Chameleon Cloud
~~~~~~~~~~~~~~~

.. code:: bash

   $ cms set cloud=chameleon
   $ cms vm start
   $ cms vm list

Cybera
~~~~~~

TODO

.. code:: bash

   $ cms set cloud=cybera
   $ cms vm start
   $ cms vm list

DevStack
~~~~~~~~

TODO

.. code:: bash

   $ cms set cloud=devstack
   $ cms vm start
   $ cms vm list
