# Reset all the variables, just in case
reset()

# Define the number field K
K = NumberField(x^3-5,name='a')
a = K.gen()

# Set up all the variables we want to use
S.<X,Y,Z,x,y,u> = PolynomialRing(K)

# This curve is the one in the statement
# of Lemma 4.2.
# We want to put the curve in Weierstrass form.
curve = (a*x-y)*(x^2-x*y+y^2)-3*(2-a)*u^3

# Define some constants
rho = 27/5*a^2+9/5*a-99/5
sigma = 1377/25*a^2-891/25*a-2511/25
c1 = -1/5*a^2 - a + 1
c2 = -5/18*a^2 - 5/9*a - 5/6
c3 = 1/6*a^2 + 5/18*a + 5/9

# Check that E is the Weierstrass form of curve
E = Y^2*Z+rho*Y*Z^2-X^3-sigma*Z^3
T = E(X=-u)(Y=c1*x)(Z=c2*x+c3*y)
T1 = ((-2/9*a^2 - 4/9*a - 5/9))*a^2/5*curve
T == T1
# True
