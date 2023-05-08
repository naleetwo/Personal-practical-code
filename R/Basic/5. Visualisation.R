#### 기본 내장 그래프 ####

### 1. plot()
# plot(y축 데이터, 옵션)
# plot(x축 데이터, y축 데이터,옵션)

y = c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5) #x값이 없을때 x는 순서 값으로 표시됨
plot(y, xlim = c(0, 5), ylim = c(0, 5))

x <- 1:10
y <- 1:10
plot(x, y)

# type : "p", "l", "b", "o", "n"
# pch : plot 종류 
# lty : "solid", "blank", "dashed", "dotted", "dotdash", "longdash", "twodash"
plot(x, y, xlim = c(0, 20), ylim = c(0, 30), main = "Graph",
     type = "l", pch = 2, cex = 1.2, col = "red", lty = "longdash")

?plot

str(cars)
head(cars)
plot(cars, type = "o")
View(cars)

# 같은 속도일때 제동거리가 다를 경우 대체적인 추세를 알기 어렵다.
# 속도에 따른 평균 제동거리를 구해서 그래프로 그려보자.

library(dplyr)

cars2 <- cars %>% group_by(speed)%>%
  summarise(mean_dist = mean(dist))
cars2
plot(cars2)
str(cars2)

?tapply

cars3 <- tapply(cars$dist, cars$speed, mean)
cars3
plot(cars3, ylab = "distance", xlab = "speed")

### 2. points()
plot(iris$Sepal.Width, iris$Sepal.Length)
plot(iris$Petal.Width, iris$Petal.Length)

with(iris,
     {
       plot(Sepal.Width, Sepal.Length)
       plot(Petal.Width, Petal.Length)
     })

with(iris,
     {
       plot(Sepal.Width, Sepal.Length)
       points(Petal.Width, Petal.Length)
     })

### 3. lines()
plot(cars)
lines(cars)

### 4. barplot(), hist(), pie(), mosaicplot(), pair()
# persp(), contour(), ...

### 5. 그래프 배열
head(mtcars)
?mtcars

## (1) 그래프 4개를 동시에 그리기
par(mfrow = c(2, 2))
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)
boxplot(mtcars$wt)

par(mfrow = c(1,1))
plot(mtcars$wt, mtcars$mpg)


## (2) 행과 열마다 그래프 개수를 다르게 설정
?layout
layout(matrix(c(1, 1, 2, 3), 2, 2, byrow = T))
#2행2열로 배열을 설정, byrow = T 일때 그래프  1, 1 가 보여짐, F 일때 1, 2
#                                             2, 3                   1, 3
#그래프의 배열을 순서대로 나열해줌
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)

par(mfrow = c(1, 1))

### 6. 특이한 그래프

## (1) arrows()
x <- c(1, 3, 6, 8, 9)
y <- c(12, 56, 78, 32, 9)

plot(x, y)
arrows(3, 56, 1, 12)
text(4, 40, "이것은 샘플입니다.", srt = 60)

## (2) 꽃잎 그래프
x <- c(1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 4, 5, 6, 6, 6)
y <- c(2, 1, 4, 2, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1)

plot(x, y)

sunflowerplot(x, y)

## (3) 별 그래프
# 데이터의 전체적인 윤곽을 살펴보는 그래프
# 데이터 항목에 대한 변화의 정도를 한눈에 파악

str(mtcars)

?stars

stars(mtcars[1:4]) 
stars(mtcars[1:4], key.loc = c(13, 2))
stars(mtcars[1:4], key.loc = c(13, 2),flip.labels =  F)
stars(mtcars[1:4], key.loc = c(13, 2),flip.labels =  F,
      draw.segments = T)
## (4) symbols

 x <- c(1,2,3,4,5)
 y <- c(2,3,4,5,6)
 z <- c(10, 5, 100, 20, 10)

 symbols(x, y, z)
 
 

#### ggplot2 ####
 # install.packages("ggplot2")
 # https://r-graph-gallery.com/ggplot2-package.html 
 
 # 레이어 지원
 
# 1) 배경지원(데이터)
# 2) 그래프 추가(,점, 선, 막대, ...)
# 3) 설정(옵션) 추가(축 범위, 범례, 색, ... )

###(1) 산포도 
 library(ggplot2)

 mpg <- ggplot2::mpg 
?ggplot2 
 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() +
  xlim(3, 6) + ylim(10, 30)

# midwest 데이터를 이용하여 전체인구(poptotal)와 아시아 인구
#(popasian) 간에 어떤 관계가 있는지 알아보려고 한다.
# x축은 전체 인구, y 축은 아시안 인구로 된 산포도 작성
# 단, 전체인구는 30만명 이하, 아시아 인구는 1만명 이하인 지역만
# 산포도 표시

library(dplyr)
library(ggplot2)
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
str(midwest)

#ggplot(data = midwest, mapping = aes(x = poptotal, y = popasian)) + geom_point() + xlim(0, 300000) + ylim (0, 10000)

options(scipen = 99) #지수를 숫자로 표시
ggplot(midwest, aes(poptotal, popasian)) + geom_point() + xlim(0,300000) + ylim(0, 10000)

### (2) 막대 그래프 : geom_col(), 히스토그램: geom_bar()
# mpg 데이터에서 구동방식(drv)별로 고속도로 평균연비를 조회하고 
# 그 결과를 막대 그래프로 표현
library(dplyr)
str(ggplot2::mpg)
str(test)
View(mpg)

mpg_drv <- mpg%>%group_by(drv)%>%
  summarise(mean_hwy = mean(hwy))
