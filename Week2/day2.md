

## Prerequisites
- Two EC2 instances running **Ubuntu 24.04**
- Port **22 (SSH)** and **80 (HTTP)** allowed in the security group
- PEM key file downloaded on local machine
- SSH access to both instances

![image](./images/instaces.png)

---

## Web Server 1 & 2 Setup

### Step 1: Connected to EC2 Instance
```bash
ssh -i "cloudtech-soniya.pem" ubuntu@<public-ip-server-1>
```

### Step 2: Update System Packages

```bash
sudo apt update
```

### Step 3: Installed Apache Web Server

```bash
sudo apt install apache2 -y
```

### Step 4: Started and Enabled Apache

```bash
sudo systemctl start apache2
sudo systemctl enable apache2
```

### Step 5: Installed PHP

```bash
sudo apt install php -y
```

### Step 6: Create Web Page

```bash
cd /var/www/html
sudo nano index.php
```

Add the following content:

```
<!DOCTYPE html>
<html>
<head>
  <title>Soniya Sharma</title>
</head>
<body>
  <h1>Soniya Sharma</h1>
  <p>Hosted on Ubuntu EC2 using Apache</p>
  <p>Server: <?php echo gethostname(); ?></p>
</body>
</html>

```
[image](./images/html.png)

### Step 7: Restart Apache

```bash
sudo systemctl restart apache2
```

### Step 8: output
![image](./images/output1.png)
![image](./images/output2.png)

---


