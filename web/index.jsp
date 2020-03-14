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
    <style>
      .p1{
        font-size: 27px;color: #F74C31;text-align: center;padding-bottom: 15px;padding-top: 15px;padding-left: 15px;padding-right: 15px
      }
      .p2{
        font-size: 27px;color: #A25A41;text-align: center;padding-bottom: 15px;padding-top: 15px;padding-left: 15px;padding-right: 15px
      }
      .p3{
        font-size: 27px;color: darkgoldenrod;text-align: center;padding-bottom: 15px;padding-top: 15px;padding-left: 15px;padding-right: 15px
      }
      .p4{
        font-size: 27px;color: #28B7A3;text-align: center;padding-bottom: 15px;padding-top: 15px;padding-left: 15px;padding-right: 15px
      }
    </style>
  </head>
  <body>
  <!-- 引入 ECharts 文件 -->
  <script src="js/echarts.min.js"></script>
  <script src="js/china.js"></script>
  <script src="js/jquery-3.2.1.min.js"></script>
  <div style="background-color: azure">
    <div style="width:50%;height: 100%;float: left;background-color: #c7dbff">
      <div style="width:100%;height: 15%">
        <table style="margin:0 auto;background-color: antiquewhite">
          <tr>
            <td><p style="font-size: 27px;text-align: center;padding-bottom: 15px;padding-top: 15px;padding-left: 15px;padding-right: 15px;color: #F74C31">现有确诊</p></td>
            <td><p style="font-size: 27px;text-align: center;padding-bottom: 15px;padding-top: 15px;padding-left: 15px;padding-right: 15px;color: #A25A41">现有疑似</p></td>
            <td><p style="font-size: 27px;text-align: center;padding-bottom: 15px;padding-top: 15px;padding-left: 15px;padding-right: 15px;color: darkgoldenrod">死亡人数</p></td>
            <td><p style="font-size: 27px;text-align: center;padding-bottom: 15px;padding-top: 15px;padding-left: 15px;padding-right: 15px;color: #28B7A3">治愈人数</p></td>
          </tr>
          <tr>
            <td><p id="p1" class="p1">123</p></td>
            <td><p id="p2" class="p2">123</p></td>
            <td><p id="p3" class="p3">123</p></td>
            <td><p id="p4" class="p4">123</p></td>
          </tr>
        </table>
      </div>
      <div  id="container" style="width:100%;height: 85%;float: left"></div>
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
    var hubeidate=[];var hubeiconfirmCount=[];var hubeicuredCount=[];var hubeideadCount=[];
    fetch(`http://localhost:8066/api/data`)
            .then(res => res.json()) // 把可读数据流转为json格式
            .then(res => {
             // console.log(res) // 获取到的疫情数据
              var getListByCountryTypeService1 = res.getListByCountryTypeService1
              var gethubei=res.gethubei
              // 将接口返回的数据进行处理 转为echarts认可的数据
              var filterData = []
              var sumcure=0;
              var sumdead=0;
              var sumdoubt=0;
              var suminfect=0;
              var x=0;
              getListByCountryTypeService1.forEach(item => {
                filterData.push({
                  name:  item.provinceShortName,
                  value: item.confirmedCount,
                  deadCount: item.deadCount,
                  curedCount: item.curedCount,
                  doubtCount: item.suspectedCount,
                  count:x
                })
                x++;
                sumcure+=item.curedCount;
                sumdead+=item.deadCount;
                suminfect+=item.confirmedCount;
                sumdoubt+=item.suspectedCount;
              })
              gethubei.forEach(item=>{
                hubeidate.push(item.dateId)
                hubeideadCount.push(item.deadCount)
                hubeicuredCount.push(item.curedCount)
                hubeiconfirmCount.push(item.confirmedCount)
              })
              document.getElementById("p1").innerHTML=suminfect;
             document.getElementById("p2").innerHTML=sumdoubt;
             document.getElementById("p3").innerHTML=sumdead;
              document.getElementById("p4").innerHTML=sumcure;
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
                  data: [ '确诊感染人数', '治愈人数', '死亡人数']
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
                  data: hubeidate

                },
                yAxis: {
                  type: 'value'
                },
                series: [
                  {
                    name: '确诊感染人数',
                    type: 'line',
                    stack: '总量',
                    data: hubeiconfirmCount
                  },
                  {
                    name: '治愈人数',
                    type: 'line',
                    stack: '总量',
                    data: hubeicuredCount

                  },
                  {
                    name: '死亡人数',
                    type: 'line',
                    stack: '总量',
                    data: hubeideadCount
                  }
                ]
              })

            })
    myEchart1.on('click',function (params) {
      myEchart3.setOption({
        series:[
                {
          data: [
            {value: params.data.doubtCount, name: '疑似感染'},
            {value: params.data.value, name: '确诊感染'},
            {value: params.data.curedCount, name: '治愈'},
            {value: params.data.deadCount, name: '死亡'}
          ]
        }
        ]
      })
      document.getElementById("p1").innerHTML=params.data.value;
      document.getElementById("p2").innerHTML=params.data.doubtCount
      document.getElementById("p3").innerHTML=params.data.deadCount;
      document.getElementById("p4").innerHTML=params.data.curedCount;
    })
  </script>
  </body>
</html>
