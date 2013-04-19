import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Prog extends HttpServlet {
int block[],qty[],comb[],tempcomb[],limit[],max=2000,total,best,counter=0,waste=0,waste_size=0;
  List store;
public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
    {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
		out.println("<html><body>");
        this.initialize(request,out);
		out.println("</body></html>");
    }
void initialize(HttpServletRequest request, PrintWriter out)
  {
    waste=0;
    counter=0;
    store=new ArrayList();
    Object wast_array[];
    this.input_data(request,out);
    this.sort();
    this.display(out);
    this.calculate(out);
    out.println("<br><font size=5 color=\"blue\">-----Summary----</font><br><br>");
    wast_array=this.store.toArray();
    if(wast_array.length>0)
    {
      out.println("Consider reusing the following remains for future projects<br>-----------------<TABLE border=\"1\"><tr><b><td>Piece no</td><td>Size</td></b></tr>");    
      for(int i=wast_array.length-1;i>=0;i--)
        out.println("<tr><td>"+(this.counter+i-wast_array.length+1)+"</td><td>"+wast_array[i]+"</td></tr>");
      out.println("</table><br><br>");
    }
    out.println("<font size=4>No of pieces req = "+this.counter);    
    out.println("</br>Waste = "+this.waste+"</font>");
  }
  void input_data(HttpServletRequest request, PrintWriter out)
  {
    
    max=Integer.parseInt(request.getParameter("proc").toString().trim());
    waste_size=Integer.parseInt(request.getParameter("waste").toString().trim()); 
    
    total=Integer.parseInt(request.getParameter("no").toString().trim());
    block=new int[total];
    qty=new int[total];
    for(int i=0;i<total;i++)
    {
      
      block[i]=Integer.parseInt(request.getParameter("tf1"+i).toString().trim());
      
      qty[i]=Integer.parseInt(request.getParameter("tf2"+i).toString().trim());
    }
  }
  void display(PrintWriter out)
  { out.println("<TABLE border=\"1\"><TR><b><td> S.no </td><td> Size </td><td> Quantity </td></b></TR>");
    for(int i=0;i<total;i++)
      out.println("<tr><td>"+(i+1)+"</td><td>"+block[i]+"</td><td>"+qty[i]+"</td></tr>");
     out.println("</table>");
  }
  void sort()
  {
    int tmp;
    for(int i=0;i<total;i++)
    {
      for(int j=0;j<total-1;j++)
      {
        if(block[i]>block[j])
        {
          tmp=block[i];
          block[i]=block[j];
          block[j]=tmp;

          tmp=qty[i];
          qty[i]=qty[j];
          qty[j]=tmp;
        }
      }
    }
  }
  void calculate(PrintWriter out)
  {
    initLimit();
    boolean start=true,chaloo=true;
    int best=0,sum=0;
    comb=new int[total];
    while(start)
    {
      //out.println("At start again");                            // DELETE IT
      this.combinations();
      
     /* for(int i=0;i<total;i++)                                            //CHECK.......
      {
        out.println(block[i]+"&nbsp;"+comb[i]);
      }*/
      sum=0;
      for(int i=0;i<total;i++)
      {
        sum+=block[i]*comb[i];
        if(sum>max)
        {
          sum=0;
          break;
        }
      }

      //out.println("sum = "+sum);                                    // CHECK............

      if(sum>0) //if a comb suited
      {
        if(sum==max) // if best comb found
        {
          //out.println("Sum = "+sum);                                  //  DELETEc IT
          this.showComb(0,out);  //print comb
          for(int i=0;i<total;i++)  //  deduct samples from stock(qty) which are already printed
            qty[i]=qty[i]-comb[i];
		  updateLimit();
          for(int i=0;i<total;i++) // reset comb[]
            comb[i]=0;
          best=0;
          sum=0;
        }
        else
          if(sum>best)
          {
            best=sum;
            tempcomb =new int[total];
            for(int i=0;i<total;i++) // storing best comb in tempComb[]
              tempcomb[i]=comb[i];
            sum=0;
          }
      }
      for(int i=0;i<total;i++)  //to check whether all comb done
      {
        if(comb[i]!=limit[i])
        {
          chaloo=true;
          break;
        }
        chaloo=false;
      }
      if(!chaloo) // when all comb completed
      {
        //for(int i=0;i<total;i++) // storing best comb in tempComb[] ...Testing
          //    out.print(tempcomb[i]);
        //for(int i=0;i<total;i++) // storing best comb in tempComb[] ...Testing
          //    out.print(comb[i]);
        this.showComb(best,out);
        out.println("<font color=\"red\">&nbsp;&nbsp;&nbsp;This piece remains = "+(max-best)+"</font><br>");
        if((max-best)<waste_size)
          waste+=max-best;
        else
          store.add(max-best);
        for(int i=0;i<total;i++)
          qty[i]=qty[i]-tempcomb[i];
		updateLimit();
        for(int i=0;i<total;i++)
          comb[i]=0;
        best=0;
      }//out.println("B4 start loop");                            // DELETE IT
      for(int i=0;i<total;i++) // To end while loop when no more pieces left
      {
        if(qty[i]==0 && i!=total-1)
          continue;
        else if(i==total-1 && qty[i]==0)
          start=false;
        break;
      }/*out.println("After start loop");                            // DELETE IT
     for(int i=0;i<total;i++)                                         ////////
          out.print(qty[i]);                                 /////////
     out.println(); */                                            //////////
    }
  }
  void showComb(int a, PrintWriter out )
  {
    counter++;
    out.println("<font color=\"brown\">=====================================</font><br>Piece no "+counter+"<br>----------<br>");
    if(a==0)
    {
      for(int i=0;i<total;i++)
        if(comb[i]!=0)
          out.println(block[i]+"  *  "+comb[i]+"<br>");
      out.println("<br><font color=\"green\">----------&nbsp;&nbsp;&nbsp;Perfect cut</font><br>");
    }
    else
    {
      for(int i=0;i<total;i++)
        if(tempcomb[i]!=0)
          out.println(block[i]+"  *  "+tempcomb[i]+"<br>");
      out.println("----------");
    }
  }
  void combinations()
  {
      for(int i=total-1;;)
      {
        if(comb[i]!=limit[i])
        {
          comb[i]++;
          break;
        }
        else
        {
          if(i==0 && comb[0]!=limit[0])
            i=total-1;
          else
          {
            comb[i]=0;
            i--;
          }
        }
      }
  }
  void initLimit()
  {
    int div;
	limit=new int[total];
    for(int i=0;i<total;i++)
	{
	  div=max/block[i];
	  if(qty[i]>div)
	    limit[i]=div;
	  else
	    limit[i]=qty[i];
    }
  }
  void updateLimit()
  {
    for(int i=0;i<total;i++)
	{
	  if(qty[i]<limit[i])
	    limit[i]=qty[i];
	}
  }
}
