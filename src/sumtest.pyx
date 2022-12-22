# [Cython] 1からnまでの和を求める関数
def sumtest(n):
    print("Cython sumtest.sumtest({}) called".format(n))
    total = 0
    for i in range(1, n + 1):
        total += i
    return total
