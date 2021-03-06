#!/bin/bash
set -e
echo "Starting updating script..."

URL=https://openvpn.net/software-packages/
LATEST_DEB=$(curl ${URL} -s | grep -oP "http.*Ubuntu16.amd_64.deb")
LATEST_VER=$(echo $LATEST_DEB | grep -Po "(?<=openvpn-as-)[0-9.]*-Ubuntu16" )
exit 0
echo "Latest DEB $LATEST_DEB ver:$LATEST_VER"

if [ ! -f /tmp/foo.txt ]; then
    echo "OpenVPN Access Point is not installed"
    CURRENT_VER=0
else
    CURRENT_VER=$(dpkg -s openvpn-as | grep -Po '(?<=Version: ).*')   
    echo "OpenVPN installed $CURRENT_VER"
fi


stop_openvpnas ()
{
  echo "Stopping openvpnas"
  # remove twisted pid
  if ps -p $(cat twistd.pid) > /dev/null 2>&1
  then
    kill $(cat twistd.pid)
    rm /twistd.pid
    /usr/local/openvpn_as/scripts/openvpnas -n
    exit 0
  else
    echo "no process running using twistd file"
    rm /twistd.pid   
  fi
}

# remove pid file if it exists
if [ -e "/var/run/openvpnas.pid" ]; then
  rm -f "/var/run/openvpnas.pid" &>/dev/null
fi

echo "Latest available openvpn-as ver: ${LATEST_VER}"
echo "Current openvpn-as installed ver: ${CURRENT_VER}"

if [ "$LATEST_VER" == "$CURRENT_VER" ]; then
  echo "Update is not required"
  exit 0
else
  echo "Updating openvpn-as to ${LATEST_VER}"
  wget $LATEST_DEB -O openvpn-as.deb
  stop_openvpnas && dpkg -i openvpn-as.deb  && rm -rf openvpn-as.deb
fi

