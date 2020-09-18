## About the file

This file helps you to generate a ssh key so that you will not be prompted for your git credentials. This is a one time process</br>
Please follow the below steps carefully to generate a ssh key and to add it to your remote repo in github.

### Generating a new SSH key

Please follow the below steps to generate a new ssh key

1. Open Terminal.

2. Paste the text below, substituting in your GitHub email address.

        $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

3. When you're prompted to "Enter a file in which to save the key," give the file name as "kobman_ssh" and press Enter.

        Enter a file in which to save the key (/home/you/.ssh/id_rsa): [kobman_ssh] [press enter]
        
4. At the prompt, type a secure passphrase.

        > Enter passphrase (empty for no passphrase): [Type a passphrase]
        > Enter same passphrase again: [Type passphrase again]

After the above 4 steps you will have your private key and public key in the files kobman_ssh & kobman_ssh.pub respectively in your home directory.

### Adding your SSH key to the ssh-agent

1. Start the ssh-agent in the background. Copy and paste the below "eval" command in your terminal
    
        $ eval "$(ssh-agent -s)"

2. Add your SSH private key to the ssh-agent. 
    
        $ ssh-add ~/kobman_ssh
        
Adding the SSH key to the ssh-agent ensures that your SSH key has an extra layer of security through the use of a passphrase.

### Adding a new SSH key to your GitHub account

1. Copy the SSH key to your clipboard.

    To copy the shh key, open the file kobman_ssh.pub in your favourite text editor and copy the whole content.
    
2. In the upper-right corner of any page, click your profile photo, then click **Settings**.
    
    ![Image of settings](https://docs.github.com/assets/images/help/settings/userbar-account-settings.png)
    
3. In the user settings sidebar, click **SSH and GPG keys**.

    ![Image of ssh and gpg keys option](https://docs.github.com/assets/images/help/settings/settings-sidebar-ssh-keys.png)
    
4. Click **New SSH key** or **Add SSH key**.
    
    ![Image of new ssh key or add ssh key option](https://docs.github.com/assets/images/help/settings/ssh-add-ssh-key.png)
    
5. In the "Title" field, add a descriptive label for the new key. 

6. Paste your key into the **Key** field.

    ![image of area to add ssh key](https://docs.github.com/assets/images/help/settings/ssh-key-paste.png)
    
7. Click **Add SSH key**.
    
    ![Image of add ssh key option](https://docs.github.com/assets/images/help/settings/ssh-add-key.png)
    
8. If prompted, confirm your GitHub password.

    ![Image of confirm password textbox](https://docs.github.com/assets/images/help/settings/sudo_mode_popup.png)
    
### Set up the repositoriy's origin branch to ssh

Run the following command in the terminal substituting in your GitHub namespace
        
        $ git remote set-url origin git@github.com:<your namespace>/KOBman.git

