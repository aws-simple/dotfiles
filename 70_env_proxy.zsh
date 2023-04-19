if (( ! $+commands[tinyproxy] )); then
  return
fi

if (( ! $+commands[brew] )); then
  return
fi

if (( ! $+commands[jq] )); then
  return
fi

### too slow
### if [[ $(brew services info tinyproxy --json | jq '.[] | .running') != "true" ]]; then
###   return
### fi

pgrep tinyproxy >& /dev/null
if [[ $? -ne 0 ]]; then
  return
fi

if [[ ! -r /usr/local/etc/tinyproxy/tinyproxy.conf ]]; then
  return
fi

port=$(cat /usr/local/etc/tinyproxy/tinyproxy.conf | grep ^Port | cut -f2 -d' ')
if [[ ! -n "$port" ]]; then
  return
fi

export http_proxy=http://127.0.0.1:$port
export HTTP_PROXY=http://127.0.0.1:$port
export https_proxy=http://127.0.0.1:$port
export HTTPS_PROXY=http://127.0.0.1:$port
