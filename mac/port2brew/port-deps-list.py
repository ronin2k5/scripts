# For macports. Print all required ports for specified port in a tree form
# E.g. port-deps-tree.py python26
import subprocess
import sys

dep_line_lib_prefix = 'Library Dependencies:'
dep_line_run_prefix = 'Runtime Dependencies:'
cached_deps = dict()

def get_immediate_deps(portname):

    deps = []

    if portname not in cached_deps:
        output = subprocess.Popen(["port","deps", portname], stdout=subprocess.PIPE).communicate()[0]
        lines = output.splitlines()
        for line in lines:
            if line.startswith(dep_line_lib_prefix):
                deps = [d.strip() for d in line[len(dep_line_lib_prefix):].split(',')]
                # cached_deps[portname] = deps
                # break
            elif line.startswith(dep_line_run_prefix):
                deps.extend([d.strip() for d in line[len(dep_line_run_prefix):].split(',')])
                # cached_deps[portname].extend(deps)
                # break

        if len(deps) > 0:
            cached_deps[portname] = deps
        else:
            cached_deps[portname] = []

    return cached_deps[portname]

def print_deps_list(deps_list):
    for d in deps_list:
        print(d)

if __name__ == '__main__':
    # portname = sys.argv[1]

    port = ""
    portsfilename = ""

    if sys.argv[1] == "-f":

        portsfilename = sys.argv[2]

    else:

        port = sys.argv[1]
    
    if port != "":

        deps_list = get_immediate_deps(port)
        print_deps_list(deps_list)

    elif portsfilename != "":

        with open(portsfilename, "r") as portsfile:
            ports = portsfile.readlines()

            with open("portdeps.csv", "w+") as depsfile:
                depsfile.write("port,dependency\n")

                for port in ports:
                    deps_list = get_immediate_deps(port.rstrip("\r\n"))

                    for dep in deps_list:
                        depsfile.write("{0},{1}\n".format(port.rstrip("\r\n"), dep))

    else:
        print("Syntax:\n")
