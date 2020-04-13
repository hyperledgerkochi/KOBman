# **KochiOrgBook Community Initiative – Getting Started User Guide**
  
   We extend a very warm welcome to you to be a participant / contributor to the KochiOrgBook initiative.KochiOrgBook (KOB)    Trustware ecosystem is a Technology demonstrator that aims to solve the digital identity problem for the mass and enable identity for all without compromising on privacy for all.

 
  ## <u>**Options to Contribute:**</u>
  
  *    Becoming a community lead and connecting with the community members by conducting / coordinating community meet ups
  
  *    Becoming a community promoter and spread awareness of KochiOrgBook initiative among peers and friends

  *    Analyzing existing business process and recommending process refinement using KOB

  *    Contributing to code refinements / enhancement
 
  *    Performing code review and sharing feedback

  *    Fixing reported issues and committing the fixes

  *    Performing testing and sharing feedback

  *    Maintaining Wiki on KOB initiative

  *    Assist in code integration from pull requests raised by community members
   
  
 ## <u>**Getting started:** </u>
 
 *  <u>**Basic introduction to Blockchain technology** </u>

    Please refer the following sites to get an overview on Blockchain technology and decentralized identity management.

    https://101blockchains.com/blockchain-definition/

    https://101blockchains.com/digital-identity/

    Outcome: You should be able to relate to some basic terms used in Blockchain technology and relevance of decentralized identity management. KOB project is based on these concepts.

*   <u>**Introduction to KochiOrgBook’s reference projects**</u> 

    KochiOrgBook project initiative references 3 projects as its base for developing its capability and service offerings.These 3 reference projects were developed by the government of British Columbia (province in Canada).High level overview of these projects will help to understand the underlying technical concepts that is being leveraged to  build KOB capabilities. 
    Please refer the following links to have basic understanding on these reference projects.
  
    VON : https://github.com/bcgov/von-network/blob/master/README.md
   
    TheOrgBook : https://github.com/bcgov/TheOrgBook/blob/master/README.md
   
    Greenlight : https://github.com/bcgov/greenlight/blob/master/README.md
   
    Outcome: You should be able to understand the purpose of these reference projects and their capabilities as this will help  you in developing the capabilities for KOB.
    

*   <u>**Creation of GitHub Id**</u>

    Please create a GitHub id for yourself (if you don’t have one). It can be created by visiting the site - https://github.com/.     Sign up using your username, email and password.Try logging in your username and password. Now you are all set to start using GitHub.All the code components, docs for KOB will be available in GitHub.You can access the same using your GitHub id for making any contribution.

*   <u>**Introduction to projects in KochiOrgBook (KOB) initiative**</u>

    We have created few sub projects under KochiOrgBook to help streamline delivery and code maintenance while achieving the features of KOB in a phased manner. The sub projects are –
    
    [] KochiOrgBook – Enterprise Wallet for associations offering search capabilities
    
    [] KOBVON – Blockchain network for the Association in the city of Kochi
    
    [] KOBRegistry – Data repository of association housing details of its members,accessible only by association members
    
    [] KOBConnect – Native Android app for the citizens of Kochi, having Wallet and consent management capabilities
    
    [] KOBDflow – Customized workflows for use cases identified for KOB that enables transparency on the workflow process and status among the stakeholders involved with the workflow

    Technology stack involved in these projects –

    [] KochiOrgBook, KOBRegistry:
    
       * Python, Django / Angular, NodeJS, Hyperledger Indy
    
    [] KOBVON, KOBDflow:
     
     * Python, Django / Angular, NodeJS, Hyperledger Indy, RUST
       
    [] KOBConnect:
      
       * Native React 
       
*   <u>**Understanding KOBman Utility**</u>

    We have developed a utility that will help you to set up the development environment of project of your choice. You can set up the development environment using few basic kobman commands. This enhances your efficiency and flexibility to set up the development environment without being constrained by the knowledge of the underlying technology components. Please visit the site to get an overview on KOBman utility - https://github.com/hyperledgerkochi/KOBman/blob/master/README.md

    Outcome: You will have an overview on Kobman utility and its capability.
    
*   <u>**Pre-requisites to using KOBman Utility**</u>

    Installing Virtual Box in your local system:
     
    Please watch the following YouTube to understand how to install Virtual Box in your local system (Windows 10) https://www.youtube.com/watch?v=63_kPIQUPp8
    
    Installing Ubuntu 18.04 LTS using your Virtual Box:

    Please watch the following YouTube to understand how to install Ubuntu 18.04 using Virtual Box in your local system (Windows 10) (this is not required if your base OS is Ubuntu 18.04 ) - https://www.youtube.com/watch?v=QbmRXJJKsvs

    Outcome: You will have Ubuntu 18.04 LTS installed in your local system using Virtual Box and are ready to move ahead to use   KOBman utility to set up your desired development environment.
    
*   <u>**Installing KOBman Utility**</u>

    Kindly ensure that you have Virtual Box installed in your local system and installed Ubuntu 18.04 LTS prior to installing  KOBman utility.Please visit the link to understand how to  install KOBman utility in your system -https://github.com/EtricKombat/KOBman/blob/master/docs/Note_1_kobman_installation.md

    Outcome: You should be able to install KOBman utility in your Ubuntu instance. Do try out the various KOBman utility commands like Help, List, Status, Install, Uninstall.
    
## **<u>Initiating work on identified RF / Issues for KochiOrgBook Initiative:</u>**

*    Identifying a sub project to work:

     We currently five sub projects identified and set up in GitHub repository for the KochiOrgBook Initiative that you can choose to work on.  Please refer to the section “Introduction to projects in KochiOrgBook (KOB) initiative” in this document to identify the sub projects.You can refer the following GitHub link to view the repository of each of these projects - https://github.com/hyperledgerkochi

*    Setting up the development environment for your respective project:

     You can set up the development environment for your respective project using the KOBman utility.Kindly ensure that the KOBman utility is installed in your Ubuntu instance. Please refer the section “Installing KOBman Utility” in this document to understand how to install KOBman utility.

*    View the list of open RF/Issues:

     Each project has a list of Issues / RF logged under the Issues section. For eg – in the case of KochiOrgBook you can visit the following link to view the list of RF/ issues that can be picked for development / verification purpose, kindly open up each issue to get a better understanding on the issue / RF by referring to its description and other comments posted - https://github.com/hyperledgerkochi/KochiOrgBook/issues


*   Confirmation on what item has been picked up:

    Please do reach back to us over our slack communication channel - kochiorgbook.slack.com once you have identified and decided to work on a particular issue.  Commence working on the identified issue after getting confirmation from us to avoid rework and to understand its priority with respect to the overall release plans for KochiOrgBook

 ## <u>**Communication options:**</u>
    
    
*   For sharing your queries,

    [] Please register and log into our slack channel - kochiorgbook.slack.com
    
*   To share a code change, please do raise a pull request against the following GitHub repository –
    
    [] For KOBman utility changes - https://github.com/hyperledgerkochi/KOBman.git
    
    [] For KochiOrgBook  changes - https://github.com/hyperledgerkochi/KochiOrgBook.git

    [] For KOBVON changes - https://github.com/hyperledgerkochi/KOBVON.git
    
    [] For KOBRegistry changes - https://github.com/hyperledgerkochi/KOBRegistry.git
    
    [] For KOBConnect changes - https://github.com/hyperledgerkochi/KOBDflow.git
    
    [] For KOBDflow changes - https://github.com/hyperledgerkochi/KOBDflow.git
    
    




	
	
