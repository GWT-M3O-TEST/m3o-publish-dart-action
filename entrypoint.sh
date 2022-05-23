#!/bin/bash
set -e

cd m3o-dart
WORK_DIR=$(pwd)

echo "dart-publisher-action-> Working directory ${WORK_DIR}"

ls -al

echo 'dart-publisher-action-> dary run dart publish'
dart pub lish --dry-run

echo 'dart-publisher-action-> setting up pub-credentials.josn file ...'
echo "${PUB_CREDENTIALS}" > ~/.config/dart/pub-credentials.json

echo 'dart-publisher-action-> publishing m3o-dart to pub.dev ...'

if [ ! -f '~/.config/dart/pub-credentials.json' ]
then
        echo "missing credentials"
        exit 1
fi

dart pub lish -f

if [ $? -eq 0 ]
then
    echo "::set-output name=success::true"
else
    echo "::set-output name=success::false"
fi

echo 'dart-publisher-action-> delete pub-credentials.json'
rm ~/.config/dart/pub-credentials.json
