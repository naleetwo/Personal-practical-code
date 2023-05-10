#### start ####
package_version(R.version)
R.version

a <- 1 # a에 1 할당
a # a출력

b <- 2
b

c <- 3
c

d <- 3.5
d

a + b
a + b + c
4 / b
5 * b

var1 <- c(1, 2, 5, 7, 8)
var1

str1 <- "a"
str2 <- "text"
str3 <- "Hello World!"
str4 <- c("a", "b", "c")
str5 <- c("Hello!", "World", "is", "good!")
str1 + 2

str5
paste(str5, collapse = ",")
paste(str5, collapse = " ")

x
x_mean <- mean(x)
x_mean

str_paste <- paste(str5, collapse = " ")
str_paste

# install.packages("ggplot2")
library(ggplot2)

qplot(data = mpg, x = hwy)
View(mpg)

qplot(data = mpg, x = cty)

qplot(data = mpg, x = drv, y = hwy)

qplot(data = mpg, x = drv, y = hwy, geom = "line")

qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

# qplot 함수 매뉴얼 출력
?qplot

# pg77 Q1 시험 점수 변수 만들고 출력하기
exam_score <- c(80, 60, 70, 50, 90)
exam_score

# Q2 전체 평균 구하기
exam_mean_score <- mean(exam_score)

# Q3 전체 평균 변수 만들고 출력하기
exam_mean_score

english <- c(90, 80, 60, 70)
english

math <- c(50, 60, 100, 20)
math

df_midterm <- data.frame(english, math)
df_midterm

class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)
mean(df_midterm$math)

df_midterm <- data.frame(english = c(90, 80, 60, 70), math = c(50, 60, 100, 20), class = c(1, 1, 2, 2))
df_midterm

# pg88 Q1 data.frame()과 c()를 조합해 표의 내용을 데이터 프레임으로 만들어 출력해 보세요

제품 <- c("사과", "딸기", "수박")
가격 <- c(1800, 1500, 3000)
판매량 <- c(24, 38, 13)

product <- data.frame(제품, 가격, 판매량)
product

mean(product$가격)
mean(product$판매량)

install.packages("readxl")
library(readxl)
df_exam <- read_excel("C:/seokwonna/Rwork/data/excel_exam.xlsx")
df_exam

mean(df_exam$english)
mean(df_exam$science)

df_exam_novar <- read_excel("C:/seokwonna/Rwork/data/excel_exam_novar.xlsx")
df_exam_novar

df_exam_novar <- read_excel("C:/seokwonna/Rwork/data/excel_exam_novar.xlsx", col_names = F)
df_exam_novar


df_exam_sheet <- read_excel("C:/seokwonna/Rwork/data/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

df_csv_exam <- read.csv("C:/seokwonna/Rwork/data/csv_exam.csv")
df_csv_exam


df_midterm <- data.frame(english = c(90, 80, 60, 70), math = c(50, 60, 100, 20), class = c(1, 1, 2, 2))
df_midterm
write.csv(df_midterm, file = "C:/seokwonna/Rwork/data/df_midterm.csv")

exam <- read.csv("C:/seokwonna/Rwork/data/csv_exam.csv")
exam
head(exam)
head(exam, 10)
dim(exam)
tail(exam)
tail(exam, 10)
View(exam)
str(exam)
summary(exam)

# install.packages("ggplot2")
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
tail(mpg)
dim(mpg)
str(mpg)
summary(mpg)

df_raw <- data.frame(var1 = c(1, 2, 1),var2 = c(2, 3, 2))
df_raw

library(dplyr)
df_new <- df_raw # 복사본 생성
df_new
df_new <- rename(df_new, v2 = var2)
df_new

df_raw

# pg112 Q1. ggplot2() 패키지의 mpg 데이터를 사용할 수 있도록 불러온 후 복사본을 만드세요
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)

mpg_copy <- mpg
# Q2 복사본 데이터를 이용해 cty는 city로 , hwy는 highway로 수정하세요.
mpg_copy <- rename(mpg_copy, city = cty, highway = hwy)

#Q3 데이터 일부를 출력해 변수명이 바뀌었는지 확인해 보세요. 아래와 같은 결과물이 출력되어야 합니다.

head(mpg_copy)

df <- data.frame(var1 = c(4, 3, 8), var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2
df
df$var_mean <- df$var1 + df$var2 / 2
df

mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)
mpg_mean <- mean(mpg$total)
mpg_mean <- round(mpg_mean, digit = 2)
mpg_mean

