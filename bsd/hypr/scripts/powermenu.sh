#!/usr/bin/env bash

# ***This script was made by Clay Gomera (Drake)***
#  - Description: A simple power menu rofi script
#  - Dependencies: rofi, power-profiles-daemon

## OPTIONS ##
option1=" Logout"
option2=" Reboot"
option3=" Power off"
option4=" Suspend"
option5=" Lock"
option6=" Change power profile"
option7=" Cancel"

## OPTIONS ARRAY ##
options="$option1\n$option2\n$option3\n$option4\n$option5\n$option6\n$option7"

## POWER PROFILE OPTIONS ##
pwr1=" Performance"
pwr2=" Balanced"
pwr3=" Power Saver"
pwr4=" Cancel"

## POWER PROFILES ARRAY ##
pwrs="$pwr1\n$pwr2\n$pwr3\n$pwr4"

## MAIN ACTION COMMAND ##
action=$(echo -e "$options" | tofi --prompt-text "                                        ")
case "$action" in
    $option1*)
         kill -9 -1;;
    $option2*)
        systemctl reboot || loginctl reboot;;
    $option3*)
        systemctl poweroff || loginctl poweroff;;
    $option4*)
        systemctl suspend;;
    $option5*)
        swaylock -l;;
    $option6*)
        currentpwr=$(powerprofilesctl get)
        pwraction=$(echo -e "$pwrs" | tofi --prompt-text "
                                                        ")
        case "$pwraction" in
            $pwr1*)
                powerprofilesctl set performance && notify-send "Power profile switched to performance";;
            $pwr2*)
                powerprofilesctl set balanced && notify-send "Power profile switched to balanced";;
            $pwr3*)
                powerprofilesctl set power-saver && notify-send "Power profile switched to power saver";;
            $pwr4*)
                exit 0
        esac;;
    $option7*)
        exit 0
esac
