#!/usr/bin/python
import os

def calculate_unuse(list, len):
	nr_pages = 0.0
	unuse = 0.0
	unuse_idx = 0.0
	unuse_idx_sum = 0.0

	for i in range(0, len):
		nr_pages += list[i]<<i

	for i in range(0, len):
		unuse = 0
		unuse_idx = 0.0
		for j in range(i, len):
			unuse += list[j]<<j
		unuse_idx = (nr_pages - unuse)/nr_pages
		unuse_idx_sum += unuse_idx
		print "%.3f\t"%unuse_idx ,
	print "%.3f"%(unuse_idx_sum/len),
	print ""

	return 0

def readfile(filp):
	try:
		for line in filp:
			int_list = [int(i) for i in line.split()]
			list_len = len(int_list)

			if (list_len <= 0):
				continue

			calculate_unuse(int_list, list_len)
	except IOError, e:
		print 'file open error:', e
	return 0

def main(filename):
	try:
		if os.path.exists(filename):
			filp=open(filename, 'rw')
		else:
			print "file not found."
			return -1
		readfile(filp)
		filp.close()
	except IOError, e:
		print 'file open error:', e

'''
main("./nopatch.SP9832A211168091211")

print ""

main("./patched.SP9832A211168091175")
'''
main("./monkey_nopatch");

print ""

main("./monkey_patched");
