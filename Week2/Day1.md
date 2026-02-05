### Host a website on ec2, Scale the website with autoscaling using scaling policies

1. Launched an EC2 instance
   Select **Ubuntu Server 24.04 LTS**.
   Instance type: t3.micro.
   Security group rules:

   * SSH: port 22
   * HTTP: port 80

2. Connect to the instance

   ```
   ssh -i key.pem ubuntu@<public-ip>
   ```

3. Install Apache web server

   ```
   sudo apt update
   sudo apt install apache2 -y
   ```

4. Start and enable Apache

   ```
   sudo systemctl start apache2
   sudo systemctl enable apache2
   ```

5. Create a simple website

   ```
   sudo nano /var/www/html/index.html
   ```

images

6. Verifying the website
 output 
---

### Part 2: Prepare the instance for scaling

1. Create an AMI
   From the EC2 console, create an image of this Ubuntu instance.

   images

2. Create a Launch Template

   * AMI: the one you created
   * Instance type: t2.micro
   * Security group: allow HTTP and SSH

   Optional user data:

   ```
   #!/bin/bash
   apt update
   apt install apache2 -y
   systemctl start apache2
   ```

---

### Part 3: Configure Auto Scaling

1. Create an Auto Scaling Group

   * Launch template: select the Ubuntu template
   * Availability Zones: choose at least two
   * Desired capacity: 1
   * Min: 1
   * Max: 3

2. Create and attach a Load Balancer

   * Create an **Application Load Balancer**
   * Listener: HTTP port 80
   * Target group: instance type, port 80
   * Attach the Auto Scaling Group to the target group

3. Add scaling policies
   Use target tracking scaling.
   Example:

   * Average CPU utilization: 60 percent

---

### Part 4: Test Auto Scaling

1. Generate CPU load

   ```
   sudo apt install stress -y
   stress --cpu 2
   ```

2. Monitor scaling

   * Watch CloudWatch metrics
   * New instances should launch automatically
   * Instances terminate when load stops

---

### Outcome

At the end of Day 1, you will have:

* An Ubuntu-based EC2 web server
* An AMI and launch template
* An Auto Scaling Group
* A load-balanced, auto-scaling website

If you want, I can shorten this into a **2–3 line daily log**, a **handwritten lab note**, or an **interview-ready explanation**.
