package Infectstatic.servelet;

import Infectstatic.dao.ProvinceDao;
import Infectstatic.pojo.Province;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ProvinceServlet")
public class ProvinceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProvinceDao a = new ProvinceDao();
        List<Province> provinces = a.list();
        //System.out.println("123456");
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(provinces);
        System.out.println(json);

        response.setContentType("index.jsp; charset=utf-8");
        response.getWriter().write(json);
        System.out.println("end");


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}