# This is Sage code.

# This is the list in Lemma 2.3
rkzerocoeffs = [1, 3, 4, 5, 10, 14, 18, 21, 25, 36, 45, 60, 100, 147, 
                150, 175, 196, 225, 245, 252, 300, 315, 350, 882, 980, 
                1050, 1470, 1575, 1764, 2940, 7350, 14700]

# Check that if D is in the list and D >= 3,
# then the curve y^2 = x^3- 432*D^2
# has rank zero.
# Using rank_bounds() is faster than using rank().
# ED.rank_bounds() returns [a,b],
# and the rank r of the curve satisfies a <= r <= b.
# In all cases, we have that a and b are both zero,
# so the rank is zero.
for D in rkzerocoeffs:
    if D >= 3:
        ED = EllipticCurve([0,0,0,0,-432*D^2])
        print("D="+str(D))
        print(ED)
        print("The rank of the curve is: "+str(ED.rank_bounds()))
        print("-----")

print("\n")

# We use a different elliptic curve for D = 1.
# Check the associated curve has rank zero.
E1 = EllipticCurve([0,0,1,0,0])
print(E1)
print("The rank of E1 is: "+str(E1.rank()))
print("The torsion points on E1 are:")
print(E1.torsion_points())
