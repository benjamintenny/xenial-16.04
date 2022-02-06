from subprocess import Popen
command = "Xvfb :99 -ac & firefox"
print("Command:", command)
process = Popen(command)
