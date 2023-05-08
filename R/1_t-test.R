#### Power Analysis ####
#데이터 갯수가 적정한지 더 필요한지에 대한 테스트
#적정한 표본의 갯수를 산출
# cohen's d(effective size) : 두 집단의 평균 차이를 두 집단의 표준편차의 합으로 나우어준다.
# (Group A Mean - Group B Mean) / Pooled standard deviation

ky <- read.csv("../data/KY.csv", header = T)
View(ky)

table(ky$group)

mean.1 <- mean(ky$score[ky$group == 1])
mean.2 <- mean(ky$score[ky$group == 2])
cat(mean.1, mean.2)

sd.1 <- sd(ky$score[ky$group == 1])
sd.2 <- sd(ky$score[ky$group == 2])
cat(sd.1, sd.2)

effective_size <- abs(mean.1 - mean.2) / sqrt((sd.1^2 + sd.2^2)/2)
effective_size

install.packages("pwr")
library(pwr)

pwr.t.test(d = effective_size, alternative = "two.sided",
           type = "two.sample", power = .8, sig.level = 0.05)
?pwr.t.test



#### 사례 1 : 두 집단의 평균 비교 ####

install.packages("moonBook")
library(moonBook)

head(acs)
str(acs)
?acs

#경기도에 소재한 대학병원에서 2년동안 내원한 급성 관상동맥증후군 환자 데이터

summary(acs)

### 가설 설정
# 주제 : 두 집단(여성, 남성)의 나이 차이를 알고 싶다.
# 귀무가설 : 남성과 여성의 평균 나이에 대해 차이가 없다.
# 대립가설 : 남성과 여성의 평균 나이에 대해 차이가 있다.

View(acs)
man.mean <-  mean(acs$age[acs$sex == "Male"])
woman.mean <- mean(acs$age[acs$sex == "Female"])
cat(man.mean, woman.mean)

### 정규분포 테스트
moonBook::densityplot(age~sex, data = acs)

## 가설 설정
# 주제 : 두 집단의 정규 분포 여부를 알고 싶다.
# 귀무가설 : 두 집단이 정규분포이다.
# 대립가설 : 두 집단이 정규분포가 아니다.

shapiro.test(acs$age[acs$sex == "Male"])
shapiro.test(acs$age[acs$sex == "Female"])

# 남성의 집단은 정규분포를 구성하며 여성의 집단은 정규분포를 구성하지 않는다.

### 등분산 테스트
## 가설 설정
# 주제 : 두 집단의 등분산 여부를 알고 싶다.
# 귀무가설 : 두 집단이 등분산이다.
# 대립가설 : 두 집단이 등분산이 아니다.

var.test(age~sex, data = acs)

?t.test

t.test(age~sex, data = acs, alt = "two.sided", var.equals = TRUE)

### 정규분포가 아닐 때 : MWW

?wilcox.test()
wilcox.test(age~sex, data = acs, alt = "two.sided", var.equals = TRUE)

### 등분산이 아닐 때, : welch's t-test
t.test(age~sex, data = acs, alt = "two.sided", var.equals = FALSE)


#### 사례 2 : 집단이 하나인 경우 ####

# A회사의 건전지 수명이 1000시간 일때 무작위로 뽑아 10개의 건전지 수명에 대해 샘플이 모집단과 다르다고 할 수 있는가? 

#귀무가설: 표본의 평균은 모집단의 평균과 같다.
#대립가설: 표본의 평균은 모집단의 평균과 다르다.

a <- c(980, 1008, 968, 1032, 1012, 1002, 996, 1017, 990, 955)
mean.a <- mean(a)
mean.a
str(a)

# 정규분포 확인
shapiro.test(a)
?t.test()
t.test(a, mu = 1000, alt = "two.sided")
t.test(a, mu = 1000, alt = "less")
t.test(a, mu = 1000, alt = "greater")

## 어떤 학급의 수학 평균 점수가 55점 이었다. 0교시 수업을 하고 다시 성적을 살펴보았다.

b <- c(58, 49, 39, 99, 32,
       88, 62, 30, 55, 65,
       44, 55, 57, 53, 88,
       42, 39)
mean.b <- mean(b)
mean.b

#정규분포 확인
shapiro.test(b)
t.test(b, mu = 55, alt = "two.sided")
t.test(b, mu = 55, alt = "less")
t.test(b, mu = 55, alt = "greater")

# p-value, 0.81 > 0.05 기 때문에 null hypothesis를 따라 0교시 수업을 해도 수학 평균 점수에 영향을 미치지 않는다.


