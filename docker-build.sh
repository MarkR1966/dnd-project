#! /bin/bash
docker-compose build
docker-compose push
ssh jenkins@dnd-manager << EOF
cd /home/rajahamza104/dnd-project
git checkout development
env SECRET_KEY=${SECRET_KEY} env DB_USER=${DB_USER} env DB_PASS=${DB_PASS} docker stack deploy --compose-file docker-compose.yaml dnd
EOF
