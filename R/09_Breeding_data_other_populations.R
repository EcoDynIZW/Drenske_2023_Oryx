#### Morocco ####
round(mean(c(1.3,1.4,0.6,1.2,1.3,1.3,0.9,1.3,1.7,1.8,1.0,1.2,1.2)), digits = 2)
round(sd(c(1.3,1.4,0.6,1.2,1.3,1.3,0.9,1.3,1.7,1.8,1.0,1.2,1.2)), digits = 2)

## breeding females Morocco
round(mean(c(67.9,69.1,64.5,59.6,54.5,54.6,47.1,58.6,78.3,66.2,58.4,73.6,61.0)))


## Survival Morocco
round(mean(c(0.77,0.65,0.89,0.77,0.79,0.81,0.77,0.74,0.84,0.72,0.59,0.92)), digits = 2)

#### Turkey ####
round(mean(c(1.7,1.7,1.8,1.2,1.4,1.4,1.5,1.5,1.3,1.4,1.6,1.4,1.9)), digits = 2)
round(sd(c(1.7,1.7,1.8,1.2,1.4,1.4,1.5,1.5,1.3,1.4,1.6,1.4,1.9)), digits = 2)

#### Syria ####
fledg_syr <- c(3,7,4,0,6,5,0,0,1,2)# last numbers in the paper is 0
nests_syr <- c(3,3,2,2,2,2,2,2,1,1)# last numbers in the paper is 0
fledg_nest <- fledg_syr/nests_syr
fledg_nest
round(mean(fledg_nest), digits = 2)
round(sd(fledg_nest), digits = 2)

#### Rosegg ####
round(mean(c(2.0,2.3,1.6,2.5,2.3,2.3,1.9,0.8,0.8,2.3,2.5,2.7)), digits = 2)
round(sd(c(2.0,2.3,1.6,2.5,2.3,2.3,1.9,0.8,0.8,2.3,2.5,2.7)), digits = 2)

#### KLF, Grünau ####
round(mean(c(0.5,0.6,0.2,1.3,1.2,1.3,1.1,1.1,1.4,1.5,1.4,2.0,2.5,1.2,1.4,1.4)), digits = 2)
round(sd(c(0.5,0.6,0.2,1.3,1.2,1.3,1.1,1.1,1.4,1.5,1.4,2.0,2.5,1.2,1.4,1.4)), digits = 2)

#### Spain, Proyecto eremita ####

# Numbers of all colonies
# 2008: 1.0
# 2009: 1.0
# 2010: 0.0
# 2011: 1.3 + 0.3 = 1.6
# 2012: 0.3
# 2013:1.1
# 2014:1.0 + 2.0 = 3.0
# 2015:1.2 + 1.0 = 2.2
# 2016:1.4 + 0.0 = 1.4
# 2017:1.1 + 2.0 = 3.1
# 2018:2.1 + 1.3 = 3.4

round(mean(c(1.0,1.0,0.0,1.6,0.3,1.1,3.0,2.2,1.4,3.1,3.4)), digits = 2)
round(sd(c(1.0,1.0,0.0,1.6,0.3,1.1,3.0,2.2,1.4,3.1,3.4)), digits = 2)

# NICHT SO BERECHNENE WIE OBEN SONDERN wirklich pro Jahr rechnen: Nester pro jahr zusammenzählen und fledglings pro jahr über die verschiedenen Kolonien. Danach

# Numbers of actual colonies
# Spain, Proyecto eremita

# 2011: 1.3
# 2012: 0.3
# 2013:1.1
# 2014:1.0 + 2.0 = 3.0
# 2015:1.2 + 1.0 = 2.2
# 2016:1.4 + 0.0 = 1.4
# 2017:1.1 + 2.0 = 3.1
# 2018:2.1 + 1.3 = 3.4

round(mean(c(1.3,0.3,1.1,3.0,2.2,1.4,3.1,3.4)), digits = 2)
round(sd(c(1.3,0.3,1.1,3.0,2.2,1.4,3.1,3.4)), digits = 2)

####  Crested Ibis, ####