summary(mpg$total)
hist(mpg$total)

#total 이 20 이상이면 pass, 그렇지 않으면 fail 부여
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg, 20)

table(mpg$test)

library(ggplot2)
qplot(mpg$test)

mpg$grade <- ifelse(mpg$total >= 30, "A", ifelse(mpg$total >= 20, "B", "C"))
head(mpg, 30)

table(mpg$grade)
qplot(mpg$grade)
mpg$grade2 <- ifelse(mpg$total )

#### 20230507 ####

library(dplyr)

setwd("C:/Users/user/Desktop/Coding/AIproject/seokwonna/R/practice data")
exam <- read.csv("csv_exam.csv")
exam

exam %>% filter(class == 1)
exam %>% filter(class != 1)
exam %>% filter(math > 50)
exam %>% filter(math < 50)
exam %>% filter(english >= 80)
exam %>% filter(english <= 80)
exam %>%  filter(class == 1 & math >= 50)
exam %>%  filter(math >= 90 | english >= 90)
exam %>% filter(english < 90 | science < 50)
exam %>% filter(class ==1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1,3,5))

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)

mean(class2$math)

#pg 133, Q1 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.
mpg <- as.data.frame(ggplot2::mpg)

mpg_a <- mpg %>% filter(displ <= 4)
mpg_b <- mpg %>% filter(displ >= 5)

mean(mpg_a$hwy)
mean(mpg_b$hwy)
#Q2 자동차와 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. "audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 cty(도시 연비)가 평균적으로 더 높은지 알아보세요.
mpg_audi <- mpg %>% filter(manufacturer == "audi")
mpg_toyota <- mpg %>% filter(manufacturer == "toyota")
mean(mpg_audi$cty)
mean(mpg_toyota$cty)
#Q3 "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 이 회사들의 데이터를 추출한 후 hwy 전체 평균을 구해 보세요.
mpg_threecom <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(mpg_threecom$hwy)

exam %>%select(math)

exam %>% select(english)

exam %>% select(class, math, english)

exam %>% select(-math)

exam %>% select(-math, -english)

exam %>% filter(class == 1) %>%  select(english)

exam %>% 
  filter(class == 1) %>% 
  select(english)

exam %>% 
  select(id, math) %>% 
  head

exam %>% 
  select(id, math) %>% 
  head(10)

#pg 138, Q1. mpg 데이터는 11개 변수로 구성되어 있습니다. 이중 일부만 추출해 분석에 활용하려고 합니다. mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해 새로운 데이터를 만드세요. 새로만든 데이터의 일부를 출력해 두 변수로만 구성되어 있는지 확인하세요.
library(ggplot2)
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)
View(mpg)

mpg_class <- mpg %>% select(class, cty)
mpg_class
#Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 앞에서 추출한 데이터를 이용해 class(자동차 종류)가 "suv"인 자동차와 "compact"인 자동차 중 어떤 자동차의 cty(도시 연비) 평균이 더 높은지 알아보세요.

mpg_suv <- mpg_class %>% filter(class == "suv")
mean(mpg_suv$cty)

mpg_compact <- mpg_class %>% filter(class == "compact")
mean(mpg_compact$cty)

exam <- read.csv("C:/seokwonna/Rwork/data/csv_exam.csv")
exam

exam %>% arrange(math) %>% head()

exam %>% arrange(desc(math))

exam %>% arrange(class, math)

#pg141, Q1. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.

mpg_audi <- mpg %>% filter(manufacturer == "audi")
mpg_audi %>% arrange(desc(hwy)) %>% 
  head(5)

exam <- read.csv("C:/seokwonna/Rwork/data/csv_exam.csv")
exam %>% 
  mutate(total = math + english + science) %>% 
  head

exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3) %>% 
  head
exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head

exam %>% 
  mutate(total = math + english + science) %>% 
  arrange(total) %>% 
  head
library(dplyr)
# pg 144, Q1. mpg() 데이터 복사본을 만들고, cty 와 hwy 를 더한 '합산 연비 변수' 를 추가하세요
mpg <- as.data.frame(ggplot2::mpg)
mpg_copy <- mpg %>% mutate(total_yield = cty + hwy)
#Q2. 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가하세요
mpg_copy<- mpg_copy %>% mutate(avr_yield = total_yield / 2)
View(mpg_copy)
#Q3. '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.
mpg_copy %>% arrange(desc(avr_yield)) %>% head(3)
#Q4. 1-3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 실행해 보세요. 데이터는 복사본 대신 mpg 원본을 이용하세요.

