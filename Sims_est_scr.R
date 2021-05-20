################################################################################
#Produces estimates from the simulated data created in sim_dat_all.R
################################################################################

library(quantreg)
library(MendelianRandomization)
library(parallel)

cl = makeCluster(6)
clusterEvalQ(cl, library(glmnet))
clusterEvalQ(cl, library(quantreg))
clusterEvalQ(cl, library(MASS))
clusterEvalQ(cl, library(MendelianRandomization))
M = 1000
clusterExport(cl, c('M', 'Est_sim_lass', 'mvmr_lass', 'cv.mvmr_lass',
                    'Est_sim_med', 'Est_sim_mrpresso', 'Est_sim_med_CI',
                    'mvmr_qr', 'mvmr_qr_CI', 'mv_med_boot', 'mr_presso',
                    'D_S1_10', 'D_S1_30', 'D_S1_50', 'D_S1_70',
                    'D_S2_10', 'D_S2_30', 'D_S2_50', 'D_S2_70',
                    'D_S3_10', 'D_S3_30', 'D_S3_50', 'D_S3_70',
                    'D_S4_10', 'D_S4_30', 'D_S4_50', 'D_S4_70',
                    'D_S1_10_med', 'D_S1_30_med', 'D_S1_50_med',
                    'D_S2_10_med', 'D_S2_30_med', 'D_S2_50_med',
                    'D_S3_10_med', 'D_S3_30_med', 'D_S3_50_med',
                    'D_S1_10_null', 'D_S1_30_null', 'D_S1_50_null', 'D_S1_70_null',
                    'D_S2_10_null', 'D_S2_30_null', 'D_S2_50_null', 'D_S2_70_null',
                    'D_S3_10_null', 'D_S3_30_null', 'D_S3_50_null', 'D_S3_70_null',
                    'D_S4_10_null', 'D_S4_30_null', 'D_S4_50_null', 'D_S4_70_null',
                    'D_S1_10_null_med', 'D_S1_30_null_med', 'D_S1_50_null_med',
                    'D_S2_10_null_med', 'D_S2_30_null_med', 'D_S2_50_null_med',
                    'D_S3_10_null_med', 'D_S3_30_null_med', 'D_S3_50_null_med'))

################################################################################
#Primary simulations
################################################################################
#theta = 0.2
#IVW, Egger & Robust estimates
#S1
E_S1_10_meta = Est_sim_meta(M, D_S1_10)
E_S1_30_meta = Est_sim_meta(M, D_S1_30)
E_S1_50_meta = Est_sim_meta(M, D_S1_50)
E_S1_70_meta = Est_sim_meta(M, D_S1_70)

#S2
E_S2_10_meta = Est_sim_meta(M, D_S2_10)
E_S2_30_meta = Est_sim_meta(M, D_S2_30)
E_S2_50_meta = Est_sim_meta(M, D_S2_50)
E_S2_70_meta = Est_sim_meta(M, D_S2_70)

#S3
E_S3_10_meta = Est_sim_meta(M, D_S3_10)
E_S3_30_meta = Est_sim_meta(M, D_S3_30)
E_S3_50_meta = Est_sim_meta(M, D_S3_50)
E_S3_70_meta = Est_sim_meta(M, D_S3_70)

#S4
E_S4_10_meta = Est_sim_meta(M, D_S4_10)
E_S4_30_meta = Est_sim_meta(M, D_S4_30)
E_S4_50_meta = Est_sim_meta(M, D_S4_50)
E_S4_70_meta = Est_sim_meta(M, D_S4_70)

################################################################################
#theta = 0
#IVW, Egger & Robust estimates
#S1
E_S1_10_null_meta = Est_sim_meta(M, D_S1_10_null)
E_S1_30_null_meta = Est_sim_meta(M, D_S1_30_null)
E_S1_50_null_meta = Est_sim_meta(M, D_S1_50_null)
E_S1_70_null_meta = Est_sim_meta(M, D_S1_70_null)

#S2
E_S2_10_null_meta = Est_sim_meta(M, D_S2_10_null)
E_S2_30_null_meta = Est_sim_meta(M, D_S2_30_null)
E_S2_50_null_meta = Est_sim_meta(M, D_S2_50_null)
E_S2_70_null_meta = Est_sim_meta(M, D_S2_70_null)

