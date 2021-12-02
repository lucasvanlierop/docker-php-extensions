#!/bin/bash

REQUIREMENTS="./install_requirements.sh"

if test -f $REQUIREMENTS; then
    bash $REQUIREMENTS
fi


for extension in /extension/*.so
do
 echo "Enabling extension $extension"
 cp $extension $(php -r "echo ini_get ('extension_dir');")/
 filename=$(basename -- "$extension")
 module="${filename%.*}"

 echo "extension = $module;"\
     >> /usr/local/etc/php/conf.d/extensions.ini
done


