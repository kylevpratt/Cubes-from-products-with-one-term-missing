# We want to time our computations.
# The timings are merely suggestive,
# giving a rough idea of how long
# the computations for (k,i) take.

# This code is not offered up in any way
# as an example of good programming technique!

import time

#####################################################################################

# We define various useful functions


# Returns 1 if gcd(a,b) divides g, and returns 0 otherwise
def checkgcd(a,b,g):
    d = gcd(a,b)
    t = gcd(d,g)
    if d == t:
        return 1
    else:
        return 0


# Returns the p-adic valuation of n. 
# It is assumed that p is a prime.
def getpadicval(n,p):
    v = 0
    while gcd(n,p) != 1:
        n = Integer(n/p)
        v += 1
    return v


# n is a 7-smooth integer. 
# Returns the cube-free part of n.
def removecubes(n):
    n1 = 1
    a = getpadicval(n,2)
    n1 *= 2^(Integer(mod(a,3)))
    b = getpadicval(n,3)
    n1 *= 3^(Integer(mod(b,3)))
    c = getpadicval(n,5)
    n1 *= 5^(Integer(mod(c,3)))
    d = getpadicval(n,7)
    n1 *= 7^(Integer(mod(d,3)))
    return n1

#####################################################################################

# This is the list in Lemma 2.3.
rkzerocoeffs = [1, 3, 4, 5, 10, 14, 18, 21, 25, 36, 45, 60, 100, 147, 
                150, 175, 196, 225, 245, 252, 300, 315, 350, 882, 980, 
                1050, 1470, 1575, 1764, 2940, 7350, 14700]

# Given k, a potential coefficient vector,
# and a location i we have removed,
# check if we can get a rank zero curve
# from the vector.
# We get these cubic equations using equation (2.1)
# in the paper.
# There are ({k-1} choose 3) different cubic equations
# to check.
# Returns 0 if some cubic equation corresponds to 
# a rank zero curve, and returns 1 otherwise.
def Check_Rank_Zero(vec,i):
    flag = 1
    # We loop over r < s < t.
    for r in range(k-2):
        if flag == 0:
            break
        if r != i:
            for s in range(r+1,k-1):
                if flag == 0:
                    break
                if s != i:
                    for t in range(s+1,k):
                        if t != i:
                            D = (t-s)*vec[r]*(t-r)*vec[s]*(s-r)*vec[t]
                            D = removecubes(D)
                            if D in rkzerocoeffs:
                                flag *= 0
    return flag

#####################################################################################

# We build up the possible coefficient vectors one entry at a time.
# The following two functions assist in this process.


# We have a partial coefficient vector (a_0,...,a_{j-1}), 
# and want to extend this to a_j.
# Returns a list of all extensions (a_0,...,a_{j-1},a_j)
# that are consistent with the necessary gcd conditions.
# This list of extensions is always nonempty,
# since it is always consistent with the gcd conditions
# to take a_j = 1.
# Here A is the list of possibilities for a_j:
# the positive cube-free integers with all primes <= k-1.
def Extend_vec(vec,j):
    vecstoreturn = []

    # if we are trying to extend to the removed spot i,
    # insert 0 as a placeholder and return
    if j == i:
        vec.append(0)
        vecstoreturn.append(vec)
        return vecstoreturn
    else:
	# Otherwise, go through all the possible choices
	# for a_j and see which ones satisfy the gcd conditions.
        for c in A:
            cflag = 1
            for t in range(j):
                if t != i:
                    cflag *= checkgcd(vec[t],c,j-t)
            
	    # If the candidate a_j value passed all the
	    # gcd checks, add [vec,c] to the list of possible
	    # extensions of vec.
            if cflag == 1:
		veccopy = vec.copy()
		veccopy.append(c)
                vecstoreturn.append(veccopy)
        return vecstoreturn


