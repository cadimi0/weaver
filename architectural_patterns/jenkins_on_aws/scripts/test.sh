#!/bin/bash

# The following line is used for GitHub Actions --------------
container_name="${1:?Error: No container name provided}"

echo "Initiating the container..."
docker run -dit -v "$(pwd)/../:/app" \
  --name ${container_name} \
  ${container_name} /bin/bash

# ------------------------------------------------------------

echo "Testing..."
docker exec ${container_name} tofu -chdir=/app init
docker exec ${container_name} tofu -chdir=/app validate
docker exec ${container_name} tofu -chdir=/app test -test-directory=test

echo "test.sh completed!"