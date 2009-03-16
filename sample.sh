#!/usr/bin/env sh
xcodebuild
build/Release/nib2objc TestViewController.xib > sample.m
git add sample.m
git commit -m "New run of the sample.sh script"
