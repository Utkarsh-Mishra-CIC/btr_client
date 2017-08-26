#!/bin/bash -x

source /host/settings.sh

### settings for the database and the drupal site
db_name=bcl
db_user=bcl
db_pass=bcl
site_name="B-Translator"
site_mail="$GMAIL_ADDRESS"
account_name=admin
account_pass="$BCL_ADMIN_PASS"
account_mail="$GMAIL_ADDRESS"

### create the database and user
mysql='mysql --defaults-file=/etc/mysql/debian.cnf'
$mysql -e "
    DROP DATABASE IF EXISTS $db_name;
    CREATE DATABASE $db_name;
    GRANT ALL ON $db_name.* TO $db_user@localhost IDENTIFIED BY '$db_pass';
"

### start site installation
sed -e '/memory_limit/ c memory_limit = -1' -i /etc/php/7.0/cli/php.ini
cd $DRUPAL_DIR
drush site-install --verbose --yes btr_client \
      --db-url="mysql://$db_user:$db_pass@localhost/$db_name" \
      --site-name="$site_name" --site-mail="$site_mail" \
      --account-name="$account_name" --account-pass="$account_pass" --account-mail="$account_mail"

drush="drush --root=$DRUPAL_DIR"

### install btrProject and btrVocabulary
$drush --yes pm-enable btrProject
$drush --yes pm-enable btrVocabulary

### install additional features
$drush --yes pm-enable bcl_btrClient
$drush --yes features-revert bcl_btrClient

$drush --yes pm-enable bcl_misc
$drush --yes features-revert bcl_misc

$drush --yes pm-enable bcl_layout
$drush --yes features-revert bcl_layout

$drush --yes pm-enable bcl_content

$drush --yes pm-enable bcl_permissions
$drush --yes features-revert bcl_permissions

#$drush --yes pm-enable bcl_captcha
#$drush --yes features-revert bcl_captcha

#$drush --yes pm-enable bcl_discus
#$drush --yes features-revert bcl_discus
#$drush --yes pm-enable bcl_invite
#$drush --yes pm-enable bcl_simplenews
#$drush --yes pm-enable bcl_mass_contact
#$drush --yes pm-enable bcl_googleanalytics
#$drush --yes pm-enable bcl_drupalchat

### update to the latest version of core and modules
#$drush --yes pm-refresh
#$drush --yes pm-update

### set drupal variable btrClient_translation_lng
$drush --yes --exact vset btrClient_translation_lng $TRANSLATION_LNG

### add $TRANSLATION_LNG as a drupal language
drush dl drush_language
if [[ "$TRANSLATION_LNG" != 'all' ]]; then
    $drush language-add $TRANSLATION_LNG
fi
