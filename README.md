# A Simple OpenLDAP Server Using Vagrant

## Requirement
- Vagrant must be installed
- This script utilize a Vagrant plugin called landrush for local DNS. If you do not want to use it, please modify 
`Vagrantfile`.

## Files
- `Vagrantfile`: The vagrnat machine setting. Vagrant use this file to start up a VirtualBox VM. It points to 
`bootstrap.sh` for the actual server setup.
- `bootstrap.sh`: A dumb shell script to install all the necessary packages for OpenLDAP server.
- `config/memberof.ldif`: OpenLDAP overlay file so we can have `memberof` attribute for our users.
- `config/refint.ldif`: A dependency for the `memberof` overlay.
- `config/mongoyun/config.php`: The config file for `phpldapadmin`.
- `config/mongoyun/ldap.ldif`: This file include all the users/groups information.

## User Information
- The root admin is `cn=admin,dc=mongoyun,dc=dev`. The password is `password`.
- All the users user `Password1!` as their password.

