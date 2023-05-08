#### 기술 통계량 ####


### table()
aws <- read.delim("../data/AWS_sample.txt", sep = "#")
head(aws)
str(aws)

table(aws$AWS_ID)
table(aws$AWS_ID, aws$X.)

table(aws[, c("AWS_ID", "X.")])

aws[2500:3100, "x."] = "modified"
aws[2500:3100, "X."]

table(aws$AWS_ID, aws$X.)

prop.table(table(aws$AWS_ID)) #빈도수
prop.table(table(aws$AWS_ID))*100
paste(prop.table(table(aws$AWS_ID))*100, "%")

### 기술 통계 함수의 모듈화
# 각 컬럼 단위로 빈도와 최대, 최소값 계산

test <- read.csv("../data/test.csv", header = T)
head(test)
length(test)
str(test)

table(test$A)
max(test$A)
min(test$A)

# 컬럼별로 데이터 분석 방법 정하기
data_summary <- function(df){
  for(idx in 1:length(df)){
    cat(idx, "번째 컬럼의 빈도 분석 결과")
    print(table(df[idx]))
    cat("\n")
  }
  for(idx in 1:length(df)){
    f <- table(df[idx])
    cat(idx, "번째 컬럼의 최대/최소값 결과 : \t")
    cat("max=", max(f), ", min =", min(f), "\n")
  }
}

data_summary(test)



#### dply ####
install.packages("dplyr")
library(dplyr)
ls("pakage:dplyr")

exam <- read.csv("../data/csv_exam.csv")
exam

###1.filter() 
#1반 학생들의 데이터 추출

exam[which(exam$class =="1"), ]
exam[exam$class == "1", ]
subset(exam, class == "1")

filter(exam, class=="1")
exam %>% filter(class == "1")

# 2반이면서 영어점수가 80점 이상인 데이터만 추출
exam[exam$class == 2 & exam$english >= 80]
exam %>% filter(class == 2 & english >= 80)

# 1, 3, 5반에 해당하는 데이터만 추출
exam %>% filter(class == 1 | class == 3 |class == 5)
exam %>% filter(class %in% c(1, 3, 5))

### 2. select()
#수학점수만 추출
exam[, 3]
exam %>% select(math)

#반, 수학, 영어점수 추출
exam[, c(2, 3, 4)]
exam %>% select(c(class,math,english))

# 1반 학생들의 수학점수만 추출(2명만 표시)
#select class, math from where class == 1 limit 2;
result <- filter(exam, class == 1)
result2 <- select(result, math)
head(result2, 2)

exam %>% filter(class == 1) %>% select(math) %>% head(2)

### 3. arrange()
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)

### 4. mutate() #새로운 콜럼을 만들어줌, 파생변수
exam$sum <- exam$math + exam$english + exam$science
exam

exam$mean <- exam$sum / 3
exam

exam <- exam[, -c(6, 7)]
exam

exam <- exam %>% mutate(sum = math + english + science, mean = sum / 3) #재할당 해야 변경된 값이 적용됨
exam

### 5. summarize()
exam %>% summarise(mean_math = mean(math), sum_math = sum(math), median_math = median(math), count = n())

### 6. group_by()
exam %>% group_by(class) %>% summarise(mean_math = mean(math), sum_math = sum(math), median_math = median(math), count = n())

### 7. left_join(), bind_rows()
test1 <- data.frame(id = c(1,2,3,4,5),
                    mitern= c(60, 70, 80, 90, 85))
test2 <- data.frame(id = c(1,2,3,4,5),
                    mitern= c(60, 70, 80, 90, 85))
left_join(test1, test2, by = "id") # wide 형
bind_rows(test1, test2) # long형

### 8. 연습문제1
install.packages("ggplot2")
library(ggplot2)
library(dplyr)

#cty - 도시연비, hwy - 고속도로연비 중요변수
str(ggplot2::mpg)
str(test)
class(mpg)
tail(mpg)
dim(mpg)
View(mpg)

# (1) 배기량이(displ)이 4 이하인 차량의 모델명, 배기량, 생산연도 조회
mpg
mpg[mpg$displ <= 4, "model", "displ", "year" ]
result <- filter(mpg, displ <= 4)
result2 <- select(result, "model", "displ", "year")
result2