#### 사례3 : 하나의 집단으로 시간에 따른 비교 #### 

str(sleep)
View(sleep)

## 주제: 같은 집단에 대해 수면시간의 증가량 차이가 나는지 알고 싶다.

## Independent two sample t-test
# 먼제 ID를 제거하여 서로 다른 두 집단으로 테스트를 해본다.
sleep2 <- sleep[, -3]

View(sleep2)
mean.1 <- mean(sleep2$extra[sleep2$group == 1])
mean.2 <- mean(sleep2$extra[sleep2$group == 2])
cat(mean.1, mean.2)

#정규분포 확인
moonBook::densityplot(extra~group, data = sleep2)

### 가설 설정
# 귀무가설 : group 1 과 2 의 평균 수면에 대해 차이가 없다.
# 대립가설 : group 1 과 2 의 평균 수면에 대해 차이가 있다.

shapiro.test(sleep2$extra[sleep2$group == 1])
#p-value 0.4079 > 0.05
shapiro.test(sleep2$extra[sleep2$group == 2])
#p_value 0.3511 > 0.05

#등분산 테스트
var.test(extra~group, data = sleep2)

#student t-test, two.sided, var.equals = T 테스트
t.test(extra~group, data = sleep2, alt = "two.sided", var.equals = TRUE)
# p-value,0.08 > 0.05 이므로 group 1과 2의 평균 수면에 대해 차이가 없다.

#======================================================================#
#평균값 확인 및 비교
tapply(sleep2$extra, sleep2$group, mean)
#정규분포 확인
with(sleep2,shapiro.test(extra[group == 1]))
with(sleep2,shapiro.test(extra[group == 2]))
#등분산 확인
var.test(extra~group, data = sleep2)
#t-test
t.test(extra~group, data = sleep2, alt = "two.sided", var.equals = TRUE)

## paired sample t-test
t.test(extra~group, data = sleep, var.equals = T, paired = T)

## 그래프 그리기
before <- subset(sleep, group == 1, extra)
before
after <- subset(sleep, group == 2, extra)
after

install.packages("PairedData")
library(PairedData)

s_graph <- paired(before, after)
s_graph

plot(s_graph, type = "profile") + theme_bw()



#### 실습 1 ####
# 주제 : 시와 군에 따라서 합계 출산율의 차이가 있는지 알아보려고 한다
#귀무가설 : 차이가 없다
#대립가설 : 차이가 있다.
# dummy : 0은 군을 나타내고 1은 시를 타나낸다.

mydata <- read.csv('../data/independent.csv', fileEncoding = 'euc-kr')
str(mydata)
View(mydata)

#군, 시 평균값 계산
si.mean <-  mean(mydata$birth_rate[mydata$dummy == 1])
gun.mean <- mean(mydata$birth_rate[mydata$dummy == 0])
cat(si.mean, gun.mean)

### 정규분포 테스트
moonBook::densityplot(birth_rate~dummy, data = mydata)

shapiro.test(mydata$birth_rate[mydata$dummy == 1])
#시 p-value <0.05 - 정규분포가 아니다
shapiro.test(mydata$birth_rate[mydata$dummy == 0])
#군 p-value <0.05 - 정규분포가 아니다

#등분산 테스트

var.test(birth_rate~dummy, data = mydata)
#시와 군 birth_rate 는 등분산이 아니다

wilcox.test(birth_rate~dummy, data = mydata, alt = "two.sided", var.equals = F)
# p-value; 0.041 <0.05 이므로 시와 군의 합계 출산율은 차이가 있다.

#if 정규분포이면서 등분산도 맞다면
t.test(birth_rate~dummy, data = mydata, alt = "two.sided", var.equals = TRUE)

#if 정규분포이면서 등분산이 아니라면: welch t-test
t.test(birth_rate~dummy, data = mydata, alt = "two.sided", var.equals = F)


#### 실습 2 ####
# 주제 : 오토와 수동에 따라 연비에 차이가 있는가?
# 기본 데이터셋에 있는 mtcars로 확인
# am : 0은 오토, 1은 수동

str(mtcars)
View(mtcars)

#군, 시 평균값 계산
auto.mean <-  mean(mtcars$mpg[mtcars$am == 0])
self.mean <- mean(mtcars$mpg[mtcars$am == 1])
cat(auto.mean, self.mean)

