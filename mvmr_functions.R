library(MASS)
library(glmnet)
library(quantreg)
library(robustbase)

mvmr_med_boot = function(bx, sebx, by, seby, N){
  est = sapply(1:N, function(i){
    p = length(by)
    k = dim(bx)[2]
    Sx = lapply(1:p, function(j){diag(sebx[j, ]^2)})
    bxboot = sapply(1:p, function(j){mvrnorm(1, bx[j, ], Sx[[j]])})
    bxboot = t(bxboot)
    byboot = rnorm(p, by, seby)
    rq(byboot ~ bxboot - 1, weights = seby^-2)$coefficients
  })
  apply(est, 1, sd)
}

mvmr_median = function(bx, sebx, by, seby, boot = FALSE, boot_it = 1000){
  qr_mod = rq(by ~ bx - 1, weights = seby^-2)
  if (boot == TRUE){
    boot_se = mvmr_med_boot(bx, sebx, by, seby, boot_it)
    return(list("coefficients" = qr_mod$coefficients, "se" = boot_se))
  } else {
    return(list("coefficients" = qr_mod$coefficients))
  }
}

cv.mvmr_lasso = function(bx, by, seby, nfolds){
  p = dim(bx)[1]
  k = dim(bx)[2]
  S = diag(seby^-2)
  b = S^(1/2) %*% bx
  Pb = b %*% solve(t(b) %*% b, t(b))
  xlas = (diag(p) - Pb) %*% S^(1/2)
  ylas = (diag(p) - Pb) %*% S^(1/2) %*% by
  alas = glmnet(xlas, ylas, intercept = FALSE)
  lamseq = sort(alas$lambda)
  lamlen = length(lamseq)
  rse = sapply(1:lamlen, function(j){
    av = which(alas$beta[, (lamlen - j + 1)] == 0)
    mod = lm.fit(as.matrix(S[av, av]^(1/2) %*% bx[av, ]), S[av, av]^(1/2) %*% by[av])
    c(sqrt(t(mod$residuals) %*% (mod$residuals) / (mod$df.residual)), length(av))
  })
  rse_inc = rse[1, 2:lamlen] - rse[1, 1:(lamlen-1)]
  het = which(rse[1, 2:lamlen] > 1 & rse_inc > ((qchisq(0.95, 1) / rse[2, 2:lamlen])))
  if (length(het) == 0){
    lam_pos = 1
  } else {
    lam_pos = min(het)
  }
  num_valid = rev(sapply(1:lamlen, function(j){sum(alas$beta[, j]==0)}))
  min_lam_pos = min(which(num_valid > k))
  if (lam_pos < min_lam_pos){lam_pos = min_lam_pos}
  return(list(fit = alas$beta[, (lamlen - lam_pos + 1)], lambda = lamseq[lam_pos]))
}

mvmr_lasso = function(bx, by, seby, K = 10){
  p = dim(as.matrix(bx))[1]
  k = dim(as.matrix(bx))[2]
  S = diag(seby^-2)
  sn = sign(bx[, 1])
  bx_or = bx * sn
  by_or = by * sn
  cv.alas = cv.mvmr_lasso(bx_or, by_or, seby, K)
  a1 = cv.alas$fit
  e = by_or - a1
  thest = solve(t(bx_or) %*% S %*% bx_or, t(bx_or) %*% S %*% e)
  v = which(a1==0)
  mvmr_mod = mr_mvivw(mr_mvinput(bx = bx_or[v, ], bxse = bx_or[v, ],
                                 by = by_or[v], byse = seby[v]))
  th_post = mvmr_mod$Estimate
  se_post = mvmr_mod$StdError
  return(list(thest = thest, a = a1, lambda = cv.alas$lambda,
              th_post = th_post, se_post = se_post))
}

mvmr_robust = function(bx, by, seby, k.max = 500, maxit.scale = 500){
  robmod = lmrob(by ~ bx - 1, weights = seby^-2, k.max = k.max,
                 maxit.scale = maxit.scale)
  coefficients = summary(robmod)$coef[, 1]
  se = summary(robmod)$coef[, 2] / min(summary(robmod)$sigma, 1)
  return(list("coefficients" = coefficients, "se" = se))
}