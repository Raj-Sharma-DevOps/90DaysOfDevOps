1. Which 3 commands save you the most time right now, and why?

**So there are multiple commands but these 3 commands are very useful for me**

[1. echo "Hello Bhai" > YourFile.txt You know this command writes a file directly for creating small file this will best i know vim is also there but i say vim is best for scripting and big files but for shortcut this is best

2. sudo chown is great if you want to change owner. But you know whe cah also chande groups using chown [sudo chown owner:group fileName] it will change group and owner at same time you dont have to do chgrp 👌

3. [sudo systemctl nginx] Using this command you can check your service is healthy its great for debuging your services [journalctl -u nginx] You can check logs as well as]

2. How do you check if a service is healthy? List the exact 2–3 commands you’d run first.
Command 1. [systemctl status nginx] to check the service is running or not 
Command 2. [ps aux | grep nginx ] This cmd will check the service is running on system level or not 
command 3. [journalctl -u nginx] This will show all logs of nginx you can verify what err actuly happend

3. How do you safely change ownership and permissions without breaking access? Give one example command.

command 1.[sudo chown -R raj:developers filename] this will change ownership of file and also group -R stands for recursively this will change inside file ownerships

command 2.[sudo chmod -R 755 fileName] This will change Read write execute permission of the file and files present inside

4. What will you focus on improving in the next 3 days?

**Practicing service debugging using systemctl and journalctl**

**Improving understanding of Linux permissions & ownership**