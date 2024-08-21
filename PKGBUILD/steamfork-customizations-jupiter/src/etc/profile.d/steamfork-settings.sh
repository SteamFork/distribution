# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)
# Copyright (C) 2024 Fewtarius

J_DIR="/home/.config/system"
J_CONF="${J_DIR}/platform.cfg"
J_CONF_LOCK="/tmp/.platform.cfg.lock"

function log() {
  SOURCE=${1//\/*\//}
  MESSAGE=${*#${1}}
  MESSAGE=${MESSAGE# }
  logger -t ${SOURCE} "${MESSAGE}"
}

function create_settings() {
  if [ ! -d "${J_DIR}" ]
  then
    mkdir -p "${J_DIR}"
  fi
  if [ ! -e "${J_CONF}" ]
  then
    touch "${J_CONF}"
  fi
}

function get_setting() {
  create_settings
  if [ -n "${3}" ]
  then
    ### Test to see if we have a game setting.
    VAR="$2\[\"$(echo ${3} | sed -E "s~'~\\\x27~g"';s~[()&]~\\&~g')\"\]\.$1"
    OUTPUT=$(awk 'BEGIN {FS="="} /^'"${VAR}"'/ {print $NF}' ${J_CONF})
    if [ ! -z "${OUTPUT}" ]
    then
      echo ${OUTPUT}
      return
    else
      ### If not, check to see if we have a system setting.
      LOCAL=$(awk -F: '/^'"${2}.${1}"'=/ { st = index($0,"=");print substr($0,st+1);exit}' ${J_CONF})
      if [ ! -z "${LOCAL}" ]
      then
        echo ${LOCAL}
        return
      fi
    fi
  fi

  if [ -z "${3}" ] && [ -n "${2}" ]
  then
    ### Check to see if we have a global setting.
    LOCAL=$(awk -F: '/^'"${2}.${1}"'=/ {  st = index($0,"=");print substr($0,st+1);exit}' ${J_CONF})
    if [ ! -z "${LOCAL}" ]
    then
      echo ${LOCAL}
      return
    fi
  fi

  ### Check to see if we have a "system." global setting.
  SYSTEM=$(awk -F: '/^system.'"${1}"='/ { st = index($0,"=");print substr($0,st+1);exit}' ${J_CONF})
  if [ -n "${SYSTEM}" ]
  then
    echo ${SYSTEM}
    return
  fi

  ### Check to see if we have a "global." global setting."
  LOCAL=$(awk -F: '/^'"${1}"='/ { st = index($0,"=");print substr($0,st+1);exit}' ${J_CONF})
  if [ -z "${LOCAL}" ]
  then
    awk -F: '/^global.'"${1}"='/ { st = index($0,"=");print substr($0,st+1);exit}' ${J_CONF}
    return
  else
    echo ${LOCAL}
  fi
  return
}

function wait_lock() {
  while true
  do
    if (set -o noclobber; echo "$$" > "${J_CONF_LOCK}") 2>/dev/null
    then
      trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT
      break
    else
     sleep 1
    fi
  done
}

function del_setting() {
  create_settings
  wait_lock
  if [[ "${1}" =~ ^[[:alnum:]] ]]
  then
    sed -i "/^${1}=/d" "${J_CONF}"
  fi
  rm -f "${J_CONF_LOCK}"
}

function sort_settings() {
  create_settings
  wait_lock
  cat "${J_CONF}" | grep ^[a-z0-9] | sort >"${J_CONF}.tmp"
  mv "${J_CONF}.tmp" "${J_CONF}"
  rm -f "${J_CONF_LOCK}"
}

function set_setting() {
  create_settings
  if [[ "${1}" =~ ^[[:alnum:]] ]]
  then
    del_setting "${1}"
    if [ ! "${2}" = "default" ]
    then
      wait_lock
      echo "${1}=${2}" >> "${J_CONF}"
      rm -f "${J_CONF_LOCK}"
    fi
  fi
}
