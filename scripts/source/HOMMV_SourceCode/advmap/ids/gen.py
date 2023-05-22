import os

answer : str = ""

with open(os.getcwd() + "/HOMMV_SourceCode/advmap/ids/cmn.txt", "r") as r:
    curr_str : str = r.readline()
    while curr_str != "":
        answer = answer + "---|`" + curr_str.split("=")[0].strip() + "`\n"
        curr_str = r.readline()

print(answer)