# (2) 통합연비 파생변수(total)을 만들고 통합연비로 내림차순정렬을 한 후에 30개의 행만 선택해서 조회
mpg$total <- (mpg$cty + mpg$hwy) / 2
result <- mpg %>% arrange(desc(total))
print(result, n = 30)

# (3) 회사별로 'suv'차량의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고 1위~5위 까지 조회

suv_rank <- mpg %>% group_by(manufacturer) %>%
  filter(class == "suv") %>%
  summarise(mean_total = mean(total), count = n())
suv_rank_desc <- suv_rank %>% arrange(desc(count))
head(suv_rank_desc, 5)

# (4) 어떤 회사의 hwy연비가 가장 높은지 알아보려고 한다.
# hwy 평균이 가장 높은 회사 세곳을 조회
head(mpg)
brand_hwy_mean <- mpg %>% group_by(manufacturer) %>%
  summarise(mean_hwy = mean(hwy)) %>% arrange(desc(mean_hwy))
head(brand_hwy_mean, 5)

# (5) 어떤 회사에서 compack(경차) 차종을 가장 많이 생산하는지 알아보려고 한다.각 회사별 경차 차중 수를 내림차순으로 정령

head(mpg)
compack_num <- mpg %>% group_by(manufacturer, class) %>%
  summarise(n = n()) %>% filter(class == "compact") %>% arrange(desc(n))
compack_num

# (6) 연료별 가격을 구해서 새로운 데이터프레임을 만든 후 (fuel)
#기존 데이터셋과 병합하여 출력
#c;CNG= 2.34, d =Disel = 2.38, e: Ethanol = 2.11
#p : preminum = 2.76, r: regular = 2.22

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22))
mpg_fuel <- left_join(mpg, fuel, by = "fl")
head(mpg_fuel)
View(mpg_fuel)

# (7) 통합 연비의 기준치를 통해 합격(pass)/불합격(fail)을 부여하는
#test 라는 이름의 파생변수 생성. 이때 기준은 20으로 한다.

mpg_test <- mpg %>% mutate(test = ifelse(total >= 20, "pass", "fail"))
View(mpg_test)

#(8) test에 대해 합격과 불학격을 받는 자동차가 각각 몇대인가?
mpg_test %>% group_by(test) %>% summarise(n = n())

#(9) 통합 연비 등급 A, B, C 세 등급으로 나누는 파생변수를 추가
#(grade)
#30이상이면 A, 20~29는, B 20미만이면 C등급으로 분류.
mpg_grade <- mpg_test %>% mutate(grade = ifelse(total >= 30, "A", ifelse(total >=20, "B", "C")))
View(mpg_grade)

### 9. 연습문제 2
midwest <- as.data.frame(ggplot2::midwest)
library(dplyr)
head(midwest)
str(midwest)

# (1) 전체 인구 대비 미성년 인구 백분율(ratio_child) 파생변수 추가

midwest <- midwest %>% mutate(ratio_child = (poptotal - popadults) / poptotal)
View(midwest)
# (2) 미성년 인구 백분율이 가장 높은 상위 5개 지역(county)의
# 미성년 인구 백분율을 조회
midwest %>% arrange(desc,ratio_child)
head(midwest)

# (3) 기준에 따라 미성년 비율 등급변수를 추가하고(grade), 각 등급에
# 몇 개의 지역이 있는지 조회
# 기준 : 미성년 인구 백분율이 40 이상이면 "large",
# 30 이상이면 "middle", 그렇지 않으면 "small"

# (4) 전체 인구 대비 아시아인 인구 백분율 (ratio_asian) 변수를 추가.
# 하위 10개 지역의 state, county, 아시안인 구 백분율을 조회



#### Data Preprocessing ####

### (1) 변수 이름 변경
df_raw <- data.frame(var1 = c(1,2,3), var2 = c(2,3,4))
df_raw

#기본(내장) 함수
names(df_raw)
names(df_raw) <- c("v1", "v2")
names(df_raw)

#dplyr
library(dplyr)
rename(df_raw, var1 = v1, var2= v2)
names(df_raw)

### (2) 결측치 처리
data1 <- read.csv("../data/dataset.csv", header = T)
head(data1)
str(data1)
# resident : 1~5까지의 값을 갖는 명목변수로 거주지를 나타냄
# gender : 1~2까지의 값을 갖는 명목변수로 남/녀를 나타냄
# job : 1~3까지의 값을 갖는 명목변수. 직업을 나타냄
# age : 양적변수(비율) : 2~69
# position : 1~5까지의 값을 갖는 명목변수. 직위를 나타냄
# price : 양적변수(비율) : 2.1 ~ 7.9
# survey : 만족도 조사 : 1~5까지 명목변수

