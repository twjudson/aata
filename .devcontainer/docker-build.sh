#!/usr/bin/env bash
# <h1><code>docker-build.sh</code> - Perform installs during the docker container build process</h1>
# <p>Prevent interactive debconf during installations.</p>
set DEBIAN_FRONTEND=noninteractive

# Install textbook authoring support software: LaTeX, sage, and other pdf tools.
apt update
apt install -y --no-install-recommends python3-pip texlive texlive-latex-extra texlive-fonts-extra texlive-xetex texlive-science texlive-music sagemath ghostscript pdf2svg

# Upgrade pip and install required Python tools.
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade CodeChat-Server runestone pretext
