#!/bin/bash
for DISPLAY in $(seq 1 1 $(kscreen-doctor -o | grep Output: | wc -l)); do kscreen-doctor output.${DISPLAY}.scale.1.25; done
