import data.Pinyin;
import data.Price;
import done.Sell;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by AlbusDumbledore on 2017/6/24 0024.
 */
@WebServlet(name = "Servlet")
public class Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        /*从前端获取数据开始*/
        int ticketnum = Integer.parseInt(request.getParameter("ticketnum"));//票的数量
        String ss = request.getParameter("start");//起点站String
        String es = request.getParameter("end");//终点站String
        String strmoney = request.getParameter("money");
        String straddmoney = request.getParameter("addmoney");
        String startsign = request.getParameter("startsign");
        String endsign = request.getParameter("endsign");
        String getstartsign="";
        String getendsign="";
        /*从前端获取数据结束*/

        /*转拼音开始*/
        Pinyin pinyin = new Pinyin();
        getstartsign = pinyin.getFullSpell(startsign);
        getendsign = pinyin.getFullSpell(endsign);
        if (getstartsign.equals("滕wangge")){
            getstartsign="tengwangge";
        }
        if (getendsign.equals("滕wangge")){
            getendsign="tengwangge";
        }
        if (getstartsign.equals("ditiedaxia")){
            getstartsign="ditiedasha";
        }
        if (getendsign.equals("ditiedaxia")){
            getendsign="ditiedasha";
        }
        if (getstartsign.equals("xinjia庵")){
            getstartsign="xinjiaan";
        }
        if (getendsign.equals("xinjia庵")){
            getendsign="xinjiaan";
        }
        if (getstartsign.equals("璜xizhan")){
            getstartsign="huangxizhan";
        }
        if (getendsign.equals("璜xizhan")){
            getendsign="huangxizhan";
        }
        /*转拼音结束*/

        /*票价计算开始*/
        Sell sell = new Sell();
        sell.setNum(ticketnum);
        try {
            sell.setES(es);
            sell.setSS(ss);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Price the= new Price();
        int p = 0;
        try {
            System.out.println();
            p = ticketnum*the.CalP(the.cal(the.ssline(sell.getSS()),the.sslinenum(sell.getSS()),sell.getES()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        /*票价计算结束*/
        /*往前端传回数值开始*/
        request.setAttribute("start",ss);
        request.setAttribute("end",es);
        request.setAttribute("ticketnum",ticketnum);
        request.setAttribute("getstartsign",getstartsign);
        request.setAttribute("getendsign",getendsign);
        if (strmoney.equals("")&&straddmoney.equals("")){
            //没进钱，且以前也没进钱
            request.setAttribute("money",0);
            request.setAttribute("addmoney",0);
        }else if ((!strmoney.equals(""))&&(straddmoney.equals(""))){
            //进钱，且以前没进钱
            request.setAttribute("money",Integer.parseInt(strmoney));
            request.setAttribute("addmoney",Integer.parseInt(strmoney));
        }else if ((strmoney.equals(""))&&(!straddmoney.equals(""))){
            //没进钱，且以前进过钱
            request.setAttribute("money",0);
            request.setAttribute("addmoney",Integer.parseInt(straddmoney));
        }else if ((!strmoney.equals(""))&&(!straddmoney.equals(""))){
            //进钱，且以前进过钱
            request.setAttribute("money",Integer.parseInt(strmoney));
            request.setAttribute("addmoney",Integer.parseInt(strmoney)+Integer.parseInt(straddmoney));
        }
        if ((es.equals("请选择"))||(ss.equals("请选择"))){
            request.setAttribute("price",0);
        }else {
            request.setAttribute("price",p);
        }
        System.out.println("*************************");
        System.out.println("起点站:"+ss);
        System.out.println("终点站:"+es);
        System.out.println("票的数量:"+ticketnum);
        System.out.println("已付:"+strmoney);
        System.out.println("本次付了:"+straddmoney);
        System.out.println("起点拼音:"+getstartsign);
        System.out.println("终点拼音:"+getendsign);
        System.out.println("*************************");
        request.getRequestDispatcher(request.getContextPath()+"/index.jsp").forward(request,response);
        /*往前端传回数值结束*/
    }
}