mpg <- mpg %>% mutate(total_yield = cty + hwy,
                      avr_yield = total_yield /2) %>% arrange(desc(avr_yield)) %>% head(3)
mpg

exam %>%  summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())

mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

mpg %>%
  group_by(manufacturer) %>%
  filter(class == "suv") %>%
  mutate(total = (cty + hwy)/2) %>%
  summarise(mean_total = mean(total)) %>%
  arrange(desc(mean_total)) %>%
  head(5)

#pg150, Q1. mpg 데이터의 class는 "suv", "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교해 보려고 합니다. class 별 cty 평균을 구해보시요
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty))
#Q2. 앞 문제의 출력 결과는 class 가 알파벳 순으로 정렬되어있는데 cty 평균 높은순으로 정렬해서 출력해주세요
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

#Q3. 어떤 회자 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다. hwy 평균이 가장 높은 회사 세곳을 출력하세요.

mpg %>% group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

#Q4. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

mpg %>% group_by(manufacturer) %>% 
  filter(class == "compact") %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

test1 <- data.frame(id = c( 1,2,3,4,5),
                    midterm = c(60, 80, 70, 90, 85))                                                                     
test2 <- data.frame(id = c( 1,2,3,4,5),
                   final = c(70, 83, 65, 95, 80)) 

test1
test2
total <- left_join(test1, test2, by = "id")
total

name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")
exam_new

group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60, 80, 70, 90, 85))

group_b <- data.frame(id = c(6,7,8,9,10),
                      test = c(70, 83, 65, 95, 80))

group_a
group_b

group_all <- bind_rows(group_a, group_b)
group_all

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22))
fuel
#pg.156 Q1. mpg데이터에는 연료 종류를 나타낸 fl변수는 있지만 연료 가격을 나타낸 변수는 없습니다. 위에서 만든 fuel 데이터를 이용해 mpg 데이터에 price_fl(연료가격) 변수를 추가하세요.
View(mpg)
mpg <- left_join(mpg, fuel, by = "fl" )
mpg %>% head
View(mpg_fuel)
#Q2. 연료가격 변수가 잘 추가 됬는지 확인하기 위해 model, fl, price_fl 변수를 추출해 앞부분 5행을 출력해 보세요.


mpg %>% select(model, fl, price_fl) %>% head(5)

#pg 160. Q1. popadults는 해당 지역의 성인 인구, poptotal은 전체 인구를 나타냅니다. midwest 데이터에 '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.
library(ggplot2)
library(dplyr)
midwest_data <- as.data.frame(ggplot2::midwest)

str(midwest_data)
View(midwest_data)
midwest_data <- midwest_data %>% mutate(per_children = (poptotal - popadults)/poptotal * 100)
View(midwest_data)

#Q2. 미성년 인구 백분율이 가장 높은 상위 5개 county(지역)의  미성년 인구 백분율을 출력하세요

midwest_data %>%  select(county, per_children) %>% arrange(desc(per_children)) %>% head(5)

#Q3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 각 등급에 몇 개의 지역이 있는지 알아보세요.

midwest_data <- midwest_data %>% mutate(grade = ifelse(per_children >= 40, "large", ifelse(per_children > 30, "middle", "small")))
table(midwest_data$grade)

#Q4. popasian 은 해당 지역의 아시아인 인구를 나타냅니다. '전체 인구 대비 아시아인 인구 백분율' 변수를 추가하고 하위 10개 지역의 state(주), county(지역), 아시아인 인구 백분율을 출력하세요.

midwest_data <- midwest_data %>% mutate(ratio_asian = popasian / poptotal * 100) %>% select(state, county, ratio_asian) %>% arrange(ratio_asian) %>% head(10)
midwest_data

df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

is.na(df)

table(is.na(df))

table(is.na(df$sex))

table(is.na(df$score))

mean(df$score)

sum(df$score)

library(dplyr)
df %>% filter(is.na(score))

df %>%  filter(!is.na(score))

df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)

sum(df_nomiss$score)

df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

df_nomiss2 <- na.omit(df)
df_nomiss2

