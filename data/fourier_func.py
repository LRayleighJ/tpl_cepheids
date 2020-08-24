#!/usr/bin/env python3

import numpy as np

def fourier(x, *a):
    """
    用于拟合光变曲线的 Fourier 函数
     x:     自变量
    *a:     拟合参数
    """
    omega = 2 * np.pi / 200
    fx = 0
    for deg in range(0, int(len(a) / 2) + 1):
        fx += a[deg] * np.cos(deg * omega * x) + a[len(a) - deg - 1] * np.sin(deg * omega * x)
    return fx
