from sumtest import sumtest
import time

time_start = time.time()
n = 100000000
s = sumtest(n)
time_end = time.time()
time_gap = time_end - time_start

print("sum of 1 to %d is %d, elapsed time: %f" % (n, s, time_gap))