mean(df$score, na.rm = T)

sum(df$score, na.rm = T)

exam <- read.csv("C:/seokwonna/Rwork/data/csv_exam.csv")
exam[c(3, 8, 15),"math"] <- NA
exam

exam %>%  summarise(mean_math = mean(math))

exam %>%  summarise(mean_math = mean(math, na.rm = T))

exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   median_math = median(math, na.rm = T))

mean(exam$math, na.rm = T)

exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))
exam
mean(exam$math)

#pg170, Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지 알아보려고 합니다. 분석을 하기 전에 우선 두 변수에 결측치가 있는지 확인해야 합니다. drv 변수와 hwy 변수에 결측치가 몇 개 있는지 알아보세요.

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

table(is.na(mpg$drv))
table(is.na(mpg$hwy))
#Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동 방식의 hwy 평규이 높은지 알아보세요. 하나의 dplyr 구문으로 만들어야 합니다.

mpg_delna <- mpg %>% filter(!is.na(mpg$hwy)) %>%  group_by(drv) %>% summarise(mean_hwy = mean(hwy))
mpg_delna

#### 20230510 ####
outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
outlier

table(outlier$sex)

table(outlier$score)

outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

library(dplyr)

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

boxplot(mpg$hwy)

boxplot(mpg$hwy)$stats

mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy >37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

#mpg데이터 이상치 만들기
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93), "drv"] <- "k"
mpg[c(29,43, 129, 203), "cty"] <- c(3,4,39,42)

#pg178, Q1. drv에 이상치가 있는지 확인하세요. 이상치를 결측 처리한 후 이상치가 사라졌는지 확인하세요. 결측 처리를 할때는 %in% 기호를 사용하세요.

table(mpg$drv)
mpg$drv <- ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)
table(mpg$drv)

#Q2. 상자 그림을 이용해 cty에 이상치가 있는지 확인하세요. 상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후 다시 상자 그림을 만들어 이상치가 사라졌는지 확인하세요.

boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty)

#Q3, 두 변수의 이상치를 결측 처리 햇으니 이제 분석할 차례입니다. 이상치를 제외한 다음 drv 별로 cty 평균이 어떻게 다른지 알아보세요. 하나의 dplyr 구문으로 만들어야 합니다.
mpg %>%
  filter(!is.na(mpg$drv) & !is.na(mpg$cty)) %>% group_by(drv) %>% summarise(mean_cty = mean(cty))

library(ggplot2)

ggplot(data = mpg, aes(x = displ, y =hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

#pg.188, Q1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. X축은 cty, y 축은 hwy로 된 산점도를 만들어 보세요

ggplot(data = mpg, aes(x= cty, y = hwy))+
  geom_point()

#Q2. 미국 지역ㅂㄹ 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 이용해 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다. x 축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 된 산점도를 만들어 보세요. 전체 인구는 50만 명 이하, 아시아 인구는 1만명 이하인 지역만 산점도에 표시되게 설정하세요.

midwest <- as.data.frame(ggplot2::midwest)

ggplot(data = midwest, aes(x= poptotal, y= popasian)) + geom_point() + xlim(0, 5e+05) + ylim(0, 1e+04)

library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)

df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

df_mpg

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

ggplot(data = mpg, aes(x=drv)) + geom_bar()

ggplot(data = mpg, aes(x = hwy)) + geom_bar()

#pg193, Q1 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. "suv"차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비가 높은순으로 정렬하세요.
mpg
mpg_suv <- mpg %>% filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% head(5)
mpg_suv

ggplot(data = mpg_suv,
       aes(x= reorder(manufacturer, -mean_cty),
           y= mean_cty)) + geom_col() 
      
#Q2, 자동차 중에서 어떤 class(자동차 종류)가 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.

ggplot(data = mpg, aes(x = class)) + geom_bar()

ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

#pg195, Q1 psavert(개인 저축률)가 시간에 따라 어떻게 변해 왔는지 알아보려고합니다. 시간에 다른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.
 
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

ggplot(data = mpg, aes( x = drv, y = hwy)) + geom_boxplot()

ggplot(data = mpg, aes(x =displ, y = hwy)) + geom_point()
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3,6) + ylim(10,30)

#pg 198, Q1 class(자동차 종류)가 "compact", "subcompact", "suv" 인 자동차의 cty(도시연비) 가 어떻게 다른지 비교해 보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어 보세요.

