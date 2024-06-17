if (( ! $+commands[tinyproxy] )); then
  return
fi

PORT_TINY=11811
PORT_SSH=12345

if [[ ! -x /usr/local/opt/gnu-sed/libexec/gnubin/sed ]]; then
  return
fi

if [[ ! -r /usr/local/etc/tinyproxy/tinyproxy.conf ]]; then
  return
fi

if [[ ! -r /usr/local/etc/tinyproxy/configured ]]; then

  # restore if we have backup but want to reconfigure it
  if [[ -r /usr/local/etc/tinyproxy/tinyproxy.conf.bckp ]]; then
    cat /usr/local/etc/tinyproxy/tinyproxy.conf.bckp > /usr/local/etc/tinyproxy/tinyproxy.conf
  fi

  # backup
  cat /usr/local/etc/tinyproxy/tinyproxy.conf > /usr/local/etc/tinyproxy/tinyproxy.conf.bckp

  # the example content is shown below
  /usr/local/opt/gnu-sed/libexec/gnubin/sed -i \
    -e "s/^Port .\+/Port ${PORT_TINY}/" \
    -e '/^$/d' \
    -e '/^#/d' \
    /usr/local/etc/tinyproxy/tinyproxy.conf
  echo "Upstream socks5 127.0.0.1:${PORT_SSH}" >> /usr/local/etc/tinyproxy/tinyproxy.conf

  # means we have configured the service
  touch /usr/local/etc/tinyproxy/configured
fi

# it's possible to use 'brew services info tinyproxy --json' to see whether tinyproxy is running, but this is too slow
pgrep tinyproxy >& /dev/null
if [[ $? -ne 0 ]]; then
  brew services restart tinyproxy

  pgrep tinyproxy >& /dev/null
  if [[ $? -ne 0 ]]; then
    return
  fi
fi

export http_proxy=http://127.0.0.1:${PORT_TINY}
export HTTP_PROXY=http://127.0.0.1:${PORT_TINY}
export https_proxy=http://127.0.0.1:${PORT_TINY}
export HTTPS_PROXY=http://127.0.0.1:${PORT_TINY}
export no_proxy=10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,127.0.0.0/8
export NO_PROXY=10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,127.0.0.0/8

alias proxyoff='unset http_proxy; unset HTTP_PROXY; unset https_proxy; unset HTTPS_PROXY; unset no_proxy; unset NO_PROXY'
alias     poff='unset http_proxy; unset HTTP_PROXY; unset https_proxy; unset HTTPS_PROXY; unset no_proxy; unset NO_PROXY'
alias  unproxy='unset http_proxy; unset HTTP_PROXY; unset https_proxy; unset HTTPS_PROXY; unset no_proxy; unset NO_PROXY'
alias      unp='unset http_proxy; unset HTTP_PROXY; unset https_proxy; unset HTTPS_PROXY; unset no_proxy; unset NO_PROXY'

if (( ! $+commands[autossh] )); then
  return
fi

grep -q "^Host tunnel" ~/.ssh/config >& /dev/null
if [[ $? -ne 0 ]]; then
  autossh -f -M 0 tunnel -xCNT -D ${PORT_SSH} \
    -o ServerAliveInterval=10 \
    -o ServerAliveCountMax=1 \
    -o ExitOnForwardFailure=yes \
    -o StrictHostKeyChecking=accept-new
fi

alias ash='f_ash() { if [[ -n $1 ]] ; then test "$1" = "kill" && kill $(ps aux | grep autossh | grep -v grep | awk "{print \$2}") || autossh -f -M 0 $1 -xCNT -D ${PORT_SSH} -o ServerAliveInterval=10 -o ServerAliveCountMax=1 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=accept-new ; else ps aux | grep autossh | grep -v grep ; fi ; } ; f_ash'


### 'tinyproxy.conf' example content
#   User nobody
#   Group nobody
#   Port ${PORT_TINY}
#   Timeout 600
#   DefaultErrorFile "/usr/local/Cellar/tinyproxy/1.11.1/share/tinyproxy/default.html"
#   StatFile "/usr/local/Cellar/tinyproxy/1.11.1/share/tinyproxy/stats.html"
#   LogLevel Info
#   MaxClients 100
#   Allow 127.0.0.1
#   Allow ::1
#   ViaProxyName "tinyproxy"
#   Upstream socks5 127.0.0.1:${PORT_SSH}