### 정규분포 테스트
moonBook::densityplot(mpg~am, data = mtcars)
#정규분포 수치확인
shapiro.test(mtcars$mpg[mtcars$am == 0])
#오토 p-value,0.8987 >0.05 - 정규분포이다
shapiro.test(mtcars$mpg[mtcars$am == 1])
#군 p-value, 0.5363 > 0.05 - 정규분포이다

#등분산 테스트

var.test(mpg~am, data = mtcars)
#오토와 수동은 p-value, 0.06691 > 0.05 이여서 등분산이 맞다.

#student t-test
t.test(mpg~am, data = mtcars, alt = "two.sided", var.equals = TRUE)
# p-value, 0.001374 < 0.05, 대립가설을 따라 오토와 수동에 따라 연비차이가 있다.


#### 실습 3 ####
# 주제 : 쥐의 몸무게가 전과 후의 차이가 있는가?

mydata <- read.csv("../data/pairedData.csv")
str(mydata)
View(mydata)

#전, 후 평균값 계산
before.mean <-  mean(mydata$before)
after.mean <- mean(mydata$After)
cat(before.mean, after.mean)

## long 형으로 변환1 
library(reshape2)
mydata1 <- melt(mydata, id = ("ID"), variable.name = "GROUP", value.name ="RESULT")
mydata1

## long 형으로 변환2
install.packages("tidyr")
library(tidyr)

?gather
mydata2 <- gather(mydata, key = "GROUP", value = "RESULT", -ID)
mydata2

with(mydata1, shapiro.test(RESULT[GROUP == "before"]))
with(mydata1, shapiro.test(RESULT[GROUP == "After"]))
#before, after 정규분포이다

t.test(RESULT ~ GROUP, data = mydata1, paired = T)
t.test(mydata$before, mydata$After, paired = T)
#p-value, 6.2e-09 < 0.05 이므로 대립가설에 의거하여 before 와 After의 몸무게는 차이가 있다.
moonBook::densityplot(RESULT ~ GROUP, data = mydata1)

before <- subset(mydata1, GROUP == "before", RESULT)
after <- subset(mydata1, GROUP == "After", RESULT)

plot(paired(before, after), type = "profile")
  


#### 실습 4 ####
# 주제 : 시별로 2010년도와 2015년도의 출산율의 차이가 있는가?

mydata <- read.csv("../data/paired.csv", fileEncoding = 'euc-kr')
str(mydata)
View(mydata)



## long 형으로 변환2
library(tidyr)
mydata1 <- gather(mydata, key = "GROUP", value ="RESULT", -c(ID, cities))
mydata1

library(reshape2)
mydata2 <- melt(mydata, id = c("ID", "cities"),
                variable.name = "GROUP",
                value.name ="RESULT")
mydata2

#전, 후 평균값 계산
birth_2015.mean <-  mean(mydata$birth_rate_2015)
birth_2010.mean <- mean(mydata$birth_rate_2010)
cat(birth_2010.mean, birth_2015.mean)

with(mydata1, shapiro.test(RESULT[GROUP == "birth_rate_2015"]))
with(mydata1, shapiro.test(RESULT[GROUP == "birth_rate_2010"]))
#birth_rate_2015, birth_rate_2010 정규분포가 아니다

moonBook::densityplot(RESULT ~ GROUP, data = mydata1)

wilcox.test(RESULT ~ GROUP, data = mydata1, paired = T)
#p-value, 0.4513 > 0.05 이므로 귀무가설을 부합하여 2015, 2010년 출생율에 대한 차이는 없다.

birth_2015 <- subset(mydata1, GROUP == "birth_rate_2015", RESULT)
birth_2010 <- subset(mydata1, GROUP == "birth_rate_2010", RESULT)

plot(paired(birth_2010, birth_2015), type = "profile")

#### 실습 5 ####
#https://www.kaggle.com/code/kappernielsen/independent-t-test-example/notebook
# 주제1 : 남녀별로 각 시험에 대해 평균 차이가 있는지 알고싶다.
# 주제2 : 같은 사람에 대해서 성적의 차이가 있는지 알고싶다.
#         첫번째 시험(G1)과 세번째 시험(G3)을 사용
mat <- read.csv("../data/student-mat.csv", header = T)
View(mat)

##주제1
#남,녀 명수 확인
table(mat$sex)

summary(mat$G1)
summary(mat$G2)
summary(mat$G3)

library(dplyr)
mat %>% group_by(sex) %>%
  summarise(mean_g1 = mean(G1), mean_g2 = mean(G2), mean_g3 = mean(G3),
            sd_g1 = sd(G1), sd_g2 = sd(G2), sd_g3 = sd(G3))

