# Week 1 

## Introduction


##### What is Machine Learning? 

> Tom Mitchell (1998) : Well-posed Learning
Problem- A computer program is said to learn
from experience E with respect to some task T
and some performance measure P, if its
performance on T, as measured by P, improves
with experience E. 
 
##### In conclusion,  

	E - Experience 

	T - Task and performance

	P - Measure(Probability)

##### Examples
> - Database mining 
> - Applications can’t program by hand
> - Self-customizing programs
> - Understanding human learning


##### Machine Learning algorithms
	
1. Supervised Learning 
	- regression (continuous) 
	- classification (discrete)

2. Unsupervised Learning
	- clustering 
	- non - clustering (ex - cocktail party Algorithm)

3. Others 

	 Reinforcement learning, recommendersystems, e.t.c...
	

## Linear Regression with One Variable

##### Training set(Supervised Learning)
	input -> h(hypothesis) -> output

	Hypothesis : Hθ(x) = θ0 + θ1 * x
	Prameters : θ0, θ1
	Cost Functions : J(θ0,θ1) = 1/2m Σ(i=1 to m) h(x^(i)) - y^(i))^2
	
where do we use Cost Functions? -> to minimize J(θ0, θ1)

keep changing parameters to reduce J(θ0, θ1)

##### Gradient descent algorithm
	
	θj := θj - a * d/(dθj) * J(θ0,θ1) (j = 0 and j = 1 )
	* a = learning rate
	* update simultaneously
	* repeat until covergence

: =  Assignment

   =  Truth assertion


if a is too small, gradient descent can be slow.
 
if a is too large, it also causes a problem.(it may fail to converge, or even diverge)

we use this alogrithm to find an optimal minimum of a differentiable function.

## Linear Algebra Review

I skip this part (I studied Linear Algebra when i was a Sophomore)
