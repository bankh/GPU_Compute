#!/bin/bash
# Usage: ./tst_gpu.sh [log]
# Run the ROCm Bandwidth Test. If 'log' argument is provided, output will be logged to a file.

LOGFILE="/path/to/rocm_bandwidth_test.log"

if [ "$1" == "log" ]; then
    # Log output to a file and display it on the terminal
    /opt/rocm/bin/rocm-bandwidth-test | tee $LOGFILE
else
    # Reference: https://github.com/tinygrad/tinybox/blob/master/tst_gpu.sh
    # Just display output on the terminal
    /opt/rocm/bin/rocm-bandwidth-test
fi
