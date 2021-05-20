################################################################################
#Functions used in Sims_all_dat.R ad Sims_est_scr.R to produce the simulated
#data and estimates using the robust MVMR methods
################################################################################

Data_sim_ind = function(n, m, p, s, k, mua, mug, sa, sg, g, theta, bx_min, bx_max, SigX){
  v = sample(p, p * (1 -s))
  a = rnorm(p, mua, sa)
  a[v] = 0
  d = runif(p, 0, mug)
  d[v] = 0
  bx = sapply(1:k, function(j){runif(p, bx_min, bx_max)})
  G = sapply(1:p, function(i){rbinom(2 * n, 2, m)})
  U = G %*% d + rnorm(2 * n, 0, 1)
  X = G %*% bx + U %*% t(g) + mvrnorm(2 * n, rep(0, k), SigX)
  Y = X %*% theta + G %*% a + U + rnorm(2 * n, 0, 1)
  sampX = seq(1, n)
  sampY = seq((n+1):(2*n))
  bxhat = matrix(nrow = p, ncol = k)
  sebx = matrix(nrow = p, ncol = k)
  byhat = vector(length = p)
  seby = vector(length = p)
  for (i in 1:p){
    for (j in 1:k){
      ssx = sstat(X[sampX, j], G[sampX, i])
      bxhat[i, j] = ssx$bhat
      sebx[i, j] = ssx$se
    }
    ssy = sstat(Y[sampY], G[sampY, i])
    byhat[i] = ssy$bhat
    seby[i] = ssy$se
  }
  return(list("bxhat" = bxhat, "sebx" = sebx, "byhat" = byhat, "seby" = seby))
}

Data_sim_ind_inside = function(n, m, p, s, k, mua, mug, sa, sg, g, theta, bx_min, bx_max, SigX){
  v = sample(p, p * (1 -s))
  a = rnorm(p, mua, sa)
  a[v] = 0
  d = runif(p, mug-0.1, mug)
  d[v] = 0
  bx = sapply(1:k, function(j){runif(p, bx_min, bx_max)})
  G = sapply(1:p, function(i){rbinom(2 * n, 2, m)})
  U = G %*% d + rnorm(2 * n, 0, 1)
  X = G %*% bx + U %*% t(g) + mvrnorm(2 * n, rep(0, k), SigX)
  Y = X %*% theta + G %*% a + U + rnorm(2 * n, 0, 1)
  sampX = seq(1, n)
  sampY = seq((n+1):(2*n))
  bxhat = matrix(nrow = p, ncol = k)
  sebx = matrix(nrow = p, ncol = k)
  byhat = vector(length = p)
  seby = vector(length = p)
  for (i in 1:p){
    for (j in 1:k){
      ssx = sstat(X[sampX, j], G[sampX, i])
      bxhat[i, j] = ssx$bhat
      sebx[i, j] = ssx$se
    }
    ssy = sstat(Y[sampY], G[sampY, i])
    byhat[i] = ssy$bhat
    seby[i] = ssy$se
  }
  return(list("bxhat" = bxhat, "sebx" = sebx, "byhat" = byhat, "seby" = seby, "v" = v))
}

Data_sim_ind_med = function(n, m, p, s, k, mua, mug, sa, sg, g, theta, bx_min, bx_max, SigX){
  v = sample(p, p * (1 -s))
  a = rnorm(p, mua, sa)
  a[v] = 0
  d = runif(p, 0, mug)
  d[v] = 0
  bx = sapply(1:k, function(j){runif(p, bx_min, bx_max)})
  G = sapply(1:p, function(i){rbinom(2 * n, 2, m)})
  U = G %*% d + rnorm(2 * n, 0, 1)
  X = G %*% bx + U %*% t(g) + mvrnorm(2 * n, rep(0, k), SigX)
  X[, 2] = X[, 2] + X[, 1]
  Y = X %*% theta + G %*% a + U + rnorm(2 * n, 0, 1)
  sampX = seq(1, n)
  sampY = seq((n+1):(2*n))
  bxhat = matrix(nrow = p, ncol = k)
  sebx = matrix(nrow = p, ncol = k)
  byhat = vector(length = p)
  seby = vector(length = p)
  for (i in 1:p){
    for (j in 1:k){
      ssx = sstat(X[sampX, j], G[sampX, i])
      bxhat[i, j] = ssx$bhat
      sebx[i, j] = ssx$se
    }
    ssy = sstat(Y[sampY], G[sampY, i])
    byhat[i] = ssy$bhat
    seby[i] = ssy$se
  }
  return(list("bxhat" = bxhat, "sebx" = sebx, "byhat" = byhat, "seby" = seby, "v" = v))
}

