taken from - [https://gist.github.com/ethicka/27c36c975a5c2cbbd1874bc78bab61c4](https://gist.github.com/ethicka/27c36c975a5c2cbbd1874bc78bab61c4)

---

🚨 __2020 Update__: I recommend using [mkcert](https://mkcert.dev) to generate local certificates. You can do everything below by just running the commands `brew install mkcert` and `mkcert -install`. Keep it simple!

---

*This gives you that beautiful green lock in Chrome.* I'm assuming you're putting your SSL documents in `/etc/ssl`, but you can put them anywhere and replace the references in the following commands. Tested successfully on Mac OS Sierra and High Sierra.

## Set up `localhost.conf`

`sudo nano /etc/ssl/localhost/localhost.conf`

Content:

```
[req]
default_bits = 1024
distinguished_name = req_distinguished_name
req_extensions = v3_req

[req_distinguished_name]

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
```

## Commands

Run these commands:
```sh
sudo openssl genrsa -out /etc/ssl/localhost/localhost.key 2048
sudo openssl rsa -in /etc/ssl/localhost/localhost.key -out /etc/ssl/localhost/localhost.key.rsa
```
If you're changing the domain from localhost then update the variable `CN` in the following:
```sh
sudo openssl req -new -key /etc/ssl/localhost/localhost.key.rsa -subj /CN=localhost -out /etc/ssl/localhost/localhost.csr -config /etc/ssl/localhost/localhost.conf
```
I set the certificate to expire in 10 years (3650 days).
```sh
sudo openssl x509 -req -extensions v3_req -days 3650 -in /etc/ssl/localhost/localhost.csr -signkey /etc/ssl/localhost/localhost.key.rsa -out /etc/ssl/localhost/localhost.crt -extfile /etc/ssl/localhost/localhost.conf
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /etc/ssl/localhost/localhost.crt
```

Done.

## Bonus: BrowserSync works over HTTPS

The whole reason I got into this was to get browserSync to work over HTTPS. This will allow you to use browserSync in your gulpfile.js with the following added browserSync command:

```js
browserSync.init({
  https: {
    key: "/etc/ssl/localhost/localhost.key",
    cert: "/etc/ssl/localhost/localhost.crt"
  },
});
```

Or in Webpacks (`webpack.config.watch.js` or `webpack.config.js`):

```js
new BrowserSyncPlugin({
  advanced: {
    browserSync: {
      https: {
        key: "/etc/ssl/localhost/localhost.key",
        cert: "/etc/ssl/localhost/localhost.crt"
      },
    }
  }
}),
```
