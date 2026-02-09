

# Create S3 bucket with no public access and ACL disabled, Create IAM policy for ec2 to access s3

---

# STEP 1 — Created Private S3 Bucket

---

## 1. Opened S3 Service

AWS Console → Search → **S3** → Click **Create bucket**

---

## 2. Configured Bucket

### Bucket Type

Selected:

```
General Purpose
```

---

### Bucket Name

```
soniya-s3-bucket
```
---

### Region

Choosed:

```
us-east-1 (same region as EC2)
```

---

## 3. Disabled ACLs

Selected:

```
Bucket owner enforced (ACLs disabled)
```

This ensures:

* Access controlled only through IAM policies


---

## 4. Blocked Public Access

Enabled:

```
Block ALL public access
```

This prevents:

* Public bucket policies
* Public ACL permissions

---

## 5. Enabled Encryption

Selected:

```
Server-side encryption with Amazon S3 managed keys (SSE-S3)
```

---

## 6. Created Bucket

Clicked:

```
Create bucket
```

---
![image3](./images3/s3bucket.png)

# STEP 2 — Created IAM Policy For S3 Access

---

## 1. IAM

AWS Console → IAM → Policies → Create policy

---

## 2. Selected JSON Editor

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ListBucket",
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::soniya-s3-bucket"
    },
    {
      "Sid": "ObjectAccess",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::soniya-s3-bucket/*"
    }
  ]
}
```
![image3](./images3/policy1.png)
---

## 3. Named Policy

```
soniya-s3-policy
```

Clicked:

```
Create policy
```
![image3](./images3/policy2.png)
![image3](./images3/policy3.png)

---

# STEP 3 — Create IAM Role For EC2

## 1. IAM → Roles → Create role
---

## 2. Selected Trusted Entity

Choosed:

```
AWS Service
```

Use Case:

```
EC2
```
---
![image3](./images3/role1.png)

## 3. Attached Policy

Select:

```
soniya-s3-policy
```

---

## 4. Named Role

```
soniya-ec2-s3-access-role
```

Clicked:

```
Create role
```

![image3](./images3/role3.png)
![image3](./images3/role2.png)
---

# STEP 4 — Launched EC2 Instance

![image3](./images3/ec2.png)

---

# STEP 5 — Connected To EC2

Use SSH:

```
ssh -i key.pem ubuntu@public-ip
```

---

# STEP 6 — Installed AWS CLI (Ubuntu Only)

---

### Updated System

```
sudo apt update
```

---

### Installed unzip

```
sudo apt install unzip -y
```

---

### Downloaded AWS CLI

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

---

### Unziped

```
unzip awscliv2.zip
```

---

### Installed

```
sudo ./aws/install
```

---

### Verified

```
aws --version
```

---

# STEP 7 — Verified IAM Role

Run:

```
aws sts get-caller-identity
```

Output showed:

![image3](./images3/ec2-role.png)

---

# STEP 8 — Tested S3 Access

---

## Listed Objects In Bucket

```
aws s3 ls s3://soniya-s3-bucket
```


---

## Uploaded File

```
echo "hello" > test.txt
aws s3 cp test.txt s3://soniya-s3-bucket/
```

---

## Confirmed Upload

```
aws s3 ls s3://soniya-s3-bucket
```
![image3](./images3/ec2-s3-access.png)
---

## Download File

```
aws s3 cp s3://soniya-s3-bucket/test.txt download.txt
```
![image3](./images3/s3download.png)
---



# RESULT

EC2 can now securely:

- Upload files to S3
- Download files from S3
- List objects inside bucket


Here are your **clean, exam-ready / revision-ready notes** from your content. I compressed and structured everything into **high-yield bullet notes** so you can revise quickly for internship, interview, or certification.

---

# AWS Simple Storage Service (S3) – Short Notes

---

# 1. What is Amazon S3?

Amazon S3 is a **scalable object storage service** used to store and retrieve unlimited data from anywhere.

### Key Highlights

* Industry-leading durability (99.999999999%)
* Highly scalable and secure
* Stores data as **objects inside buckets**
* Used by companies like Netflix, Airbnb, etc.

---

# 2. Core Architecture

---

## Bucket

Container that stores objects.

### Features

* Globally unique name
* Region specific storage
* Acts like top-level folder

---

## Object

Basic storage unit in S3.

### Components

* **Key** → Object name/path
* **Value** → Actual data
* **Metadata** → Object information
* **Size Limit** → 0 Bytes – 5 TB

---

# 3. S3 Storage Classes

Used to optimize cost and performance based on access pattern.

| Storage Class        | Access     | AZs | Use Case                       |
| -------------------- | ---------- | --- | ------------------------------ |
| S3 Standard          | Frequent   | ≥3  | Websites, apps                 |
| Intelligent-Tiering  | Unknown    | ≥3  | Automatic cost optimization    |
| Standard-IA          | Infrequent | ≥3  | Backups, DR                    |
| One Zone-IA          | Infrequent | 1   | Reproducible data              |
| Glacier Instant      | Rare       | ≥3  | Fast archive retrieval         |
| Glacier Flexible     | Rare       | ≥3  | Archive with delayed retrieval |
| Glacier Deep Archive | Very Rare  | ≥3  | Long-term compliance           |

---

# 4. S3 Lifecycle Management

Automates storage cost optimization.

### Functions

* Moves objects between storage classes
* Deletes old data
* Manages object versions

### Example Lifecycle Rule

* 30 days → Standard-IA
* 365 days → Glacier Deep Archive
* 7 years → Delete object

---

# 5. Access Control & Security

Controls who can access S3 data.

---

## IAM Policies

* Controls user/role permissions
* Most commonly used method

---

## Bucket Policies

* JSON-based policies attached to bucket
* Used for cross-account or public access

---

## Access Control Lists (ACLs)

* Legacy method
* AWS recommends disabling ACLs

---

## Block Public Access

* Prevents accidental public exposure
* Enabled by default

---

# 6. Encryption Methods

---

## Server-Side Encryption (SSE)

### Types

* SSE-S3 → AWS managed keys
* SSE-KMS → AWS KMS managed keys (auditing + rotation)
* SSE-C → Customer managed keys

---

## Client-Side Encryption

* Data encrypted before uploading

---

# 7. Data Consistency

S3 provides:

Strong Read-After-Write Consistency
Latest data is immediately available after upload or update.

---

# 8. S3 Versioning

Stores multiple versions of objects.

### Benefits

* Protects accidental deletion
* Enables rollback to previous version
* Uses delete markers instead of permanent deletion

---

# 9. Advanced S3 Features

---

## Cross-Region Replication (CRR)

Replicates data to another region for DR and compliance.

---

## Pre-Signed URLs

Temporary access to private objects.

Example:

* Secure download/upload links

---

## Object Lock (WORM)

Write Once Read Many.

Used for:

* Legal compliance
* Audit requirements

---

## S3 Select

Query object data using SQL to reduce transfer cost.

---

# 10. Basic Workflow Using S3

---

### Step 1 → Create Bucket

### Step 2 → Upload Objects

### Step 3 → Configure Permissions

### Step 4 → Setup Lifecycle Rules

### Step 5 → Enable Logging & Monitoring

---

# 11. Monitoring & Logging

Use:

* S3 Access Logs
* CloudWatch

Tracks:

* Object access
* Usage activity




