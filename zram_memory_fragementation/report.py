#!/usr/bin/python
import os
import sys
import re

def main(argc, argv):
	filename = argv[argc - 1]
	if not os.path.exists(filename):
		print "file %s not exists" %filename
		return

	swaptotal = 0
	swapfree = 0

	list_swapuseds = []
	list_frags = []

	with open(filename, 'r') as f:
		for row in f:
			if row.startswith("SwapTotal:", 0, len("SwapTotal:")):
				swaptotal = int(re.findall(r'\d+', row)[0])
			if row.startswith("SwapFree", 0, len("SwapFree:")):
				swapfree = int(re.findall(r'\d+', row)[0])
				list_swapuseds.append(swaptotal-swapfree)

			if row.startswith("Node 0, zone   Normal 0.000", 0, len("Node 0, zone   Normal 0.000")):
				data = row.split()
				sum = 0.0
				for i in range(4, len(data)):
					sum += float(data[i])
				list_frags.append(sum/14)

	for i in range(len(list_frags)):
		if i % 2 == 1:
			print "%d\t%f" %(list_swapuseds[i], list_frags[i])

if __name__ == '__main__':
	main(len(sys.argv), sys.argv)
