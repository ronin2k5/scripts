#!/usr/bin/python

import sys
import tempfile
import shutil

# initialize arguments
args = {

    "infile":       "",
    "outfile":      "",
    "addsectnums":  False,
    "addtoclinks":  False

}

def syntaxError(cmd):
    print("Syntax: " + cmd + " <infile> [-o outfile] [-addsectnums] [-addtoclinks]")
    exit(1)

def getArgs(args, argv):

    argiter = iter(argv[1:])

    # check argument count
    if len(argv) < 2:
        syntaxError(argv[0])

    args["infile"] = next(argiter)
    # args["infile"] = "..\\USBArmory\\usbarmory-mac-kali-setup.md"

    arg = next(argiter, None)

    while arg != None:
        if arg == "-o":
            args["outfile"] = next(argiter, None)
        elif arg == "-hassectnums":
            args["hassectnums"] = True
        elif arg == "-addsectnums":
            args["addsectnums"] = True
        elif arg == "-addtoclinks":
            args["addtoclinks"] = True
        else:
            break   # once an unknown argument is encountered, ignore the rest of the arguments

        arg = next(argiter, None)   

def updateFile(args):
    
    tempoutfile = False
    sectionstack = []

    if (args["infile"] == args["outfile"]) or (args["outfile"] == ""):

        tempoutfile = True
        outf = tempfile.NamedTemporaryFile(mode='w', delete=False)
        
    else:

        outf = open(args["outfile"], "w")

    # outf.write(toc)

    with open(args["infile"], "r") as inf:

        for line in inf.readlines():

            if line[0] == '#':

                # determine the heading level
                level = line.find(' ')

                # update counter for appropriate heading level
                if level > len(sectionstack):

                    sectionstack.append(1)
                
                else:

                    if level < len(sectionstack):
                        sectionstack.pop()

                    sectionstack[-1] += 1

                if args["addtoclinks"]:

                    if len(sectionstack) > 1 or sectionstack[0] > 1:

                        outf.write("[Back to Table Of Contents](#table-of-contents)\n\n")

                outf.write(level * '#')

                if args["addsectnums"]:

                    # assemble section number
                    if line.find("](") >= 0:

                        sectionnum = ""
                        headinglink = True

                    else:

                        sectionnum = " "
                        headinglink = False

                    for n in sectionstack:
                        sectionnum += str(n) + '.'

                    if headinglink:

                        sectionnum += " "
                        outf.write(" [" + sectionnum + line[line.find("[") + 1:])

                    else:

                        outf.write(sectionnum + line[level:])

                else:

                    outf.write(line[level:])

            else:

                outf.write(line)

    outf.close()

    if tempoutfile:
        shutil.move(outf.name, inf.name)

def genTOC(args):

    toc = "# TABLE OF CONTENTS\n\n"

    if args["outfile"] == "":
        outfile = args["infile"]
    else:
        outfile = args["outfile"]

    with open(outfile, "r") as f:   #use outfile, as we want to include any section numbers that may have been added

        # iterate over file
        for line in f.readlines():

            # skip empty lines
            if line == '\n':
                continue

            # look for headings
            if line[0] == '#':

                # determine the heading level
                level = line.find(' ') - 1

                if line.find("](") >= 0:
                    # if heading is a link, only take that heading name, not the link
                    section = line[line.find("[") + 1 : line.find("]")]
                else:
                    # otherwise take the whole heading
                    section = line[line.find(" ") + 1 : line.find('\n')]

                toc += level * '\t' + "- [" + section + "](#" + section.lower().replace(' ', '-') + ")\n"

    toc += '\n'

    with tempfile.NamedTemporaryFile(mode='w', delete=False) as tmpf:

        tmpf.write(toc)

        with open(outfile, "r") as inf:

            tmpf.writelines(inf.readlines())

    if args["outfile"] == "":
        outfile = args["infile"]
    else:
        outfile = args["outfile"]

    shutil.move(tmpf.name, outfile)

# main
getArgs(args, sys.argv)
updateFile(args)
genTOC(args)
