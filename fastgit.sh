#!/bin/bash

echo "Enter commit message:"

read MSG

git add .
git commit -m "$(echo $MSG)"
git push

reset