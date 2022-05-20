#%%% 

import csv
from ctypes import sizeof

with open('PerformanceVisibility/test.log') as file:
    lines = file.read().splitlines()
    print(len(lines))

    
