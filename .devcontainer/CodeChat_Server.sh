#!/usr/bin/env bash

# For some reason, there's often junk on the opened ports. Start the server to let it read this junk, so the next invocation will be clean.
CodeChat_Server serve &
sleep 1
kill %1
CodeChat_Server start
