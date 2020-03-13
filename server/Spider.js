//node 请求
const superagent=require('superagent')
const cheerio=require('cheerio')
const fs= require('fs')
const path=require('path')
//目标网站请求
const url='https://ncov.dxy.cn/ncovh5/view/pneumonia'
superagent
    .get(url)
    .then(res=>{
       // console.log(res.text)
        const $ =cheerio.load(res.text) //jquery操作dom
        //获取全国疫情信息数据
        var $getListByCountryTypeService1=$('#getListByCountryTypeService1').html()
        var $getAreaStat=$('#getAreaStat').html()
        var $getStatisticsService=$('#getStatisticsService').html()
       // console.log($getListByCountryTypeService1)
        var dataObj={}
        eval($getListByCountryTypeService1.replace(/window/g,'dataObj'))
        eval($getAreaStat.replace(/window/g,'dataObj'))
        eval($getStatisticsService.replace(/window/g,'dataObj'))
        fs.writeFile(path.join(__dirname,'./data.json'),JSON.stringify(dataObj),err=>{
            if(err) throw err
            console.log('数据写入成功')
        })
        console.log(dataObj)
        console.log()
    })

    .catch(err=>{
        throw err
    })