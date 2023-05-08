####단일(단순) 회귀 분석 ####
#  y = ax + b 

women
?women
str(women)
plot(weight ~ height, data = women)

fit <- lm(weight ~ height, data = women)
fit

abline(fit, col = 'blue')

summary(fit)
#R-squared:  0.9903 

cor.test(women$weight, women$height)
#      cor 0.9954948 

### 설명력을 검증하기 위한 그래프
plot(fit)

par(mfrow = c(2,2)) #그래프 2행 2열로
plot(fit) 
#첫번째 그래프 0을 중심으로 평행하게 선형성을 보기위한 그래프
#두번째 그래프 Q-Q -> 정규분포를 확인하기 위한 그래프
# 그래프에 가깝게 데이터가 모여어야 정규분포
#세번째 그래프 등분산
#네번째 이상치 확인

### 다항 회귀 분석(Polynomial Regression)
fit1 <- lm(weight ~ height + I(height^2), data = women)
summary(fit1)

plot(weight ~ height, data = women)
lines(women$height, fitted(fit1), col = "red")
#현상설명 목적으로 fitting model 을 그린다 / 머신러닝에서는 사용하지 않음

par(mfrow = c(2,2))
plot(fit1)

shapiro.test(resid(fit))
shapiro.test(resid(fit1))

#### 실습1 ####
# 주제 : 유치원 수가 많은 지역에 합계 출산율도 높은가?
# 또는 합계 출산율이 유치원 수에 영양을 받는가?

mydata <- read.csv("C:/seokwonna/Rwork/data/regression.csv", fileEncoding = "euc-kr")
View(mydata)

# social_welfare : 사회복지시설
# active_firms : 사업체 수
# urban_park : 도시공원
# doctor : 의사
# tris : 폐수 배출 업소
# kindergarten : 유치원

str(mydata)

fit <- lm(birth_rate ~ kindergarten, data = mydata)
summary(fit)
# Multiple R-squared:  0.03945

par(mfrow = c(2,2))
plot(fit)
shapiro.test(resid(fit))
# 정규분포 x

fit1 <- lm(log(birth_rate) ~ log(kindergarten), data = mydata)
summary(fit1)
# Multiple R-squared:  0.04382
par(mfrow = c(2,2))
plot(fit1)
shapiro.test(resid(fit1))
# 정규분포 o

fit2 <- lm(birth_rate ~dummy, data = mydata)
summary(fit2)
#Multiple R-squared:  0.03811


#### 다중 회귀 분석  ####
# y = a1x1 + a2x2 + a3x3 + ... + b

house <- read.csv("C:/seokwonna/Rwork/data/kc_house_data.csv", header = T, fileEncoding = 'euc-kr')
str(house)

## 가설 : 거실의 크기가 크면 매매 가격이 비쌀것이다. 

leg1 <- lm(price ~sqft_living, data = house)
summary(leg1)
#Multiple R-squared:  0.4929

#먼저 살펴볼 변수
# sqft_living, bathroom, sqft_lot, floors
attach(house)
x <- cbind(sqft_living, bathrooms, sqft_lot, floors)
cor(x)
cor(x, price)

reg2 <- lm(price ~ sqft_living + floors, data = house)
summary(reg2)
#Multiple R-squared:  0.4929

reg2_1 <- lm(price ~ sqft_living + floors + sqft_living*floors,
             data = house)
summary(reg2_1)
#sqft_living*floors 조절변수를 통해 p-value 의 값을 임의로 변경하여 유의미한 값을 도출하게 만듦

# 다중 공선성 확인
#install.packages("car")
library(car)
vif(reg2_1)
# 값이 10 보다 커서 두 변수가 겹치는 영향을 미쳐서 sqft_living 과 floors 변수를 같이 사용 x

# 다른 변수를 가지고 시도
x = cbind(floors, sqft_above, sqft_basement)
cor(x)

x = cbind(floors, bedrooms)
cor(x)

reg3 <- lm(price ~ floors + bedrooms, data = house)
summary(reg3)
#Multiple R-squared:  0.1375

vif(reg3)
View(house)
unique(waterfront)

x = cbind(floors, bedrooms, waterfront)
cor(x)

cor(x, price)

reg4 <- lm(price ~ floors + bedrooms + waterfront, data = house)
summary(reg4)
#Multiple R-squared:  0.2068
vif(reg4)

reg5 <- lm(price ~ floors + bedrooms + waterfront + bedrooms*waterfront,
           data = house)
