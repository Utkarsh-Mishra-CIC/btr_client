
# B-Translator Client

Drupal installation profile for B-Translator Client.

The codename *B-Translator* can be decoded like *Bee Translator*,
since it aims at collecting very small translation contributions from
a wide crowd of people and to dilute them into something useful.

It can also be decoded like *Be Translator*, as an invitation to
anybody to give his small contribution for translating programs or
making their translations better.

For more detailed information see: http://info.btranslator.org


## Installation

  - First install Docker:
    https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository

  - Then install `ds` and `wsproxy`:
     + https://github.com/docker-scripts/ds#installation
     + https://github.com/docker-scripts/wsproxy#installation


  - Get the code from GitHub:
    ```
    git clone https://github.com/B-Translator/btr_client /opt/docker-scripts/btr_client
    ```

  - Create a directory for the container: `ds init btr_client/ds @l10n-org-al`

  - Fix the settings:
    ```
    cd /var/ds/l10n-org-al/
    vim settings.sh
    ```

  - Build image, create the container and configure it: `ds make`


## Access the website

  - Tell `wsproxy` to manage the domain of this container: `ds wsproxy add`

  - Tell `wsproxy` to get a free letsencrypt.org SSL certificate for this domain:
    ```
    ds wsproxy ssl-cert --test
    ds wsproxy ssl-cert
    ```

  - If installation is not on a public server, add to `/etc/hosts` the
    line `127.0.0.1 l10n.org.al` and then try in browser:
    https://l10n.org.al


## Other commands

    ds help

    ds shell
    ds stop
    ds start
    ds snapshot

    ds runcfg set-adminpass <new-drupal-admin-passwd>
    ds runcfg set-domain <new.domain>
    ds runcfg emailsmtp <gmail-user> <gmail-passwd>

    ds runcfg dev/clone proj proj_test
    ds runcfg dev/clone_rm proj_test
    ds runcfg dev/clone proj proj1

    ds backup [proj1]
    ds restore <backup-file.tgz> [proj1]
