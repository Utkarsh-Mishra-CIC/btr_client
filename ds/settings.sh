APP=btr_client/ds

### Docker settings.
IMAGE=btr_client
CONTAINER=bcl-example-org
DOMAIN="bcl.example.org"

### Uncomment if this installation is for development.
DEV=true

### Other domains.
[[ -n $DEV ]] && DOMAINS="dev.bcl.example.org tst.bcl.example.org"

### Gmail account for notifications.
### Make sure to enable less-secure-apps:
### https://support.google.com/accounts/answer/6010255?hl=en
GMAIL_ADDRESS=bcl.example.org@gmail.com
GMAIL_PASSWD=

### Admin settings.
ADMIN_PASS=123456

### Translation language of B-Translator Client.
### Can be: 'fr', 'de', 'sq' etc. or can be 'all'
TRANSLATION_LNG='all'

### Settings for OAuth2 Login.
OAUTH2_SERVER_URL='https://dev.btranslator.org'
OAUTH2_CLIENT_ID='client1'
OAUTH2_CLIENT_SECRET='0123456789'
