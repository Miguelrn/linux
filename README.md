```
docker volume create linux_data
```
```
docker build -t linux-ssh .
```
```
docker run -it --rm -v linux_data:/home/dockeruser ubuntu bash
---
mkdir -p /home/dockeruser/.ssh
chmod 700 /home/dockeruser/.ssh
cat << EOF > /home/dockeruser/.ssh/authorized_keys
<PASTE YOUR PUBLIC KEY CONTENT HERE>
EOF
chmod 600 /home/dockeruser/.ssh/authorized_keys
chown -R 1000:1000 /home/dockeruser/.ssh
exit

```

```
docker run -d \
  --name linux_vm \
  -p 2222:22 \
  -v linux_data:/home/dockeruser \
  linux-ssh
```