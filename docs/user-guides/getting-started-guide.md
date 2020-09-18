

#                                                      Getting Started Guide

**Step 1:** Installing KOBman utility

   Follow below instructions to install KOBman utility

       $ curl -L https://raw.githubusercontent.com/hyperledgerkochi/KOBman/dist/dist/get.kobman.io | bash   
       
       
![image](https://user-images.githubusercontent.com/54981984/89986554-59546980-dc9a-11ea-95d9-a21b4511d51b.png)


     $ source ~/.kobman/bin/kobman-init.sh
     
     
![image](https://user-images.githubusercontent.com/54981984/89987221-4c844580-dc9b-11ea-9418-59e720969333.png)


 _________________________________________________________

**Step 2:** Confirming Installation 

 To confirm installation try any of below commands
  
      $ kob
      
  ![image](https://user-images.githubusercontent.com/54981984/89987651-07144800-dc9c-11ea-8859-1e029fed16c8.png)
      
      
     $ kob -V

![image](https://user-images.githubusercontent.com/54981984/89987823-46db2f80-dc9c-11ea-8e03-b4ee4b4e863b.png)


This command option helps to identify the [version](https://github.com/hyperledgerkochi/KOBman/blob/master/dist/list.txt) of KOBman utility installed in the local system.

 _________________________________________________________
 

 **Step 3:** Listing available environments
  
To view the available environments, execute below command

      $ kob list

![image](https://user-images.githubusercontent.com/54981984/89988281-f0babc00-dc9c-11ea-87ee-8e571c9dbc0b.png)

This command option helps to identify the [available environments](https://github.com/hyperledgerkochi/KOBman/blob/master/dist/environments) in KOBman utility.

 _________________________________________________________

**Step 4:**  Installing KOBman dev environment

 This command help you to create fork of the KOBman reposistory under your own namespace , this also creates a dev environment where you can work from your fork of KOBman.

Export your GitHub id using the below command by substituting `<namespace>` with your GitHub id  
   
   `$ export KOBMAN_USER_NAMESPACE=<namespace>`
   
Run the install command after exporting your Github id

     $ kob install -env KOBman --version 0.0.1

![image](https://user-images.githubusercontent.com/54981984/89994122-527f2400-dca5-11ea-9181-8a34269e508c.png)


________________________________


**Step 5:** Listing down installed environment and its version

 Execute the below command to display the environments installed
 
        $ kob status
        
 ![image](https://user-images.githubusercontent.com/54981984/89999848-02a45b00-dcad-11ea-862e-9e4bebee547b.png)

 _________________________________________________________

**Step 6:** Viewing KOBman dev environment 
  
   By default the KOBman dev environment will be installed in you home directory under the name `KOBman_env`. This can be used as the workspace for working on the KOBman utility.
  
  Below shows tree structure of dev environment 
  
     $ tree -d KOBman_env/
  
  ![image](https://user-images.githubusercontent.com/54981984/90000149-6a5aa600-dcad-11ea-8231-8bb5cbd7249f.png)

 ________________________________________________________

**Step 7:** Uninstalling KOBman dev environment 

  To Uninstall KOBman dev environment, execute the below command 

     $ kob uninstall -env KOBman 

 When prompted, type in 'y' if you want to remove the dev environment or type in 'n' if you want the operation to be cancelled.

![image](https://user-images.githubusercontent.com/54981984/90000733-274d0280-dcae-11ea-9d59-d82a35254ccb.png)

 ________________________________________________________

**Step 8:** Remove KOBman utility from local system

      $ kob remove
      
  When prompted, type in 'y' if you want to remove the KOBman utility from your local system or type in 'n' if you want the operation to be cancelled.

![image](https://user-images.githubusercontent.com/54981984/90509346-cf633f80-e176-11ea-93da-181e8d1b5c40.png)

 
