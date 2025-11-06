# Hometask #4

**Topic:** User management and permissions configuration on AWS EC2 (Ubuntu 22.04)

Objective

* Deploy an AWS EC2 instance using **Ubuntu 22.04**.
* Configure two users (`adminuser` and `poweruser`) with specific permissions and access rules.

Steps to Run

### **Step 1 — Launch EC2 Instance**

1. Open **AWS Management Console** or use **AWS CLI**.
2. Launch a new **EC2 instance**:

   * Image: `Ubuntu 22.04 `
   * Instance type: `t3.micro`
   * Key pair: your existing key (`.pem` file)
   * Add the prepared script in **User data** (it automatically configures all users and permissions).
3. Wait until the instance status is **running**.

 **Step 2 — Connect via SSH**

Use your terminal to connect to the instance:

```bash
ssh -i "<your-key>.pem" ubuntu@<your-instance-public-ip>
```

**Step 3 — Verify User Creation**

Check that both users were created:

```bash
cat /etc/passwd | grep user
```

You should see:

```
adminuser:x:1001:1001::/home/adminuser:/bin/bash
poweruser:x:1002:1002::/home/poweruser:/bin/bash
```

Verify that `poweruser` can use `iptables` without a password:

   ```bash
   sudo -l -U poweruser
   ```

   Output should include:

   ```
   (ALL) NOPASSWD: /sbin/iptables
   ```

**Step 5 — Check Login Behavior**

Switch to each user:

   ```bash
   su - adminuser
   su - poweruser
   ```
Ensure:

   * `adminuser` requires a password to log in;
   * `poweruser` can log in **without** a password.


Expected Result

* Instance runs successfully with preconfigured users.
* `adminuser` can use `sudo`.
* `poweruser` can log in without a password and run `iptables` via sudo without prompts.
* The symbolic link `/home/poweruser/mtab-link` correctly points to `/etc/mtab`.
