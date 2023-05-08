#### type1 : One Way ANOVA ####

library(moonBook)
View(acs)
str(acs)

# 진단 결과에 따라 저밀도 콜레스테롤 수치(LDLC)를 알고 싶다.
# 진단 결과(Dx) : STEMI(급성심근경색), NSTEMI(만성심근경색),
#                 unstable angina(협심증)

moonBook::densityplot(LDLC~Dx, data =acs)

#정규분포 확인

with(acs, shapiro.test(LDLC[Dx == "NSTEMI"]))
#p-value = 1.56e-08 < 0.05 / 정규분포 x
with(acs, shapiro.test(LDLC[Dx == "STEMI"]))
#p-value = 0.6066 > 0.05 / 정규분포 o
with(acs, shapiro.test(LDLC[Dx == "Unstable Angina"]))
#p-value = 2.136e-07 / 정규분포 x
# --> 정규분포 x

#정규분포를 확인하는 또 다른 방법 (ANOVA 일때)

out = aov(LDLC ~ Dx, data = acs)
out
#잔차값만 뽑아옴 residual standard error
shapiro.test(resid(out))

# 등분산 확인

bartlett.test(LDLC ~ Dx, data = acs)
# p-value = 0.1857 > 0.05

# anova 검정( 정규분포이고 등분산일 경우 )
out = aov(LDLC ~ Dx, data = acs)
summary(out)
#p value 0.00377 < 0.05 / 진단 결과에 따라 LDLC가 차이가 있다.
  
# 연속변수가 아니거나 정규분포가 아닌 경우
kruskal.test(LDLC ~ Dx, data = acs)
#p-value = 0.004669 <0.05 진단 결과에 따라 LDLC가 차이가 있다.

#등분산이 아닐 경우
?oneway.test
oneway.test(LDLC ~ Dx, data = acs, var.equal = FALSE)
# p-value = 0.007471 < 0.05 / 진단 결과에 따라 LDLC 값이 차잉가 있다.

### 사후 검정

# aov()를 사용했을 경우 : TukeyHSD()
TukeyHSD(out)

#kruskal.test()를 사용했을경우 
install.packages("pgirmess")
library(pgirmess)

kruskalmc(acs$LDLC, acs$Dx)
#결과표에 stat.signif TRUE, FALSE 값으로 알려줌

#oneway.test()를 사용했을 경우
install.packages("nparcomp")
library(nparcomp)

result <- mctp(LDLC ~ Dx, data = acs)
summary(result)


#### 실습1 ####
str(iris)
View(iris)

#주제 : 품종별로 Sepal.Width 의 평균 차이가 있는가?
#만약 있다면 어느 폼종과 차이가 있는가?

moonBook::densityplot(Sepal.Width~ Species, data =iris)

#정규분포를 확인하는 또 다른 방법 (ANOVA 일때)

out = aov(Sepal.Width~ Species, data =iris)
out
#잔차값만 뽑아옴 residual standard error
shapiro.test(resid(out))
#p-value = 0.323 > 0.05 정규분포 이다

# 등분산 확인

bartlett.test(Sepal.Width~ Species, data =iris)
#p-value = 0.3515 > 0.05 등분산이다

#ANOVA 검증
out = aov(Sepal.Width~ Species, data =iris)
summary(out)
#p-value = <2e-16, Sepal.Width 종별로 차이가 있다.

#사후 검정

# aov()를 사용했을 경우 : TukeyHSD()
TukeyHSD(out)
#kruskal.test()를 사용했을경우 
#install.packages("pgirmess")
library(pgirmess)
kruskalmc(iris$Sepal.Width, iris$Species)
#결과표에 stat.signif TRUE, FALSE 값으로 알려줌

#oneway.test()를 사용했을 경우
#install.packages("nparcomp")
library(nparcomp)
result <- mctp(Sepal.Width ~ Species, data = iris)
summary(result)


#### 실습2 ####
# 주제 : 시, 군, 구에 따라서 합계 출산유의 차이가 있는가?
# 있다면 어느 것과 차이가 있는가?

