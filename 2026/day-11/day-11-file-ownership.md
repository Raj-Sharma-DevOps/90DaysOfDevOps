# Day 11 Challenge

## Files & Directories Created
~/devops/
├── devops.txt
├── notes.txt
├── script.sh
├── project/
├── project-config.yaml
├── team-notes.txt
├── app-logs/
├── heist-project/
│   ├── plans/
│   │   └── strategy.txt
│   └── vault/
│       └── gold.txt


~/practice-devops/
└── bank-heist/
    ├── access-codes.txt/
    ├── blueprints.pdf/
    └── escape-plan.txt/


## Ownership Changes
notes.txt
ubuntu:ubuntu → berlin:developers

team-notes.txt
ubuntu:ubuntu → ubuntu:hiest-team

project-config.yaml
ubuntu:ubuntu → professor:hiest-team

app-logs/
ubuntu:ubuntu → berlin:hiest-team

heist-project/
ubuntu:ubuntu → professor:planners

bank-heist/access-codes.txt/
ubuntu:ubuntu → tokyo:vault-team

bank-heist/blueprints.pdf/
ubuntu:ubuntu → berlin:tech-team

bank-heist/escape-plan.txt/
ubuntu:ubuntu → nirobi:vault-team


## Commands Used

# SSH
ssh -i Devops.pem ubuntu@ec2-44-220-163-26.compute-1.amazonaws.com

# Create files & directories
touch devops.txt notes.txt script.sh
mkdir project app-logs
touch team-notes.txt project-config.yaml

# Group management
sudo groupadd developers
sudo groupadd hiest-team
sudo groupadd planners
sudo groupadd vault-team
sudo groupadd tech-team

# Ownership & group changes
sudo chown :tokyo notes.txt
sudo chown berlin notes.txt
sudo chown :berlin notes.txt
sudo chown $USER notes.txt
sudo chgrp tokyo notes.txt
sudo chgrp developers notes.txt
sudo chown berlin:tokyo notes.txt
sudo chgrp hiest-team team-notes.txt
sudo chown professor:hiest-team project-config.yaml
sudo chown berlin:hiest-team app-logs

# Nested directories
mkdir -p heist-project/{vault,plans}
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.txt
sudo chown professor:planners heist-project

# Practice project
mkdir -p practice-devops/bank-heist
mkdir -p bank-heist/{access-codes.txt,blueprints.pdf,escape-plan.txt}
mv bank-heist practice-devops/

sudo chown tokyo:vault-team bank-heist/access-codes.txt
sudo chown berlin:tech-team bank-heist/blueprints.pdf
sudo chown nirobi:vault-team bank-heist/escape-plan.txt

# Verification
ls -l
ls -lR
tail -n 2 /etc/group


## What I Learned

1. How we can change owner and groups
2. We can also change group using chown 
3. We can see full group using -lR