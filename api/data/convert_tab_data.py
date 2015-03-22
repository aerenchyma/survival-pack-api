import sys
import json

# first command line arg: filename to open
# second command line arg: filename to write (NOT the same)
if sys[1] == sys[2]:
	print "Don't overwrite your file! Please run again."
elif sys[2][-4:].upper() != "JSON":
	print "Please save input in a JSON file." # quick and easy conversion
else:
	f = open(sys[1],"r")
	lines = f.readlines()
	f.close()
	tab_split = []
	for l in lines:
		sep = lines.split("\t")
		tab_split.append(sep)

	d = {}
	d["maxwt"] = tab_split[0][-1]
	d["items"] = {}

	for inp in tab_split[2:]:
		d["items"][inp[0]] = {}
		d["items"][inp[0]]["weight"] = inp[1]
		d["items"][inp[0]]["value"] = inp[2]

	jsonf = open(sys[2],"w")
	jsonf.write(json.dumps(str(d)))
