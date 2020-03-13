//node 请求
const superagent=require('superagent')
const cheerio=require('cheerio')
//目标网站请求
const url='https://ncov.dxy.cn/ncovh5/view/pneumonia'
superagent
    .get(url)
    .then(res=>{
       // console.log(res.text)
        const $ =cheerio.load(res.text) //jquery操作dom
        //获取全国疫情信息数据
        var $getListByCountryTypeService1=$('#getListByCountryTypeService1').html()
       // console.log($getListByCountryTypeService1)
        var dataObj={}
        eval($getListByCountryTypeService1.replace(/window/g,'dataObj'))
        console.log(dataObj)
    })
    .catch(err=>{
        throw err
    })