# rauto-common
Common utilities for 16-662 Robot Autonomy

1. coeffmat = trplan(N, R, WP, TAU)

for x and y, N = 9, R = 4; for z and yaw, N = 5, R = 2. WP is a (R + 1) * NWP matrix, 
where NWP is the number of waypoints, and each column is the zero-order derivative
constraint, first-order derivative constraint, ...; set the corresponding value to 
NaN if no constraint is to be enforced. TAU is 1 * NMP matrix, where each element is
the desired duration between the last waypoint to this waypoint. 

example usage:
```matlab
WP = [0, 2, 2, 2; 1, 1, 1, 1; NaN, NaN, NaN, NaN];
TAU = [0, 2, 2, 2];
COEFFMAT = TRPLAN(5, 2, WP, TAU);
``` 

2. dercf = dercoeff(COEFFMAT)

just put coeffmat in here... 

example usage:
```matlab
DERCF = dercoeff(COEFFMAT); % obtained from step 1. 
```

3. [...] = trval(T, R, TAU, ...)

evaluate the dercf at query timepoints T, with orders of derivatives specified in R.
TAU should be the same as in step 1. T must be a column vector. 


```matlab
EV = trval(linspace(0, 6), [0: 2], TAU, DERCF); 
```

the resulting EV is a numel(T) X numel(R) matrix, where the columns are the polynomials
evaluated timepoints at T, at derivatives of order R.


## complete example

problem statement: the drone is still at (0, 0, 0, 0) at time 0. formulate a trajectory
such that the drone arrives at (4, 3, 2, 1) at time 5, with velocity on the x-axis zero, 
and that the drone arrives at (1, 2, 1, 2) at time 10 with zero velocity. return the
planned positions and velocities and query points [0, 0.05, 0.10, ..., 10.00];

```matlab
WPX = [0, 4, 1; 0, 0, 0; NaN, NaN, NaN]; 
WPY = [0, 3, 2; 0, NaN, 0; NaN, NaN, NaN]; 
WPZ = [0, 2, 1; 0, NaN, 0; NaN, NaN, NaN; NaN, NaN, NaN; NaN, NaN, NaN]; 
WPTHETA = [0, 1, 2; 0, NaN, 0; NaN, NaN, NaN; NaN, NaN, NaN; NaN, NaN, NaN];
TAU = [0, 5, 5];

CMX = TRPLAN(5, 2, WPX, TAU); DCX = DERCOEFF(CMX); 
CMY = TRPLAN(5, 2, WPY, TAU); DCY = DERCOEFF(CMY); 
CMZ = TRPLAN(9, 4, WPZ, TAU); DCZ = DERCOEFF(CMZ); 
CMTHETA = TRPLAN(9, 4, WPTHETA, TAU); DCTHETA = DERCOEFF(CMTHETA); 

[x, y, z, theta] = TRVAL([0:0.05:10]', [0: 1], TAU, DCX, DCY, DCZ, DCTHETA); 

```



 
 





 

 



