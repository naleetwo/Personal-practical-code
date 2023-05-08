#### 실습1 ####
# 주제 : 담배값을 인상 정의 월별 매출액과 인상 후의 월별 매출액의 관계가 있나?
# 담배값과 매출액의 관계가 잇는가?

x <- c(70, 72, 62, 64, 71, 76, 0, 65, 75, 72)
y <- c(70, 74, 65, 68, 72, 74, 61, 66, 76, 75)

?cor
cor(x, y, method = "pearson")
cor(x, y, method = "spearman")
cor(x, y, method = "kendall")

cor.test(x, y, method = "pearson")

#### 실습2 ####
# 주제: 인구 증가율과 노령 인구 비율간의 관계가 있는가?
# pop_growth: 인구 증가율
# eldery_rate : 노령 인구 비율
# finance : 재정 자립도
# culture_center : 인구 10만명당 문화기반 시설 수

mydata <- read.csv("C:/seokwonna/Rwork/data/cor.csv", fileEncoding = 'euc-kr')
View(mydata)

plot(mydata$pop_growth, mydata$elderly_rate)

cor(mydata$pop_growth, mydata$elderly_rate, method = "pearson")
# ~0.3/0.3~0.6/0.6~

attach(mydata)
x <- cbind(pop_growth, birth_rate, elderly_rate, finacnce, cultural_center)
x
cor(x)
detach(mydata)

#### 실습 3 ####
install.packages("UsingR")
library(UsingR)

str(galton)

plot(child ~ parent, data = galton) 

cor.test(galton$child, galton$parent)

out <- lm(child~parent, data = galton)
summary(out)

abline(out, col = "red")

sunflowerplot(galton)

#jitter - data 흩뿌리는 함수()
plot(jitter(child, 5) ~ jitter(parent,5),data = galton)

#### 실습 4 ####
# 세 관측소에서 관측한 오존농도, 일산화질소, 이산화질소를 30분마다 측정한 값

install.packages("SwissAir")
library(SwissAir)     

View(AirQual)

Ox <- AirQual[ , c("ad.O3", "lu.O3", "sz.O3")] + 
  AirQual[ , c("ad.NOx", "lu.NOx", "sz.NOx")] -
  AirQual[ , c("ad.NO", "lu.NO", "sz.NO")]
Ox
View(Ox)

names(Ox) <- c("ad", "lu", "sz")

plot(lu ~ sz, data = Ox)
#결측치가 있으면 상관관계가 NA로 나타난다, 결측치를 제거해야함
Ox <- na.omit(Ox)
cor(Ox$lu, Ox$sz)

#install.packages("hexbin")
library(hexbin)
bin <- hexbin(Ox$lu, Ox$sz, xbins = 50)
plot(bin)

smoothScatter(Ox$lu, Ox$sz)

install.packages("IDPmisc")
library(IDPmisc)
iplot(Ox$lu, Ox$sz)
