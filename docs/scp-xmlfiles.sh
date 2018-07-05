#!/usr/bin/env bash
while read -r line; do
scp johnson@goobi-prod.ub.uni-leipzig.de:$line /tmp/data1/
done


