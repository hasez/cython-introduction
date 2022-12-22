# [Cython] 1からnまでの和を求める関数
def sumtest( int n ):
    cdef int i
    cdef long total

    print("Cython sumtest2.sumtest({}) called".format(n))
    total = 0
    for i in range(1, n + 1):
        total += i
    return total
