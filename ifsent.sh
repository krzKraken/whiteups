#!/bin/bash


val=$(echo "$(cat bundle.js; echo $?)")
echo "$val"
