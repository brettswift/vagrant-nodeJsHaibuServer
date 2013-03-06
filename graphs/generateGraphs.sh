#!/bin/bash

mkdir dot

puppet apply --noop --graph --graphdir ./dot  ../modules/haibu/manifests/init.pp 

dot -Tpng ./dot/resources.dot -o resources.png
dot -Tpng ./dot/relationships.dot -o relationships.png
dot -Tpng ./dot/expanded_relationships.dot -o expanded_relationships.png


