#### 변수####

goods <- "냉장고"

goods

# 변수 사용시 객체 형태로 사용하는 것을 권장
goods.name <- "냉장고"
goods.code <- "ref001"
goods.price <- 600000

# 줄마다 실행시켜야함

# 값을 대입할 경우 = 대신 <- 사용
goods.name <- "냉장고"
goods.code <- "ref001"
goods.price <- 600000

# 데이터 타입 확인
class(goods.name)
class(goods.price)
mode(goods.name)
mode(goods.price)



#### vector ####

# c()
v <- c(1,2,3,4,5)
v
class(v)
mode(v)

#()묶어서 실행하면 값 출력됨
# print() <- ()
(v <- c(1,2,3,4,5))
print(v <- c(1,2,3,4,5))

c(1:5)
c(1,2,3,4,"5")
#나머지 숫자 - 1,2,3,4,가 문자열로 바뀜

#seq()
?seq
seq(from = 1, to = 10, by =1)
seq(1, 10, 2)

#rep()
?rep
rep(1:3, 3)

# 벡터의 접근
v <- c(1:50)
v[10:45]
length(v)
v[10 : length(v) - 5]
v[10: (length(v)-5)]
 
v1 <- c(13, -5, 20:23, 12 , -2:3)
v1

v1[1]
v1[c(2,4)] # 2, 4번째 값을 보여줌 c 가 data를 combine 해서 한꺼번에 보여줌
v1[c(4, 5:8, 7)]
v1[-1]
# [-1]는 첫번째 데이터 제거
v1[-2]
v1[c(-2, -4)]

v1[-c(2,4)]

#집합 연산

x <- c(1, 3, 5, 7)
y <- c(3, 5)
union(x, y); setdiff(x, y); intersect(x, y)

# 컬럼명 지정
age <- c(30, 35,40)
names(ages) <- c('홍길동', '임꺽정', '신돌석')
age

#특정 변수의 데이터 제거
age <- NULL
age

# 벡터 생성의 또 다른 표현
X <- C(2, 3)
X <- (2:3) #C 생략가능









#### factory ####

gender <- c('man', 'women', 'man')
class(gender)
mode(gender)

is.factor(gender)

ngender <- as.factor(gender)
ngender

class(ngender) #추가된 별도의 클래스로 묶여진 형식은 식별가능
mode(ngender)
is.factor(ngender)

plot(ngender)
# plot(gender) 범주형으로 묶여있어서 
table(ngender)

?factor
gfac <- factor(gender, levels = c('women', 'man'))
gfac

plot(gfac)


#### Matrix ####

# matrix()
?matrix()

matrix((1:5))
matrix(c(1:11),nrow = 2) #숫자 배열이 안맞으면 처음숫자부터 다시 시작함
matrix((1:10), nrow = 2)
m <- matrix((1:10), nrow = 2, byrow = T) # T <- True
class(m)
mode(m)


# rbind(), cbind()

x1 <- c(3, 4, 50:52)
x2 <- c(30, 5, 6:8, 7, 8)
x1
x2

rbind(x1, x2) #배열이 부족한 값은 처음수부터 채워진다

cbind(x1, x2)

#matrix 의 차수 확인

x <- matrix(c(1:9), ncol = 3)
x

length(x) #전체 길이

length(x); nrow(x); ncol(x); dim(x) #반복구문 사용할때 데이터확인할시 필요함

#컬럼명 지정
colnames(x) <- c("one", "two", "three")
x
colnames(x)

#apply()
?apply

apply(x, 1, max) # 행과 열
apply(x, 2, max)
apply(x, 1, sum)
apply(x, 2, sum)




#### DataFrame ####

# data.frame()
#column(열 생성)
no <- c(1, 2, 3) 
name <- c('hong', 'lee', 'kim')
pay <- c(150.25, 250.18, 300.34)
#각 열의 값을 지정해줌
emp <- data.frame(NO = no, Name = name, Payment = pay) 
emp

