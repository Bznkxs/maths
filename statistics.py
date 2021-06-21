import numpy as np
import scipy.stats as stats
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

def sample_std(x: np.ndarray):
    return np.sqrt(x.var() * len(x) / (len(x) - 1))

def interval(x: np.ndarray, alpha, sigma=None):
    x_mean = x.mean()
    s = sample_std(x)
    tsem = stats.tsem(x)

    intv_mu_1 = stats.t.interval(1 - alpha, len(x) - 1, x_mean, tsem)
    if sigma:
        intv_mu_0 = stats.norm.interval(1 - alpha, x_mean, sigma)
    else:
        intv_mu_0 = None
    intv_sigma = stats.chi2.interval(1 - alpha, len(x) - 1)  # gets chi^2(alpha/2), chi^2(1-alpha/2)
    intv_sigma = s ** 2 * (len(x) - 1) / intv_sigma[::-1]
    print(intv_mu_0, intv_mu_1, intv_sigma)
    return intv_mu_0, intv_mu_1, intv_sigma


from scipy.stats import ttest_1samp  # t-test


from scipy.stats import chi2_contingency  # chi2_contingency to perform chi2 independence test


if __name__ == '__main__':
    a = np.array([9.23, 8.72, 10.31, 9.64, 9.51, 9.34, 9.08, 9.95])
    interval(a, 0.05)  # do an interval hypothesis
    d = np.array([[1,3,2],[2,1,1]])
    print(chi2_contingency(d))  # statistic; p-value; degrees of freedom; expected values