#S3
E_S3_10_null_meta = Est_sim_meta(M, D_S3_10_null)
E_S3_30_null_meta = Est_sim_meta(M, D_S3_30_null)
E_S3_50_null_meta = Est_sim_meta(M, D_S3_50_null)
E_S3_70_null_meta = Est_sim_meta(M, D_S3_70_null)

#S4
E_S4_10_null_meta = Est_sim_meta(M, D_S4_10_null)
E_S4_30_null_meta = Est_sim_meta(M, D_S4_30_null)
E_S4_50_null_meta = Est_sim_meta(M, D_S4_50_null)
E_S4_70_null_meta = Est_sim_meta(M, D_S4_70_null)

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
clusterSetRNGStream(cl, 20210301)
E_S1_lass_70 = Est_sim_lass(M, D_S1_70)

#S2
clusterSetRNGStream(cl, 20200916)
E_S2_lass_10 = Est_sim_lass(M, D_S2_10)
clusterSetRNGStream(cl, 20200917)
E_S2_lass_30 = Est_sim_lass(M, D_S2_30)
clusterSetRNGStream(cl, 20200918)
E_S2_lass_50 = Est_sim_lass(M, D_S2_50)
clusterSetRNGStream(cl, 20210302)
E_S2_lass_70 = Est_sim_lass(M, D_S2_70)

#S3
clusterSetRNGStream(cl, 20200919)
E_S3_lass_10 = Est_sim_lass(M, D_S3_10)
clusterSetRNGStream(cl, 20200920)
E_S3_lass_30 = Est_sim_lass(M, D_S3_30)
clusterSetRNGStream(cl, 20200921)
E_S3_lass_50 = Est_sim_lass(M, D_S3_50)
clusterSetRNGStream(cl, 20210303)
E_S3_lass_70 = Est_sim_lass(M, D_S3_70)

#S4
clusterSetRNGStream(cl, 20210304)
E_S4_lass_10 = Est_sim_lass(M, D_S4_10)
clusterSetRNGStream(cl, 20210305)
E_S4_lass_30 = Est_sim_lass(M, D_S4_30)
clusterSetRNGStream(cl, 20210306)
E_S4_lass_50 = Est_sim_lass(M, D_S4_50)
clusterSetRNGStream(cl, 20210307)
E_S4_lass_70 = Est_sim_lass(M, D_S4_70)

################################################################################
#theta = 0
#S1
clusterSetRNGStream(cl, 20201013)
E_S1_lass_10_null = Est_sim_lass(M, D_S1_10_null)
clusterSetRNGStream(cl, 20201014)
E_S1_lass_30_null = Est_sim_lass(M, D_S1_30_null)
clusterSetRNGStream(cl, 20201015)
E_S1_lass_50_null = Est_sim_lass(M, D_S1_50_null)
clusterSetRNGStream(cl, 20210308)
E_S1_lass_70_null = Est_sim_lass(M, D_S1_70_null)

#S2
clusterSetRNGStream(cl, 20201016)
E_S2_lass_10_null = Est_sim_lass(M, D_S2_10_null)
clusterSetRNGStream(cl, 20201017)
E_S2_lass_30_null = Est_sim_lass(M, D_S2_30_null)
clusterSetRNGStream(cl, 20201018)
E_S2_lass_50_null = Est_sim_lass(M, D_S2_50_null)
clusterSetRNGStream(cl, 20210309)
E_S2_lass_70_null = Est_sim_lass(M, D_S2_70_null)

#S3
clusterSetRNGStream(cl, 20201019)
E_S3_lass_10_null = Est_sim_lass(M, D_S3_10_null)
clusterSetRNGStream(cl, 20201020)
E_S3_lass_30_null = Est_sim_lass(M, D_S3_30_null)
clusterSetRNGStream(cl, 20201021)
E_S3_lass_50_null = Est_sim_lass(M, D_S3_50_null)
clusterSetRNGStream(cl, 20210310)
E_S3_lass_70_null = Est_sim_lass(M, D_S3_70_null)

#S4
clusterSetRNGStream(cl, 20210311)
E_S4_lass_10_null = Est_sim_lass(M, D_S4_10_null)
clusterSetRNGStream(cl, 20210312)
E_S4_lass_30_null = Est_sim_lass(M, D_S4_30_null)
clusterSetRNGStream(cl, 20210313)
E_S4_lass_50_null = Est_sim_lass(M, D_S4_50_null)
clusterSetRNGStream(cl, 20210314)
E_S4_lass_70_null = Est_sim_lass(M, D_S4_70_null)

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

