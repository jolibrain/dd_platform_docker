# DeepDetect Platform Docker

## Installation

```
# Setup platform project name, directory and architecture
export PROJECT_NAME=dd_platform
export DD_PLATFORM=$HOME/deepdetect
export ARCH=cpu # gpu also available

# Install platform repository
git clone https://github.com/jolibrain/dd_platform_docker.git \
    ${DD_PLATFORM}

# Go to directory
cd ${DD_PLATFORM}/code/${ARCH}/

# Start platform docker containers
CURRENT_UID=$(id -u):$(id -g) MUID=$(id -u) \
    docker-compose -p $PROJECT_NAME up -d

# Go to http://localhost:1912
```

## Connecting to an existing DeepDetect server

If you need to connect a new DeepDetect server to the platform,
you must modify the `nginx` configuration to access to this server,
and the `platform-ui` configuration to update the UI.

### config/nginx/nginx.conf

Set a new `upstream` in the `http` section:

```
upstream UPSTREAM_NAME {
	least_conn;
	server DD_HOST:DD_PORT max_fails=3 fail_timeout=30s;
}
```

Set a new `location` in the `server` section:

```
location ~ /api/SERVER_NAME/(?<url>.*) {
	proxy_pass http://UPSTREAM_NAME/$url$is_args$args;
	proxy_http_version 1.1;
	proxy_set_header Upgrade $http_upgrade;
	proxy_set_header Connection 'upgrade';
	proxy_set_header Host $host;
	proxy_cache_bypass $http_upgrade;
}
```

### config/platform_ui/config.json

In `deepdetect.servers` array, add the following item:

```
{
  "name": "SERVER_NAME",
  "settings": {
    "path": "/api/SERVER_NAME",
    "isWritable": true
  }
}
```

The flag `isWritable` will allow you to create and delete services on this server
from the `platform_ui` web interface.

## Monitoring another GPU

In order to monitor a GPU, you'll need to modify the `platform_ui` config file
to update the interface, and the `nginx` config to let the interface access it.

### config/nginx/nginx.conf

Set a new `upstream` in the `http` section:

```
upstream gpu_stat_GPU_NAME {
  least_conn;
  server GPU_STATS_HOST:GPU_STATS_PORT max_fails=3 fail_timeout=30s;
}

```

Usually, `GPU_STATS_PORT` is `12345`

Set a new `location` in the `server` section:

```
location ~ /gpu/ENDPOINT {
  proxy_pass http://gpu_stat_GPU_NAME/$url$is_args$args;
  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection 'upgrade';
  proxy_set_header Host $host;
  proxy_cache_bypass $http_upgrade;
}
```

### config/platform_ui/config.json

In `gpuInfo.servers` array, add the following item:

```
{
  "name": "GPU_NAME",
  "url": "/gpu/ENDPOINT"
}
```

## Configuration of docker image versions

Docker-compose uses the `latest` tag for all docker images that correspond to
the latest stable version.

You can select the wanted version with these following environment variables:

```
DD_SERVER_TAG=latest
DD_PLATFORM_UI_TAG=latest
DD_JUPYTER_TAG=latest
DD_FILEBROWSER_TAG=latest
```