shapiro.test(mat$G1[mat$sex == "M"])
#p-value, 0.013 < 0.05 / 정규분포 x
shapiro.test(mat$G2[mat$sex == "M"])
#p-value, 0.0002798 < 0.05 / 정규분포 x
shapiro.test(mat$G3[mat$sex == "M"])
#p-value, 8.972e-08 < 0.05 / 정규분포 x
shapiro.test(mat$G1[mat$sex == "F"])
#p-value, 5.691e-05 < 0.05 / 정규분포 x
shapiro.test(mat$G2[mat$sex == "F"])
#p-value, 7.68e-05 < 0.05 / 정규분포 x
shapiro.test(mat$G3[mat$sex == "F"])
#p-value, 7.168e-09 < 0.05 / 정규분포 x

#남녀 G1, G2, G3 시험 평균 도출 및 비교
G1_male.mean <- mean(mat$G1[mat$sex == "M"])
G2_male.mean <- mean(mat$G2[mat$sex == "M"])
G3_male.mean <- mean(mat$G3[mat$sex == "M"])
G1_female.mean <- mean(mat$G1[mat$sex == "F"])
G2_female.mean <- mean(mat$G2[mat$sex == "F"])
G3_female.mean <- mean(mat$G3[mat$sex == "F"])
cat(G1_male.mean, G2_male.mean, G3_male.mean)
cat(G1_female.mean, G2_female.mean, G3_female.mean)

#정규분포 확인
moonBook::densityplot(G1~sex, data = mat)
moonBook::densityplot(G2~sex, data = mat)
moonBook::densityplot(G3~sex, data = mat)

shapiro.test(mat$G1[mat$sex == "M"])
#p-value, 0.013 < 0.05 / 정규분포 x
shapiro.test(mat$G2[mat$sex == "M"])
#p-value, 0.0002798 < 0.05 / 정규분포 x
shapiro.test(mat$G3[mat$sex == "M"])
#p-value, 8.972e-08 < 0.05 / 정규분포 x
shapiro.test(mat$G1[mat$sex == "F"])
#p-value, 5.691e-05 < 0.05 / 정규분포 x
shapiro.test(mat$G2[mat$sex == "F"])
#p-value, 7.68e-05 < 0.05 / 정규분포 x
shapiro.test(mat$G3[mat$sex == "F"])
#p-value, 7.168e-09 < 0.05 / 정규분포 x

#등분산 확인
var.test(G1~sex, data = mat)
#p-value = 0.4967 > 0.05 / 등분산 O
var.test(G2~sex, data = mat)
#p-value = 0.3977 > 0.05 / 등분산 O
var.test(G3~sex, data = mat)
#p-value = 0.6989 > 0.05 / 등분산 O

#정규분포 x, 등분산 o 일때,
wilcox.test(G1~sex, data = mat, alt = "two.sided", var.equals = TRUE)
# p-value = 0.05957 > 0.05 이므로 G1 남녀 평균 점수는 차이가 없다.
wilcox.test(G2~sex, data = mat, alt = "two.sided", var.equals = TRUE)
# p-value = 0.04874 < 0.05 이므로 G2 남녀 평균 점수는 차이가 있다.
wilcox.test(G3~sex, data = mat, alt = "two.sided", var.equals = TRUE)
# p-value = 0.04065 < 0.05 이므로 G3 남녀 평균 점수는 차이가 있다.

#if 정규분포일 경우
t.test(G1~sex, data = mat, alt = "two.sided", var.equals = TRUE)
t.test(G2~sex, data = mat, alt = "two.sided", var.equals = TRUE)
t.test(G3~sex, data = mat, alt = "two.sided", var.equals = TRUE)


##주제2
mat %>% summarise(mean_g1 = mean(G1), mean_g3 = mean(G3))

# long 형으로 변환, 변수가많을시에 추가하고 싶은 변수값만 value 뒤에 적음
mydata <- gather(mat, key = "GROUP", value ="RESULT", "G1", "G3")
mydata
str(mydata)
View(mydata)

t.test(RESULT ~ GROUP, data = mydata, paired = T)
p-value = 0.0004291 < 0.05 
wilcox.test(RESULT ~ GROUP, data = mydata, paired = T)
p-value = 0.3153 > 0.05

#long 형을 사용하지 않고 wide 형으로 t-test 확인 할때
t.test(mat$G1, mat$G3, paired = T)