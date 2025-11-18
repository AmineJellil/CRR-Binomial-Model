

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
### plot Binomial model function 
```python
K = 80
T=1
S0=80
sigma = 0.2
r = 0.05
N=range(1,200)
calls_list=[]
for n in N:
    p,t = Binomial("C", K, T, S0, sigma, r, n)
    calls_list.append(p)

plt.plot(N, calls_list, label="Binomial price")
plt.xlabel("Number of time steps")
plt.ylabel("European call option price")
plt.legend()
plt.show()
```
### Plot Number of time steps V.S running time figures
```python
K=80
T=1
S=80
sigma=0.2
r=0.05
N2=range(1,2300,10)
time_e=[]
time_ec=[]
for i in N2:
    p1,t1=Binomial("P",K,T,S,sigma,r,i)
    p3,t3=Binomial("C",K,T,S,sigma,r,i)
    time_e.append(t1)
    time_ec.append(t3)
plt.plot(N2, time_e,label='European Put Time')
plt.plot(N2, time_ec,label='European Call Time')
plt.ylabel('Compute time')
plt.xlabel("Number of time steps")
plt.legend()
plt.show()
```
