#!/bin/bash

# yeet existing instances
polybar-msg cmd quit

polybar i3bar |& tee -a /tmp/polybar.log

