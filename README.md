#Borges-utils

This is just a couple of shellscripts that facilitate working with
[Borges](https://github.com/johm/borges). Include are:

- A Vagrantfile for provisioning a 'production' VM using kvm as a host.
- A shell script for importing a dump of the infoshopkeeper database into
  a recent version of Borges.
- Scripts for performing a daily backup, which are automatically added to
  `$PATH` in the VM provisioning, and can be added to Cron to easily
  backup every day.

Great!
