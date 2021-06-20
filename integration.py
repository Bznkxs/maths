import numpy as np
from numpy import trapz
from scipy.integrate import quad, quadrature, fixed_quad, simpson, cumtrapz
"""
quad: self-adoptive Simpson
quadrature: self-adoptive Gaussian(Gauss-Lobatto)
fixed_quad: fixed-order Gaussian

trapz: trapzoid for sampled data
cumtrapz: trapzoid cumulative (just like cumulative sum) for sampled data
simpson: Simpson for sampled data


"""

if __name__ == '__main__':
    # we are going to calculate \int_{-2}^{2}x^2dx in multiple ways
    # 1. use self-adoptive int. functions (plus fixed Gaussian)
    # they return tuples: (estimated integral value, error)
    f = lambda w: w**2
    p_simp = quad(f, -2, 2)
    p_gauss = quadrature(f, -2, 2)
    p_fgauss = fixed_quad(f, -2, 2, n=5)

    # 2. use int. functions for samples
    x = np.linspace(-2, 2, num=20)  # 21 values
    y=x**2
    p_ssimp = simpson(y, x)
    p_strapz = trapz(y, x)
    p_sctrapz = cumtrapz(y, x)  # should calculate an array

    print(p_simp, p_gauss, p_fgauss)  # the self-adoptive
    print(p_ssimp, p_strapz, p_sctrapz[-1])  # the sampled
