# This is Sage code.

# Reset the variables, just in case.
reset()

# Set up the number field K
K = NumberField(x^3-5,name='a')
a = K.gen()

# Let f,g,h be variables in a polynomial ring over K
R.<f,g,h> = PolynomialRing(K)

# eps0 is the fundamental unit of the ring of integers of K
eps0 = 1-4*a+2*a^2

# Look at what happens if b=1 in
# the expression for ax-y.
print("First look at b=1")
T1 = (2-a)*eps0^1*(f+a*g+a^2*h)^3
print("The entire expression for ax-y is:")
print(str(T1)+"\n"+"------------")
# (8*a^2 - 9*a - 8)*f^3 + (-27*a^2 - 24*a + 120)*f^2*g + (-24*a^2 + 120*a - 135)*f*g^2 
# + (40*a^2 - 45*a - 40)*g^3 + (-24*a^2 + 120*a - 135)*f^2*h + (240*a^2 - 270*a - 240)*f*g*h 
# + (-135*a^2 - 120*a + 600)*g^2*h + (-135*a^2 - 120*a + 600)*f*h^2 
# + (-120*a^2 + 600*a - 675)*g*h^2 + (200*a^2 - 225*a - 200)*h^3

# We go through the monomials of T1, and for each monomial we extract the coefficient of a
# Make sure that each coefficient of a is divisible by 3
print("The coefficient of a is:")
c1 = 0
flag = 1
for m in T1.monomials():
    Lm = T1.monomial_coefficient(m)
    cm = Lm[1]
    c1 += m*cm
    if Integer(mod(cm,3)) != 0:
        flag *= 0       
print(c1)
# x = -9*f^3 - 24*f^2*g + 120*f*g^2 - 45*g^3 + 120*f^2*h - 270*f*g*h - 120*g^2*h 
#     - 120*f*h^2 + 600*g*h^2 - 225*h^3

print("Check if every term is divisible by 3.") 
print(flag)
# flag is 1, which happens if and only if every coefficient of a in T1 is divisible by 3

print("------------")


# Look at what happens if b=2 in
# the expression for ax-y.
print("Next look at b=2")
T2 = (2-a)*eps0^2*(f+a*g+a^2*h)^3
print("The entire expression for ax-y is:")
print(str(T2)+"\n"+"------------")
# (28*a^2 + 103*a - 258)*f^3 + (309*a^2 - 774*a + 420)*f^2*g + (-774*a^2 + 420*a + 1545)*f*g^2
# + (140*a^2 + 515*a - 1290)*g^3 + (-774*a^2 + 420*a + 1545)*f^2*h + (840*a^2 + 3090*a - 7740)*f*g*h
# + (1545*a^2 - 3870*a + 2100)*g^2*h + (1545*a^2 - 3870*a + 2100)*f*h^2
# + (-3870*a^2 + 2100*a + 7725)*g*h^2 + (700*a^2 + 2575*a - 6450)*h^3

# We go through the monomials of T2, and for each monomial we extract the coefficient of 1
# Make sure that each coefficient of 1 is divisible by 3
c2 = 0
flag = 1
for m in T2.monomials():
    Lm = T2.monomial_coefficient(m)
    cm = Lm[0]
    c2 += m*cm
    if Integer(mod(cm,3)) != 0:
        flag *= 0
print("The coefficient of 1 is:")
print(c2)
# -y = -258*f^3 + 420*f^2*g + 1545*f*g^2 - 1290*g^3 + 1545*f^2*h - 7740*f*g*h + 2100*g^2*h
#     + 2100*f*h^2 + 7725*g*h^2 - 6450*h^3

print("Check if every term is divisible by 3.")
print(flag)
# flag is 1, which happens if and only if every coefficient of 1 in T2 is divisible by 3
