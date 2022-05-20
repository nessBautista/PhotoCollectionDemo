#!/usr/bin/env bash

xcrun simctl spawn booted log stream --predicate 'eventMessage contains "PerformanceVisibility.App"' >> test.log 2>&1 &