#!/usr/bin/bash

battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

notify_capacity=10
shutdown_capacity=5

if [[ $battery_capacity -le $notify_capacity && $battery_status = "Discharging" ]]; then
  notify-send --urgency=critical --hint=int:transient:1 --icon=battery_empty "Battery Low" "You should probably plug-in."
fi

if [[ $battery_capacity -le $shutdown_capacity && $battery_status = "Discharging" ]]; then
  notify-send --urgency=critical --hint=int:transient:1 --icon=battery_empty "Battery Critically Low" "Computer will suspend in 60 seconds."
  sleep 60s

  battery_status=$(cat /sys/class/power_supply/BAT0/status)
  if [[ $battery_status = "Discharging" ]]; then
    systemctl suspend
  fi
fi
