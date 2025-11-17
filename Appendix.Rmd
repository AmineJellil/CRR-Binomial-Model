

```python
import math
from scipy.stats import norm
import time
import matplotlib.pyplot as plt
import numpy as np
```

### Binomial model function 
```python
def Binomial(Option,K,T,S,sigma,r,N):
    start=time.process_time()
    delta=T/N
    u=math.exp(sigma*math.sqrt(delta))
    d=math.exp(-sigma*math.sqrt(delta))
    p = (math.exp((r) * delta) - d) / (u - d)
    if Option=="C":
        #European Call
        f = []
        for j in range(N + 1):
            S_Nj = S * pow(u, j) * pow(d, N - j)
            f_Nj = max(0, S_Nj - K)
            f.append(f_Nj)
        for n in reversed(range(N)):
            f_n = []
            for j in range(n+1):
                f_nj = math.exp(-r*delta)*(p*f[j+1]+(1-p)*f[j])
                f_n.append(f_nj)
            f = f_n
        option_price = f[0]
    elif Option=="P":
        #European Put#
        f=[]
        for j in range(N+1):
            S_Nj=S*pow(u,j)*pow(d,N-j)
            f_Nj=max(0,K-S_Nj)
            f.append(f_Nj)
        for n in reversed(range(N)):
            f_n=[]
            for j in range(n+1):
                f_nj=math.exp(-r*delta)*(p*f[j+1]+(1-p)*f[j])
                f_n.append(f_nj)
            f=f_n
        option_price=f[0]
    else:
        print("wrong Option input")
    option_price=round(option_price,3)
    end=time.process_time()
    return option_price,end-start
  ```