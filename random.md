##### Login and Save session cookie
`curl --data "log=<user>&pwd=<pass>&rememberme=forever&submit=Login+%C2%BB&redirect_to=wp-admin%2F" --cookie-jar ./cookie.txt <site-url>`

`curl --user <username>:<password> --cookie-jar ./cookie.txt <site-url>`

`curl --interface <ip-address> --user <username>:<password> --cookie-jar ./cookie.txt <site-url>`

##### NTFS on MacOS

`sudo ntfs-3g /dev/disk2s1 ./mnt/ntfs/ -olocal -oallow_other -o auto_xattr`
