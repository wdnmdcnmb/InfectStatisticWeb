package Infectstatic.servelet;

import Infectstatic.dao.ProvinceDao;
import Infectstatic.pojo.Province;

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
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProvinceDao a=new ProvinceDao();
        List<Province> provinces= a.list();
        request.setAttribute("provinces",provinces);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
