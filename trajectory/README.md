## polyhess 

* usage: h = polyhess(n, r, tau)

Generate the Hessian matrix for polynomials of order n to the R-th order derivative, with an integration duration of
TAU. In our use case, for *x* and *y*, set n = 9, r = 4; for *z* and *y*, set n = 5, r = 2. Note that this is a
low-level function that you typically don't need to invoke. 
