package Infectstatic.dao;

import Infectstatic.pojo.Province;

import java.util.ArrayList;
import java.util.List;

public class ProvinceDao {
    public List<Province> list(){
        List<Province> provinces=new ArrayList<>();
        for(int i=0;i<36;i++){//测试
            Province a=new Province();
            a.name="ss";
            a.curePeople=100;
            a.deadPeople=10;
            a.doubtPeople=20;
            a.infectPeople=30;
            provinces.add(a);
        }
        return provinces;
    }
}
