import os
cwd = os.path.dirname(os.path.realpath(__file__))

def cleanOpen(filename):
    output = []
    with open(filename) as file:
        for item in file.readlines():
            contents = item.split(",")
            # print(f"{contents[0]}, {output}")
            detected = 0
            for entry in output:
                if contents[0] in entry:
                    detected += 1
            if not detected: output.append(item)
    return output


deduped = cleanOpen(f"{cwd}\\ht&wt.csv")
outputFile = open(f"{cwd}\\Out.csv", "w")
for item in deduped: outputFile.write(item)
outputFile.close()