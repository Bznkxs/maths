import scipy
import scipy.stats
import numpy as np
import statsmodels.api as sm


def linear_regression(*x, y):
    x = np.stack(x).transpose()
    xc = sm.add_constant(x)
    est = sm.OLS(y, xc)
    est2 = est.fit()

    return est2, xc


def analyze(*x, y):
    est2, xc = linear_regression(*x, y=y)
    alpha = 0.05
    print(est2.summary2(alpha=alpha))
    b = est2.params  # the regression parameters
    Q = sum(est2.resid ** 2)
    s = est2.mse_resid
    ts = est2.tvalues
    t = scipy.stats.t.ppf(1-alpha/2, est2.df_resid)
    Sb = b / ts
    lefts = b - t * Sb  # calculate trust interval of b by hand
    rights = b + t * Sb
    print(b)
    print(ts)
    print(Sb)
    print(lefts)
    print(rights)
    return est2, xc

def predict(avgx, est2, *pred_x, alpha=0.05):
    pred_x = [1] + list(pred_x)
    pred_x = np.array(pred_x)
    pred_y = est2.predict(pred_x)
    c = est2.normalized_cov_params
    t = scipy.stats.t.ppf(1 - alpha / 2, est2.df_resid)
    dy = t * est2.mse_resid * np.sqrt((pred_x - avgx).T @ c @ (pred_x - avgx) + 1 + 1 / est2.nobs)
    print(pred_y, dy)
    return pred_y, dy
    # sxx = np.var(x) * n


if __name__ == '__main__':
    x = [1,2,3,4,5]
    x2 = [3,3,3,3,1]
    y = [2,4,6,8,9]
    # use the following commands to get almost all you need
    est2, xc = analyze(x, x2, y=y)
    xavg = np.mean(xc, axis=0)
    predict(xavg, est2, 3, 4)
