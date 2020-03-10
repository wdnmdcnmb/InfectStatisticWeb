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
      <style>
          .centerItem {
              width: 856px;
              height: 640px;
              background-color: aliceblue;
              margin: 110px auto 0 auto;
          }
      </style>
  </head>
  <body>
  <div id="mapBox" class="centerItem"></div>

  <!-- 引入相关文件 -->
  <script src="js/jquery-3.2.1.min.js"></script>
  <!-- 引入 ECharts 文件 -->
  <script src="js/echarts.js"></script>
  <script src="js/china.js"></script>

  <script>
      // 基于准备好的dom，初始化echarts实例
      var mapBoxEchart = echarts.init(document.getElementById('mapBox'));

      // 指定相关的配置项和数据
      var mapBoxOption = {
          series: [{
              type: 'map',
              mapType: 'china',
              label: {
                  normal: {
                      show: true, //显示省份标签
                      textStyle: {
                          color: "blue"
                      } //省份标签字体颜色
                  },
                  emphasis: { //对应的鼠标悬浮效果
                      show: false,
                      textStyle: {
                          color: "#800080"
                      }
                  }
              },
              aspectScale: 0.75,//这个参数用于 scale 地图的长宽比。最终的 aspect 的计算方式是：geoBoundingRect.width / geoBoundingRect.height * aspectScale
              zoom: 1.2,//当前视角的缩放比例。
              itemStyle: {
                  normal: {
                      borderWidth: .5, //区域边框宽度
                      borderColor: '#009fe8', //区域边框颜色
                      areaColor: "#ffefd5", //区域颜色
                  },
                  emphasis: {//鼠标滑过地图高亮的相关设置
                      borderWidth: .5,
                      borderColor: '#4b0082',
                      areaColor: "#ffdead",
                  }
              }
          }]
      };
      // 使用制定的配置项和数据显示图表
      mapBoxEchart.setOption(mapBoxOption);
      // echart图表自适应
      window.addEventListener("resize", function() {
          mapBoxEchart.resize();
      });
  </script>
  </body>
</html>
