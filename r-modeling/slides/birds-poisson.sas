data birds;
 input site habitat count;
datalines;
1 1 27
1 2 209
2 1 1
2 2 0
3 1 12
3 2 21
4 1 19
4 2 15
5 1 7
5 2 14
6 1 22
6 2 22
7 1 128
7 2 5
8 1 17
8 2 7
9 1 10
9 2 6
10 1 69
10 2 79
11 1 4
11 2 7
12 1 317
12 2 74
13 1 26
13 2 1
14 1 15
14 2 48
15 1 22
15 2 2
16 1 143
16 2 62
17 1 25
17 2 35
18 1 31
18 2 989
19 1 2
19 2 12
20 1 827
20 2 93
21 1 1
21 2 36
22 1 10
22 2 0
23 1 193
23 2 14
24 1 5
24 2 4
;

/* Normal */
proc glimmix data=birds method = laplace;
 class site habitat;
 model count=habitat;
 random intercept / subject=site;
 lsmeans habitat / diff cl;
run;

/* Poisson */
proc glimmix data=birds;
 class site habitat;
 model count=habitat/d=poisson;
 random intercept / subject=site;
 lsmeans habitat / diff cl ilink plot = meanplot(cl);
 estimate 'diff' habitat 1 -1 / exp cl;
run;

/* Negative Binomial */
proc glimmix data=birds pconv = 1e-6;
 class site habitat;
 model count=habitat/d=negbin;
 random intercept / subject=site;
 lsmeans habitat / diff cl ilink plot = meanplot(cl);
 estimate 'diff' habitat 1 -1 / exp cl;
 nloptions maxiter = 100;
run;

