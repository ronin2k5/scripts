import sys

# datatypeMap = {

#     "bin": "models.BinaryField",
#     "bool": "models.BooleanField",
#     "nulbool": "models.NullBooleanField",
#     "date": "models.DateField",
#     "time": "models.TimeField",
#     "datetime": "models.DateTimeField",
#     "duration": "models.DurationField",
#     "auto": "models.AutoField",
#     "bigint": "models.BigIntegerField",
#     "dec": "models.DecimalField",
#     "float": "models.FloatField",
#     "int": "models.IntegerField",
#     "uint": "models.PositiveIntegerField",
#     "usmlint": "models.PositiveSmallIntegerField",
#     "smlint": "options.SmallIntegerField",
#     "varchar": "models.CharField",
#     "text": "models.TextField",
#     "csvint": "models.CommaSeparatedIntegerField",
#     "email": "models.EmailField",
#     "file": "models.FileField",
#     "path": "models.FilePathField",
#     "image": "models.ImageField",
#     "ipaddr": "models.GenericIPAddressField",
#     "slug": "models.SlugField",
#     "url": "models.URLField",
#     "uuid": "models.UUIDField",
#     "FK": "models.ForeignKey"

# }

datatypeMap = {

    "bn": "models.BinaryField",
    "bl": "models.BooleanField",
    "nbl": "models.NullBooleanField",
    "d": "models.DateField",
    "t": "models.TimeField",
    "dt": "models.DateTimeField",
    "dur": "models.DurationField",
    "auto": "models.AutoField",
    "bint": "models.BigIntegerField",
    "dec": "models.DecimalField",
    "flt": "models.FloatField",
    "int": "models.IntegerField",
    "uint": "models.PositiveIntegerField",
    "usint": "models.PositiveSmallIntegerField",
    "sint": "options.SmallIntegerField",
    "vchr": "models.CharField",
    "txt": "models.TextField",
    "csvint": "models.CommaSeparatedIntegerField",
    "eml": "models.EmailField",
    "fil": "models.FileField",
    "pth": "models.FilePathField",
    "img": "models.ImageField",
    "ip": "models.GenericIPAddressField",
    "slg": "models.SlugField",
    "url": "models.URLField",
    "uuid": "models.UUIDField",
    "FK": "models.ForeignKey"

}

class Col:

    def __init__(self, name, datatype, attribs):

        self.name = name
        self.datatype = datatype
        self.attribs = attribs

class Table:

    def __init__(self, name, cols):

        self.name = name
        self.cols = cols

class ModelGenerator:

    def __init__(self):

        self.model = "from django.db import models\n"

    def genTableCode(self, table):

        self.model += "\nclass " + table.name + "(models.Model):\n\n"

        for col in table.cols:

            self.model += "\t" + col.name + " = " + col.datatype + "(" + col.attribs + ")\n"

    def loadModel(self, modelfile):

        with open(modelfile, "r") as m:

            tablename = ""
            newtblflag = True
            cols = []

            for line in m:

                if line == "\n" or line == "":

                    self.genTableCode(Table(tablename, cols))

                    newtblflag = True
                    cols.clear()

                elif newtblflag:

                    tablename = line[:-1]
                    newtblflag = False

                else:

                    parts = line.split("(")

                    if len(parts) > 1:
                        attribs = parts[1][:-2] # remove final ")"

                    colparts = parts[0].split()
                    colname = colparts[0]
                    coltype = datatypeMap[colparts[1]]

                    cols.append(Col(colname, coltype, attribs))

                    colname = ""
                    coltype = ""
                    attribs = ""

            else:

                self.genTableCode(Table(tablename, cols))

    def writeModelsFile(self):

        with open("models.py", "w") as m:

            m.write(self.model)

    def writeSerializersFile(self):

        None

    def writeViewsFile(self):

        None

    def writeURLsFile(self):

        None

def showSyntax():

    print("Syntax: python genModels.py <model file>")

if __name__ == "__main__":

    debug = False
    mg = ModelGenerator()

    if len(sys.argv) < 2:

        if not debug:

            showSyntax()
            exit()

        if debug:

            mg.loadModel("model.txt")

    if not debug:

        modelfile = sys.argv[1]
        mg.loadModel(modelfile)
        mg.writeModelsFile()
