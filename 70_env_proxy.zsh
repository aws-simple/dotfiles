# 1) make backup of initial 'tinyproxy' configuration file
#   `cp /usr/local/etc/tinyproxy/tinyproxy.conf /usr/local/etc/tinyproxy/tinyproxy.conf_bckp_00`
# 2) change its content to the following
#   `cat /usr/local/etc/tinyproxy/tinyproxy.conf`
#   User nobody
#   Group nobody
#   Port 11811
#   Timeout 600
#   DefaultErrorFile "/usr/local/Cellar/tinyproxy/1.11.1/share/tinyproxy/default.html"
#   StatFile "/usr/local/Cellar/tinyproxy/1.11.1/share/tinyproxy/stats.html"
#   LogLevel Info
#   MaxClients 100
#   Allow 127.0.0.1
#   Allow ::1
#   ViaProxyName "tinyproxy"
#   Upstream socks5 127.0.0.1:12345
# 3) use the following command to establish ssh tunnel which listen on the port used as 'tinyproxy' upstream socket
#   `ssh -D 12345 -xCNTf user@host`
# 4) use the content of this file as part of shell init configuragion to setup proxy environment variables (like 'http_proxy' one and other)

if (( ! $+commands[tinyproxy] )); then
  return
fi

if (( ! $+commands[jq] )); then
  return
fi

# To start tinyproxy as background service run:
#   brew services restart tinyproxy
# 
# To restart tinyproxy after an upgrade run:
#   brew services restart tinyproxy

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
