#### 키보드 입력 ####
# scan() : 벡터 입력
# edit() : 데이터프레임 입력

a <- scan() #숫자형식의 데이터 입력. 입력을 중단할 경우 빈칸에 엔터
a

?scan
b <- scan(what = character())
b

df <- data.frame()
df <- edit(df)
df #dataframe 생성됨 데이터 편집기에 데이터 수치 입력가능




#### 파일 입력 ####
# read.csv(), read.table(), read.delim()
# read.xlsx(), read.spss()

?read.table

student <- read.table("../data/student.txt")
student

student1 <- read.table("../data/student1.txt", fileEncoding = 'euc-kr', header = T)
student1

student2 <- read.table(file.choose(), header = T, sep = ";")
student2

student3 <- read.table("../data/student3.txt", fileEncoding  = 'euc-kr', header = T,
                       na.strings = c("-", "+", "&"))
student3

### read.xlsx()
install.packages("xlsx")
library(rJava)
library(xlsx)

studentx <- read.xlsx(file.choose(), sheetIndex = 1)
studnetx
studentx1 <- read.xlsx(file.choose(), sheetName = "emp2")
studentx1

### read.spss()
#install.packages("foreign")
library(foreign)

raw_welfare <- read.spss("../data/Koweps_hpc10_2015_beta1.sav", 
                         to.data.frame = T) #테이블로 데이터가져옴
View(raw_welfare) #view함수를 써서 테이블로 봄


#### 화면 출력 ####
# 변수명
# (식)
# print()
# cat()

x <- 10
y <- 20
z <- x + y

print(z)
print(z<- x + y)

#print("x + y 의 결과는", z , "입니다.")
cat("x + y 의 결과는", z , "입니다.")


#### 파일 출력 ####
# write.csv(), write.table(), write.xlsx()

studentx <- read.xlsx("../data/studentexcel.xlsx", sheetName = "emp2")
studentx
class(studentx)

write.table(studentx, "../data/stud1.txt")
write.table(studentx, "../data/stud2.txt", row.names = F)
write.table(studentx, "../data/stud3.txt", row.names = F, quote = F)
write.csv(studentx, "../data/stud4.txt", row.names = F, quote = F)
#row.names = F, index 값 지우고 저장
#quote = F, " "

library(rJava)
library(xlsx)

write.xlsx(studentx, "../data/stud5.xlsx", row.names = F)


#### rda 파일 입출력 ####
# save()
# load()

save(studentx, file = "../data/stud6.rda")

rm(studentx)
sutdentx


load("../data/stud6.rda")
studentx


#### sink() ####

?data
data()

data(iris)
head(iris)
tail(iris)
str(iris)

sink("../data/iris.txt") #지정경로로 함수값이 출력됨 -> 출력위치 변환

head(iris)
tail(iris) #출력된 자료에 append 되어서 출력됨
str(iris)

sink() #sink() R studio Console로 출력값이 변환됨

head(iris)
