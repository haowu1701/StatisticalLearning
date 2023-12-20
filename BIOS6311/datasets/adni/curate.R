dx = read.csv('~/Box Sync/teaching/PMB/datasets/adni/DXSUM_PDXCONV_ADNIALL.csv')
hipp = read.csv('~/Box Sync/teaching/PMB/datasets/adni/UCSFSNTVOL.csv')

# match diagnosis from closest date
hipp$DX = NA
for(i in 1:nrow(hipp)){
  x = hipp[i, c('RID', 'EXAMDATE')]
  sdf = dx[ which(dx$RID==x[1,1]), ] 
  hipp$DX[i] = sdf$DXCURREN[ which.min(abs(as.Date(x[1,2]) - as.Date(sdf$EXAMDATE) )) ]
  }


hipp$DX = ifelse(hipp$DX==1, 'HC', ifelse(hipp$DX==2, 'MCI', 'AD'))

# checking the data make sense
t.test(hipp$LEFTHIPPO, hipp$RIGHTHIPPO, paired = T)
t.test(hipp$LEFTHIPPO[ hipp$DX=='HC'], hipp$LEFTHIPPO[ hipp$DX=='MCI'] )

saveRDS(hipp, file = '~/Box Sync/teaching/PMB/datasets/adni/hippocampus.rds')
