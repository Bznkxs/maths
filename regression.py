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
    s2 = est2.mse_resid
    s = np.sqrt(s2)
    ts = est2.tvalues
    t = scipy.stats.t.ppf(1-alpha/2, est2.df_resid)
    Sb = b / ts
    lefts = b - t * Sb  # calculate trust interval of b by hand; equals corresponding values in summary
    rights = b + t * Sb
    return est2, xc


def predict(avgx, est2, *pred_x, alpha=0.05):
    pred_x = [1] + list(pred_x)
    pred_x = np.array(pred_x)
    pred_y = est2.predict(pred_x)
    c = est2.normalized_cov_params
    s2 = est2.mse_resid
    s = np.sqrt(s2)
    t = scipy.stats.t.ppf(1 - alpha / 2, est2.df_resid)
    dy = t * s * np.sqrt((pred_x - avgx).T @ c @ (pred_x - avgx) + 1 + 1 / est2.nobs)
    print(pred_y, dy, t, )
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

    d1 = np.array([[
        586, 462, 491, 565, 462, 532, 478, 515, 493, 528, 576, 533, 531
    ], [
        4.4, 14, 10.1, 6.7, 11.5, 9.6, 12.4, 8.9, 11.1, 7.8, 5.5, 8.6, 7.2
    ]])
    est2, xc = analyze(d1[1], y=d1[0])
    xavg = np.mean(xc, axis=0)
    print("??")
    predict(xavg, est2, 10)
