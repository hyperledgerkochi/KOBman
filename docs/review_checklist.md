| <ins> Check Points </ins>                           | <ins> Y/N </ins> | <ins> Observations </ins> |
| --------------------------------------------------- | ---------------- | ------------------------------------------------ |
| Verify if all file / script names start with __kob  |                  |                                     |
| Verify if all function names start with __kob       |                  |                                     |
| Verify if the function names have meaningful names which denote what they are intended to do  |                  |                                     |                           
| Verify if all environment variables are in caps (eg KOBMAN_VERSION)   |                  |                                     |
| Verify if all environment variables used in this script are initiatlized in kobman_init.sh  |                  |                                     |
| Verify if the environment variables are invoked using export (in the beginning of the script) if they are intended to be used as is in the script |                  |                                     |
| Verify if all local variables are in small letters (eg argument(1)) |                  |                                     |
| Verify if any variable defined in a script which is reused in another script has been defined as Environment Variable |                  |                                     |
| Verify if __kobman_echo function has been instead of echo to display messages in the script |                  |                                     |
| Verify if __kobman_echo_debug function has been to display error message in the script |                  |                                     |
| Validate if all command scripts have their correspondiing test scripts available for verification purpose |                  |                                     |
| Validate if all environment scripts have their corresponding test scripts available for verification purpose |                  |                                     |
| Verify if all test scripts have the following standard set of functions included in them - <br> __kob_Init() <br> __kob_Execute() <br> __kob_Validate() <br> __kob_Cleanup() |                  |                                     |
| Verify if all environment scripts have the following standard set of functions included in them as required - <br> __kob_Init() <br> __kob_Execute() <br> __kob_Validate() <br> __kob_Cleanup() |                  |                                     |
| Verify if code can be optimized further - <br> - Remove indented if else loops with appropriate case statements <br> - Group lines of code into a function (if they are intended to achieve a specific objective) <br> - Reuse of existing defined functions than creating newer functions |                  |                                     |
| Verify if the code exists in the branch for the specific RF # |                  |                                     |
| Verify if comments from previous pull request have been closed in the current code |                  |                                     |
