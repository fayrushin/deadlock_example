#!/bin/bash

echo "Building deadlock example build directory"
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build

echo "Copying gdb files with custom commands"
cp gdbcommands gdbDisplayLockedThreads.py build

echo "Change directory to pwd/build"
cd build || exit
echo "Run deadlock_example"
./deadlock_example 1 &

echo "Sleeping 3s"
sleep 3

PID_EXAMPLE=$(pidof deadlock_example)
echo "kill $PID_EXAMPLE"
kill -6 "$PID_EXAMPLE"

echo "Waiting 5s before core dump being saved"
sleep 5 

CORE_FILE=$(find /var/lib/systemd/coredump -name "*${PID_EXAMPLE}*")
echo "Copying core file $CORE_FILE to pwd/core"
cp -p $CORE_FILE ./core

echo "Test deadlock examples"
gdb -c core ./deadlock_example -x ./gdbcommands -batch #| grep DEADLOCKED
cd ..
rm -rf build/*