Data_sim_ind_S1 = function(n, m, p, s, k, mua, mug, sa, sg, g, theta, bx_min, bx_max, SigX){
  v = sample(p, p * (1 -s))
  a = rnorm(p, mua, sa)
  a[v] = 0
  d = runif(p, 0, mug)
  d[v] = 0
  bx = sapply(1:k, function(j){runif(p, bx_min, bx_max)})
  G = sapply(1:p, function(i){rbinom(n, 2, m)})
  U = G %*% d + rnorm(n, 0, 1)
  X = G %*% bx + U %*% t(g) + mvrnorm(n, rep(0, k), SigX)
  Y = X %*% theta + G %*% a + U + rnorm(n, 0, 1)
  sampX = seq(1, n)
  sampY = seq(1, n)
  bxhat = matrix(nrow = p, ncol = k)
  sebx = matrix(nrow = p, ncol = k)
  byhat = vector(length = p)
  seby = vector(length = p)
  for (i in 1:p){
    for (j in 1:k){
      ssx = sstat(X[sampX, j], G[sampX, i])
      bxhat[i, j] = ssx$bhat
      sebx[i, j] = ssx$se
    }
    ssy = sstat(Y[sampY], G[sampY, i])
    byhat[i] = ssy$bhat
    seby[i] = ssy$se
  }
  return(list("bxhat" = bxhat, "sebx" = sebx, "byhat" = byhat, "seby" = seby))
}

sstat = function(Y, X, intercept = TRUE){
  n = length(Y)
  if (intercept == TRUE){
    xx = cbind(rep(1, n), X)
  }
  else {xx = X}
  mod = lm.fit(xx, Y)
  bhat= c(mod$coefficients[2])
  s = t(mod$residuals) %*% (mod$residuals) / (mod$df.residual)
  se = sqrt((c(s) * solve(t(xx) %*% xx))[2,2])
  return(list("bhat" = bhat, "se" = se))
}

Est_sim_meta = function(M, D){
  sapply(1:M, function(j){
    Dsum = D[[j]]
    mrob = mr_mvinput(bx = Dsum$bxhat, bxse = Dsum$sebx, by = Dsum$byhat, byse = Dsum$seby)
    th_mrivw = mr_mvivw(mrob)
    th_egger = mr_mvegger(mrob)
    th_robust = mvmr_robust(Dsum$bxhat, Dsum$byhat, Dsum$seby, k.max = 1000, maxit.scale = 1000)
    c(th_mrivw$Estimate, th_mrivw$StdError, th_egger$Estimate, th_egger$StdError.Est,
      th_robust$coefficients, th_robust$se)
  })
}

Est_sim_mrpresso = function(M, D){
  parLapply(cl, 1:M, function(j){
    Dsum = D[[j]]
    k = dim(Dsum$bxhat)[2]
    dat = data.frame(bx = Dsum$bxhat, sebx = Dsum$sebx, by = Dsum$byhat, seby = Dsum$seby)
    A = mr_presso(BetaOutcome = "by", BetaExposure = names(dat)[1:k], SdOutcome = "seby",
                  SdExposure = names(dat)[(k+1):(2*k)], OUTLIERtest = TRUE,
                  DISTORTIONtest = TRUE, data = dat, NbDistribution = 2000,
                  SignifThreshold = 0.05)
    return(A)
  })
}

Est_sim_med = function(M, D){
  parSapply(cl, 1:M, function(j){
    Dsum = D[[j]]
    th_qr = mvmr_qr(Dsum$bxhat, Dsum$sebx, Dsum$byhat, Dsum$seby, boot = TRUE, boot_it = 1000)
    c(th_qr$coefficients, th_qr$se)
  })
}

Est_sim_med_CI = function(M, D){
  parSapply(cl, 1:M, function(j){
    Dsum = D[[j]]
    th_qr = mvmr_qr_CI(Dsum$bxhat, Dsum$byhat, Dsum$seby, boot = TRUE, boot_it = 1000)
    c(th_qr$coefficients, th_qr$CIlow_boot, th_qr$CIupp_boot, th_qr$CIlow_rinv, th_qr$CIupp_rinv)
  })
}

Est_sim_lass = function(M, D){
  parSapply(cl, 1:M, function(j){
    Dsum = D[[j]]
    th_lass = mvmr_lass(Dsum$bxhat, Dsum$byhat, Dsum$seby)
    c(th_lass$th_post, th_lass$se_post)
  })
}

mvmr_qr_CI = function(bx, by, seby, boot = FALSE, boot_it = 1000){
  qr_mod = rq(by ~ bx - 1, weights = seby^-2)
  if (boot == TRUE){
    a = sapply(1:boot_it, function(i){
      p = length(by)
      b = sample(p, replace = TRUE)
      rq(by[b] ~ bx[b, ] - 1, weights = seby[b]^-2)$coefficients[1]
    })
    return(list("coefficients" = qr_mod$coefficients[1],
                "CIlow_boot" = sort(a)[round(boot_it/20,1)], "CIupp_boot" = sort(a)[round(19*boot_it/20,1)],
                "CIlow_rinv" = summary(qr_mod)$coefficients[1, 2], "CIupp_rinv" = summary(qr_mod)$coefficients[1, 3]))
  } else {
    return(list("coefficients" = qr_mod$coefficients[1],
                "CIlow_rinv" = summary(qr_mod)$coefficients[1, 2], "CIupp_rinv" = summary(qr_mod)$coefficients[1, 3]))
  }
}
