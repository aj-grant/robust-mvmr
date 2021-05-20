################################################################################
#Produces simulated datasets
################################################################################

library(parallel)
library(MASS)
cl = makeCluster(6)
clusterEvalQ(cl, library(MASS))

n = 20000
m = 0.3
k = 4
p = list('100' = 100, '20' = 20)
sa = 0.2
sg = 0.2
g = rep(1/k, k)
bx_min = 0
bx_max = list('100' = 0.1, '20' = 0.22)
th = list('thA' = c(0.2, 0.1, 0.3, 0.4), 'th0' = c(0, -0.1, 0.1, 0.2))
s = list('10' = 0.1, '30' = 0.3, '50' = 0.5, '70' = 0.7)
mua = list('S1' = 0, 'S2' = 0.1, 'S3' = 0, 'S4' = 0)
mug = list('S1' = 0, 'S2' = 0, 'S3' = 0.1, 'S4' = 0.05)
SigX = list('unc' = diag(k), 'cor' = diag(rep(0.5, k)) + 0.5)
M = 1000

clusterExport(cl, c('sstat', 'Data_sim_ind', 'Data_sim_ind_S1',
                    'Data_sim_ind_inside', 'Data_sim_ind_med', 'n', 'm', 'k',
                    'p', 'sa', 'sg', 'g', 'bx_min', 'bx_max', 'th', 's', 'mua',
                    'mug', 'SigX', 'M'))

################################################################################
#Primary simulations
################################################################################

################################################################################
#theta = 0.2
clusterSetRNGStream(cl, 20190506)
#S1
D_S1_10 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S1_30 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S1_50 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S2
D_S2_10 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_30 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_50 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S3
D_S3_10 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_30 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_50 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})

D_S1_70 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'70', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_70 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'70', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_70 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'70', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S4
D_S4_10 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_inside(n, m, p$'100', s = s$'10', k, mua = mua$S4, mug = mug$S4,
                      sa, sg, g, theta = th$thA, bx_min, bx_max$'100',
                      SigX = SigX$unc)
})
D_S4_30 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_inside(n, m, p$'100', s = s$'30', k, mua = mua$S4, mug = mug$S4,
                      sa, sg, g, theta = th$thA, bx_min, bx_max$'100',
                      SigX = SigX$unc)
})
D_S4_50 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_inside(n, m, p$'100', s = s$'50', k, mua = mua$S4, mug = mug$S4,
                      sa, sg, g, theta = th$thA, bx_min, bx_max$'100',
                      SigX = SigX$unc)
})
D_S4_70 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_inside(n, m, p$'100', s = s$'70', k, mua = mua$S4, mug = mug$S4,
                      sa, sg, g, theta = th$thA, bx_min, bx_max$'100',
                      SigX = SigX$unc)
})

save(D_S1_10, D_S1_30, D_S1_50, D_S1_70, D_S2_10, D_S2_30, D_S2_50, D_S2_70,
     D_S3_10, D_S3_30, D_S3_50, D_S3_70, D_S4_10, D_S4_30, D_S4_50, D_S4_70,
     file = 'Sims results/sim_dat.R')

################################################################################
#theta = 0
clusterSetRNGStream(cl, 20190507)
#S1
D_S1_10_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S1_30_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S1_50_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S2
D_S2_10_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_30_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_50_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S3
D_S3_10_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_30_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_50_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})

D_S1_70_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'70', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_70_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'70', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_70_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'70', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S4
D_S4_10_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_inside(n, m, p$'100', s = s$'10', k, mua = mua$S4, mug = mug$S4,
                      sa, sg, g, theta = th$th0, bx_min, bx_max$'100',
                      SigX = SigX$unc)
})
D_S4_30_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_inside(n, m, p$'100', s = s$'30', k, mua = mua$S4, mug = mug$S4,
                      sa, sg, g, theta = th$th0, bx_min, bx_max$'100',
                      SigX = SigX$unc)
})
D_S4_50_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_inside(n, m, p$'100', s = s$'50', k, mua = mua$S4, mug = mug$S4,
                      sa, sg, g, theta = th$th0, bx_min, bx_max$'100',
                      SigX = SigX$unc)
})
D_S4_70_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_inside(n, m, p$'100', s = s$'70', k, mua = mua$S4, mug = mug$S4,
                      sa, sg, g, theta = th$th0, bx_min, bx_max$'100',
                      SigX = SigX$unc)
})

save(D_S1_10_null, D_S1_30_null, D_S1_50_null, D_S1_70_null, D_S2_10_null,
     D_S2_30_null, D_S2_50_null, D_S2_70_null, D_S3_10_null, D_S3_30_null,
     D_S3_50_null, D_S3_70_null, D_S4_10_null, D_S4_30_null, D_S4_50_null,
     D_S4_70_null, file = 'Sims results/sim_dat_null.R')

################################################################################
#p = 20 sims
################################################################################

################################################################################
#theta = 0.2
clusterSetRNGStream(cl, 20190506)
#S1
D_S1_10_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'10', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S1_30_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'30', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S1_50_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'50', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})

#S2
D_S2_10_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'10', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S2_30_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'30', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S2_50_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'50', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})

#S3
D_S3_10_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'10', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S3_30_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'30', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S3_50_p20 = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'50', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'20', SigX = SigX$unc)
})

