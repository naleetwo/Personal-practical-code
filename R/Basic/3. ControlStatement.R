#### 조건문 ####


# 난수 준비
?runif

x <- runif(1) # 0~1 까지의 균일 분포, rnorm()
x

# x가 0.5보다 크면 출력, {}가 조건문, 조건문이 맞지 않는다면
# 입력함수자체가 결과값으로 나옴
if(x > 0.5){
  print(x)
}

# x가 0.5보다 작으면 1-x를 출력하고 그렇지 않으면 x를 출력
if( x < 0.5 ){
  print(1-x)}else{
    print(x)
  }
if( x < 0.5) print(1-x) else print(x)

### ifelse()
ifelse (x < 0.5, 1-x, x)

?scan
### 다중 조건
avg <- scan()

if(avg >= 90){
  print("당신의 학점은 A학점입니다.")
} else if(avg >=80){
  print("당신의 학점은 B학점입니다.")
}else if(avg >=70){
  print("당신의 학점은 C학점입니다.")
}else if(avg >=60){
  print("당신의 학점은 D학점입니다.")
}else{
  print("당신의 학점은 F학점입니다.")
}

avg <- scan
switch(avr, "90" >= "당신의 학점은 A학점입니다.",
       "80" >= "당신의 학점은 B학점입니다.",
       "70" >= "당신의 학점은 C학점입니다.",
       "60" >= "당신의 학점은 D학점입니다.",
       "60" > "당신의 학점은 F학점입니다."
       )

### switch(변수, 실행문1, 실행문2, ...)

a <- "중1"
switch(a, "중1" = print("14살"), "중2" = print("15살"))
switch(a, "중1" = "14살", "중2" = "15살")
  

#별도의 기존값이 없으면 default로 n번째 값이 출력됨
#ex) b <-3, 3번째 값인 16살이 출력됨
b <- 3
switch(b, "14살", "15살", "16살")

empname <- scan(what = "")
switch(empname, hong = 250, lee = 350, kim = 200, kang = 400)

# 위의 다중 조건을 switch로 구성

avg <- scan()

if(avg >= 90){
  print("당신의 학점은 A학점입니다.")
} else if(avg >=80){
  print("당신의 학점은 B학점입니다.")
}else if(avg >=70){
  print("당신의 학점은 C학점입니다.")
}else if(avg >=60){
  print("당신의 학점은 D학점입니다.")
}else{
  print("당신의 학점은 F학점입니다.")
}

#avg <- scan()
#switch(avg, A >= 90, B >= 80, C >= 70, D >= 60, F > 60)

avg <- scan() %/% 10
result <- switch(as.character(avg), "10" = "A", "9" = "A", "8" = "B",
                 "7" = "C", "6" = "D", "5" = "F")
cat("당신의 학점은", result, "입니다.")


### which() : 값의 위치(index)를 찾아주는 함수

#vector에서 사용
x <- c(2:10)
x 

which(x == 3)
x[which(x==3)]

# matrix에서 사용
m <- matrix(1:12, 3, 4)
m 

?which #position index를 보여줌
which(m%%3 == 0)
which(m%%3 == 0, arr.ind = F)
# which() 함수는 arr.ind = F 매개변수를 사용하여 벡터 형태로 3으로 나누어 떨어지는 요소의 인덱스인 3, 6, 9, 12를 반환합니다.
which(m%%3 == 0, arr.ind = T)
# arr.ind = T 매개변수를 사용하여 행렬 형태로 3으로 나누어 떨어지는 요소의 행과 열 인덱스인 (3, 1), (1, 2), (2, 3), (3, 4)를 반환합니다.

#data.frame 에서 사용
no <- c(1:5)
name <- c("홍길동", "유비", "관우", "장비", "전우치")
score <- c(85, 78, 89, 90, 74)
exam <- data.frame(학번 = no, 이름 = name, 성적 = score)
exam

# 이름이 장비인 사람 검색
which(exam$이름 == "장비")
exam[which(exam$이름 == "장비"), ]
exam[exam$이름 == "장비", ]
exam[4, ]

# which.max(), which.min() : 숫자에서만 인식
# 가장 높은 점수를 가진 학생은?
which.max(exam$성적)
exam[which.max(exam$성적), ]

### any(), all()
x <- runif(5)
x

# x값들 중에서 0.8이상이 있는가?
any( x >= 0.8)

# x값들이 모두 0.7 이하인가?
all( x <= 0.7)


#### 반복문 ####

# 1부터 10까지의 합계
sum <- 0
for(i in seq(1, 10)){
  sum <- sum + i
}
print(sum)

sum <- 0
for(i in seq(1, 10)) sum <- sum + i
print(sum)


#### 함수 ####

### 함수 만들기

# 인자 없는 함수
test1 <- function(){
  x <- 10
  y <- 20
  return (x*y)
}
test1()

#인자있는 함수
test2 <- function(x, y){
  a <- x
  b <- y
  return (a - b)
}
test2(10, 5)
test2(y = 10, x = 5) #변수 순서는 function(x,y)이나 x = 변수, y = 변수를 직접적으로 대입하면 변수위치 상관없음

# 가변인수 ... =
test3 <- function(...){
  #print(list(...))
  for(i in list(...)) print(i)
}

test3(10)
test3(10, 20)
test3(10, 20, 30)
test3('3', '홍길동', 30)

#가변인수 실행시킬때
test4 <- function(a, b, ...){
  print(a)
  print(b)
  print("-----------------------")
  print(list(...))
}
test4(10, 20, 30, 40)

### 문자열 함수

# stringr : 정규표현식을 활용
# install.packages("stringr")
library(stringr) # require(stringr)

str1 <- "홍길동35이순신45임꺽정35"
str_extract(str1, "\\d{2}")
str_extract_all(str1, "\\d{2}") 
str_extract_all(str1, "[0-9]{2}") #[0-9] 숫자, {2}; 두자리
class(str_extract_all(str1, "[0-9]{2}"))
str_extract_all(str1, "[0-9]{1}") #{1};한자리

str2 <- "hongkd105leess1002you25TOM400강감찬2005"
str_extract_all(str2, "[a-z,A-Z,가-핳]+")

length(str2)
str_length(str2)

str_locate(str2, "강감찬")
str_locate(str2, "[가-핳]+")

str_c(str2, "유비55")
str2

### 기본 함수
sample <- data.frame(c1 = c("abc_abcdefg", "abc_ABCDE", "ccd"),
                     c2 = 1:3)
sample

sample

nchar(sample[1, 1])
which(sample[,1] == "ccd")
toupper(sample[1, 1])
tolower(sample[2, 1])
substr(sample[,1], start = 1, stop = 2) #1열 문자 2글자 가져오기
paste0(sample[,1], sample[,2]) #1열 값, 2열값 붙여넣기
paste(sample[, 1], sample[, 2], sep = "@@") #1열 값, 2열값 sep에 @@넣어서 붙여넣기

### 문자열을 분리해서 하나의 컬럼을 두 개의 컬럼으로 확장
install.packages("splitstackshape")
library(splitstackshape)

cSplit(sample, splitCols = "c1", sep = "_")

#패키지의 함수 목록 확인
ls("package:stringr")