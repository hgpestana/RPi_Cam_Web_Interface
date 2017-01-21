#!/bin/bash
sink_addr=$1
mac_addr=$2
if bluetoothctl <<< "info $mac_addr" | grep -qi "Connected: no"; then
      pulseaudio --start
      sleep 3s
      bluetoothctl <<< "trust $mac_addr"
      sleep 3s
      bluetoothctl <<< "connect $mac_addr"
      sleep 8s
      pactl set-card-profile bluez_card.$sink_addr a2dp
      pactl set-sink-volume bluez_sink.$sink_addr 50%
      pacmd set-default-sink bluez_sink.$sink_addr
fi
