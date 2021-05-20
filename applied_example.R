#Produces estimates for the causal effect of intelligence, years of education and household income on Alzheimer's disease, using univariable and robust multivariable methods

library(MendelianRandomization)
library(tidyverse)
library(RColorBrewer)
library(cowplot)
library(gridExtra)

beta_se_all = read.csv("beta_se_all.csv", header = TRUE)

#Univariable MR intelligence -> AD
mr_int_AD = mr_ivw(mr_input(bx = beta_se_all$hill_beta,
                            bxse = beta_se_all$hill_se,
                            by = beta_se_all$lambert_beta,
                            byse = beta_se_all$lambert_se))

#Univariable MR education -> AD
mr_edu_AD = mr_ivw(mr_input(bx = beta_se_all$okbay_beta,
                            bxse = beta_se_all$okbay_se,
                            by = beta_se_all$lambert_beta,
                            byse = beta_se_all$lambert_se))

#Univariable MR income -> AD
mr_inc_AD = mr_ivw(mr_input(bx = beta_se_all$ukbb_beta,
                            bxse = beta_se_all$ukbb_se,
                            by = beta_se_all$lambert_beta,
                            byse = beta_se_all$lambert_se))

#Multivariable MR all -> AD
bx_matrix = as.matrix(cbind(beta_se_all$hill_beta,
                            beta_se_all$okbay_beta,
                            beta_se_all$ukbb_beta))
sebx_matrix = as.matrix(cbind(beta_se_all$hill_se,
                              beta_se_all$okbay_se,
                              beta_se_all$ukbb_se))
mvmr_AD = mr_mvivw(mr_mvinput(bx = bx_matrix, bxse = sebx_matrix,
                              by = beta_se_all$lambert_beta,
                              byse = beta_se_all$lambert_se))

#Residual vs fitted values
fv = fitted(lm(beta_se_all$lambert_beta ~ beta_se_all$hill_beta +
                 beta_se_all$okbay_beta + beta_se_all$ukbb_beta - 1,
               weights = beta_se_all$lambert_se^-2))
rv = residuals(lm(beta_se_all$lambert_beta ~ beta_se_all$hill_beta +
                    beta_se_all$okbay_beta + beta_se_all$ukbb_beta - 1,
                  weights = beta_se_all$lambert_se^-2))

#Robust MVMR methods
mvmr_egger_AD = mr_mvegger(mr_mvinput(bx = bx_matrix, bxse = sebx_matrix,
                           by = beta_se_all$lambert_beta,
                           byse = beta_se_all$lambert_se))
mvmr_robust_AD = mvmr_robust(bx_matrix, beta_se_all$lambert_beta,
                             beta_se_all$lambert_se, k.max = 1000, maxit.scale = 1000)
set.seed(20200705)
mvmr_presso_AD = mr_presso(BetaOutcome = "by", BetaExposure = c("bx.1", "bx.2", "bx.3"),
                           SdOutcome = "seby", SdExposure = c("sebx.1", "sebx.2", "sebx.3"),
                           OUTLIERtest = TRUE, DISTORTIONtest = TRUE, data = dat,
                           NbDistribution = 5000, SignifThreshold = 0.05)
set.seed(20200706)
mvmr_median_AD = mvmr_qr(bx_matrix, sebx_matrix, beta_se_all$lambert_beta,
                         beta_se_all$lambert_se, boot = TRUE, boot_it = 1000)
set.seed(20200707)
mvmr_lasso_AD = mvmr_lass(bx_matrix, beta_se_all$lambert_beta,
                          beta_se_all$lambert_se)
#set.seed(20210414)
qhet_est = qhet_mvmr(format_mvmr(BXGs = bx_matrix, BYG = beta_se_all$lambert_beta, seBXGs = sebx_matrix, beta_se_all$lambert_se), pcor = diag(3), CI = TRUE, iterations = 1000)
