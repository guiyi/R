#install.packages("DBI")  #安装包
#install.packages("RMySQL")
#installed.packages() #已安装的包
#(.packages())

library(DBI)
library(RMySQL)

con <- dbConnect(MySQL(),host="localhost",dbname="lagou",user="root",password="root")
#summary(con)
dbReadTable(con,'lianjia_hefei')
res <- dbSendQuery(con, "SELECT *FROM lianjia_hefei")
res <- dbSendQuery(con, "SELECT *FROM lianjia_hefei")
data <- dbFetch(res, n=2) #取前2条数据，n=-1时是获取所有数据
data
data <- dbFetch(res, n=-1) #取余下所有数据
data
dbClearResult(res)
dbDisconnect(con) #断开连接




#用SQL语句批量查询
con <- dbConnect(MySQL(),host="localhost",dbname="lagou",user="root",password="root")
sql <- "SELECT * FROM lianjia_hefei;"
res <- dbSendQuery(con,sql)
dbFetch(res, n = -1)



sql1 <-'SELECT
	area,
	sum(allhouse) amount
FROM
	lianjia_hefei
GROUP BY
	area
ORDER BY
	amount DESC;'

res1 <- dbSendQuery(con,sql1)
v <- dbFetch(res1, n = -1)
area <- as.character(v[,1])
amount <- as.numeric(v[,2])
v <- c(7,12,28,3,41)

#折线图
	plot(amount ,xaxt="n",type = "o", col = "red", xlab = "区域", ylab = "可卖套数",main = "2017.05合肥二手房各区域可卖套数
	")
	#x轴值
	axis(1,at=1:length(area),labels=area)
	#数据标签
	#x轴，y轴，y轴
	text(axis(1,at=1:length(area),labels=area),amount,amount,cex=1.5,pos=1, col = "red")


#条形图标签，标题和颜色

	barplot(amount,names.arg = area,xlab = "区域",ylab = "可卖套数",col = "blue",main = "2017.05合肥二手房各区域可卖套数
	",border = "red")
	text(axis(1,at=1:length(area),labels=area),amount,amount,cex=1.5,pos=1, col = "red")
#饼图
	1.pie(amount,area)
	
	2.
	#计算每个功能所占的比重（保留2位小数，可自己设定小数位数）
	ratio=sprintf("%.2f",100*amount/sum(amount)) 
	#计算之后画图时需要加上百分比
	ratio=paste(ratio,"%",sep="")
	#设定之后画图时需要加上的信息。
	label=paste(area, ratio,sep="\n") 
	pie(amount,labels=label,font=2,main = "2017.05合肥二手房各区域可卖套数")
	3.#3D饼图
	library(plotrix)
	pie3D(amount,labels = label,explode = 0.1, main = "2017.05合肥二手房各区域可卖套数 ")








if (dbMoreResults(con)) {
  res2 <- dbNextResult(con)
  dbFetch(res2, n = -1)
}
dbListResults(con)
dbClearResult(res1)
dbClearResult(res2)
 
dbDisconnect(con)