## 1) 결측치 확인
table(is.na(data1))

summary(data1)
summary(data1$price)

## 2) 결측치 제거
sum(data1$price, na.rm = T)
summary(data1$price)

price2 <- na.omit(data1$price)
summary(price2)

## 3) 결측치 대체
price3 <- ifelse(is.na(data1$price), 0, data1$price)
summary(price3)

price4 <- ifelse(is.na(data1$price),
                 round(mean(data1$price), na.rm = T)
                  data1$price)
summary(price4)

### (3) 이상치 처리

## 질적 데이터 : 도수분포표, 분할표 > 막대 그래프, 원 그래프
table(data1$gender)
barplot(table(data1$gender))
pie(table(data1$gender))

## 양적 데이터 : 산술평균, 중앙값,조화평균 >히스토그램,
## 상자그래프, 시계열 그래프 ,산포도
plot(data1$price)
boxplot(data1$price)

## 이상치 확인  - 주관점 
data2 <- subset(data1, price >= 2 & price <=8)

length(data1$price)
length(data2$price)


plot(data2$price)
boxplot(data2$price)

summary(data2$age)
plot(data2$age)
boxplot(data2$age)


#### Feature Engineering ####

View(data2)

## 가독성을 위한 데이터 변경

data2$resident2[data2$resident == 1] <- "1.서울특별시"
data2$resident2[data2$resident == 2] <- "2.인천광역시"
data2$resident2[data2$resident == 3] <- "3.대전광역시"
data2$resident2[data2$resident == 4] <- "4.대구광역시"
data2$resident2[data2$resident == 5] <- "5.시구군"

View(data2)

##척도 변경 : Binning(양적 -> 질적)
## 나이 변수를 청년층(30세 이하), 중년층(31-55이하), 장년층(56-)

data2$age2[data2$age <= 30] <- "청년층"
data2$age2[data2$age > 30 & data2$age <= 55] <- "중년층"
data2$age2[data2$age > 55] <- "장년층"

View(data2)

##역코딩 : 주로 설문조사에서 사용되는 리쿠르트 척도의 순서

table(data2$survey)

data2$survey2 <- 6 - data2$survey
table(data2$survey2)

## Dummy : 척도 변경(질적 -> 양적) -> 0또는 1로 변환 (onehot incoding)
house_data <- read.csv('../data/user_data.csv',fileEncoding = "euc-kr", header =T)
View(house_data)

# house_type(거주 유형) : 단독주택(1), 다가구주택(2), 아파트(3), 오피스텔(4)
house_data$house_type2 <- ifelse(house_data$house_type == 1 |
                                   house_data$house_type == 2, 0, 1)
table(house_data$house_type2)
View(house_data)

## 데이터의 구조 변경(wide type, long type)
##reshape, reshape2, tidyr, ...
## melt(): wide -> long로 변경, cast()
#install.packages("reshape2")
library(reshape2)

head(airquality) #wide 형, feature 가 column 순으로 나열되어있다
str(airquality)

m1 <- melt(airquality, id.vars = c("Month", "Day"))
View(m1)

m2 <- melt(airquality, id.vars = c("Month", "Day"),
           variable.name = "Climate_var",
           value.name = "Climate_val")
View(m2)

?dcast

dc1 <- dcast(m2, Month+Day ~ Climate_var) #formula ~ 를 사용하면 인자위치를 고정시켜서 유용하게 쓰임

View(dc1)

##예제1
data1 <- read.csv("../data/data.csv")
View(data1)

#날짜별로 컬럼을 생성해서 wide 하게 변경
dc2 <- dcast(data1, Customer_ID ~ Date)
View(dc2)

#다시 long형으로 변경
m3 <- melt(dc2, id.vars = "Customer_ID", variable.name = "Date", value.name = "Buy")
View(m3)

##예제2
data2 <- read.csv("../data/pay_data.csv", fileEncoding = "euc-kr")
View(data2)

#product_type 을 wide하게 변경

#dc3 <- dcast(data2, user_id ~ product_type)
dc3 <- dcast(data2, user_id+pay_method ~ product_type)
View(dc3)


