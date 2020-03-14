
# 疫情统计-疫情地图可视化：


### 本次作业链接:[点击这里](https://edu.cnblogs.com/campus/fzu/2020SpringW/homework/10456)
### 结对学号: 221701416 | 221701434 
### 项目介绍:
#### 1.需求:
1.疫情发生以来，疫情数据起到了积极作用。民众也通过疫情信息来判断自己当前地区的感染情况。

2.当前，全民抗击新冠肺炎疫情进入逐步恢复产能的新阶段，在逐步恢复产能时，民众迫切需要一款能够及时直观的获取疫情分布图以及疫情当前信息的软件。
#### 2.功能:
1.展示所有省份的感染程度，通过颜色加以区分，以及在图上显示死亡，治愈，累计感染人数

2.通过折线图，分别展示确诊人数，累计感染，治愈/死亡，以时间为横坐标，人数为纵坐标

3.通过饼状图，简洁明了的显示当前感染占比
#### 3.好处:
1.访问简易化，通过网页能够直观显示当前疫情状况

2.简单的操作以及简洁明了的界面，保证了使用上的便携性以及交互性

3.可视化明显，能让用户在不知道数据的情况下就能了解全国感染情况

4.在网页中推送实时疫情信息，保证时效性

### 项目的构建与运行:
#### 1.技术和框架:
1.本次结对任务通过前端JSP嵌入echarts实现中国地图可视化

2.本次结对任务通过后端Java代码以及servlet方法来响应客户端的所有请求

3.本次作业采用后端nodeJS技术进行网络爬虫，通过fetch部署接口，跨域访问得到我们需要的疫情数据
#### 2.构建:
1.基于web平台，通过前端实现疫情数据可视化，将后端数据有效的呈现出来

2.使用JAVA语言进行后端数据处理，丰富逻辑功能，自行处理日志文件


4.通过JSON传递爬到的数据给echarts表格，实现数据动态更新
#### 3.项目的运行:
1.打开项目

2.启动server目录下的index.js，若启动成功则会显示:当前服务器启动成功 http://localhost:8066/api/data

3.启动index.js成功后，启动web目录下的index.jsp（部署在tomcat上）进行网页访问