save(D_S1_10_p20, D_S1_30_p20, D_S1_50_p20, D_S2_10_p20, D_S2_30_p20,
     D_S2_50_p20, D_S3_10_p20, D_S3_30_p20, D_S3_50_p20,
     file = 'Sims p20/sim_p20_dat.R')

################################################################################
#theta = 0
clusterSetRNGStream(cl, 20190507)
#S1
D_S1_10_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'10', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S1_30_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'30', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S1_50_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'50', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})

#S2
D_S2_10_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'10', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S2_30_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'30', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S2_50_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'50', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})

#S3
D_S3_10_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'10', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S3_30_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'30', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})
D_S3_50_p20_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'20', s = s$'50', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'20', SigX = SigX$unc)
})

save(D_S1_10_p20_null, D_S1_30_p20_null, D_S1_50_p20_null, D_S2_10_p20_null,
     D_S2_30_p20_null, D_S2_50_p20_null, D_S3_10_p20_null, D_S3_30_p20_null,
     D_S3_50_p20_null, file = 'Sims p20/sim_p20_dat_null.R')

################################################################################
#Correlated X's
################################################################################

################################################################################
#theta = 0.2
clusterSetRNGStream(cl, 20190506)
#S1
D_S1_10_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S1_30_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S1_50_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})

#S2
D_S2_10_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S2_30_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S2_50_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})

#S3
D_S3_10_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S3_30_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S3_50_cor = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$cor)
})

save(D_S1_10_cor, D_S1_30_cor, D_S1_50_cor, D_S2_10_cor, D_S2_30_cor,
     D_S2_50_cor, D_S3_10_cor, D_S3_30_cor, D_S3_50_cor,
     file = 'Sims cor/sim_cor_dat.R')

################################################################################
#theta = 0
clusterSetRNGStream(cl, 20190507)
#S1
D_S1_10_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S1_30_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S1_50_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S1, mug = mug$S1, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})

#S2
D_S2_10_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S2_30_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S2_50_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S2, mug = mug$S2, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})

#S3
D_S3_10_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'10', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S3_30_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'30', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})
D_S3_50_cor_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind(n, m, p$'100', s = s$'50', k, mua = mua$S3, mug = mug$S3, sa, sg,
               g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$cor)
})

save(D_S1_10_cor_null, D_S1_30_cor_null, D_S1_50_cor_null, D_S2_10_cor_null,
     D_S2_30_cor_null, D_S2_50_cor_null, D_S3_10_cor_null, D_S3_30_cor_null,
     D_S3_50_cor_null, file = 'Sims cor/sim_cor_dat_null.R')

################################################################################
#1 sample sims
################################################################################

################################################################################
#theta = 0.2
clusterSetRNGStream(cl, 20190506)
#S1
D_S1_10_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'10', k, mua = mua$S1, mug = mug$S1, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S1_30_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'30', k, mua = mua$S1, mug = mug$S1, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S1_50_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'50', k, mua = mua$S1, mug = mug$S1, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S2
D_S2_10_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'10', k, mua = mua$S2, mug = mug$S2, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_30_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'30', k, mua = mua$S2, mug = mug$S2, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_50_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'50', k, mua = mua$S2, mug = mug$S2, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S3
D_S3_10_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'10', k, mua = mua$S3, mug = mug$S3, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_30_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'30', k, mua = mua$S3, mug = mug$S3, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_50_S1 = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'50', k, mua = mua$S3, mug = mug$S3, sa,
                  sg, g, theta = th$thA, bx_min, bx_max$'100', SigX = SigX$unc)
})

save(D_S1_10_S1, D_S1_30_S1, D_S1_50_S1, D_S2_10_S1, D_S2_30_S1, D_S2_50_S1,
     D_S3_10_S1, D_S3_30_S1, D_S3_50_S1, file = 'Sims S1/sim_S1_dat.R')

################################################################################
#theta = 0
clusterSetRNGStream(cl, 20190507)
#S1
D_S1_10_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'10', k, mua = mua$S1, mug = mug$S1, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S1_30_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'30', k, mua = mua$S1, mug = mug$S1, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S1_50_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'50', k, mua = mua$S1, mug = mug$S1, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S2
D_S2_10_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'10', k, mua = mua$S2, mug = mug$S2, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_30_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'30', k, mua = mua$S2, mug = mug$S2, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S2_50_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'50', k, mua = mua$S2, mug = mug$S2, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})

#S3
D_S3_10_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'10', k, mua = mua$S3, mug = mug$S3, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_30_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'30', k, mua = mua$S3, mug = mug$S3, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})
D_S3_50_S1_null = parLapply(cl, 1:M, function(j){
  Data_sim_ind_S1(n, m, p$'100', s = s$'50', k, mua = mua$S3, mug = mug$S3, sa,
                  sg, g, theta = th$th0, bx_min, bx_max$'100', SigX = SigX$unc)
})

save(D_S1_10_S1_null, D_S1_30_S1_null, D_S1_50_S1_null, D_S2_10_S1_null,
     D_S2_30_S1_null, D_S2_50_S1_null, D_S3_10_S1_null, D_S3_30_S1_null,
     D_S3_50_S1_null, file = 'Sims S1/sim_S1_dat_null.R')

stopCluster(cl)