mydata <- read.csv("../data/anova_one_way.csv", fileEncoding = 'euc-kr')
View(mydata)
str(mydata)

moonBook::densityplot(birth_rate~ ad_layer, data =mydata)

#정규분포를 확인(ANOVA 일때)

out = aov(birth_rate~ ad_layer, data =mydata)
out
#잔차값만 뽑아옴 residual standard error
shapiro.test(resid(out))
#p-value = 5.788e-07 < 0.05, 정규분포가 아니다

# 등분산 확인

bartlett.test(birth_rate~ ad_layer, data =mydata)
# p-value = 9.659e-05 < 0.05 / 등분산이 같지 않다.


#정규분포 x, 등분산 x 이면 Welch's anova 검증
oneway.test(birth_rate~ ad_layer, data =mydata, var.equal = FALSE)
# p-value < 2.2e-16 < 0.05 / 시, 군, 구에 따라 출생율 차이가 있다.

#사후 검증

#oneway.test()를 사용했을 경우
#install.packages("nparcomp")
library(nparcomp)
result <- mctp(birth_rate~ ad_layer, data =mydata)
summary(result)
#자치구;1, 자치군;2, 자치시;3
#2 - 1 p.value = 1.110223e-16 < 0.05
#3 - 1 p.value = 1.332268e-15 < 0.05
#3 - 2 p.value = 2.256839e-01 > 0.05

kruskalmc(mydata$birth_rate, mydata$ad_layer)
TukeyHSD(out)


#### 실습3 ####
# 실습 데이터 : https://www.kaggle.com
library(dplyr)

telco <- read.csv("../data/Telco-Customer-Churn.csv", header = T)
str(telco)
View(telco)

# 주제 : 지불 방식별로 총 지불금액이 차이가 있는가?
# 있다면 무엇과 차이가 있는가?
# 지불 방식 (PaymentMethod) : Bank transfer, Credit Card, Electronic check, Mailed check
# 총 지불금액 (TotalCharges)

moonBook::densityplot(TotalCharges~ PaymentMethod, data =telco)

#정규분포를 확인(ANOVA 일때)
out = aov(TotalCharges~ PaymentMethod, data =telco)
out
#잔차값만 뽑아옴 residual standard error
shapiro.test(resid(out))
str(telco)

