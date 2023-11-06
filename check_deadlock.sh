#!/bin/bash

if [[ "$#" -ne 1 ]]; then
	echo "Run ./check_deadlock.sh <0,1>"
	exit 1
fi

DEADLOCK=$1

echo "Building deadlock example build directory"
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build

echo "Copying gdb files with custom commands"
cp gdbcommands gdbDisplayLockedThreads.py build

echo "Change directory to pwd/build"
cd build || exit
echo "Run deadlock_example"
./deadlock_example "$DEADLOCK" &

echo "Sleeping 2s"
sleep 2

PID_EXAMPLE=$(pidof deadlock_example)
echo "kill $PID_EXAMPLE"
kill -6 "$PID_EXAMPLE"

echo "Waiting 5s before core dump being saved"
sleep 5

CORE_FILE=$(find /var/lib/systemd/coredump -name "*${PID_EXAMPLE}*") || exit
echo "Copying core file $CORE_FILE to pwd/core"
cp -p "$CORE_FILE" ./core

echo "Test deadlock examples"
GDB_RESULT=$(gdb -c core ./deadlock_example -x ./gdbcommands -batch) || exit
DEAD_LOCK_COUNT=$(echo "$GDB_RESULT" | grep -c DEADLOCKED)
echo "Count of deadlocks: $DEAD_LOCK_COUNT"
if [[ $DEAD_LOCK_COUNT == 0 ]]; then
	echo "------- Test passed -------"
else
	echo "------- Test failed -------"
fi

# cd ..
# echo "Cleaning build dir"
# rm -rf build/*
