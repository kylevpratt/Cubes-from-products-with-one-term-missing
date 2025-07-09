/* 
We set the seed so we get the same outputs every time
*/
SetSeed(0);
Random(1,10);
/*
The random integer should always be 2
*/


/*
Define the number field K over which we work
*/
_<a> := PolynomialRing(Rationals());  
K<a> := NumberField(a^3-5); 
OK := IntegerRing(K);


/*
Define constants rho and sigma in K,
and define the elliptic curve E with
which we work
*/
rho := 27/5*a^2+9/5*a-99/5; 
sigma := 1377/25*a^2-891/25*a-2511/25;
E<X,Y,Z> := EllipticCurve([0,0,rho,0,sigma]);

/*
Check that E has rank two
*/
RankBounds(E);

/*
2 2; the lower bound and upper bound for the rank are both two,
so E has rank two
*/


/*
Set up the map from E to P^1(Q)
*/
P1 := ProjectiveSpace(Rationals(),1); 
d1 := -1/6*a^2 - 1/6*a; 
d2 := -1/6*a^2 - 5/6; 
d3 := -9/5*a^2 - 9/5*a + 9;
phi := map< E->P1 | [d1*Y, d2*Y+d3*Z] >;


/*
Calculate the Mordell-Weil group of E.
This takes several minutes.
*/
G,GtoEK,flag1,flag2 := MordellWeilGroup(E);
G; GtoEK; flag1; flag2;


/* G; 
Abelian Group isomorphic to Z + Z
Defined on 2 generators (free) 

This means the Mordell-Weil group of E is isomorphic to Z + Z
*/


/* GtoEK; 
Mapping from: GrpAb: G to CrvEll: E
Composition of Mapping from: GrpAb: G to Set of points of Elliptic Curve defined
by y^2 + (675*a^2 + 225*a - 2475)*y = x^3 + (860625*a^2 - 556875*a - 1569375)
over K with coordinates in K given by a rule [no inverse] and
Elliptic curve isomorphism from: Elliptic Curve defined by y^2 + (675*a^2 +
    225*a - 2475)*y = x^3 + (860625*a^2 - 556875*a - 1569375) over K to CrvEll:
E
Taking (x : y : 1) to (1/25*x : 1/125*y : 1) 

GtoEK is an isomorphism between the abstract group Z + Z
and the Mordell-Weil group of E
*/


/* flag1, flag2 are both true
This means that the Mordell-Weil group of E provably has rank 2,
and we have provably found generators for the whole group
*/


V,R := Chabauty(GtoEK,phi); V; R;

/* V;
{
    -G.1 + G.2
}
V consists of all points in E(K) (represented as the abstract group G) with Q-rational image
under the map phi
*/

/* R;
79720200
*/


/* G.1 and G.2 are the two generators of Z + Z
The result of the Chabauty/Mordell-Weil sieve computation
is that the point P = GtoEK(-G.1+G.2) = (1/5*(-3*a^2 + 3*a + 15) : 1/5*(-9*a^2 - 9*a + 27) : 1)
on E is the only point P such that phi(P) has (d1*Y,d2*Y+d3*Z) in P^1(Q)
*/


phiExt := Extend(phi);
[ phiExt( GtoEK(P) ) : P in V ];

/*[ (1/2 : 1) ]
The point (x,y) in projective space P^1(Q) is equal to (1/2,1).
*/
