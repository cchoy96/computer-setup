#!/bin/bash

TEAMS_DIR="/Users/chris.choy/Library/Application\ Support/Microsoft/Teams"

# Clear the Microsoft Teams Cache
eval cd $TEAMS_DIR
echo -e "Clearing the Microsoft Teams Caches"

rm Application\ Cache/Cache/*
rm Application\ Cache/Index
rm Cache/*
rm Cookies
rm databases/*
rm GPUCache/*
rm -rf IndexedDB/*
rm -rf Local\ Storage/*

echo -e "Successful cache clear"

