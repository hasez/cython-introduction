def sumtest(n):
    print("Python sumtest.sumtest({}) called".format(n))
    sum = 0
    for i in range(1, n + 1):
        sum += i
    return sum
