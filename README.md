# KOBman

**KOBman** , is A command line utility inspired from sdkman !! 
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

## Installation

Open your favourite terminal and enter the following:

    $ curl -L https://raw.githubusercontent.com/kobman/KOBman/RF-1.0.1.3.1/dist/get.kobman.io | bash

If the environment needs tweaking for KOBMAN to be installed, the installer will prompt you accordingly and ask you to restart.


### Local Installation

To install KOBMAN locally running against your local server, run the following commands:

	
	$ source ~/.kobman/bin/kobman-init.sh



### Local Environment Installation

Run the following commands on the terminal to manage respective environments.
	
###Development environement setting up commands:

I) Install Commands

a.	

> This command will install versin :'0.0.2' of the environment 'KOBman' from the one of the github contributer's  namespace 'asa1997' 
> KOBman namespace -> "https://github.com/asa1997/KOBman  
> KOBman version -> '0.0.2'  

<table>
	<tr><th>Syntax/Example</th><th>command</th></tr>
	<tr><td>Syntax</td><td>kob install --environment kobman [--version version_id] [--namespace name_value]</td></tr>
	<tr><td>Example</td><td>kob install --environment kobman --version 0.0.2 --namespace asa1997</td></tr>
</table>

_________________
	
b.	                 	

> This command will install versin :'0.0.3' of the environment 'kobman' from the **default github namespace 'hyperlederkochi'** 
> KOBman namespace -> "https://github.com/hyperledgerkochi/KOBman  
> KOBman version -> '0.0.3'  

<table>
	<tr><th>Syntax/Example</th><th>command</th></tr>
	<tr><td>Syntax</td><td>kob install --environment kobman [--version version_id]</td>kob install --environment kobman [--version version_id]</tr>
	<tr><td>Example</td><td>kob install --environment kobman --version 0.0.3 </td></tr>
</table>
_________________
	

c.	     
   
> This command will install **default versin :0.0.1** of the environment 'kobman' from one of the github contiruber's  namespace 'EtricKombat' 

> KOBman namespace -> "https://github.com/EtricKombat/KOBman  
> KOBman version -> '0.0.1'  

<table>
	<tr><th>Syntax/Example</th><th>command</th></tr>
	<tr><td>Syntax</td><td>kob install --environment kobman [--namespace namespace_value]</td></tr>
	<tr><td>Example</td><td>kob install --environment kobman --namespace EtricKombat</td></tr>
</table>
	
_________________
	

d.	      

> This command will install **default versin :0.0.1** of the environment 'kobman' from the **default github namespace 'hyperlederkochi'** 

> KOBman namespace -> "https://github.com/hyperledgerkochi/KOBman  
> KOBman version -> '0.0.1' 

<table>
	<tr><th>Syntax/Example</th><th>command</th></tr>
	<tr><td>Syntax</td><td>kob install --environment kobman</td></tr>
	<tr><td>Example</td><td>kob install --environment kobman</td></tr>
</table>
_____________



e.	Other available hyperledgerkochi environment's 
       
<table>
	<tr><th>keyword</th><th>environment name</th><th>github namespace</th></tr>
	<tr><td>tobvon</td><td>von-network</td><td>https://github.com/hyperledgerkochi/von-network</td></tr>
	<tr><td></td><td>TheOrgBook</td><td>https://github.com/hyperledgerkochi/TheOrgBook</td></tr>
	<tr><td>tob</td><td>greenlight</td><td>https://github.com/hyperledgerkochi/greenlight</td></tr>
	<tr><td>kobman</td><td>KOBman</td><td></td></tr>
</table>


##### Work in progress


<table>
	<tr><th>keyword</th><th>environment name</th><th>github namespace</th></tr>
	<tr><td>kobvon</td><td>KochiOrgBook- VON</td><td>https://github.com/hyperledgerkochi/KOBVON</td></tr>
	<tr><td>kob</td><td>KochiOrgBook</td><td>https://github.com/hyperledgerkochi/KochiOrgBook</td></tr>
	<tr><td>kobdflow</td><td>KochiOrgBook- Dflow</td><td>https://github.com/hyperledgerkochi/KOB_GreenLight</td></tr>
	<tr><td>kobregistory</td><td>KochiOrgBook- Registry</td><td>https://github.com/hyperledgerkochi/KOBRegistry</td></tr>
	<tr><td>kobconnect</td><td>KochiOrgBook- Connect</td><td>https://github.com/hyperledgerkochi/KOBConnect</td></tr>
</table>



_____________

II) Unnstall Commands


Uninstall environement  commands:
       
       kob uninstall --environment kobman

                
        
Other useful commands:        
  
             
        kob list
        kob status        
        kob help     
        kob version     
         

## Adding new features

For new features creation , you have to edit (add file 'kobman-*' ) extention script in the below listed directory,test it & publish

        ./kobman/env/

## Contributors

This project exists thanks to all the people who contribute. 
<a href="https://github.com/kobman/KOBman/graphs/contributors"><img src="https://i.stack.imgur.com/kk4j4.jpg" /></a>