mpg_drv
#ggplot(mpg_drv, aes(drv, mean_hwy)) + geom_col()
ggplot(mpg_drv, aes(reorder(drv, mean_hwy), mean_hwy)) + geom_col()
#reorder 사용하면 오름차순서대로 정렬할수있음

ggplot(mpg_drv, aes(reorder(drv, -mean_hwy), mean_hwy)) + geom_col()
#reorder에서 y값에 - 사용하면 내림차순서대로 정렬할수있음

#히스토그램표현
ggplot(mpg, aes(drv)) + geom_bar()
ggplot(mpg, aes(hwy)) + geom_bar()

# 어떤 회사에서 생산한 'suv' 차종의 도시연비가 높은지 알아보려고 한다.
# suv차종을 대상으로 평균 cty 가 가장 높은 회사 다섯 곳을 조회하고 그래프로 출력
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)
mpg_class <- mpg %>% filter(class == "suv") %>%
  group_by(manufacturer)%>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)
mpg_class

ggplot(mpg_class) 

#자동차 종류 중에서 어떤 종류(class가)가장 많은지 알아보려고 한다. 
# 자동차 종류별 빈도를 그래프로 출력

### (3) 선 그래프 : geom_line()

str(economics)
head(economics)
tail(economics)

ggplot(data = economics, aes(date, unemploy)) + geom_line()
ggplot(data = economics, aes(date, pop)) + geom_line()

### (4) 상자 그래프 : geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()

# mpg 데이터에서 class가 "compact", "subcompact", "suv"인 자동차의 cty가 
# 어떻게 다른지 비교하려고 한다.
# 이 세 차종의 도시 연비를 비교

class_cty <- mpg%>%filter(class)%>%select(class, cty)
ggplot(class_cty, aes(class, cty)) + geom_boxplot()

mpg_class <- mpg %>%
  filter(class %in% c("compact", "subcompact", "suv")) %>%
  select(class, cty)
ggplot(mpg_class, aes(class, cty)) + geom_boxplot()

### (5) iris 실습
str(iris)

## 꽃받침(Sepal)의 길이가 따라서 폭의 크기가 어떤 관계인지 분포를 확인

ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point(colour = "blue", pch =1, size = 3)

ggplot(iris, aes(Sepal.Length, Sepal.Width, color=Species, size=Pelta.Length)) + geom_point()
      labs(title = "꽃받침의 비교")
      subtitle = "꽃받침의 길이에 대한 록의 크기를 확인"
      caption = '주석 달기'
       x = "꽃받침의 길이"
       y = "꽃받침의 폭"
       
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point(colour = c("red", "green", "blue")[iris$Species],
             pch = c(0, 2, 20)[iris$Species],
             size = c(1, 3, 5)[iris$Species])

## 같은 y축에 여러 그래프 그리기(선 그래프)

# 1) 순서를 갖는 데이터 준비
str(iris)
View(iris)
rownames(iris)

seq <- as.integer(rownames(iris))
View(seq)
iris_data <- cbind(id = seq_along(seq), iris)
head(iris_data)

# 2) 각 데이터에 대한 색상(rainbow(), heat.colors(),terrain.colors(), topo.colors(), cm.colors())

ex <- topo.colors(30)
pie(rep(1, 30), col = ex)

# 3) wide 형을 long형으로
library(reshape2) 

mdata <- melt(iris_data, id.vars = c("id", "Species"))
View(mdata)
g <- ggplot(mdata) + geom_line(aes(id, value, color = variable, cex = 0.8))
g

cols = topo.colors(4, alpha = 0.5)
cols

names(cols) <- names(iris_data)[2:5]
cols

g + scale_color_manual(name = "변수명", values = cols)




#### 텍스트 마이닝과 워드 크라우드 ####

install.packages("memoise")
install.packages("multilinguer")
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages("remotes")

remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"), force = TRUE)

library(KoNLP)

#### 지도 시각화 ####
#R 11장에 나와있음

install.packages("mapproj")
install.packages("ggiraphExtra") 

library(ggiraphExtra)

str(USArrests)
head(USArrests)
View(USArrests)
class(USArrests)

library(tibble)
crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state)

install.packages("maps")
library(ggplot2)

states_map <- map_data("state")
str(states_map)

library(mapproj)
?ggChoropleth

ggChoropleth(data = crime,
             mapping = aes(fill = Murder , map_id = state),
             map = states_map,
             interactive = T)

### 대한민국 지도 그리기
# https://github.com/cardiomoon/kormaps2014
# 책 285?pg 에 있음

install.packages("stringi")
install.packages("devtools") #외부 라이브러리 가져올때 쓰는 툴, 깃허브 연결

devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

head(korpop1)
str(korpop1)

head(kormap1)
str(kormap1)

# 컬럼 이름 변경
library(dplyr)

korpop1 <- rename(korpop1, pop = "총인구_명", name = "행정구역별_읍면동")
View(korpop1)

library(ggplot2)
library(mapproj)
library(ggiraphExtra)

ggChoropleth(data = korpop1,
             aes(fill = pop, map_id = code, tooltip = name),
             map = kormap1,
             interactive = T)

#289~297pg 까지 코드 따라 쓰기
install.packages("plotly")
library(plotly)

library(ggplot2)
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) +geom_point()
ggplotly(p)

install.packages("dygraphs")
library(dygraphs)

economics <- ggplot2::economics
head(economics)

library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)

head(eco)

dygraph(eco) #그래프 생성

dygraph(eco) %>% dyRangeSelector()
#저축율
eco_a <- xts(economics$psavert, order.by = economics$date)
#실업자 수
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

eco2 <- cbind(eco_a, eco_b)
colnames(eco2) <- c("psavert", "unemploy")
head(eco2)
dygraph(eco2) %>% dyRangeSelector()

#pg310 Markdown

#pg312, 