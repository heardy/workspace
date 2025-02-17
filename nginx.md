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
