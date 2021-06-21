import numpy as np
from scipy.misc import derivative

def iteration(fun, iter_func, x0=None, max_iter=None, tol=1e-8):
    cur_it = 0
    x = x0
    while np.linalg.norm(fun(x), ord=np.inf) > tol and (max_iter is None or cur_it < max_iter):
        x = iter_func(x)
        cur_it += 1
    return x, fun(x), cur_it

def newton_iter(fun, x0=None, max_iter=None, tol=1e-8):
    def d(X):
        try:
            return X-fun(X) / np.array([derivative(fun, x, dx=1e-6)[i] for i, x in enumerate(X)])
        except Exception:
            return X-fun(X) / np.array([derivative(fun, x, dx=1e-6) for i, x in enumerate(X)])
    return iteration(fun, d, x0, max_iter, tol)


if __name__ == '__main__':
    a = np.array([1, 5, 10])
    f = lambda x: np.exp(x) - a
    x0 = np.array([3, 10, 2])

    print(newton_iter(f, x0))
    print(iteration(f, lambda x: x-f(x)/(np.exp(x)), x0))
    print(np.log(a))

    g = lambda x: np.cos(x)
    print(newton_iter(g, [1.2]))
    print(iteration(g, lambda x: x+1/np.tan(x), [1.2]))
    print([np.pi / 2])