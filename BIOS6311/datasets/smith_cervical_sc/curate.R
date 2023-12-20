sc = as.data.frame(readxl::read_excel('~/Box Sync/teaching/PMB/datasets/smith_cervical_sc/Cervical_spinal_cord_MRI.xlsx'))
dim(sc)
mf = sc[ sc$Visit==1, c('ID', 'Sex', 'Age in months', 'C4 CSA', 'C3 CSA') ]
tp = sc[ sc$Visit==1, c('ID', 'C4 CSA') ]
tp2 = sc[ sc$Visit==2, c('ID', 'C4 CSA') ]
tp = merge( tp, tp2, by = 'ID', suffixes = c('_tp1', '_tp2'))

mf$`C4 CSA` = jitter(mf$`C4 CSA`, amount = .1 * sd(mf$`C4 CSA`))
mf$`C3 CSA` = jitter(mf$`C3 CSA`, amount = .1 * sd(mf$`C3 CSA`))
mf$`Age` = jitter(mf$`C3 CSA`, amount = 3)
tp$`C4 CSA_tp1` = jitter(tp$`C4 CSA_tp1`, amount = 0.1 * sd(tp$`C4 CSA_tp1`) )
tp$`C4 CSA_tp2` = jitter(tp$`C4 CSA_tp2`, amount = 0.1 * sd(tp$`C4 CSA_tp2`) )
save(tp, mf, file='~/Box Sync/teaching/PMB/datasets/smith_cervical_sc/tpmf.rdata')
