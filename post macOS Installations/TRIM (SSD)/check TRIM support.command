#!/bin/bash
clear

system_profiler SPSerialATADataType | grep 'TRIM'
echo