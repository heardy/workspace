##### Login and Save session cookie
`curl --data "log=<user>&pwd=<pass>&rememberme=forever&submit=Login+%C2%BB&redirect_to=wp-admin%2F" --cookie-jar ./cookie.txt https://<site-url>/blog/wp-login.php`
