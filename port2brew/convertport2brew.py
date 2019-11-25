import subprocess
import sys

def convert(port):
    print(port)
    output = subprocess.Popen(["brew", "install", port], stdout=subprocess.PIPE).communicate()[0]
    print(output)
    output = subprocess.Popen(["sudo", "port", "uninstall", "-q", port], stdout=subprocess.PIPE).communicate()[0]
    print(output)

if __name__ == '__main__':

    portsfilename = sys.argv[1]

    with open(portsfilename, "r") as portsfile:
        ports = portsfile.readlines()

        for port in ports:
            convert(port)
