# cython-introduction

## はじめに

Python は簡単に使えるけど、遅い  
C と比較すると100倍くらい  
Python のプログラムをC/C++に変換、高速化するCythonについて、紹介します  

## 環境準備

```
mkdir -p ~/work/cython-sample
cd ~/work/cython-sample/
code .
```

### 実行環境の設定ファイルを準備する
- docker-compose.yml
- Dockerfile
- requirements.txt
- .devcontainer/devcontainer.json
- .env

```bash
code docker-compose.yml
code Dockerfile
code requirements.txt
code .devcontainer/devcontainer.json
code .env
mkdir -p src
```

### 実行環境の起動

remote container を起動します

```bash
docker compose up --build -d
devcontainer open
python -V
cython -V
```

### 実装

#### python プログラム

元となる python プログラムを作成、実行する

```
code src/sumtest.py

cd src
ipython
from sumtest import sumtest
sumtest(50)
exit
```

#### cython プログラム

cython プログラムを作成する

```
cp src/sumtest.py src/sumtest.pyx
code src/sumtest.pyx
```

コンパイル用のプログラムを作成、コンパイルする

```
code src/setup.py
cd src
python setup.py build_ext --inplace
```

C プログラムと、共有ライブラリが作成される

```
src
  sumtest.c
  sumtest.cpython-311-x86_64-linux-gnu.so
```

実行する

```
ipython
from sumtest import sumtest
sumtest(10)
```

.so が優先されるので、cython 版が動作する

### 実行時間の比較

実行時間の計測用プログラムを作成する

```
code sumtime.py
```

#### cython 計測

```
python sumtime.py
```

結果例

```
Cython sumtest.sumtest(100000000) called
sum of 1 to 100000000 is 5000000050000000, elapsed time: 4.065816879272461
```

#### python 計測

c と so を削除して、実行する
```
rm -f *.c *.so
python sumtime.py
```

結果例

```
Python sumtest.sumtest(100000000) called
sum of 1 to 100000000 is 5000000050000000, elapsed time: 4.538129091262817
```

### Cython 最適化

静的型付けする

```
cp sumtest.pyx sumtest2.pyx
code sumtest2.pyx
```
```diff
# [Cython] 1 からnまでの和を求める
- def sumtest(n):
+ def sumtest(int n):
+    cdef int i
+    cdef long total
    print("Cython sumtest2.sumtest({}) called".format(n))
    total = 0
    for i in range(1, n + 1):
        total += i
    return total
```
コンパイル用プログラムに sumtest2 を追加する
```
code setup.py
```

計測用プログラムを作成する
```
cp sumtime.py sumtime2.py
code sumtime2.py
```

#### 計測

```
python setup.py build_ext --inplace
python sumtime2.py
```

実行例

```
Cython sumtest2.sumtest(100000000) called
sum of 1 to 100000000 is 5000000050000000, elapsed time: 0.045577049255371094
```






