'''
pygib套件使用說明：
首先要安裝python程式，然後安裝pygrib套件，目前pygrib能在linux系統安狀。
若要在WINDOWS系統上安裝，需要透過cygwin的方式。
以下舉例pygrib的例子
資料是由氣象局的開放資料下載的
'''

import pygrib as pb   #載入pygrib套件
import numpy as np
import pandas as pd

fn = 'M-A0064-048.grb2'
gbdata = pb.open(fn)

#上面設定gbdata儲存grib2的資料，若要輸出資料中有何種變數，可以利用select()功能
print(gbdata.select())
