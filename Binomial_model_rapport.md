---
output:
  pdf_document:
    toc: false              # On garde 'false' comme dans votre exemple, \tableofcontents gère l'affichage
    toc_depth: 2
    number_sections: true
    highlight: tango
header-includes:
  - \usepackage[table]{xcolor}
  - \usepackage{colortbl}
  - \usepackage{amsmath}
  - \usepackage{amssymb}
  - \usepackage{longtable}
  - \definecolor{lightgreen}{RGB}{204,255,204}
fontsize: 11pt
papersize: a4
geometry: top=1.5cm, bottom=3cm, left=1.5cm, right=1.5cm
---

\begin{center}
{\Huge \textbf{Binomial model - CRR}}\\[0.2cm]
{\LARGE \textbf{2025-2026}}\\[1cm]
{\normalsize Mohammed-Amine Jellil}
\end{center}

\vspace{1cm}
\renewcommand{\contentsname}{Content}
\tableofcontents
\newpage

# Binomial model

## Introduction

The binomial model is one of the most classical approaches for valuing European options. 
Its central idea is to represent the evolution of a financial asset through a discrete-time tree, 
where at each step the price can move either upward or downward by fixed proportions. 
This simplified description of price dynamics makes it possible to approximate the behavior 
of more complex continuous-time models while keeping the calculations straightforward.

To construct the tree, the time to maturity \(T\) is divided into \(N\) equal intervals of 
length \(\Delta t = T/N\). Over each interval, the stock price \(S_t\) may increase by a 
factor \(u\) or decrease by a factor \(d\). In the Cox–Ross–Rubinstein (CRR) version of 
the model, these factors are chosen based on the volatility \(\sigma\):

\[
u = e^{\sigma\sqrt{\Delta t}}, \qquad d = e^{-\sigma\sqrt{\Delta t}}.
\]

Under the risk-neutral framework, the expected discounted price of the asset must evolve as 
a martingale. This condition determines the risk-neutral probability \(p\) of an upward movement:

\[
p = \frac{e^{r\Delta t} - d}{u - d},
\]

where \(r\) is the continuously compounded risk-free interest rate. 
With these ingredients, the entire price tree of the asset can be generated up to maturity.

At the final time \(T\), the payoff of the European option is known explicitly. For a call 
option, the terminal payoff at node \((N, j)\) is:

\[
f_{N,j} = \max(S_0\,u^j d^{N-j} - K,\, 0),
\]

and similarly for a put option:

\[
f_{N,j} = \max(K - S_0\,u^j d^{N-j},\, 0).
\]

Once the payoffs at maturity are obtained, the option value at earlier nodes is computed using 
backward induction. At each step, the price is the discounted expected value under the 
risk-neutral probability:

\[
f_{n,j} = e^{-r\Delta t}\left[p f_{n+1,j+1} + (1-p) f_{n+1,j}\right].
\]

Repeating this procedure from \(n = N-1\) down to \(n = 0\) yields the option price at the initial 
node, which is the estimate provided by the binomial model.

By increasing the number of time steps \(N\), the model becomes a finer approximation of the 
continuous price dynamics, and the computed value of the European option converges toward 
its theoretical limit.

## Compute time

```{r fig1, echo=FALSE, out.width="80%",fig.cap="Figure 1: Compute time V.S Number of time steps"}
knitr::include_graphics("Compute_time.png")
```
\vspace{1cm}

Figure 1 illustrates how the computation time evolves as the number of binomial steps \(N\) increases, where \(N\) ranges from 1 to 2300 with a step size of 10. As expected, the time required to evaluate the price of a European option increases steadily with the number of steps.

This trend is consistent with the structure of the binomial model: each additional step adds new nodes to the tree, and the backward induction algorithm must process all these nodes. Since the total number of nodes grows proportionally to \(N^2\), the computational effort increases accordingly, which explains the overall upward slope observed in the figure.

The computation times for European call and put options are almost identical. This is natural because both contracts require the same number of operations during pricing. The small fluctuations visible in the plot are likely due to variations in CPU load or dynamic clock frequency rather than differences in the algorithm itself.

## Convergence of the Binomial Model
The option considered in this experiment is a European call with strike \(K = 80\), initial stock price \(S_0 = 80\), maturity \(T = 1\), volatility \(\sigma = 0.2\), and risk-free interest rate \(r = 0.05\).
\newpage
```{r fig_convergence, echo=FALSE, out.width="80%",fig.cap="Figure 2: European call option price V.S Number of time steps"}
knitr::include_graphics("Convergence.png")
```

\vspace{1cm}

Figure 2 shows how the binomial price of a European call option evolves as the number of time steps 
\(N\) increases from 1 to 200. For small values of \(N\), the computed prices display strong oscillations, reflecting the fact that a coarse binomial tree does not approximate well the underlying price dynamics.

As \(N\) becomes larger, these oscillations gradually diminish and the prices begin to stabilize. With a finer time discretization, the binomial model provides a more accurate approximation of the continuous evolution of the asset price, causing the option value to converge toward its limiting value.

This behavior is typical of the Cox–Ross–Rubinstein scheme: increasing the number of time steps \(N\) improves the accuracy of the approximation. The figure clearly illustrates this convergence pattern, with pronounced fluctuations for small \(N\) and a smooth stabilization as \(N\) grows.
