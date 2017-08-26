APP=dbox/ds

### Docker settings.
IMAGE=btr_client
CONTAINER=bcl-example-org
SSHD_PORT=2201
#PORTS="80:80 443:443 $SSHD_PORT:22"    ## ports to be forwarded when running stand-alone
PORTS=""    ## no ports to be forwarded when running behind wsproxy

DOMAIN="bcl.example.org"
DOMAINS="dev.bcl.example.org tst.bcl.example.org"  # other domains

### Gmail account for notifications.
### Make sure to enable less-secure-apps:
### https://support.google.com/accounts/answer/6010255?hl=en
GMAIL_ADDRESS=
GMAIL_PASSWD=

### Admin settings.
ADMIN_PASS=

### Translation language of B-Translator Client.
TRANSLATION_LNG='fr'

### Settings for OAuth2 Login.
OAUTH2_SERVER_URL='http://dev.btranslator.org'
OAUTH2_CLIENT_ID='client1'
OAUTH2_CLIENT_SECRET='0123456789'

### Uncomment if this installation is for development.
DEV=true
