

// 1. 引入express
const express = require('express')
const fs = require('fs')
const path = require('path')
// 2. 创建服务器应用
const app = express()
// 3. 监听请求

app.all('*', function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild');
  res.header("Access-Control-Allow-Methods", "PUT,POST,GET,DELETE,OPTIONS");
  res.header("X-Powered-By", ' 3.2.1')
  res.header("Content-Type", "application/json;charset=utf-8");
  next();
});
app.get('/api/data', (req, res) => {
  // 要将爬取到的json数据返回
  fs.readFile(path.join(__dirname, './data.json'), 'utf8', (err, data) => {
    if (err) throw err
    console.log(data)
    res.send(data)
  })
})
// 4. 分配端口号启动服务
app.listen(8066, () => {
  console.log(`当前服务器启动成功 http://localhost:8066/api/data`)
})
