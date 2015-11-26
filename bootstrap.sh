#!/usr/bin/env bash

# Default profile
PROFILE="mongoyun"
DOMAIN="mongoyun.dev"

bash /vagrant/scripts/init.sh

echo "********** Install OpenLDAP **********"
echo -e "\
    slapd slapd/root_password password password
    slapd slapd/root_password_again password password
    slapd slapd/password1 password password
    slapd slapd/password2 password password
    slapd slapd/no_configuration boolean false
    slapd slapd/domain string $DOMAIN
    slapd shared/organization string $DOMAIN
    slapd slapd/internal/adminpw password password
    slapd slapd/internal/generated_adminpw password password
    slapd slapd/backend select HDB
    slapd slapd/purge_database boolean false
    slapd slapd/move_old_database boolean true
    slapd slapd/allow_ldap_v2 boolean false
" | debconf-set-selections

apt-get install -y slapd ldap-utils

echo "********** Configuring OpenLDAP **********"
ldapadd -Y EXTERNAL -H ldapi:/// -f /vagrant/config/memberof.ldif 

ldapadd -Y EXTERNAL -H ldapi:/// -f /vagrant/config/refint.ldif 

ldapadd -x -D cn=admin,dc=mongoyun,dc=dev -w password -f /vagrant/config/$PROFILE/ldap.ldif

echo "********** Install phpLDAPadmin **********"
apt-get install -y phpldapadmin

cp /etc/phpldapadmin/config.php /etc/phpldapadmin/config.php.backup
cp /vagrant/config/$PROFILE/config.php /etc/phpldapadmin/

service apache2 restart

