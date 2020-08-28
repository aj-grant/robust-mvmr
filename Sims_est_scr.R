library(quantreg)
library(MendelianRandomization)
library(parallel)

cl = makeCluster(6)
clusterEvalQ(cl, library(glmnet))
clusterEvalQ(cl, library(quantreg))
clusterEvalQ(cl, library(MASS))
clusterEvalQ(cl, library(MendelianRandomization))
M = 1000
clusterExport(cl, c('M', 'Est_sim_lass', 'mvmr_lasso', 'cv.mvmr_lasso',
                    'Est_sim_med', 'mvmr_median', 'mvmr_med_boot',
                    'D_S1_10', 'D_S1_30', 'D_S1_50',
                    'D_S2_10', 'D_S2_30', 'D_S2_50',
                    'D_S3_10', 'D_S3_30', 'D_S3_50',
                    'D_S1_10_null', 'D_S1_30_null', 'D_S1_50_null',
                    'D_S2_10_null', 'D_S2_30_null', 'D_S2_50_null',
                    'D_S3_10_null', 'D_S3_30_null', 'D_S3_50_null'))

################################################################################
#Primary simulations
################################################################################
#theta = 0.2
#IVW, Egger & Robust estimates
#S1
E_S1_10_meta = Est_sim_meta(M, D_S1_10)
E_S1_30_meta = Est_sim_meta(M, D_S1_30)
E_S1_50_meta = Est_sim_meta(M, D_S1_50)

#S2
E_S2_10_meta = Est_sim_meta(M, D_S2_10)
E_S2_30_meta = Est_sim_meta(M, D_S2_30)
E_S2_50_meta = Est_sim_meta(M, D_S2_50)

#S3
E_S3_10_meta = Est_sim_meta(M, D_S3_10)
E_S3_30_meta = Est_sim_meta(M, D_S3_30)
E_S3_50_meta = Est_sim_meta(M, D_S3_50)

################################################################################
#theta = 0
#IVW, Egger & Robust estimates
#S1
E_S1_10_null_meta = Est_sim_meta(M, D_S1_10_null)
E_S1_30_null_meta = Est_sim_meta(M, D_S1_30_null)
E_S1_50_null_meta = Est_sim_meta(M, D_S1_50_null)

#S2
E_S2_10_null_meta = Est_sim_meta(M, D_S2_10_null)
E_S2_30_null_meta = Est_sim_meta(M, D_S2_30_null)
E_S2_50_null_meta = Est_sim_meta(M, D_S2_50_null)

#S3
E_S3_10_null_meta = Est_sim_meta(M, D_S3_10_null)
E_S3_30_null_meta = Est_sim_meta(M, D_S3_30_null)
E_S3_50_null_meta = Est_sim_meta(M, D_S3_50_null)

################################################################################
#MVMR Lasso Estimates
################################################################################
#theta = 0.2
#S1
clusterSetRNGStream(cl, 20200913)
E_S1_lass_10 = Est_sim_lass(M, D_S1_10)
clusterSetRNGStream(cl, 20200914)
E_S1_lass_30 = Est_sim_lass(M, D_S1_30)
clusterSetRNGStream(cl, 20200915)
E_S1_lass_50 = Est_sim_lass(M, D_S1_50)

#S2
clusterSetRNGStream(cl, 20200916)
E_S2_lass_10 = Est_sim_lass(M, D_S2_10)
clusterSetRNGStream(cl, 20200917)
E_S2_lass_30 = Est_sim_lass(M, D_S2_30)
clusterSetRNGStream(cl, 20200918)
E_S2_lass_50 = Est_sim_lass(M, D_S2_50)

#S3
clusterSetRNGStream(cl, 20200919)
E_S3_lass_10 = Est_sim_lass(M, D_S3_10)
clusterSetRNGStream(cl, 20200920)
E_S3_lass_30 = Est_sim_lass(M, D_S3_30)
clusterSetRNGStream(cl, 20200921)
E_S3_lass_50 = Est_sim_lass(M, D_S3_50)

################################################################################
#theta = 0
#S1
clusterSetRNGStream(cl, 20201013)
E_S1_lass_10_null = Est_sim_lass(M, D_S1_10_null)
clusterSetRNGStream(cl, 20201014)
E_S1_lass_30_null = Est_sim_lass(M, D_S1_30_null)
clusterSetRNGStream(cl, 20201015)
E_S1_lass_50_null = Est_sim_lass(M, D_S1_50_null)

#S2
clusterSetRNGStream(cl, 20201016)
E_S2_lass_10_null = Est_sim_lass(M, D_S2_10_null)
clusterSetRNGStream(cl, 20201017)
E_S2_lass_30_null = Est_sim_lass(M, D_S2_30_null)
clusterSetRNGStream(cl, 20201018)
E_S2_lass_50_null = Est_sim_lass(M, D_S2_50_null)

#S3
clusterSetRNGStream(cl, 20201019)
E_S3_lass_10_null = Est_sim_lass(M, D_S3_10_null)
clusterSetRNGStream(cl, 20201020)
E_S3_lass_30_null = Est_sim_lass(M, D_S3_30_null)
clusterSetRNGStream(cl, 20201021)
E_S3_lass_50_null = Est_sim_lass(M, D_S3_50_null)

################################################################################
#MVMR Median Estimates
################################################################################
#theta = 0.2
#S1
clusterSetRNGStream(cl, 20200713)
E_S1_med_10 = Est_sim_med(M, D_S1_10)
clusterSetRNGStream(cl, 20200714)
E_S1_med_30 = Est_sim_med(M, D_S1_30)
clusterSetRNGStream(cl, 20200715)
E_S1_med_50 = Est_sim_med(M, D_S1_50)

#S2
clusterSetRNGStream(cl, 20200716)
E_S2_med_10 = Est_sim_med(M, D_S2_10)
clusterSetRNGStream(cl, 20200717)
E_S2_med_30 = Est_sim_med(M, D_S2_30)
clusterSetRNGStream(cl, 20200718)
E_S2_med_50 = Est_sim_med(M, D_S2_50)

#S3
clusterSetRNGStream(cl, 20200719)
E_S3_med_10 = Est_sim_med(M, D_S3_10)
clusterSetRNGStream(cl, 20200720)
E_S3_med_30 = Est_sim_med(M, D_S3_30)
clusterSetRNGStream(cl, 20200721)
E_S3_med_50 = Est_sim_med(M, D_S3_50)

################################################################################
#theta = 0
#S1
clusterSetRNGStream(cl, 20200813)
E_S1_med_10_null = Est_sim_med(M, D_S1_10_null)
clusterSetRNGStream(cl, 20200814)
E_S1_med_30_null = Est_sim_med(M, D_S1_30_null)
clusterSetRNGStream(cl, 20200815)
E_S1_med_50_null = Est_sim_med(M, D_S1_50_null)

#S2
clusterSetRNGStream(cl, 20200816)
E_S2_med_10_null = Est_sim_med(M, D_S2_10_null)
clusterSetRNGStream(cl, 20200817)
E_S2_med_30_null = Est_sim_med(M, D_S2_30_null)
clusterSetRNGStream(cl, 20200818)
E_S2_med_50_null = Est_sim_med(M, D_S2_50_null)

#S3
clusterSetRNGStream(cl, 20200819)
E_S3_med_10_null = Est_sim_med(M, D_S3_10_null)
clusterSetRNGStream(cl, 20200820)
E_S3_med_30_null = Est_sim_med(M, D_S3_30_null)
clusterSetRNGStream(cl, 20200821)
E_S3_med_50_null = Est_sim_med(M, D_S3_50_null)

stopCluster(cl)