# We use the previous function for j <= k-2.
# When we want to extend to j=k-1 (that is, finish the vector), there is a unique a_{k-1}
# by which to extend, since the product of all the a_j must be a cube.
# After getting what the last element has to be,
# see if it is consistent with the necessary gcd conditions.
# Empirically, the last element is *not* consistent for
# a large proportion of potential coefficient vectors.
def Finish_extend(vec):
    prod = 1
    for j in range(k-1):
        if j != i:
            prod *= vec[j]
    aval = 1
    aval *= 2^(3-Integer(mod(getpadicval(prod,2),3)))
    aval *= 3^(3-Integer(mod(getpadicval(prod,3),3)))
    aval *= 5^(3-Integer(mod(getpadicval(prod,5),3)))
    aval *= 7^(3-Integer(mod(getpadicval(prod,7),3)))
    aval = removecubes(aval)
    
    cflag = 1
    for j in range(k-1):
        if j != i:
            cflag *= checkgcd(vec[j],aval,k-1-j)
    
    if cflag == 1:
        veccopy = vec.copy()
        veccopy.append(aval)
        return veccopy
    else:
        return []

#####################################################################################

# Make a choice for 5 <= k <= 11 and 1 <= i <= k-1, then run the code.
# For k >= 6 we restrict to i <= (k-1)/2 by symmetry.
k = 7
i = 3


# Start the timer
s_time = time.time()


# Given k and i, we want to build the list of possible coefficient vectors.

# We first get a list A of the possible choices for each a_j.
# These are the positive cube-free integers with all
# prime factors <= k-1.
P = prime_range(k)
A = [1]
copyA = A.copy()
for p in P:
    copyA = A.copy()
    for a in A:
        copyA.append(a*p)
        copyA.append(a*p^2)
    A = copyA
A.sort()


print("We're working with k="+str(k)+" and i="+str(i))
print("-----")


# We start building all the possible coefficient vectors

# We start gently, getting a list of all possible
# incomplete coefficient vectors of length two
print("Building first two coefficients")
print("Time elapsed: "+str(time.time()-s_time))
first2coeffs = []
for a in A:
    # If i=1, then we can't put anything in this position
    # We put a zero here to keep the indices in the vectors consistent
    if i == 1:
        first2coeffs.append([a,0])
    else:
        for b in A:
            # The numbers n and n+d are coprime, so
            # the first two entries in the coefficient
            # vector have to be coprime.
            if gcd(a,b) == 1:
                first2coeffs.append([a,b])


# Now build the list of coefficient vectors.
# For each partial coefficient vector, get all
# possible ways to extend the vector by one more entry.
# We build the whole vector, except for the last entry a_{k-1}.

# The list W is a list of partial coefficient vectors.
# W starts out as a list of all possible length-two partial
# coefficient vectors.
W = first2coeffs

# Now, for each partial coefficient vector in W,
# determine all possible ways to extend the vector
# by one more element.
# Update W to include these extensions.
# Repeatedly extend until the coefficient vectors
# are only missing their last term a_{k-1}.
for j in range(2,k-1):
    print("Working on extending to j="+str(j))
    print("Number of w's so far: "+str(len(W)))
    print("Time elapsed: "+str(time.time()-s_time))
    NewW = []
    for w in W:
        temp = Extend_vec(w,j)
        for v in temp:
            NewW.append(v)
    W = NewW


# Now try to complete each coefficient vector 
# by adding the last term. 
lastW = []
print("Extending to last coefficient")
print("Number of w's so far: "+str(len(W)))
print("Time elapsed: "+str(time.time()-s_time))
for w in W:
    temp = Finish_extend(w)
    if len(temp) > 0:
        lastW.append(temp)
        
# W is a list of potential coefficient vectors
W = lastW
print("Number of coefficient vectors to consider: "+str(len(W)))


# For each remaining potential coefficient vector, 
# try to eliminate it with rank zero curves.
print("Trying to eliminate with rank zero curves")
print("Time elapsed: "+str(time.time()-s_time))
for w in W:
    if Check_Rank_Zero(w,i) == 1:
        print("This vector does not pass the rank zero check:")
        print(w)

e_time = time.time()
print("Finished!")
print("Total time elapsed: "+str(e_time-s_time))
