#!/bin/bash

### Interactive CPU job ###

salloc \
    --account=st-cwl-1
    --time=00:30:00
    --nodes=1 
    --mem=6G
    --ntasks=1