#S4 and 70% pleiotropy
clusterSetRNGStream(cl, 20210413)
E_S1_med_70 = Est_sim_med(M, D_S1_70)
clusterSetRNGStream(cl, 20210414)
E_S2_med_70 = Est_sim_med(M, D_S2_70)
clusterSetRNGStream(cl, 20210415)
E_S3_med_70 = Est_sim_med(M, D_S3_70)
clusterSetRNGStream(cl, 20210416)
E_S4_med_10 = Est_sim_med(M, D_S4_10)
clusterSetRNGStream(cl, 20210417)
E_S4_med_30 = Est_sim_med(M, D_S4_30)
clusterSetRNGStream(cl, 20210418)
E_S4_med_50 = Est_sim_med(M, D_S4_50)
clusterSetRNGStream(cl, 20210419)
E_S4_med_70 = Est_sim_med(M, D_S4_70)

clusterSetRNGStream(cl, 20210420)
E_S1_med_70_null = Est_sim_med(M, D_S1_70_null)
clusterSetRNGStream(cl, 20210421)
E_S2_med_70_null = Est_sim_med(M, D_S2_70_null)
clusterSetRNGStream(cl, 20210422)
E_S3_med_70_null = Est_sim_med(M, D_S3_70_null)
clusterSetRNGStream(cl, 20210423)
E_S4_med_10_null = Est_sim_med(M, D_S4_10_null)
clusterSetRNGStream(cl, 20210424)
E_S4_med_30_null = Est_sim_med(M, D_S4_30_null)
clusterSetRNGStream(cl, 20210425)
E_S4_med_50_null = Est_sim_med(M, D_S4_50_null)
clusterSetRNGStream(cl, 20210426)
E_S4_med_70_null = Est_sim_med(M, D_S4_70_null)

################################################################################
#Mediator scenario
################################################################################
E_S1_10_meta_med = Est_sim_meta(M, D_S1_10_med)
E_S1_30_meta_med = Est_sim_meta(M, D_S1_30_med)
E_S1_50_meta_med = Est_sim_meta(M, D_S1_50_med)

#S2
E_S2_10_meta_med = Est_sim_meta(M, D_S2_10_med)
E_S2_30_meta_med = Est_sim_meta(M, D_S2_30_med)
E_S2_50_meta_med = Est_sim_meta(M, D_S2_50_med)

#S3
E_S3_10_meta_med = Est_sim_meta(M, D_S3_10_med)
E_S3_30_meta_med = Est_sim_meta(M, D_S3_30_med)
E_S3_50_meta_med = Est_sim_meta(M, D_S3_50_med)

#S4
E_S4_10_meta_med = Est_sim_meta(M, D_S4_10_med)
E_S4_30_meta_med = Est_sim_meta(M, D_S4_30_med)
E_S4_50_meta_med = Est_sim_meta(M, D_S4_50_med)

################################################################################
#theta = 0
#IVW, Egger & Robust estimates
#S1
E_S1_10_null_meta_med = Est_sim_meta(M, D_S1_10_null_med)
E_S1_30_null_meta_med = Est_sim_meta(M, D_S1_30_null_med)
E_S1_50_null_meta_med = Est_sim_meta(M, D_S1_50_null_med)

#S2
E_S2_10_null_meta_med = Est_sim_meta(M, D_S2_10_null_med)
E_S2_30_null_meta_med = Est_sim_meta(M, D_S2_30_null_med)
E_S2_50_null_meta_med = Est_sim_meta(M, D_S2_50_null_med)

#S3
E_S3_10_null_meta_med = Est_sim_meta(M, D_S3_10_null_med)
E_S3_30_null_meta_med = Est_sim_meta(M, D_S3_30_null_med)
E_S3_50_null_meta_med = Est_sim_meta(M, D_S3_50_null_med)

################################################################################
#Mediator scenario Lasso Estimates
################################################################################
#theta = 0.2
#S1
clusterSetRNGStream(cl, 20210422)
E_S1_lass_10_med = Est_sim_lass(M, D_S1_10_med)
E_S1_lass_30_med = Est_sim_lass(M, D_S1_30_med)
E_S1_lass_50_med = Est_sim_lass(M, D_S1_50_med)

