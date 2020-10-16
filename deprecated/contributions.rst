Summer 2019
-----------

-  Vafa Andalibi

   -  Implemented atuomated aws registration in browser,
      i.e. \ ``cms register aws yaml`` command, tested successfully on
      Linux, MacOS and Windows.
   -  Implemented ``image()`` and ``images()`` for aws provider
   -  Implemented ``@DatabaseImportAsJson`` decorator to import data to
      database using ``mongoimport`` which significantly improved the
      bulk database import, e.g. in
      ``cms image list --cloud=aws --refresh`` the import time was
      improved from roughly 1 hour to 20 seconds.
   -  Fixing ``key upload/delete`` for aws provider
   -  Implemented ``ssh()`` for aws provider, as well as
      testing/debugging it on ``cms ssh`` and ``cms vm ssh``, addressing
      `#224 <https://github.com/cloudmesh/cloudmesh-cloud/issues/224>`__
   -  Re-implemented ``set_server_metadata()`` and
      ``get_server_metadata()`` (collaboration with Prof. von Laszewski)
      for aws provider
   -  Several patches on ``create()`` method for aws provider, i.e. key
      assignment, metadata set/get and returned ``dict`` to be saved in
      the database
   -  Fixes on ``update_dict()`` for ``key`` and ``image``
   -  Implementing ``find_all_by_name()`` for mongodb
   -  Added patches to improve database utilization, used in
      ``cms start/stop`` and other commands addressing
      `#222 <https://github.com/cloudmesh/cloudmesh-cloud/issues/222>`__,
      `#223 <https://github.com/cloudmesh/cloudmesh-cloud/issues/223>`__
      and
      `#225 <https://github.com/cloudmesh/cloudmesh-cloud/issues/225>`__
   -  Implemented ``run2()`` in ``Shell`` in ``Common3`` to address the
      file-system redirection issue on windows when running subprocesses
      using python
   -  Updated ``output`` dict for ``image`` and ``vm`` on aws provider
   -  Fixing the ``cms init`` bug for windows.
   -  Implementing the workaround for running the ``mongod.exe`` in user
      space to prevent asking user to administrative privilege
   -  implemented ``wait()`` in aws
   -  writing ``test_01_clean_local_remote`` and test for ``wait()``

-  Sriman Pullakhandam

   **compute/aws/Provider.py**

   Created/Updated the compute AWS Provider and implemented the
   following methods:

   -  ``def start``
   -  ``def stop``
   -  ``def info``
   -  ``def list``
   -  ``def suspend``
   -  ``def resume``
   -  ``def destroy``
   -  ``def create``
   -  ``def rename``
   -  ``def delete_server_metadata``

   **Test classes**

   -  Created test_06_vm_provider.py to run all the methods from the
      Compute AWS Provider.

-  Saurabh Swaroop

   -  Implemented Print Function (AWS)
   -  Implemented list_secgroups Function (AWS)
   -  Implemented list_secgroup_rules Function (AWS)
   -  Implemented add_secgroup Function (AWS)
   -  Implemented add_secgroup_rule Function (AWS)
   -  Implemented remove_secgroup Function (AWS)
   -  Implemented upload_secgroup Function (AWS)
   -  Implemented add_rules_to_secgroup Function (AWS)
   -  Implemented remove_rules_from_secgroup Function (AWS)
   -  Implemented list_public_ips Function (AWS)
   -  Implemented delete_public_ip Function (AWS)
   -  Implemented create_public_ip Function (AWS)
   -  Implemented find_available_public_ip Function (AWS)
   -  Implemented attach_public_ip Function (AWS)
   -  Implemented detach_public_ip Function (AWS)
   -  Implemented Start Function (AWS)
   -  Implemented Stop Function (AWS)
   -  Implemented Info Function (AWS)
   -  Implemented suspend Function (AWS)
   -  Implemented resume Function (AWS)
   -  Implemented destroy Function (AWS)
   -  Implemented create Function (AWS)
   -  Implemented rename Function (AWS)
   -  Implemented add_server_metadata Function (AWS)
   -  Implemented delete_server_metadata Function (AWS)
   -  Implemented update_dict Function (Mostly copied from openstack
      implementation)
   -  Modified sec.py to display secgroup info for AWS
   -  Enhanced test_04_sec_command
   -  Enhanced test_05_secgroup_provider

-  Joaquin Avila Eggleton

   **compute/azure/Provider.py**

   Created the compute Azure Provider and implemented the following
   methods:

   -  ``def __init__``
   -  ``def get_resource_group``
   -  ``def set_server_metadata``
   -  ``def get_server_metadata``
   -  ``def delete_server_metadata``
   -  ``def list_secgroups``
   -  ``def list_secgroup_rules``
   -  ``def add_secgroup``
   -  ``def add_secgroup_rule``
   -  ``def remove_secgroup``
   -  ``def upload_secgroup``
   -  ``def add_rules_to_secgroup``
   -  ``def remove_rules_from_secgroup``
   -  ``def create``
   -  ``def create_vm_parameters``
   -  ``def create_nic``
   -  ``def start``
   -  ``def reboot``
   -  ``def stop``
   -  ``def resume``
   -  ``def suspend``
   -  ``def info``
   -  ``def status``
   -  ``def list``
   -  ``def destroy``
   -  ``def images``
   -  ``def flavors``
   -  ``def flavor``
   -  ``def find``
   -  ``def image``
   -  ``def get_list``
   -  ``def update_dict``

   **Test classes**

   -  Created test_compute_pyazure.py to run all the methods from the
      Compute Azure Provider.

   **cloudmesh.yaml**

   -  Added Azure specific attributes

-  Moeen Arshad
