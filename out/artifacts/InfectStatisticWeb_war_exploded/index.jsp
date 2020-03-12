<%@ page import="java.util.List" %>
<%@ page import="Infectstatic.pojo.Province" %>
<%@ page import="java.lang.reflect.Parameter" %><%--
  Created by IntelliJ IDEA.
  User: 外星人
  Date: 2020/3/10
  Time: 18:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>中国地图</title>
    <link href="css/indexdiv.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
  <!-- 引入 ECharts 文件 -->
  <script src="js/echarts.min.js"></script>
  <script src="js/china.js"></script>
  <div style="background-color: azure">
  <div id="container1" style="width: 50%;height: 100%"></div>
    <div id="container4" style="width: 50%;height: 100%;background-color: azure">
    <div id="container2" style="width: 100%;height: 50%;background-color: azure"></div>
    <div id="container3" style="width: 100%;height: 50%;background-color: azure"></div>
    </div>
  </div>
  <script>
      // 基于准备好的dom，初始化echarts实例
      var myEchart1 = echarts.init(document.querySelector('#container1'));
      var myEchart2=echarts.init(document.querySelector('#container2'));//显示治疗人数，死亡人数，感染人数走势
      var myEchart3=echarts.init(document.querySelector('#container3'));//显示治疗人数，死亡人数，感染人数占比
       //↓↓实现请求接口
<%
            List<Province> provinces=(List)request.getAttribute("provinces");
%>
      //↑↑实现请求接口
      // 指定相关的配置项和数据
      myEchart1.setOption({
          title:{
              text:'全国实时疫情数据分布图',
              subtext:'',
              left:'center'

          },
          backgroundColor:'#c7dbff',
          visualMap: [    //需要后台数据
              {
                  type: 'continuous', // continuous连续的 piecewise分段
                  pieces: [
                      { gt: 10000 }, // (10000, Infinity]
                      { gt: 1000, lte: 9999 }, // (1000, 9999]
                      { gt: 100, lte: 999 }, // (100, 999]
                      { gt: 10, lte: 99 }, // (10, 99]
                      { gt: 0, lte: 9 } // (0, 9]
                  ],
                  inRange: {
                      color: ['#fdebcf', '#f59e83', '#e55a4e', '#cb2a2f', '#811c24']
                  }
              }
          ],
          tooltip:{
            formatter:function () {
                return '地区:湖北<br/>确诊：100人<br/>治愈：12人<br/>死亡：56人<br/>'
            }
          },
          series:[
              {
                  type:'map',
                  map:'china',
                  label:{
                      show:true,
                  }
              }
          ],
          //data:provinces
      })
      myEchart2.setOption({
          title: {
              text: '折线图堆叠'
          },
          tooltip: {
              trigger: 'axis'
          },
          legend: {
              data: ['邮件营销', '联盟广告', '视频广告', '直接访问', '搜索引擎']
          },
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          toolbox: {
              feature: {
                  saveAsImage: {}
              }
          },
          xAxis: {
              type: 'category',
              boundaryGap: false,
              data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
          },
          yAxis: {
              type: 'value'
          },
          series: [
              {
                  name: '邮件营销',
                  type: 'line',
                  stack: '总量',
                  data: [120, 132, 101, 134, 90, 230, 210]
              },
              {
                  name: '联盟广告',
                  type: 'line',
                  stack: '总量',
                  data: [220, 182, 191, 234, 290, 330, 310]
              },
              {
                  name: '视频广告',
                  type: 'line',
                  stack: '总量',
                  data: [150, 232, 201, 154, 190, 330, 410]
              },
              {
                  name: '直接访问',
                  type: 'line',
                  stack: '总量',
                  data: [320, 332, 301, 334, 390, 330, 320]
              },
              {
                  name: '搜索引擎',
                  type: 'line',
                  stack: '总量',
                  data: [820, 932, 901, 934, 1290, 1330, 1320]
              }
          ]
      })
    myEchart3.setOption({
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b}: {c} ({d}%)'
        },
        legend: {
            orient: 'vertical',
            left: 10,
            data: ['直接访问', '邮件营销', '联盟广告', '视频广告', '搜索引擎']
        },
        series: [
            {
                name: '访问来源',
                type: 'pie',
                radius: ['50%', '70%'],
                avoidLabelOverlap: false,
                label: {
                    normal: {
                        show: false,
                        position: 'center'
                    },
                    emphasis: {
                        show: true,
                        textStyle: {
                            fontSize: '30',
                            fontWeight: 'bold'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data: [
                    {value: 335, name: '直接访问'},
                    {value: 310, name: '邮件营销'},
                    {value: 234, name: '联盟广告'},
                    {value: 135, name: '视频广告'},
                    {value: 1548, name: '搜索引擎'}
                ]
            }
        ]
    })
  </script>
  </body>
</html>
