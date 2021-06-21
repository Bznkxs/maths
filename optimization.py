import numpy as np

from scipy.optimize import linprog

# https://docs.scipy.org/doc/scipy/reference/tutorial/optimize.html#linear-programming-linprog
if __name__ == '__main__':
    # consider the example in the problem above
    # maximize 29x_1+45x_2
    c = [-29, -45, 0, 0]
    A_ub = [[1, -1, -3, 0], [-2, 3, 7, -3]]
    b_ub = [5, -10]
    A_eq = [[2, 8, 1, 0], [4, 4, 0, 1]]
    b_eq = [60, 60]
    x0_bounds = (0, None)
    x1_bounds = (0, 5)
    x2_bounds = (None, 0.5)
    x3_bounds = (-3, None)
    bounds = [x0_bounds, x1_bounds, x2_bounds, x3_bounds]
    result = linprog(c, A_ub=A_ub, b_ub=b_ub, A_eq=A_eq, b_eq=b_eq, bounds=bounds)
    print(result)  # should be infeasible
    x1_bounds = (0, 6)
    bounds = [x0_bounds, x1_bounds, x2_bounds, x3_bounds]
    result = linprog(c, A_ub=A_ub, b_ub=b_ub, A_eq=A_eq, b_eq=b_eq, bounds=bounds)
    print(result)
