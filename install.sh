#!/bin/bash

REQUIREMENTS=$(dirname ${BASH_SOURCE})"/install_requirements.sh"

echo $REQUIREMENTS
if test -f $REQUIREMENTS; then
    bash $REQUIREMENTS
fi


for extension in $(dirname ${BASH_SOURCE})/*.so
do
 filename=$(basename -- "$extension")
 module="${filename%.*}"
 echo "Enabling extension $filename"

 cp $extension $(php -r "echo ini_get ('extension_dir');")/
 docker-php-ext-enable $module
done

