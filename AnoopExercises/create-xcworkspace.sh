#!/bin/bash

set -eu

if [ "${1-default}" == "--clean" ]; then
    rm -rf AnoopExercises.xcodeproj
    rm -rf AnoopExercises.xcworkspace
fi

if ! [ -e AnoopExercises/Theme/R/R.generated.swift ]; then
    mkdir -p AnoopExercises/Theme/R
    touch AnoopExercises/Theme/R/R.generated.swift
fi

./download-tools.sh
./bin/xcodegen/bin/xcodegen generate

if [ "${1-default}" == "--clean" ]; then
    xcodebuild -alltargets clean
fi

bundle install
bundle exec pod install
cp IDETemplateMacros.plist AnoopExercises.xcodeproj/xcshareddata/.
