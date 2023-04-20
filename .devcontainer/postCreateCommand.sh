#!/usr/bin/env bash

# Create a new PreTeXt project.
pretext new -d .

# Build pretext project
pretext build
pretext generate

# Add new remote repositories for origin (forked) and upstream (original)
git remote add upstream https://github.com/twjudson/aata
# git remote add origin **How do you tell the url of the personal, forked branch when anyone could do so?

# git pull origin main
# git reset --hard origin/main

# For the Digital System Design book...
#echo "Installing Digital System Design textbook..."
#apt install iverilog
#git clone https://github.com/bjones1/digital_systems_design.git
#cd digital_systems_design
# A Runestone build must be run before waf configure will work, even though the waf build Runestone runs will fail.
#runestone build
#python3 waf configure --no-arm --no-pic24
