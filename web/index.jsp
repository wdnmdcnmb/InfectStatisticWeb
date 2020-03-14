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
  <div  id="container" style="width:50%;height: 100%;float: left"></div>
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


    fetch(`http://localhost:8066/api/data`)
            .then(res => res.json()) // 把可读数据流转为json格式
            .then(res => {
             // console.log(res) // 获取到的疫情数据
              var getListByCountryTypeService1 = res.getListByCountryTypeService1
              // 将接口返回的数据进行处理 转为echarts认可的数据
              var filterData = []
              var sumcure=0;
              var sumdead=0;
              var sumdoubt=0;
              var suminfect=0;
              getListByCountryTypeService1.forEach(item => {
                filterData.push({
                  name:  item.provinceShortName,
                  value: item.confirmedCount,
                  deadCount: item.deadCount,
                  curedCount: item.curedCount,
                  doubtCount: item.suspectedCount,
                })
                sumcure+=item.curedCount;
                sumdead+=item.deadCount;
                suminfect+=item.confirmedCount;
                sumdoubt+=item.suspectedCount;
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
                    console.log(params,'formatter');
                    return  "地区："+params.data.name+'<br/>'
                            +"确诊："+params.value+"人"+'<br/>'
                            +"治愈："+params.data.curedCount+"人"+'<br/>'
                            +"死亡："+params.data.deadCount+"人"+'<br/>'
                            +"疑似："+params.data.doubtCount+"人"

                  }//数据格式化
                },
                series:[
                  {
                    type:'map',
                    map:'china',
                    label:{
                      show:true,
                    },
                    data: filterData
                    //dataType:filterData
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
                      {value: sumdoubt, name: '疑似感染'},
                      {value: suminfect, name: '确诊感染'},
                      {value: sumcure, name: '治愈'},
                      {value: sumdead, name: '死亡'}
                    ]
                  }
                ]
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
            })




  </script>
  </body>
</html>
