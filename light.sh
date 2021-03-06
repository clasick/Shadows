#/bin/bash

# echo "The time is $(date +"%T")"

desiredCodeTheme="Solarized Light"
desiredPlasmaTheme="breeze"
desiredPlasmaLookAndFeelTheme="breeze"

if [ -d "/home/vkk/.config/Code - OSS/User" ]; then
    codeTheme=$(perl -n -e  '/workbench.colorTheme": "(.*)"/ && print $1' '/home/vkk/.config/Code - OSS/User/settings.json')
    sed -i "s/\"workbench.colorTheme\": \"\(.*\)\"/\"workbench.colorTheme\": \"$desiredCodeTheme\"/" '/home/vkk/.config/Code - OSS/User/settings.json'
    newTheme=$(perl -n -e  '/workbench.colorTheme": "(.*)"/ && print $1' '/home/vkk/.config/Code - OSS/User/settings.json')
    if [ "$newTheme" = "$desiredCodeTheme" ]; then
        echo "Theme successfully changed to $desiredCodeTheme (from $codeTheme)"
    else
        echo "Switch failed (newTheme value is $newTheme)"
    fi
fi

if [ -f '/home/vkk/.config/plasmarc' ]; then
    kwriteconfig5 --file ~/.config/plasmarc --group Theme --key name $desiredPlasmaTheme
    lookandfeeltool --apply org.kde.$desiredPlasmaLookAndFeelTheme.desktop
    echo "Plasma theme changed to $desiredPlasmaTheme"
else
    echo "Plasma was not found"
fi

if [ -f '/home/vkk/.config/konsolerc' ]; then
    konsoleprofile colors="SolarizedLight"
fi
