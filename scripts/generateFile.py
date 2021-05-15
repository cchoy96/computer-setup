#!/bin/python3

def generateFile(numGb):
    chunk = ['f'] * 104857600  # 100 MB
    targetBytes = numGb * 1073741824
    with open(str(numGb) + 'GB_file.txt', 'w') as f:
        totalBytes = 0
        while (totalBytes < targetBytes):
            f.write("".join(chunk))
            totalBytes += len(chunk)

generateFile(4)
