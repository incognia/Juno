#!/bin/bash
git add .
git commit -m "Update $(date +"%m/%d/%y %H:%M:%S")"
git push

reset