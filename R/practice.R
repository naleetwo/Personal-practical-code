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

#20230507

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

# pg 144, Q1. mpg() 데이터 복사본을 만들고, cty 와 hwy 를 더한 '합산 연비 변수' 를 추가하세요

#Q2. 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가하세요

#Q3. '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.

#Q4. 1-3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 실행해 보세요. 데이터는 복사본 대신 mpg 원본을 이용하세요.
