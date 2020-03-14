package Infectstatic.dao;

import Infectstatic.pojo.Province;

import java.util.ArrayList;
import java.util.List;

public class ProvinceDao {
    public List<Province> list(){
        List<Province> provinces=new ArrayList<>();
            for(int i=0;i<35;i++){
                Province a=new Province();
                a.name="ss";
                a.infectPeople=20;
                a.doubtPeople=30;
                a.deadPeople=15;
                a.curePeople=9;
                provinces.add(a);
            }
            return provinces;
    }
}