with(telco, shapiro.test(TotalCharges[PaymentMethod == "Electronic check"]))
#p-value < 2.2e-16 < 0.05 / 정규분포 x
with(telco, shapiro.test(TotalCharges[PaymentMethod == "Mailed check"]))
#p-value < 2.2e-16 < 0.05 / 정규분포 x
with(telco, shapiro.test(TotalCharges[PaymentMethod == "Credit card (automatic)
"]))

with(telco, shapiro.test(TotalCharges[PaymentMethod == "Bank transfer (automatic)"]))
# p-value < 2.2e-16 < 0.05 /정규분포 x

# 등분산 확인

bartlett.test(TotalCharges ~ PaymentMethod, data =telco)
# p-value < 2.2e-16 < 0.05 / 등분산 x

oneway.test(TotalCharges~ PaymentMethod, data =telco, var.equal = FALSE)
#p-value < 2.2e-16 < 0.05

kruskalmc(telco$TotalCharges, telco$PaymentMethod)

# 각 지불방식별로 인원수와 평균 금액을 조회
unique(telco$PaymentMethod)
table(telco$PaymentMethod)

result <- telco %>% select(PaymentMethod, TotalCharges) %>%
  group_by(PaymentMethod) %>% 
  summarise(count = n(), mean_payment = mean(TotalCharges, na.rm = T))
result

# 그래프로 확인
moonBook::densityplot(TotalCharges~ PaymentMethod, data =telco)

with(telco, shapiro.test(TotalCharges[PaymentMethod == "Electronic check"]))
#p-value < 2.2e-16 < 0.05 / 정규분포 x
with(telco, shapiro.test(TotalCharges[PaymentMethod == "Mailed check"]))
#p-value < 2.2e-16 < 0.05 / 정규분포 x
with(telco, shapiro.test(TotalCharges[PaymentMethod == "Credit card (automatic)
"])) 
#샘플이 5000개가 넘어감면 정규분포에 도달하기때문에 검증할 필요가 없음
with(telco, shapiro.test(TotalCharges[PaymentMethod == "Bank transfer (automatic)"]))
# p-value < 2.2e-16 < 0.05 /정규분포 x

#정규분포를 확인(ANOVA 일때)
out = aov(TotalCharges~ PaymentMethod, data =telco)
out
#잔차값만 뽑아옴 residual standard error
shapiro.test(resid(out))

# 앤더슨 달링 테스트 

# 등분산 여부
bartlett.test(TotalCharges ~ PaymentMethod, data = telco)

# Welch's anova
oneway.test(TotalCharges~ PaymentMethod, data =telco, var.equal = FALSE)
#p-value < 2.2e-16 < 0.05

#사후 검정

result <- mctp(TotalCharges~ PaymentMethod, data =telco)
summary(result)

plot(result)

# 만약 정규분포가 아니라는 상황이서 테스트 
kruskal.test(TotalCharges~ PaymentMethod, data = telco)

kruskalmc(telco$TotalCharges, telco$PaymentMethod)

library(ggplot2)
ggplot(mydata, aes(birth_rate, ad_layer, col = "multichild")) + geom_boxplot()


#### type 2 : Two way ANOVA ####



mydata <- read.csv("../data/anova_two_way.csv", fileEncoding = "euc-kr")
View(mydata)
str(mydata)

out <- aov(birth_rate ~ ad_layer + multichild + ad_layer:multichild, data = mydata)
shapiro.test(resid(out))

summary(out)

#ad_layer:multichild 교차검증시 사용

#사후 검정
result <- TukeyHSD(out)
result

#자치구:YES-자치구:NO   0.03739375 -0.26402560  0.33881310 0.9992350
#자치시:YES-자치구:NO   0.20992708 -0.06721660  0.48707076 0.2524103
#자치시:NO-자치군:NO   -0.07300111 -0.18027855  0.03427632 0.3709479
#자치구:YES-자치군:NO  -0.29530256 -0.59475532  0.00415019 0.0557066
#자치시:YES-자치군:NO  -0.12276923 -0.39777277  0.15223431 0.7938268
#자치구:YES-자치시:NO  -0.22230145 -0.52292838  0.07832548 0.2778173
#자치시:YES-자치시:NO  -0.04976812 -0.32604976  0.22651353 0.9954370
#자치시:YES-자치구:YES  0.17253333 -0.22052525  0.56559192 0.8052735

#시나 구에 다자녀 지원정책이 출산율에 대해 영향을 미치지 않지만
#군에 다자녀 지원정책을 할경우 출산율을 높일 수 있다.


#### 실습4 ####

telco <- read.csv("../data/Telco-Customer-Churn.csv", header = T)
str(telco)
View(telco)

#contract 포함 two way anova 
#원인(독립) 변수 : PaymentMethod, contract
#결과(종속) 변수 : TotalCharges

moonBook::densityplot(TotalCharges~ PaymentMethod, data =telco)
moonBook::densityplot(TotalCharges~ Contract, data =telco)

#등분산 체크
bartlett.test(TotalCharges~ PaymentMethod, data =telco)
bartlett.test(TotalCharges~ Contract, data =telco)
#등분산 x

shapiro.test(resid(out))
str(telco)

oneway.test(TotalCharges~ PaymentMethod + Contract + PaymentMethod:Contract, data = telco, var.equal = F)
#if 등분산이라고 가정
out <- aov(TotalCharges~ PaymentMethod + Contract + PaymentMethod:Contract, data = telco)
summary(out)
#사후 검정

result <- TukeyHSD(out)
result

library(ggplot2)
ggplot(telco, aes(PaymentMethod, TotalCharges, col = Contract)) + geom_boxplot()

#mailed check 는 contract에 영향을 받지 않는다.
#bank transfer, credit card, electronic check payment 방식은 1년이상으로 결제하는게 효율적이다.
#mailed check 고객이 적기 때문에 payment 방식을 bank transfer, credit card, electronic check payment 로 줄이는 것이 서비스 유지에 효율적으로 보인다.

#=========================================================================#
# Bank transfer (automatic)와 Credit card (automatic)는 계약 기간과 무관하게 차이가 없다.
# 즉, Two year면서 Electronic check로 가입을 하는 고객들이 많은 금액을 지불한다고 보여지므로 이쪽을 권유해야 한다.
# 반대로 Month-to-monthd이면서 Mailed check인 고객들은 금방 해지하는 경향이 크므로 가입시 피하도록 권유해야 한다.

#2년 계약 electronic check  고객들을 유치하는 한편, mailed check 지불방식의 고객들은 계약기간에 상관없이 낮은 요금을 사용하는 것을 고려, 고객들을 위한 저비용이 서비스를 제공하여  가입기간의 장기화를 계획해야한다.

# 일반적으로 모든 지불방식에서 달별 계약, 1년 계약, 2년 계약 순으로 지불 금액이 크다. 
# 지불 방식에서 mailed check 지불 방식이 다른 지불방식들에 비해 지불 금액이 낮다.
# 계약기간 중 1년계약, 2년계약에서 electronic check가 다른 지불방식보다 지불 금액이 높다.
#따라서 mailed check 지불방식을 사용하지 않도록 유도하고 1년, 2년 계약 시 electronic check를 사용하도록 유도해야한다

#mailed check 는 contract에 영향을 받지 않는다.
#bank transfer, credit card, electronic check payment 방식은 1년이상으로 결제하는게 효율적이다.
#mailed check 고객이 적기 때문에 payment 방식을 bank transfer, credit card, electronic check payment 로 줄이는 것이 서비스 유지에 효율적으로 보인다.


#자동이체나 자동결제하는 사람들은 꾸준한 소득이 있어서 자동이체를 해도 괜찮은 사람들로 보여서 안정적인 직업이 있다고 볼 수 있다. 
#반면에 month-to-month는 불안전한 소득인 사람이거나 일시적인 체류자들로 보여진다. 
#결국 안정적인 직장인 위주로 가입자를 받는 것이 좋을 것 같다.

# 어떤 결제 양식이든 2년 단위 구독이 가장 요금을 많이 벌어들인다고 추측할 수 있다.
# 우편 수표 지불의 경우 고객 수가 적은 만큼 각 Contract 별 차이가 적다.
# 그러나 나머지 지불 방식의 경우 월 단위 - 년 단위 - 2년 단위 순으로 Contract 별 요금 총액이 커진다.
# 특히 전자 수표 지불의 경우 가장 큰 Contract 별 차이를 보였다.
# 따라서 신규 고객 유치 및 기존 고객의 구독 기간 연장 시
# 월 단위 구독 보다는 1, 2년 단위 구독을 유도하는 것이 총 요금 증가에 긍정적인 영향를 미친다고 예측할 수 있다.
# 또한 추후 이용객 수도 적고 총 요금도 적은 우편 수표의 경우 폐지하거나 다른 지불 방식으로 변경하는 것을 유도할 필요가 있다.
#==============================================================================#

#### type 3: Repeated Measured ANOVA ####

# 주제 : 6명을 대상으로 운동능력향상의 차이가 있는지 알아보려고 한다.
df <- data.frame()
df <- edit(df)
df

means <- c(mean(df$pre),mean(df$three_month),mean(df$six_month))
means

plot(means, type = "o", lty = 2, col = 2)

#ANOVA 설치
#install.packages("car")
library(car)

#multimodles <- lapply(df[, c("pre", "three_month", "six_month")], function(x) lm(x~1, data = df))

multimodels <- lm(cbind(df$pre, df$three_month, df$six_month)~1)

trials <- factor(c("pre", "three_month", "six_month"), ordered = F)

model1 <- Anova(multimodels, idata = data.frame(trials) , idesign = ~trials, type ="III")

summary(model1, multivariate =F)
#aov(one way anova) 외에 특정한 anova를 테스트할때 쓰는 함수

# long 형으로 변경

library(tidyr)

dflong <- gather(df,key = "ID", value = 'SCORE', -id)
dflong

#사후 검정
with(dflong, pairwise.t.test(SCORE, ID, paired =T, 
                             p.adjust.method = 'bonferroni'))

#정규분포 확인 aov() 사용

out <- aov(SCORE ~ ID,data = dflong )
shapiro.test(reside(out))



#### 실습 5 ####
rm <- read.csv("../data/onewaysample.csv", header = T)
View(rm)

rm <- rm[, 2:6]
rm

means <- c(mean(rm$score0),
           mean(rm$score1),
           mean(rm$score3),
           mean(rm$score6))
means
plot(means, type = "o", lty = 2, col = 2)

multimodels <- lm(cbind(rm$score0, rm$score1, rm$score3, rm$score6)~1)

trials <- factor(c("score0", "score1", "score3", "score6"), ordered = F)

model1 <- Anova(multimodels, idata = data.frame(trials) , idesign = ~trials, type ="III")
#Mauchly Tests for Sphericity p-value, 0.25494 > 0.05
summary(model1, multivariate =F)

# long 형으로 변경

#library(tidyr)

rmlong <- gather(rm,key = "ID", value = 'SCORE', -id)
rmlong

#사후 검정
with(rmlong, pairwise.t.test(SCORE, ID, paired =T, 
                             p.adjust.method = 'bonferroni'))

#정규분포
out <- aov(SCORE~ID, data = rmlong)
shapiro.test(resid(out))

summary(out)

TukeyHSD(out)

## Friedman Test
?friedman.test

## Hollander & Wolfe (1973), p. 140ff.
## Comparison of three methods ("round out", "narrow angle", and
##  "wide angle") for rounding first base.  For each of 18 players
##  and the three method, the average time of two runs from a point on
##  the first base line 35ft from home plate to a point 15ft short of
##  second base is recorded.
RoundingTimes <-
  matrix(c(5.40, 5.50, 5.55,
           5.85, 5.70, 5.75,
           5.20, 5.60, 5.50,
           5.55, 5.50, 5.40,
           5.90, 5.85, 5.70,
           5.45, 5.55, 5.60,
           5.40, 5.40, 5.35,
           5.45, 5.50, 5.35,
           5.25, 5.15, 5.00,
           5.85, 5.80, 5.70,
           5.25, 5.20, 5.10,
           5.65, 5.55, 5.45,
           5.60, 5.35, 5.45,
           5.05, 5.00, 4.95,
           5.50, 5.50, 5.40,
           5.45, 5.55, 5.50,
           5.55, 5.55, 5.35,
           5.45, 5.50, 5.55,
           5.50, 5.45, 5.25,
           5.65, 5.60, 5.40,
           5.70, 5.65, 5.55,
           6.30, 6.30, 6.25),
         nrow = 22,
         byrow = TRUE,
         dimnames = list(1 : 22,
                         c("Round Out", "Narrow Angle", "Wide Angle")))
RoundingTimes
View(RoundingTimes)

library(reshape2)
rt <- melt(RoundingTimes)
rt

#정규분포 확인
out <- aov(value ~ Var2, data = rt)
shapiro.test(resid(out))
#p-value = 0.001112, 정규분포가 아니다

boxplot(value~ Var2, data = rt)

friedman.test(RoundingTimes)
#p-value = 0.003805 < 0.05, 차이가 있다

#사후 검정 -friedman test-
# https://www.r-statistics.com/2010/02/post-hoc-analysis-for-friedmans-test-r-code/
#-------------------------------------------------------------------------#
friedman.test.with.post.hoc <- function(formu, data, to.print.friedman = T, to.post.hoc.if.signif = T,  to.plot.parallel = T, to.plot.boxplot = T, signif.P = .05, color.blocks.in.cor.plot = T, jitter.Y.in.cor.plot =F)
#-------------------------------------------------------------------------#
{
  # formu is a formula of the shape:     Y ~ X | block
  # data is a long data.frame with three columns:    [[ Y (numeric), X (factor), block (factor) ]]
  
  # Note: This function doesn't handle NA's! In case of NA in Y in one of the blocks, then that entire block should be removed.
  
  
  # Loading needed packages
  if(!require(coin))
  {
    print("You are missing the package 'coin', we will now try to install it...")
    install.packages("coin")
    library(coin)
  }
  
  if(!require(multcomp))
  {
    print("You are missing the package 'multcomp', we will now try to install it...")
    install.packages("multcomp")
    library(multcomp)
  }
  
  if(!require(colorspace))
  {
    print("You are missing the package 'colorspace', we will now try to install it...")
    install.packages("colorspace")
    library(colorspace)
  }
  
  
  # get the names out of the formula
  formu.names <- all.vars(formu)
  Y.name <- formu.names[1]
  X.name <- formu.names[2]
  block.name <- formu.names[3]
  
  if(dim(data)[2] >3) data <- data[,c(Y.name,X.name,block.name)]    # In case we have a "data" data frame with more then the three columns we need. This code will clean it from them...
  
  # Note: the function doesn't handle NA's. In case of NA in one of the block T outcomes, that entire block should be removed.
  
  # stopping in case there is NA in the Y vector
  if(sum(is.na(data[,Y.name])) > 0) stop("Function stopped: This function doesn't handle NA's. In case of NA in Y in one of the blocks, then that entire block should be removed.")
  
  # make sure that the number of factors goes with the actual values present in the data:
  data[,X.name ] <- factor(data[,X.name ])
  data[,block.name ] <- factor(data[,block.name ])
  number.of.X.levels <- length(levels(data[,X.name ]))
  if(number.of.X.levels == 2) { warning(paste("'",X.name,"'", "has only two levels. Consider using paired wilcox.test instead of friedman test"))}
  
  # making the object that will hold the friedman test and the other.
  the.sym.test <- symmetry_test(formu, data = data,    ### all pairwise comparisons
                                teststat = "max",
                                xtrafo = function(Y.data) { trafo( Y.data, factor_trafo = function(x) { model.matrix(~ x - 1) %*% t(contrMat(table(x), "Tukey")) } ) },
                                ytrafo = function(Y.data){ trafo(Y.data, numeric_trafo = rank, block = data[,block.name] ) }
  )
  # if(to.print.friedman) { print(the.sym.test) }
  
  
  if(to.post.hoc.if.signif)
  {
    if(pvalue(the.sym.test) < signif.P)
    {
      # the post hoc test
      The.post.hoc.P.values <- pvalue(the.sym.test, method = "single-step")    # this is the post hoc of the friedman test
      
      
      # plotting
      if(to.plot.parallel & to.plot.boxplot)    par(mfrow = c(1,2)) # if we are plotting two plots, let's make sure we'll be able to see both
      
      if(to.plot.parallel)
      {
        X.names <- levels(data[, X.name])
        X.for.plot <- seq_along(X.names)
        plot.xlim <- c(.7 , length(X.for.plot)+.3)    # adding some spacing from both sides of the plot
        
        if(color.blocks.in.cor.plot)
        {
          blocks.col <- rainbow_hcl(length(levels(data[,block.name])))
        } else {
          blocks.col <- 1 # black
        }
        
        data2 <- data
        if(jitter.Y.in.cor.plot) {
          data2[,Y.name] <- jitter(data2[,Y.name])
          par.cor.plot.text <- "Parallel coordinates plot (with Jitter)"
        } else {
          par.cor.plot.text <- "Parallel coordinates plot"
        }
        
        # adding a Parallel coordinates plot
        matplot(as.matrix(reshape(data2,  idvar=X.name, timevar=block.name,
                                  direction="wide")[,-1])  ,
                type = "l",  lty = 1, axes = FALSE, ylab = Y.name,
                xlim = plot.xlim,
                col = blocks.col,
                main = par.cor.plot.text)
        axis(1, at = X.for.plot , labels = X.names) # plot X axis
        axis(2) # plot Y axis
        points(tapply(data[,Y.name], data[,X.name], median) ~ X.for.plot, col = "red",pch = 4, cex = 2, lwd = 5)
      }
      
      if(to.plot.boxplot)
      {
        # first we create a function to create a new Y, by substracting different combinations of X levels from each other.
        subtract.a.from.b <- function(a.b , the.data)
        {
          the.data[,a.b[2]] - the.data[,a.b[1]]
        }
        
        temp.wide <- reshape(data,  idvar=X.name, timevar=block.name,
                             direction="wide")     #[,-1]
        wide.data <- as.matrix(t(temp.wide[,-1]))
        colnames(wide.data) <- temp.wide[,1]
        
        Y.b.minus.a.combos <- apply(with(data,combn(levels(data[,X.name]), 2)), 2, subtract.a.from.b, the.data =wide.data)
        names.b.minus.a.combos <- apply(with(data,combn(levels(data[,X.name]), 2)), 2, function(a.b) {paste(a.b[2],a.b[1],sep=" - ")})
        
        the.ylim <- range(Y.b.minus.a.combos)
        the.ylim[2] <- the.ylim[2] + max(sd(Y.b.minus.a.combos))    # adding some space for the labels
        is.signif.color <- ifelse(The.post.hoc.P.values < .05 , "green", "grey")
        
        boxplot(Y.b.minus.a.combos,
                names = names.b.minus.a.combos ,
                col = is.signif.color,
                main = "Boxplots (of the differences)",
                ylim = the.ylim
        )
        legend("topright", legend = paste(names.b.minus.a.combos, rep(" ; PostHoc P.value:", number.of.X.levels),round(The.post.hoc.P.values,5)) , fill =  is.signif.color )
        abline(h = 0, col = "blue")
        
      }
      
      list.to.return <- list(Friedman.Test = the.sym.test, PostHoc.Test = The.post.hoc.P.values)
      if(to.print.friedman) {print(list.to.return)}
      return(list.to.return)
      
    }    else {
      print("The results where not significant, There is no need for a post hoc test")
      return(the.sym.test)
    }
  }
  
  # Original credit (for linking online, to the package that performs the post hoc test) goes to "David Winsemius", see:
  # http://tolstoy.newcastle.edu.au/R/e8/help/09/10/1416.html
}

#--------------------------------------------------------------------#
friedman.test.with.post.hoc(value ~ Var2 | Var1, rt)


#### Two Way Repeated Measured ANOVA ####
# 주제 : 시차별로 여드름에 대한 효능의 차이가 있는가?

df <- read.csv("C:/seokwonna/Rwork/data/10_rmanova.csv", header = T)
View(df)

#long 형으로 변경
library(reshape2)
dflong <- melt(df, id= c("group", "id"), variable.name = "time",
               value.name = "month",
               measure.vars = c("month0", "month1", "month3", "month6"))
dflong

#그래프화
interaction.plot(dflong$time, dflong$group, dflong$month)

#anova test
out <- aov(month ~ group*time, data = dflong)
#정규분포 확인
shapiro.test(resid(out))

#anova test, summary 
summary(out)

#사후 검정/ 두집단의 차이를 t-test로 각각 point를 비교

acl0 <- dflong[dflong$time == "month0", ]
acl1 <- dflong[dflong$time == "month1", ]
acl3 <- dflong[dflong$time == "month3", ]
acl6 <- dflong[dflong$time == "month6", ]

t.test(month ~ group, data = acl0)
#p-value = 0.8076 > 0.05, group 1과 2는 차이가 없다.
t.test(month ~ group, data = acl1)
#p-value = 0.01962 < 0.05, group 1과 2는 차이가 없다.
t.test(month ~ group, data = acl3)
#p-value = 0.0002795 < 0.05, group 1과 2는 차이가 있다.
t.test(month ~ group, data = acl6)
# p-value = 0.0009661 < 0.05, group 1과 2는 차이가 있다.

#Bonferroni correction(본페르니 교정을 통해서 다중 t-test p-value 값 보정)
#4C2
0.05/6 #0.008

