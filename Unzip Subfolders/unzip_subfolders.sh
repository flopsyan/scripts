#!/usr/bin/env bash
for z in */*.zip; do unzip -o "$z" -d "${z%/*}" & done
wait
