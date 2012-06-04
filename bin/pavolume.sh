#!/bin/bash
# modified from http://crunchbanglinux.org/forums/topic/11392/pulseaudio-volume-control-with-media-keys/
# settings -> keyboard -> application shortcuts -> "/path/to/script/pavolume.sh mute" bind to XF86AudioMute (or whatever key you prefer)

ls ~/.pulse/mute &> /dev/null
if [[ $? != 0 ]]
then
    echo "false" > ~/.pulse/mute
fi

MUTE=`cat ~/.pulse/mute`
CARDS=`pacmd list-cards | grep 'card.s. available' | awk ' { printf "%s", $2 } '`

if [[ $1 == "mute" ]]
then
    if [[ $MUTE == "false" ]]
    then
		for (( CARDS--; $CARDS >= 0; CARDS-- ))
		do
			pactl set-sink-mute $CARDS 1
		done
        echo "true" >  ~/.pulse/mute
    exit    
    else
		for (( CARDS--; $CARDS >= 0; CARDS-- ))
		do
			pactl set-sink-mute $CARDS 0
		done
        echo "false" >  ~/.pulse/mute   
    exit
    fi
fi