#S2
E_S2_lass_10_med = Est_sim_lass(M, D_S2_10_med)
E_S2_lass_30_med = Est_sim_lass(M, D_S2_30_med)
E_S2_lass_50_med = Est_sim_lass(M, D_S2_50_med)

#S3
E_S3_lass_10_med = Est_sim_lass(M, D_S3_10_med)
E_S3_lass_30_med = Est_sim_lass(M, D_S3_30_med)
E_S3_lass_50_med = Est_sim_lass(M, D_S3_50_med)

#theta = 0
#S1
clusterSetRNGStream(cl, 20210423)
E_S1_lass_10_med_null = Est_sim_lass(M, D_S1_10_null_med)
E_S1_lass_30_med_null = Est_sim_lass(M, D_S1_30_null_med)
E_S1_lass_50_med_null = Est_sim_lass(M, D_S1_50_null_med)

#S2
E_S2_lass_10_med_null = Est_sim_lass(M, D_S2_10_null_med)
E_S2_lass_30_med_null = Est_sim_lass(M, D_S2_30_null_med)
E_S2_lass_50_med_null = Est_sim_lass(M, D_S2_50_null_med)

#S3
E_S3_lass_10_med_null = Est_sim_lass(M, D_S3_10_null_med)
E_S3_lass_30_med_null = Est_sim_lass(M, D_S3_30_null_med)
E_S3_lass_50_med_null = Est_sim_lass(M, D_S3_50_null_med)

################################################################################
#Mediator scenario LAD Estimates
################################################################################

#theta = 0.2
#S1
clusterSetRNGStream(cl, 20210424)
E_S1_med_10_med = Est_sim_med(M, D_S1_10_med)
E_S1_med_30_med = Est_sim_med(M, D_S1_30_med)
E_S1_med_50_med = Est_sim_med(M, D_S1_50_med)

#S2
E_S2_med_10_med = Est_sim_med(M, D_S2_10_med)
E_S2_med_30_med = Est_sim_med(M, D_S2_30_med)
E_S2_med_50_med = Est_sim_med(M, D_S2_50_med)

#S3
E_S3_med_10_med = Est_sim_med(M, D_S3_10_med)
E_S3_med_30_med = Est_sim_med(M, D_S3_30_med)
E_S3_med_50_med = Est_sim_med(M, D_S3_50_med)

#theta = 0
#S1
clusterSetRNGStream(cl, 20210425)
E_S1_med_10_med_null = Est_sim_med(M, D_S1_10_null_med)
E_S1_med_30_med_null = Est_sim_med(M, D_S1_30_null_med)
E_S1_med_50_med_null = Est_sim_med(M, D_S1_50_null_med)

#S2
E_S2_med_10_med_null = Est_sim_med(M, D_S2_10_null_med)
E_S2_med_30_med_null = Est_sim_med(M, D_S2_30_null_med)
E_S2_med_50_med_null = Est_sim_med(M, D_S2_50_null_med)

#S3
E_S3_med_10_med_null = Est_sim_med(M, D_S3_10_null_med)
E_S3_med_30_med_null = Est_sim_med(M, D_S3_30_null_med)
E_S3_med_50_med_null = Est_sim_med(M, D_S3_50_null_med)

################################################################################
#Mediator scenario MR-PRESSO Estimates
################################################################################

#theta = 0.2
#S1
clusterSetRNGStream(cl, 20210426)
E_S1_pres_10_med = Est_sim_mrpresso(M, D_S1_10_med)
E_S1_pres_30_med = Est_sim_mrpresso(M, D_S1_30_med)
E_S1_pres_50_med = Est_sim_mrpresso(M, D_S1_50_med)

#S2
E_S2_pres_10_med = Est_sim_mrpresso(M, D_S2_10_med)
E_S2_pres_30_med = Est_sim_mrpresso(M, D_S2_30_med)
E_S2_pres_50_med = Est_sim_mrpresso(M, D_S2_50_med)

#S3
E_S3_pres_10_med = Est_sim_mrpresso(M, D_S3_10_med)
E_S3_pres_30_med = Est_sim_mrpresso(M, D_S3_30_med)
E_S3_pres_50_med = Est_sim_mrpresso(M, D_S3_50_med)

