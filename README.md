# KOBman

**KOBman** , is a command line utility inspired from sdkman !!
KOBMan gives you a *kob* command on your shell , you can use it to automate the setup of various development environments required for KOB projects  


# KOBMAN! CLI
### The KochiOrgBook Manager Command Line Interface<!--Text-->

<!--Text-->

<!--
<!--[![Build Status](https://travis-ci.org/kobman/kobman-cli.svg?branch=master)](https://travis-ci.org/kobman/kobman-cli)
[![Latest Version](https://api.bintray.com/packages/kobman/generic/kobman-cli/images/download.svg) ](https://bintray.com/kobman/generic/kobman-cli/_latestVersion)
[![Backers on Open Collective](https://opencollective.com/kobman/backers/badge.svg)](#backers)
[![Sponsors on Open Collective](https://opencollective.com/kobman/sponsors/badge.svg)](#sponsors)
[![Slack](https://slack.kobman.io/badge.svg)](https://slack.kobman.io)
-->

KOBMAN is a tool for managing parallel Versions of multiple KochiOrgBook projects on any Unix based system. It provides a convenient command line interface for installing, removing and listing Environments.

See documentation on the [KOBMAN! website](https://kobman.github.io).

## System pre-requisite

  - OS          : Ubuntu 18.04LTS
  - Memory[RAM]): 4GB (min)
  - Storage     : 30GB (min)


## Installation

Open your favourite terminal and enter the following:

    $ curl -L https://raw.githubusercontent.com/hyperledgerkochi/KOBman/dist/dist/get.kobman.io | bash

If the environment needs tweaking for KOBMAN to be installed, the installer will prompt you accordingly and ask you to restart.


### Local Installation

To install KOBMAN locally running against your local server, run the following commands:


	$ source ~/.kobman/bin/kobman-init.sh


### Local environment commands

Run the following commands on the terminal to manage respective environments.

### Install commands:

        $ kob install -env [environment_name] --version [version_tag]

        Example   :
           $ kob install -env KOBman --version 0.0.2

Please run the following command to get the list of other environments and its versions.

	   	`$ kob list`

____________________

### Uninstall commands:

        $ kob uninstall -env [environment_name] --version [version_tag]

        Example   :
           $ kob uninstall -env KOBman --version 0.0.2

____________________

### Version commands:

    $ kob --version
    $ kob --version -env [environment_name]

    Example   :
       $ kob --version -env KOBman

____________________

### Other useful commands:        

        $ kob list
        $ kob status        
        $ kob help     

## Contributors

This project exists thanks to all the people who contribute.
<a href="https://github.com/kobman/KOBman/graphs/contributors"><img src="https://i.stack.imgur.com/kk4j4.jpg" /></a>
