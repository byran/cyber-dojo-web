#!/bin/bash
set -e

my_dir="$( cd "$( dirname "${0}" )" && pwd )"
. ${my_dir}/env_vars.sh

one_time_creation_of_start_point_volumes()
{
  curl https://raw.githubusercontent.com/cyber-dojo/commander/master/cyber-dojo > /tmp/cyber-dojo
  chmod +x /tmp/cyber-dojo
  local GIT_URL=https://github.com/cyber-dojo/start-points-
  set +e
  # These all fail (and do nothing) if the start-point already exists
  /tmp/cyber-dojo start-point create ${CYBER_DOJO_START_POINT_LANGUAGES} \
      --list=https://raw.githubusercontent.com/cyber-dojo/start-points-languages/master/languages_list_travis 2> /dev/null
  /tmp/cyber-dojo start-point create ${CYBER_DOJO_START_POINT_EXERCISES} \
      --git=${GIT_URL}exercises.git 2> /dev/null
  /tmp/cyber-dojo start-point create ${CYBER_DOJO_START_POINT_CUSTOM} \
      --git=${GIT_URL}custom.git 2> /dev/null
  set -e
  rm /tmp/cyber-dojo
}

one_time_creation_of_start_point_volumes

docker-compose --file ${my_dir}/docker-compose.yml up -d
sleep 2