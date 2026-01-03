```
docker volume create linux_data
```
```
docker build -t linux-ssh .
```

```
docker run -d \
  --name linux_vm \
  -p 2222:22 \
  -v linux_data:/home \
  linux-ssh
```