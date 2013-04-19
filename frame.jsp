<html>
<body>
<%@ page import="java.util.*,java.io.*" %>
<%!
  int block[],qty[],comb[],tempcomb[],max=2000,total,best,counter=0,waste=0,waste_size=0;
  List store=new ArrayList();
  void initialize(HttpServletRequest request, PrintWriter out)
  {
    Object wast_array[];
    this.input_data(request,out);
    this.sort();
    this.display(out);
    this.calculate(out);
    out.println("\n-----Summary----\n");
    wast_array=this.store.toArray();
    if(Integer.parseInt(wast_array[wast_array.length-1].toString())>=this.waste_size)
    {
      out.println("Consider reusing the following remains for future projects\n-----------------\nno\tSize\n");    
      for(int i=wast_array.length-1;i>=0;i--)
        out.println((this.counter+i-wast_array.length+1)+"\t"+wast_array[i]);
      out.println("-----------------\n");
    }
    out.println("No of pieces req = "+this.counter);    
    out.println("Waste = "+this.waste);
  }
  void input_data(HttpServletRequest request, PrintWriter out)
  {
    
    out.println("Enter size of procurement");
    max=Integer.parseInt((String)request.getParameter("proc"));
    out.println("Enter maximum size of block less then which would be considered waste");
    waste_size=Integer.parseInt((String)request.getParameter("waste")); 
    out.println("Enter no of pieces");
    total=Integer.parseInt((String)request.getParameter("no"));
    block=new int[total];
    qty=new int[total];
    for(int i=0;i<total;i++)
    {
      out.println("Enter size of block");
      block[i]=Integer.parseInt((String)request.getParameter("tf1"+i));
      out.println("Enter no of sample");
      qty[i]=Integer.parseInt((String)request.getParameter("tf2"+i));
    }
  }
  void display(PrintWriter out)
  {
    out.println("S.no\tSize\tQuantity");
    for(int i=0;i<total;i++)
      out.println((i+1)+"\t"+block[i]+"\t"+qty[i]);
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
    boolean start=true,chaloo=true;
    int best=0,sum=0;
    comb=new int[total];
    while(start)
    {
      //out.println("At start again");                            // DELETE IT
      this.combinations();
      
     /* for(int i=0;i<total;i++)                                            //CHECK.......
      {
        out.println(block[i]+"\t"+comb[i]);
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
        if(comb[i]!=qty[i])
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
        out.println("\t\t\tThis piece remains = "+(max-best));
        if((max-best)<waste_size)
          waste+=max-best;
        else
          store.add(max-best);
        for(int i=0;i<total;i++)
          qty[i]=qty[i]-tempcomb[i];
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
    out.println("=====================================\nPiece no "+counter+"\n----------");
    if(a==0)
    {
      for(int i=0;i<total;i++)
        if(comb[i]!=0)
          out.println(block[i]+"  *  "+comb[i]);
      out.println("----------\t\t\tPerfect cut");
    }
    else
    {
      for(int i=0;i<total;i++)
        if(tempcomb[i]!=0)
          out.println(block[i]+"  *  "+tempcomb[i]);
      out.println("----------");
    }
  }
  void combinations()
  {
      for(int i=total-1;;)
      {
        if(comb[i]!=qty[i])
        {
          comb[i]++;
          break;
        }
        else
        {
          if(i==0 && comb[0]!=qty[0])
            i=total-1;
          else
          {
            comb[i]=0;
            i--;
          }
        }
      }
  }
}
%>
<%= initialize(request,out) %>
</body>
</html>