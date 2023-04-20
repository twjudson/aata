# <h1><code>Dockerfile</code> - Define the Docker build process</h1>
# <p>Select a Python lexer for this file, since comments in both this Dockerfile and in Python start with a <code>#</code>. The command to do this is "CodeChat Editor lexer: python."</p>
# <p>Use a pre-built <a href="https://hub.docker.com/_/python/tags">Python Docker image</a>.</p>
FROM mcr.microsoft.com/devcontainers/python:0-3.11-bullseye
# <p>Copy the build script into the image, then run it.</p>
COPY docker-build.sh /tmp/
RUN bash /tmp/docker-build.sh