summary(reg5)
vif(reg5)

reg6 <- lm(price ~ floors + bedrooms + waterfront + floors*waterfront,
           data = house)
summary(reg6)
vif(reg6)

#### 실습2 ####
library(car)
View(state.x77)
states <- as.data.frame(state.x77[,c("Murder", "Population", "Illiteracy",
                           "Income", "Frost")])
View(states)

fit <- lm(Murder ~ ., data=states)
summary(fit)
#Multiple R-squared:  0.567

#다중공선성 확인, sqrt(vif) > 2/ 다중공선성이 없다. 
sqrt(vif(fit))

4/ (50 - 4  - 1) = 0.1  #보다 값이 클 경우

### 이상 관측치를 확인할  수 있는 그래프
influencePlot(fit, id = list(mehtod = "identify"))

### 회귀 모형의 교정
par(mfrow = c(2,2))
plot(fit)

## 정규성을 만족하지 않을 때 : 결과 변수에 람다승을 해준다.
# -2, -1, -0.5, 0, 1.5, 2
shapiro.test(resid(fit))
#p-value = 0.6672 > 0.05/ 정규분포이다.

powerTransform(states$Murder)
#0.605542 결과치에 나온 수치는 곱해주면 좋다는 이상치값임
summary(powerTransform(states$Murder))


## 선형성을 만족하지 않을 때
boxTidwell(Murder ~ Population + Illiteracy, data = states)

states$Population <- states$Population ^ 0.85
states$Illiteracy <- states$Illiteracy^1.35
fit2 <- lm(Murder ~ Population + Illiteracy, data =states)
summary(fit2)

# 등분산성을 만족하지 않을 경우
ncvTest(fit)

spreadLevelPlot(fit)


## 회귀 모형의 선택
# 1. Backward Stepwise Regression : 모든 독립변수를 대상으로 하나씩 빼는 방법

# 2. Forward Stepwide Regreess : 독립변수를 하나씩 추가하면서 테스트
# 3. All Subset Regression
#  AIC(Akaike's Information Criterion) : 이 값은 작을 수록 좋다.

## AIC 확인
fit1 <- lm(Murder ~ ., data = states)
summary(fit1)

fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
summary(fit2)
AIC(fit1, fit2)

## Backward
full.model <- lm(Murder~ ., data = states)
reduce.model <- step(full.model, direction = "backward")
reduce.model

## Forward
min.model<- lm(Murder ~ 1, data = states) 
# 1은 변수가 하나도 없다 표시
fwd.model <- step(min.model, direction = "forward",
                  scope = (Murder ~ Population + Illiteracy + Income + Frost))
#변수값이 줄어들면 더이상 진행하지 않아서 추가적인 변수진행값에 대해서 알수 없다.

## All Subset Regression
install.packages("leaps")
library(leaps)
leap <- regsubsets(Murder ~ Population + Illiteracy + Income + Frost,
           data = states, nbest = 4)
leap

par(mfrow = c(1,1))
plot(leap,scale = "adjr2")
#
#### 실습3 ####
# 정규성, 등분산성, 다중공선성 검증
# 독립변수들이 출산율과 관계가 있는가?
# 가장 영향력이 있는 변수들은 무엇인가?

mydata <- read.csv("C:/seokwonna/Rwork/data/regression.csv", fileEncoding = "euc-kr")
View(mydata)

str(mydata)
mydata <- mydata[, -1]
str(mydata)

reg1 <- lm(birth_rate ~ ., data = mydata)
summary(reg1)
#Multiple R-squared:  0.1621

par(mfrow = c(2,2))
plot(reg1)

## Backward
full.model <- lm(birth_rate~ ., data = mydata)
reduce.model <- step(full.model, direction = "backward", trace = 0)
reduce.model

#significant한 변수만 모아서 재확인
reg2 <- lm(birth_rate ~ social_welfare + active_firms + pop + 
             tris + kindergarten, data = mydata)
summary(reg2)
#Multiple R-squared:  0.1476

plot(reg2)

#정규성
shapiro.test(resid(reg2))
#p-value = 0.0001742 < 0.05 정규분포 x

## 정규성을 만족하지 않을 때 : 결과 변수에 람다승을 해준다.
powerTransform(mydata$birth_rate)
#-1
summary(powerTransform(mydata$birth_rate))

reg3 <- lm(birth_rate^-1 ~ social_welfare + active_firms + pop + 
             tris + kindergarten, data = mydata)
