#!/bin/bash

### Interactive GPU job ###

salloc \
    --account=st-cwl-1-gpu
    --partition=interactive_gpu
    --time=00:30:00
    --nodes=1 
    --mem=8G
    --ntasks=1
    --gpus=1
