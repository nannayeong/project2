<%@page import="java.util.Vector"%>
<%@page import="model.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.BbsDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   
<%

int action = 0; //up(1) down(0)
int currYear = 0;
int currMonth = 0;
String boxSize = "70";

Calendar c = Calendar.getInstance();
Calendar cal = Calendar.getInstance();

if(request.getParameter("action") == null) {
    
     currMonth = c.get(Calendar.MONTH);
     currYear = c.get(Calendar.YEAR);
     cal.set(currYear,currMonth,1);
    
} else {
    
     if(request.getParameter("action") != null){
         
          currMonth = Integer.parseInt(request.getParameter("month"));
          currYear = Integer.parseInt(request.getParameter("year"));
         
          if(Integer.parseInt(request.getParameter("action"))==1) {

               cal.set(currYear, currMonth, 1);
               cal.add(Calendar.MONTH, 1); //다음달
               currMonth = cal.get(Calendar.MONTH);
               currYear = cal.get(Calendar.YEAR);
              
          } else {              

               cal.set(currYear, currMonth, 1);
               cal.add(Calendar.MONTH, -1); //이전달
               currMonth = cal.get(Calendar.MONTH);
               currYear = cal.get(Calendar.YEAR);         
          }
         
     }
}

BbsDAO bbsdao = new BbsDAO();
List<BbsDTO> dtoList = bbsdao.selectList("cal");

%>

<%!
     public boolean isDate(int y, int m, int d) {
    
          m -= 1;
          Calendar c = Calendar.getInstance();
          c.setLenient(false);
         
          try {
              
               c.set(y, m, d);
               Date dt = c.getTime();
              
          } catch(IllegalArgumentException e) {
               return false;
          }
          return true;
     }
%>

<%!
     public String getTitle(Calendar cal){
         
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월");
          return sdf.format(cal.getTime());    
     }

%>
<body>

	<colgroup>
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="*" />
	</colgroup>
	<tr>
		<th><img src="../images/day01.gif" alt="S" /></th>
		<th><img src="../images/day02.gif" alt="M" /></th>
		<th><img src="../images/day03.gif" alt="T" /></th>
		<th><img src="../images/day04.gif" alt="W" /></th>
		<th><img src="../images/day05.gif" alt="T" /></th>
		<th><img src="../images/day06.gif" alt="F" /></th>
		<th><img src="../images/day07.gif" alt="S" /></th>
	</tr>
<%

//'Calendar loop


     int currDay;
     String todayColor;
     int count = 1;
     int dispDay = 1;


     for (int w = 1; w < 7; w++)
     {
%>
       <tr>
<%
          for (int d = 1; d < 8; d++)
          {
               if (!(count >= cal.get(Calendar.DAY_OF_WEEK))) //  
               {

%>
          <td class="empty">&nbsp;</td>
<%
                    count += 1;
               }
               else
               {

                    if (isDate (currYear, currMonth + 1,dispDay) ) // use the isDate method
                    {
                    	SimpleDateFormat fm = new SimpleDateFormat("yy-mm-dd");
                    	Date to = fm.parse(currYear+"-"+currMonth+1+"-"+dispDay);
                    	List<BbsDTO> dtoListD = new Vector<BbsDTO>();
                    	
                    	Date dD = null;
                    	for(BbsDTO dto : dtoList){
                    		 dD = fm.parse(dto.getDate());
                    		 if(fm.format(to).equals(fm.format(dD))){
                       			System.out.println("같다");
                       			dtoListD.add(dto);
                       		}
                    	}
                  		
                    	System.out.print("to:"+fm.format(to));
                    	System.out.print("dD:"+fm.format(dD));
                         //오늘
                         if (dispDay == c.get(Calendar.DAY_OF_MONTH) &&
                            c.get(Calendar.MONTH) == cal.get(Calendar.MONTH) 
                                && c.get(Calendar.YEAR) == cal.get(Calendar.YEAR) )
                         {
                             todayColor = "class='toDayColor'";
                         }
                         else
                         {
                             todayColor = "";
                         }
%>
          <td <%=todayColor%>><%=dispDay%><br>
          <c:forEach items="<%=dtoListD %>" var="d" varStatus="status">
          <div><a href="../board/boardView.do?boardName=cal&num=${d.num }">${d.title }</a></div></c:forEach>
          </td><%
                         count += 1;
                         dispDay += 1;
                    }
                    else
                    {
%>
          <td class="empty">&nbsp;</td>
<%
                    }
               }
       }
%>
       </tr>
<% 
}
%>
</body>
