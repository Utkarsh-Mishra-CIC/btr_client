#!/bin/bash -x

source /host/settings.sh

### make sure that we have the right git branch on the make file
makefile="$CODE_DIR/build-btr_client.make"
git_branch=$(git -C $CODE_DIR branch | cut -d' ' -f2)
sed -i $makefile \
    -e "/btr_client..download..branch/ c projects[btr_client][download][branch] = $git_branch"

### retrieve all the projects/modules and build the application directory
rm -rf $DRUPAL_DIR
drush make --prepare-install --force-complete \
           --contrib-destination=profiles/btr_client \
           $makefile $DRUPAL_DIR

### Replace the profile btr_client with a version
### that is a git clone, so that any updates
### can be retrieved easily (without having to
### reinstall the whole application).
cd $DRUPAL_DIR/profiles/
mv btr_client btr_client-bak
cp -a $CODE_DIR .
### copy contrib libraries and modules
cp -a btr_client-bak/libraries/ btr_client/
cp -a btr_client-bak/modules/contrib/ btr_client/modules/
cp -a btr_client-bak/themes/contrib/ btr_client/themes/
### cleanup
rm -rf btr_client-bak/

### copy the bootstrap library to the custom theme, etc.
cd $DRUPAL_DIR/profiles/btr_client/
cp -a libraries/bootstrap themes/contrib/bootstrap/
cp -a libraries/bootstrap themes/btr_client/
cp libraries/bootstrap/less/variables.less themes/btr_client/less/

### copy hybriauth provider DrupalOAuth2.php to the right place
cd $DRUPAL_DIR/profiles/btr_client/libraries/
cp hybridauth-drupaloauth2/DrupalOAuth2.php \
   hybridauth/hybridauth/Hybrid/Providers/

### copy the logo file to the drupal dir
ln -s $DRUPAL_DIR/profiles/btr_client/btr_client.png $DRUPAL_DIR/logo.png

### get a clone of btrclient from github
if [[ -n $DEV ]]; then
    cd $DRUPAL_DIR/profiles/btr_client/modules/contrib/btrclient
    git clone https://github.com/B-Translator/btrclient.git
    cp -a btrclient/.git .
    rm -rf btrclient/
fi

### set propper directory permissions
mkdir -p $DRUPAL_DIR/sites/all/translations
chown -R www-data: $DRUPAL_DIR/sites/all/translations
mkdir -p sites/default/files/
chown -R www-data: sites/default/files/
mkdir -p cache/
chown -R www-data: cache/
### create the downloads dir
mkdir -p /var/www/downloads/
chown www-data /var/www/downloads/
