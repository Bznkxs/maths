import numpy as np
from scipy.integrate import RK23, RK45
# https://numerical-analysis.readthedocs.io/en/latest/ODE/ODE.html


def ode23(fun, t0, y0, t_bound, max_step=np.inf,
                 rtol=1e-3, atol=1e-6, vectorized=False,
                 first_step=None, **extraneous):
    """
    Parameters
    ----------
    fun : callable
        Right-hand side of the system. The calling signature is ``fun(t, y)``.
        Here ``t`` is a scalar and there are two options for ndarray ``y``.
        It can either have shape (n,), then ``fun`` must return array_like with
        shape (n,). Or alternatively it can have shape (n, k), then ``fun``
        must return array_like with shape (n, k), i.e. each column
        corresponds to a single column in ``y``. The choice between the two
        options is determined by `vectorized` argument (see below).
    t0 : float
        Initial time.
    y0 : array_like, shape (n,)
        Initial state.
    t_bound : float
        Boundary time - the integration won't continue beyond it. It also
        determines the direction of the integration.
    first_step : float or None, optional
        Initial step size. Default is ``None`` which means that the algorithm
        should choose.
    max_step : float, optional
        Maximum allowed step size. Default is np.inf, i.e., the step size is not
        bounded and determined solely by the solver.
    rtol, atol : float and array_like, optional
        Relative and absolute tolerances. The solver keeps the local error
        estimates less than ``atol + rtol * abs(y)``. Here, `rtol` controls a
        relative accuracy (number of correct digits). But if a component of `y`
        is approximately below `atol`, the error only needs to fall within
        the same `atol` threshold, and the number of correct digits is not
        guaranteed. If components of y have different scales, it might be
        beneficial to set different `atol` values for different components by
        passing array_like with shape (n,) for `atol`. Default values are
        1e-3 for `rtol` and 1e-6 for `atol`.
    vectorized : bool, optional
        Whether `fun` is implemented in a vectorized fashion. Default is False.

    """
    solver23 = RK23(fun, t0, y0, t_bound, max_step, rtol, atol, vectorized, first_step, **extraneous)
    while solver23.status == 'running':
        solver23.step()
    return solver23.t, solver23.y


def ode45(fun, t0, y0, t_bound, max_step=np.inf,
                 rtol=1e-3, atol=1e-6, vectorized=False,
                 first_step=None, **extraneous):
    """
    Parameters
    ----------
    fun : callable
        Right-hand side of the system. The calling signature is ``fun(t, y)``.
        Here ``t`` is a scalar and there are two options for ndarray ``y``.
        It can either have shape (n,), then ``fun`` must return array_like with
        shape (n,). Or alternatively it can have shape (n, k), then ``fun``
        must return array_like with shape (n, k), i.e. each column
        corresponds to a single column in ``y``. The choice between the two
        options is determined by `vectorized` argument (see below).
    t0 : float
        Initial time.
    y0 : array_like, shape (n,)
        Initial state.
    t_bound : float
        Boundary time - the integration won't continue beyond it. It also
        determines the direction of the integration.
    first_step : float or None, optional
        Initial step size. Default is ``None`` which means that the algorithm
        should choose.
    max_step : float, optional
        Maximum allowed step size. Default is np.inf, i.e., the step size is not
        bounded and determined solely by the solver.
    rtol, atol : float and array_like, optional
        Relative and absolute tolerances. The solver keeps the local error
        estimates less than ``atol + rtol * abs(y)``. Here, `rtol` controls a
        relative accuracy (number of correct digits). But if a component of `y`
        is approximately below `atol`, the error only needs to fall within
        the same `atol` threshold, and the number of correct digits is not
        guaranteed. If components of y have different scales, it might be
        beneficial to set different `atol` values for different components by
        passing array_like with shape (n,) for `atol`. Default values are
        1e-3 for `rtol` and 1e-6 for `atol`.
    vectorized : bool, optional
        Whether `fun` is implemented in a vectorized fashion. Default is False.

    """
    solver45 = RK45(fun, t0, y0, t_bound, max_step, rtol, atol, vectorized, first_step, **extraneous)
    while solver45.status == 'running':
        solver45.step()
    return solver45.t, solver45.y


def forward_euler(fun, t0, y0, t_bound, max_step=np.inf):
    if np.isinf(max_step):
        max_step = (t_bound - t0) / 100

    ts = np.linspace(t0, t_bound, int(np.ceil((t_bound - t0) / max_step)))
    ys = np.array(y0)
    for i in range(len(ts) - 1):
        ys = ys + fun(ts[i], ys) * (ts[i+1] - ts[i])
    return ts[-1], ys


def improved_euler(fun, t0, y0, t_bound, max_step=np.inf):
    if np.isinf(max_step):
        max_step = (t_bound - t0) / 100

    ts = np.linspace(t0, t_bound, int(np.ceil((t_bound - t0) / max_step)))
    ys = np.array(y0)
    for i in range(len(ts) - 1):
        h = (ts[i+1] - ts[i])
        k1 = fun(ts[i], ys)
        ys1 = ys + k1 * h
        k2 = fun(ts[i], ys1)
        ys = ys + (k1 + k2) * h / 2
    return ts[-1], ys


def rk4(fun, t0, y0, t_bound, max_step=np.inf):
    if np.isinf(max_step):
        max_step = (t_bound - t0) / 100
    ts = np.linspace(t0, t_bound, int(np.ceil((t_bound - t0) / max_step)))
    ys = np.array(y0)
    for i in range(len(ts) - 1):
        h = (ts[i + 1] - ts[i])
        k1 = fun(ts[i], ys)
        k2 = fun(ts[i] + h / 2, ys + h / 2 * k1)
        k3 = fun(ts[i] + h / 2, ys + h / 2 * k2)
        k4 = fun(ts[i + 1], ys + h * k3)
        ys = ys + h * (k1 + 2 * k2 + 2 * k3 + k4) / 6
    return ts[-1], ys


if __name__ == '__main__':
    f = lambda x, y: y

    # the following is usage of RK23. RK45 follows the same usage.
    # the solvers do not have a fixed step. set max_step to limit.
    solver23 = RK23(f, 0, [1], 2, max_step=0.001)  # note: y0 in form [y00, y01, ...]
    while solver23.status == 'running':
        solver23.step()
    while solver23.status == 'running':
        solver23.step()
    print(solver23.t, solver23.y)

    # use the wrapped method directly
    print(ode23(f, 0, [1], 2, max_step=0.001))
    print(ode45(f, 0, [1], 2, max_step=0.001))
    print(forward_euler(f, 0, [1], 2, max_step=0.001))
    print(improved_euler(f, 0, [1], 2, max_step=0.001))
    print(rk4(f, 0, [1], 2, max_step=0.001))
    print(np.exp(2))  # this is the accurate value
