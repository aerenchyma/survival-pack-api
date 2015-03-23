import sys
import json

# first command line arg: filename to open
# second command line arg: filename to write (NOT the same)
if sys.argv[1] == sys.argv[2]:
	print "Don't overwrite your file! Please run again."
elif sys.argv[2][-4:].upper() != "JSON":
	print "Please save input in a JSON file." # quick and easy conversion
else:
	f = open(sys.argv[1],"r")
	lines = f.readlines()
	f.close()
	tab_split = []
	for l in lines:
		sep = l.split("\t")
		#print sep
		tab_split.append(sep)

	d = {}
	d["maxwt"] = int(tab_split[0][-1].strip())
	d["data"] = {}
	d["data"]["items"] = {}

	for inp in tab_split[2:]:
		print inp
		d["items"][inp[0]] = {}
		d["items"][inp[0]]["weight"] = int(inp[1])
		d["items"][inp[0]]["value"] = int(inp[2].strip())

	jsonf = open(sys.argv[2],"w")
	jsonf.write(json.dumps(d))
