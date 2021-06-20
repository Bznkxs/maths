import numpy as np
import scipy.linalg

from scipy.linalg import inv, lu, lu_solve, eigvals
from scipy.stats import ortho_group


def lu_tutoring(a):
    N = len(a)
    # naive LU decomp
    u = a.copy()
    L = np.eye(N)
    for j in range(N - 1):
        lam = np.eye(N)
        gamma = u[j + 1:, j] / u[j, j]
        lam[j + 1:, j] = -gamma
        u = lam @ u
        lam[j + 1:, j] = gamma
        L = L @ lam
    return L, u


def gauss_solver(A, b, exact=False):
    a = np.array(A)
    b = np.array(b)
    if not exact:
        return np.linalg.solve((a.T @ a), (a.T @ b))
    return np.linalg.solve(a, b)


def iteration_solver(A, b, x0=None, name='jacobi', sor_factor=1., max_iter=None, rtol=1e-6, check_convergence=True):
    """
    build up B and f, and perform
    x(n+1)=Bx(n)+f
    note we do not consider speed.
    :param check_convergence: if this checks convergence
    :param rtol: maximum relative tolerance of |b-Ax|/b
    :param max_iter: Optional[int]
    :param A:
    :param b:
    :param name: select from 'jacobi', 'gs' and 'sor'
    :param sor_factor: float, omega in SOR iteration
    :return: x, rel_loss, cur_iter
    """
    D, L, U = np.diag(A), -np.tril(A), -np.triu(A)
    Dm = np.diagflat(D)
    L += Dm
    U += Dm  # remove diagonal elements
    if name == 'jacobi':
        Dinv = 1 / D  # this is a 1-D array
        Dinv = np.diagflat(Dinv)
        B = Dinv @ (L + U)
        f = Dinv @ b
    else:
        if name == 'gs':
            sor_factor = 1
        base_mat = (Dm - sor_factor * L)
        base_mat_inv = np.linalg.inv(base_mat)
        B = base_mat_inv @ (sor_factor * U + (1 - sor_factor) * Dm)
        f = base_mat_inv @ b * sor_factor
    cur_itr = 0
    if x0 is None:
        x0 = np.zeros([A.shape[1]])
    x = x0
    loss = scipy.linalg.norm(b - A @ x) / scipy.linalg.norm(b)
    init_loss = loss
    if check_convergence:
        if np.abs(np.linalg.eigvals(B)).max() >= 1:
            print(name, ": Non-convergence warning", np.abs(np.linalg.eigvals(B)).max())
            return x, loss, 0
    while rtol < loss < init_loss * 10 and (max_iter is None or cur_itr < max_iter):
        cur_itr += 1
        x = B @ x + f
        loss = scipy.linalg.norm(b - A @ x) / scipy.linalg.norm(b)
    return x, loss, cur_itr


if __name__ == '__main__':
    A = np.random.random([4, 4]) + np.eye(4)
    b = np.random.random([4])
    # perform a LU decomposition. It is recommended to use lu to provide
    # a LU decomp with PERMUTATION, but in case you need a raw LU,
    # use lu_tutoring.
    p, l, u = lu(A)
    l1, u1 = lu_tutoring(A)
    # A.T: matrix transpose
    # np.matmul(A, b) or A@b: Ab
    print(l1, '\n', u1)
    print(p, '\n', l, '\n', u)
    print(gauss_solver(A, b, exact=False))
    print(gauss_solver(A, b, exact=True))
    print(iteration_solver(A, b, name='jacobi'))
    print(iteration_solver(A, b, name='gs'))
    print(iteration_solver(A, b, name='sor', sor_factor=0.01))