#theta = 0
#S1
clusterSetRNGStream(cl, 20210427)
E_S1_pres_10_med_null = Est_sim_mrpresso(M, D_S1_10_null_med)
E_S1_pres_30_med_null = Est_sim_mrpresso(M, D_S1_30_null_med)
E_S1_pres_50_med_null = Est_sim_mrpresso(M, D_S1_50_null_med)

#S2
E_S2_pres_10_med_null = Est_sim_mrpresso(M, D_S2_10_null_med)
E_S2_pres_30_med_null = Est_sim_mrpresso(M, D_S2_30_null_med)
E_S2_pres_50_med_null = Est_sim_mrpresso(M, D_S2_50_null_med)

#S3
E_S3_pres_10_med_null = Est_sim_mrpresso(M, D_S3_10_null_med)
E_S3_pres_30_med_null = Est_sim_mrpresso(M, D_S3_30_null_med)
E_S3_pres_50_med_null = Est_sim_mrpresso(M, D_S3_50_null_med)

################################################################################
#LAD Estimates alternative CIs
################################################################################

#theta = 0.2
#S1
clusterSetRNGStream(cl, 20210428)
E_S1_med_10_CI = Est_sim_med_CI(M, D_S1_10)
E_S1_med_30_CI = Est_sim_med_CI(M, D_S1_30)
E_S1_med_50_CI = Est_sim_med_CI(M, D_S1_50)

#S2
E_S2_med_10_CI = Est_sim_med_CI(M, D_S2_10)
E_S2_med_30_CI = Est_sim_med_CI(M, D_S2_30)
E_S2_med_50_CI = Est_sim_med_CI(M, D_S2_50)

#S3
E_S3_med_10_CI = Est_sim_med_CI(M, D_S3_10)
E_S3_med_30_CI = Est_sim_med_CI(M, D_S3_30)
E_S3_med_50_CI = Est_sim_med_CI(M, D_S3_50)

#theta = 0
#S1
clusterSetRNGStream(cl, 20210429)
E_S1_med_10_CI_null = Est_sim_med_CI(M, D_S1_10_null)
E_S1_med_30_CI_null = Est_sim_med_CI(M, D_S1_30_null)
E_S1_med_50_CI_null = Est_sim_med_CI(M, D_S1_50_null)

#S2
E_S2_med_10_CI_null = Est_sim_med_CI(M, D_S2_10_null)
E_S2_med_30_CI_null = Est_sim_med_CI(M, D_S2_30_null)
E_S2_med_50_CI_null = Est_sim_med_CI(M, D_S2_50_null)

#S3
E_S3_med_10_CI_null = Est_sim_med_CI(M, D_S3_10_null)
E_S3_med_30_CI_null = Est_sim_med_CI(M, D_S3_30_null)
E_S3_med_50_CI_null = Est_sim_med_CI(M, D_S3_50_null)

stopCluster(cl)

################################################################################
#MR PRESSO Estimates
################################################################################

#library(MRPRESSO)
library(parallel)
cl = makeCluster(4)
clusterEvalQ(cl)
M = 1000
clusterExport(cl, c('M', 'Est_sim_mrpresso', 'mr_presso',
                    'D_S1_10', 'D_S1_30', 'D_S1_50',
                    'D_S2_10', 'D_S2_30', 'D_S2_50',
                    'D_S3_10', 'D_S3_30', 'D_S3_50'))
clusterSetRNGStream(cl, 20190501)

#theta = 0.2
#S1
clusterSetRNGStream(cl, 20200513)
E_S1_pres_10 = Est_sim_mrpresso(M, D_S1_10)
clusterSetRNGStream(cl, 20200514)
E_S1_pres_30 = Est_sim_mrpresso(M, D_S1_30)
clusterSetRNGStream(cl, 20200515)
E_S1_pres_50 = Est_sim_mrpresso(M, D_S1_50)

#S2
clusterSetRNGStream(cl, 20200516)
E_S2_pres_10 = Est_sim_mrpresso(M, D_S2_10)
clusterSetRNGStream(cl, 20200517)
E_S2_pres_30 = Est_sim_mrpresso(M, D_S2_30)
clusterSetRNGStream(cl, 20200518)
E_S2_pres_50 = Est_sim_mrpresso(M, D_S2_50)

#S3
clusterSetRNGStream(cl, 20200519)
E_S3_pres_10 = Est_sim_mrpresso(M, D_S3_10)
clusterSetRNGStream(cl, 20200520)
E_S3_pres_30 = Est_sim_mrpresso(M, D_S3_30)
clusterSetRNGStream(cl, 20200521)
E_S3_pres_50 = Est_sim_mrpresso(M, D_S3_50)

