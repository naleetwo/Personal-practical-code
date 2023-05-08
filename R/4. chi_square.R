#### 실습1 ####
# 주제: 자동차의 실린더 수와 변속기의 관계를 알고 싶다.

View(mtcars)

# 실린더 수와 변속기 종류 파악

table(mtcars$cyl, mtcars$am)

# 테이블의 가독성을 높이기 위해 전처리
mtcars$tm <- ifelse(mtcars$am == 0, "auto", "manual")
result <- table(mtcars$cyl, mtcars$tm)
result

barplot(result)

# Plot the scatter plot
plot(x, y)

#auto의 눈금이 벗어났기 때문에 최대값을 알 수 없다.(눈금 조정)
barplot(result, ylim=c(0, 10))

# 범례 추가
barplot(result, ylim =c(0, 20), legend = rownames(result))

myrownames <- paste(rownames(result), "cyl")
myrownames
barplot(result, ylim = c(0,20), legend = myrownames)

# 그래프를 수직으로 나누기
barplot(result, ylim = c(0, 20), legend = myrownames, beside = T, horiz = T)

# 색상
barplot(result, ylim = c(0, 20), legend = myrownames, beside = T, horiz = T,
        col = c("tan1", "coral2", "firebrick2"))

result
#행과 열의 합계
addmargins(result)

chisq.test(result)

fisher.test(result)

#### 실습2 ####
# 주제 : 시군구와 다가구 자녀지원 조례가 관계가 있는가?

mydata <- read.csv("C:/seokwonna/Rwork/data/anova_two_way.csv", fileEncoding = "euc-kr")
View(mydata)

result <- table(mydata$ad_layer, mydata$multichild)

barplot(result)

# Plot the scatter plot
plot(x, y)

#auto의 눈금이 벗어났기 때문에 최대값을 알 수 없다.(눈금 조정)
barplot(result, ylim=c(0, 10))


#행과 열의 합계
addmargins(result)

chisq.test(result)
#p-value = 0.7133 > 0.05 / 관계가 없다
#카이제곱 approximation은 정확하지 않을수도 있습니다 / 기대도수가 높으므로 fisher's exact test 로 검증
fisher.test(result)
#p-value = 0.7125 > 0.05 / 관계가 없다.

#### 실습3 : Cocran-Armitage Trend Test ####

library(moonBook)
View(acs)

# 흡연 여부와 고혈압의 유무가 서로 관련이 있는가?
table(acs$HBP, acs$smoking)

acs$smoking <- factor(acs$smoking, levels = c("Never", "Ex-smoker", "Smoker"))

result <- table(acs$HBP, acs$smoking)

chisq.test(result)

### Cocran-Arimitage Trend Test
?prop.trend.test
# x : 사건이 발생한 횟수
# n : 시도한 횟수

result[2,] # 사건이 발생한 횟수(고혈압이 발생한 사람 수)
colSums(result) # 열의 합계를 보여주는 함수

prop.trend.test(result[2,], colSums(result))

### 시각화
mosaicplot(result, color = c("tan1", "firebrick2"))

t(result)
mosaicplot(t(result), color = c("tan1", "firebrick2"),
           ylab = "Hypertension", xlab = "Smoking")

# 색상 정보
colors()
demo("colors")

mytable(smoking ~ age, data = acs)
# 관계형 정보에서는 이름 ,데이터(양)

