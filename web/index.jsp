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
  <script src="js/jquery-3.2.1.min.js"></script>
  <div style="background-color: azure">
    <div id="container1" style="width: 50%;height: 100%">
      <div style="width: 100%;height: 30%;background-color: #c7dbff">

      </div>
  <div  id="container" style="width: 100%;height: 70%"></div>
    </div>
    <div id="container4" style="width: 50%;height: 100%;background-color: #c7dbff">
    <div id="container2" style="width: 100%;height: 50%;background-color: #c7dbff"></div>
    <div id="container3" style="width: 100%;height: 50%;background-color: #c7dbff"></div>
    </div>
  </div>
  <script>
      // 基于准备好的dom，初始化echarts实例
      var myEchart2=echarts.init(document.querySelector('#container2'));//显示治疗人数，死亡人数，感染人数走势
      var myEchart3=echarts.init(document.querySelector('#container3'));//显示治疗人数，死亡人数，感染人数占比
      var myEchart1 = echarts.init(document.querySelector('#container'));
      var mydata=[];
      // 指定相关的配置项和数据
      $.ajax({
          type:"post",//类型选择post/get
          async:true,//异步请求
          url:"ProvinceServlet",//请求发送到servlet
          dataType:"json",
          success:function (result) {
              for(var i=0;i<result.length;i++){
                  var d={};
                  d["name"]=result[i].name;
                  d["value"]=result[i].infectPeople;
                  d["doubtPeople"]=result[i].doubtPeople;
                  d["deadPeople"]=result[i].deadPeople;
                  d["curePeople"]=result[i].curePeople;
                  mydata.push(d);
              }

          }
      })
      myEchart1.setOption({
          title:{
              text:'全国实时疫情数据分布图',
              subtext:'',
              left:'center'

          },
          backgroundColor:'#c7dbff',
          visualMap: [    //需要后台数据
              {
                  type: 'piecewise', // continuous连续的 piecewise分段
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
              formatter : function(params) {
                  return  "地区:"+params.name
                      +'<br/>'+"确诊人数:"+params.infectPeople
                      +'<br/>'+"死亡人数"+params.deadPeople
                      +'<br/>'+"治愈人数:"+params.curePeople
                      +'<br/>'+"疑似患者人数:"+params.doubtPeople
                      ;
              }//数据格式化
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
          data:mydata
      })
      myEchart1.on('click',function (params) {
          alert(params.name);
      })
      myEchart2.setOption({
          title: {
              text: '折线图堆叠'
          },
          tooltip: {
              trigger: 'axis'
          },
          legend: {
              data: ['疑似感染人数', '确诊感染人数', '治愈人数', '死亡人数']
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
                  name: '疑似感染人数',
                  type: 'line',
                  stack: '总量',
                  data: [120, 132, 101, 134, 90, 230, 210]
              },
              {
                  name: '确诊感染人数',
                  type: 'line',
                  stack: '总量',
                  data: [220, 182, 191, 234, 290, 330, 310]
              },
              {
                  name: '治愈人数',
                  type: 'line',
                  stack: '总量',
                  data: [150, 232, 201, 154, 190, 330, 410]
              },
              {
                  name: '死亡人数',
                  type: 'line',
                  stack: '总量',
                  data: [320, 332, 301, 334, 390, 330, 320]
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
            data: ['疑似感染', '确诊感染', '治愈', '死亡']
        },
        series: [
            {
                name: '人员类型',
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
                    {value: 335, name: '疑似感染'},
                    {value: 310, name: '确诊感染'},
                    {value: 234, name: '治愈'},
                    {value: 135, name: '死亡'}
                ]
            }
        ]
    })


  </script>
  </body>
</html>
