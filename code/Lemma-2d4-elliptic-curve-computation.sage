#This is Sage code.

#This is the elliptic curve we need for Lemma 2.4
# Check that the elliptic curve related
# to the ternary cubic equation
# x^3 + y^3 + 2z^3 = 0
# has rank zero.
# Also, print out the torsion points.
E0 = EllipticCurve([0,0,0,0,-27])
print(E0)
print("The rank of E0 is: "+str(E0.rank()))
print("The torsion points on E0 are:")
print(E0.torsion_points())