################################################################################
#theta = 0
clusterExport(cl, c('M', 'D_S1_10_null', 'D_S1_30_null', 'D_S1_50_null',
                    'D_S2_10_null', 'D_S2_30_null', 'D_S2_50_null',
                    'D_S3_10_null', 'D_S3_30_null', 'D_S3_50_null'))
#S1
clusterSetRNGStream(cl, 20200613)
E_S1_pres_10_null = Est_sim_mrpresso(M, D_S1_10_null)
clusterSetRNGStream(cl, 20200614)
E_S1_pres_30_null = Est_sim_mrpresso(M, D_S1_30_null)
clusterSetRNGStream(cl, 20200615)
E_S1_pres_50_null = Est_sim_mrpresso(M, D_S1_50_null)

#S2
clusterSetRNGStream(cl, 20200616)
E_S2_pres_10_null = Est_sim_mrpresso(M, D_S2_10_null)
clusterSetRNGStream(cl, 20200617)
E_S2_pres_30_null = Est_sim_mrpresso(M, D_S2_30_null)
clusterSetRNGStream(cl, 20200618)
E_S2_pres_50_null = Est_sim_mrpresso(M, D_S2_50_null)

#S3
clusterSetRNGStream(cl, 20200619)
E_S3_pres_10_null = Est_sim_mrpresso(M, D_S3_10_null)
clusterSetRNGStream(cl, 20200620)
E_S3_pres_30_null = Est_sim_mrpresso(M, D_S3_30_null)
clusterSetRNGStream(cl, 20200621)
E_S3_pres_50_null = Est_sim_mrpresso(M, D_S3_50_null)

stopCluster(cl)

cl = makeCluster(6)
clusterEvalQ(cl, library(MASS))
clusterEvalQ(cl, library(MendelianRandomization))
M = 1000
clusterExport(cl, c('M', 'Est_sim_mrpresso', 'mr_presso',
                    'D_S1_70', 'D_S2_70', 'D_S3_70', 'D_S4_10', 'D_S4_30',
                    'D_S4_50', 'D_S4_70', 'D_S1_70_null', 'D_S2_70_null',
                    'D_S3_70_null', 'D_S4_10_null', 'D_S4_30_null',
                    'D_S4_50_null', 'D_S4_70_null'))

clusterSetRNGStream(cl, 20210413)
E_S1_pres_70 = Est_sim_mrpresso(M, D_S1_70)
clusterSetRNGStream(cl, 20210414)
E_S2_pres_70 = Est_sim_mrpresso(M, D_S2_70)
clusterSetRNGStream(cl, 20210415)
E_S3_pres_70 = Est_sim_mrpresso(M, D_S3_70)
clusterSetRNGStream(cl, 20210416)
E_S4_pres_10 = Est_sim_mrpresso(M, D_S4_10)
clusterSetRNGStream(cl, 20210417)
E_S4_pres_30 = Est_sim_mrpresso(M, D_S4_30)
clusterSetRNGStream(cl, 20210418)
E_S4_pres_50 = Est_sim_mrpresso(M, D_S4_50)
clusterSetRNGStream(cl, 20210419)
E_S4_pres_70 = Est_sim_mrpresso(M, D_S4_70)

clusterSetRNGStream(cl, 20210420)
E_S1_pres_70_null = Est_sim_mrpresso(M, D_S1_70_null)
clusterSetRNGStream(cl, 20210421)
E_S2_pres_70_null = Est_sim_mrpresso(M, D_S2_70_null)
clusterSetRNGStream(cl, 20210422)
E_S3_pres_70_null = Est_sim_mrpresso(M, D_S3_70_null)
clusterSetRNGStream(cl, 20210423)
E_S4_pres_10_null = Est_sim_mrpresso(M, D_S4_10_null)
clusterSetRNGStream(cl, 20210424)
E_S4_pres_30_null = Est_sim_mrpresso(M, D_S4_30_null)
clusterSetRNGStream(cl, 20210425)
E_S4_pres_50_null = Est_sim_mrpresso(M, D_S4_50_null)
clusterSetRNGStream(cl, 20210426)
E_S4_pres_70_null = Est_sim_mrpresso(M, D_S4_70_null)

stopCluster(cl)
