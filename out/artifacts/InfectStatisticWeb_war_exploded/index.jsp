<%--
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
  </head>
  <body>
  <div id="container" style="width: 800px;height: 600px"></div>

  <!-- 引入相关文件 -->
  <script src="js/jquery-3.2.1.min.js"></script>
  <!-- 引入 ECharts 文件 -->
  <script src="js/echarts.js"></script>
  <script src="js/china.js"></script>

  <script>
      // 基于准备好的dom，初始化echarts实例
      var myEchart = echarts.init(document.querySelector('#container'));
       //↓↓实现请求接口







      //↑↑实现请求接口
      // 指定相关的配置项和数据
      myEchart.setOption({
          title:{
              text:'全国实时疫情数据分布图',
              subtext:'',
              left:'center'

          },
          backgroundColor:'#c7dbff',
          tooltip:{
            formatter:function () {
                return '地区：湖北<br/>确诊：100人<br/>治愈：12人<br/>死亡：56人<br/>'
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
          ]
      })
  </script>
  </body>
</html>