summary(reg3)
shapiro.test(resid(reg3))
#p-value = 0.4624 > 0.05, 정규분포 o

plot(reg3)

#다중공선성 확인
# 수치가 10을 넘지 않아야 한다
sqrt(vif(reg1))
sqrt(vif(reg2))
sqrt(vif(reg3))

## 등분산성
ncvTest(reg1)
ncvTest(reg2)
ncvTest(reg3)

spreadLevelPlot(reg3)
#Suggested power transformation:  3.364431 

reg4 <- lm((birth_rate^-1)^3.3 ~ social_welfare + active_firms + pop + 
             tris + kindergarten, data = mydata)
summary(reg4)

ncvTest(reg4)
#p = 0.30907 > 0.05 등분산성 o

#### 실습4 ####

mydata <- read.csv("C:/seokwonna/Rwork/data/SeoulBikeData.csv", fileEncoding = "euc-kr")
View(mydata)
str(mydata)
summary(mydata)

## 1. 시간대별로 평균 몇 대가 대여 되었을까?
library(dplyr)

result1 <- mydata %>% group_by(Hour) %>%
  summarise(count = mean(Rented.Bike.Count))
print(result1, n = 24)
View(result1)

## 2. 위의 결과를 시각화
library(ggplot2)
ggplot(result1, aes(Hour, count)) +
  geom_line(color = 'blue', size = 1) + 
  geom_vline(xintercept = 8, size = 1, color= 'red') +
  geom_vline(xintercept = 18, size = 1, color= 'red') +
  annotate(geom = "text", x = 6, y = 1000, label = "출근") +
  annotate(geom = "text", x = 16, y = 1300, label = "퇴근")

## 3. 선형 회귀
attach(mydata)
reg1 <- lm(Rented.Bike.Count ~ ., data = mydata)
summary(reg1)

#### 로지스틱 회기 분석 ####
# 일반화 선형 모델 : glm() 
titanic <- read.csv("C:/seokwonna/Rwork/data/train.csv", header = T)
View(titanic)

# 종속변수 : Survived(1: 생존, 0 :사망)
# 독립변수 : Pclass (1st, 2nd, 3rd)

titanic$Pclass1 <- ifelse(titanic$Pclass == 1, 1, 0)
titanic$Pclass2 <- ifelse(titanic$Pclass == 2, 1, 0)
titanic$Pclass3 <- ifelse(titanic$Pclass == 3, 1, 0)
View(titanic)

reg1 <- lm(Survived ~ Pclass2 + Pclass3, data = titanic)
summary(reg1)
0.62963-0.15680
0.62963-0.38727

reg2 <- glm(Survived ~ Pclass2 + Pclass3, data = titanic, family = binomial)
summary(reg2)

#+ 가나오면 확률이 증가한다, -가 나오면 수치만큼 확률이 감소한다
(exp(0.5306)-1)*100
#생존가능성이 69.9952 % 증가
(exp(-0.6394)-1)*100
#생존가능성이 -47.23911 % 감소
(exp(-1.6704)-1)*100
#생존가능성이 -81.18282 % 감소

# Age, Fare, Gender, SibSp
titanic$GenderFemale <- ifelse(titanic$Sex == "female", 1, 0)
titanic$GenderMale <- ifelse(titanic$Sex == "male", 1, 0)

unique(titanic$SibSp)
titanic$SibSp0 <- ifelse(titanic$SibSp == 0, 1, 0)
titanic$SibSp1 <- ifelse(titanic$SibSp == 1, 1, 0)
titanic$SibSp2 <- ifelse(titanic$SibSp == 2, 1, 0)
titanic$SibSp3 <- ifelse(titanic$SibSp == 3, 1, 0)
titanic$SibSp4 <- ifelse(titanic$SibSp == 4, 1, 0)
titanic$SibSp5 <- ifelse(titanic$SibSp == 5, 1, 0)
titanic$SibSp8 <- ifelse(titanic$SibSp == 8, 1, 0)

reg3 <- glm(Survived ~ Age + Fare + GenderMale +
              SibSp1 + SibSp2 + SibSp3 + SibSp4 + SibSp5 + SibSp8,
            data = titanic, family = binomial)
summary(reg3)
(exp(-0.0224)-1)*100
(exp(0.014946)-1)*100
#Gendermale 이 남자일 경우
(exp(-2.411)-1)*100
# sibling 이 3명일 경우
(exp(-2.461568)-1)*100
exp(-2.411)
#남자가 89% 확률 
