Here's a step-by-step guide to set up Nginx on Mac:


1. **Install Nginx using Homebrew**:
```bash
brew install nginx
```

2. **Start Nginx**:
```bash
sudo brew services start nginx
```

3. **Create your site configuration**:
```bash
# Create sites-available directory if it doesn't exist
sudo mkdir -p /opt/homebrew/etc/nginx/sites-available
sudo mkdir -p /opt/homebrew/etc/nginx/sites-enabled

# Create your site configuration
sudo nano /opt/homebrew/etc/nginx/sites-available/local.example.com
```

4. **Add your site configuration**:
```nginx:/opt/homebrew/etc/nginx/sites-available/local.example.com
server {
    listen 80;
    server_name local.example.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # WebSocket support for Vite HMR
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

5. **Modify the main Nginx configuration**:
```bash
sudo nano /opt/homebrew/etc/nginx/nginx.conf
```

Add this line inside the `http` block:

```bash
http {
    # ... existing config ...
    include /opt/homebrew/etc/nginx/sites-enabled/*;
    # ... existing config ...
}
```

6. **Create a symbolic link to enable your site**:
```bash
sudo ln -s /opt/homebrew/etc/nginx/sites-available/local.example.com /opt/homebrew/etc/nginx/sites-enabled/

# Test your nginx configuration
sudo nginx -t

# If test is successful, reload nginx
sudo nginx -s reload
```

7. **Update your hosts file**:
```bash
sudo nano /etc/hosts
```

Add this line:

```bash
127.0.0.1   local.example.com"
```

8. **Useful Nginx commands**:
```bash
# Start nginx
sudo brew services start nginx

# Stop nginx
sudo brew services stop nginx

# Restart nginx
sudo brew services restart nginx

# Reload configuration
sudo nginx -s reload

# Test configuration
sudo nginx -t
```

Common issues and solutions:

1. If you get a permission denied error:
```bash
sudo chown -R $USER:admin /opt/homebrew/etc/nginx
sudo chmod -R 755 /opt/homebrew/etc/nginx
```

2. If port 80 is already in use, you can check what's using it:
```bash
sudo lsof -i :80
```

3. To find your Nginx logs:
```bash
# Error log
tail -f /opt/homebrew/var/log/nginx/error.log

# Access log
tail -f /opt/homebrew/var/log/nginx/access.log
```

After setting this up, start your Vite dev server on port 3000, and you should be able to access your site at `http://local.example.com` without specifying a port number.

## nginx SSL setup

1. **First, create a self-signed certificate**:
```bash
# Create directory for certificates
sudo mkdir -p /opt/homebrew/etc/nginx/ssl

# Generate self-signed certificate
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /opt/homebrew/etc/nginx/ssl/local.example.com.key \
-out /opt/homebrew/etc/nginx/ssl/local.example.com.crt
```

2. **Update Nginx configuration**:
```nginx:/opt/homebrew/etc/nginx/sites-available/local.example.com
server {
    # Redirect HTTP to HTTPS
    listen 80;
    server_name local.example.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    server_name local.example.com;

    # SSL configuration
    ssl_certificate /opt/homebrew/etc/nginx/ssl/local.example.com.crt;
    ssl_certificate_key /opt/homebrew/etc/nginx/ssl/local.example.com.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    # Increase buffer size for large headers
    proxy_buffer_size 128k;
    proxy_buffers 4 256k;
    proxy_busy_buffers_size 256k;

    # Handle Vite HMR and asset paths
    location ~* ^/@(vite|fs|id)/ {
        proxy_pass http://127.0.0.1:30002;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_buffering off;
    }

    # Handle main location
    location / {
        proxy_pass http://127.0.0.1:30002;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_buffering off;
    }

    error_log /opt/homebrew/var/log/nginx/error.log debug;
    access_log /opt/homebrew/var/log/nginx/access.log;
}
```

3. **Update your Vite configuration**:
```javascript:vite.config.js
export default defineConfig({
  server: {
    host: '127.0.0.1',
    port: 30002,
    strictPort: true,
    hmr: {
      host: 'local.example.com',
      clientPort: 443,
      protocol: 'wss' // Use secure WebSocket
    }
  }
})
```

4. **Reload Nginx**:
```bash
sudo nginx -t
sudo nginx -s reload
```


Now you should be able to access your site at `https://local.example.com`. You'll likely see a browser warning about the self-signed certificate - you can proceed by accepting the risk (this is safe for local development).
