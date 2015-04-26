from Tkinter import *
import os
import sys
import time
cmd = """
osascript -e 'tell application "System Events" to keystroke "%s" using {command down}' 
"""
run_drone = """ make run """
# minimize active window
last_key = None
i = 0

import termios, fcntl, sys, os
fd = sys.stdin.fileno()

oldterm = termios.tcgetattr(fd)
newattr = termios.tcgetattr(fd)
newattr[3] = newattr[3] & ~termios.ICANON & ~termios.ECHO
termios.tcsetattr(fd, termios.TCSANOW, newattr)

oldflags = fcntl.fcntl(fd, fcntl.F_GETFL)
fcntl.fcntl(fd, fcntl.F_SETFL, oldflags | os.O_NONBLOCK)
os.system(run_drone)
try:
    while 1:
        try:
            c = sys.stdin.read(1)
            print "Got character", repr(c)
            if last_key != c:
                last_key = c
            
            print "pressed %s" % c
            for i in range(10):
                os.system(cmd % c)
            if last_key == "z":
                sys.exit(0)
        except IOError: pass
finally:
    termios.tcsetattr(fd, termios.TCSAFLUSH, oldterm)
    fcntl.fcntl(fd, fcntl.F_SETFL, oldflags)