# 파일을 읽어들일때 사용되는 함수
# read.csv(), read.table(), read.delim()

#get working directory
getwd()

read.table("../data/emp.txt")
txtemp <- read.table("../data/emp.txt",header = T, sep = " ")
class(txtemp)
mode(txtemp)

setwd("../data")
getwd()

csvemp <- read.csv('emp.csv')
csvemp

read.csv("emp.csv", col.name = c('사번', '이름', '급여'))

read.csv("emp2.csv",fileEncoding = 'euc-kr', encoding = 'utf-8', header = F, col.name=c('사번', '이름', '급여'))
aws <-read.delim("AWS_sample.txt", sep = "#")
head(aws) #6개만 가져옴

View(aws) #dataframe으로 데이터 보여줌

#접근
aws[1, 1] [행, 열]

x1 <- aws[1:3, 2:4]
x1

x2 <- aws[9:11, 2:4]
x2

cbind(x1, x2)
rbind(x1, x2)

class(aws[,1])
mode(aws[,1])

aws[, 1]
aws$AWS_ID #같은표현임

#구조 확인
str(aws)

#기본 통계량 확인
summary(aws)

#apply()
df <- data.frame(x=(1:5), y = seq(2, 10, 2), z = c("a", "b", "c", "d", "e"))
df

apply(df[,c(1, 2)], 1, sum)
apply(df[,c(1, 2)], 2, sum)

# 데이터의 일부 추출
subset(df, x >=3 )
subset(df, x >= 2 & y <= 6)

# 병합
height <- data.frame(id = c(1, 2), h = c(180, 175))
weight <- data.frame(id = c(1, 2), h = c(80, 75))

merge(height, weight, by.x = "id", by.y = "id")


#### Array ####

v <- c(1 : 12)
v

arr <- array(v , c(4, 2, 3)) #행, 열, 면
arr

# 접근
arr[,,1] #전체 행, 전체 열, 1 면
arr[,,2]
arr[,,3]

# 추출
arr[2, 2, 1]
arr[,,1][2,2]



#### List ####
#다차원의 multiple 데이터를 묶어서 사용하기 위한 함수

x1 <- 1
x2 <- data.frame(var1 = c(1, 2, 3), var2 = c('a', 'b', 'c'))
x3 <- matrix(c(1:12), ncol = 2)
x4 <- array(1:20, dim = c(2, 5, 2))

x5 <- list(c1 = x1, c2 = x2, c3 = x3, c4 = x4)

x5$c2

list1 <- list(c("lee", "kim"), "이순신", 95)
list1 #변수명을 주지 않으면  index 형식으로 data가 저장됨

list1[1]
list1[[1]]
list1[[1]][1]
list1[[1]][2]

list1 <- list("lee", "이순신", 95)
list1

un <- unlist(list1)
un
class(un)

# lapply(), sapply()
# lapply() : apply()는 2차원 데이터만 입력을 받는다. vector 또는 그 이상의 차원을 입력받기 위한 방법으로 사용. 반환형은  list형이다.
# sapply() : 반환형이 matrix 또는 vector 로 반환을 한다(lapply의 wrapper). 
a <- list(c(1:5))
a

b <- list(c(6:10))
b

c <- c(a,b)
c
class(c)

x <- lapply(c, max) #list에서 사용하기위한 apply 함수
#lapply(X, FUN), X= 데이터, FUN = 적용할 함수, list 형태로 반환
x1 <- unlist(x)
x1

sapply(c , max)
#sapply(X, FUN), X= 데이터, FUN = 적용할 함수, vector 형태로 반환

#### 기타 데이터 타입 ####

#날짜

Sys.Date()
Sys.time()

a <- '23/3/31'
class(a)

b <- as.Date(a)
b
class(b)

as.Date(a, "%y/%m/%d")

