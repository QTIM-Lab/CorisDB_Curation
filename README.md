# coris_db
Repo for organizing the db scheme of our coris_db

## NGINX and FLASK Deploy
[source](https://dev.to/herbzhao/my-docker-learning-journey-edh)

### Instructions
1. Build Flask container
```bash
docker build -f flask/Dockerfile -t bbearce/flask-wsgi:python3.6 ./flask
```

2. Build Nginx container
```bash
docker build -f nginx/Dockerfile -t bbearce/nginx:nginx ./flask
```

1. Build Vue container
[source](https://vuetifyjs.com/en/getting-started/installation/)
I need to create the base template:

```bash
docker run \
  -it \
  --rm \
  -v /home/bearceb/coris_db/vue/project:/project \
  --entrypoint sh \
  node:lts-alpine3.17
```

```bash
/ # yarn create vuetify
/ # cp -r /vuetify-project/* /project/
/ # exit
```

```bash
docker build -f vue/Dockerfile -t bbearce/vue:node ./vue
# docker rmi bbearce/vue:node
```

```bash
docker run \
  -it \
  --rm \
  -v /home/bearceb/coris_db/vue/project:/project \
  --network=host \
  -w /project \
  --entrypoint sh \
  bbearce/vue:node
```





```
docker run \
  --name vue-test \
  -it \
  --rm \
  -v /home/bearceb/coris_db/vue/project:/project \
  node:lts-alpine3.17
```