#### 주제: 극단적 선택의 비율은 어느 연령대가 가장 높은가? ####
# 사망원인 통계
# 자살 방지를 위한 도움의 손길은 누구에게 더 지원해야 할까

#자살율이 높은비중 내림차순별로 정렬 나이 남, 여, 통합

install.packages("dplyr")
library(dplyr)
ls("pakage:dplyr")

suicide_data <- read.csv("../data/2019_suicide.csv", fileEncoding = "utf-8", skip =1)
View(suicide_data)

#컬럼 제거, 컬럼명 변경
suicide_data <- suicide_data[, -1]
names(suicide_data) <- c("성별", "연령", "사망자수", "사망율")
View(suicide_data)

#결측치 처리, 사망율 - 값 0으로 변환

suicide_data$사망율 <- ifelse(is.na(suicide_data$사망율), 0, suicide_data$사망율)
View(suicide_data)

str(suicide_data)

#이상치 확인 및 처리

suicide_data$사망율 <- ifelse(suicide_data$사망율 > 100, 100, suicide_data$사망율)
view(suicide_data)

# 취약 연령층 확인, 남녀, 남자, 여자자

suicide_total_num <- suicide_data %>% arrange(desc(사망자수)) %>% filter(성별 == "계")
head(suicide_total_num)
suicide_total_per <- suicide_data %>% arrange(desc(사망율)) %>% filter(성별 == "계")
head(suicide_total_per)
#전 연령층 사망자 수 기준: 45-49세가 취약층이고, 사망율 기준 90세이상이 높다.

suicide_total_num <- suicide_data %>% arrange(desc(사망자수)) %>% filter(성별 == "남자")
head(suicide_total_num)
suicide_total_per <- suicide_data %>% arrange(desc(사망율)) %>% filter(성별 == "남자")
head(suicide_total_per)

#남자 연령층 사망자 수 기준: 55-59세가 취약층이고, 사망율 기준 80세이상이 높다.

suicide_total_num <- suicide_data %>% arrange(desc(사망자수)) %>% filter(성별 == "여자")
head(suicide_total_num)

suicide_total_per <- suicide_data %>% arrange(desc(사망율)) %>% filter(성별 == "여자")
head(suicide_total_per)

#여자자 사망자 수 기준: 35-39세가 취약층이고, 사망율 기준 90세이상이 높다.

#결과:
#전 연령층 사망자 수 기준: 45-49세가 취약층이고, 사망율 기준 90세이상이 높다.
#남자 연령층 사망자 수 기준: 55-59세가 취약층이고, 사망율 기준 80세이상이 높다.
#여자 사망자 수 기준: 35-39세가 취약층이고, 사망율 기준 90세이상이 높다.



#### Database 연동 ####
# https://mariadb.com/kb/en/rmariadb/

install.packages("rJava")
install.packages("DBI")
install.packages("RMySQL")

library(RMySQL)

conn <- dbConnect(MySQL(), dbname="testdb", user = "root", "1111")
conn

dbListTables(conn)

result <- dbGetQuery(conn, "select * from emp")
result

dbListFields(conn, "emp")

# DML

dbSendQuery(conn, 'delete from tbla')
dbGetQuery(conn, "select *from tbla")

# 파일로부터 데이터를 읽어들여 DB에 저장
file_score <- read.csv("../data/score.csv", header = T)
file_score

dbWriteTable(conn, "score", file_score, row.names = F)

result <- dbGetQuery(conn, "select * from score")
result

dbDisconnect(conn)



#### sqldf ####

#RMYSQL 패키지 연결 끊기
detach("package:RMySQL", unload = T)

install.packages("sqldf")
library(sqldf)

head(iris)
sqldf("select * from iris limit 6")

#품종별로 sepal.length, petal.length 를 10개까지 조회
#단, petal.length가 큰 순으로 정렬하여 조회

iris %>% select(Species, Sepal.Length, Petal.Length) %>%
  group_by(Species) %>%
  arrange(desc(Petal.Length)) %>%
  head(10)

sqldf('select Species, "Sepal.Length", "Petal.Length" from iris group by Species order by "Petal.Length" desc limit 10')

# 중복된 품종 제거
unique(iris$Species)
sqldf("select distinct species from iris")

table(iris$Species)
sqldf("select species, count(species) from iris group by species")
