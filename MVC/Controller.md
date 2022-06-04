## Controller Servlet

**Servlet 생애주기**

생성 init => 명령어와 명령 핸들러 선언, template 설정

\-----요청후-----

service

doGet/doPost => 요청명령 분석 => Action객체 사용

　　　　　　　　　　　　　　　　(model사용 => 결과request에 저장 => view선택) 

　　　　　　　　　　　　　　　=> forward

\--------------------

destroy 메모리해제

---

Controller(front controller) => 요청받고, 요청기능 분석, Backend controller호출

　　　　　　　　　　　　　view포워드

나중에 사라짐(안보이는거임)



Action(backend controller) => model사용, request저장, view선택(리턴)

나중에 controller라는 이름으로 바뀔것

---

\> Controller.java (속성파일을 이용)

```java
package controller; 
 
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import action.Action;
import action.NullAction;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse; 
											//Controller는 서블릿.
public class Controller extends HttpServlet {//상속받아서 서블릿으로(요청-응답제어를 위해서) => web.xml에서 servlet설정해줘야 객체생성할수있음.
    private boolean usingTemplate = false; 
    private String templatePage = null; 
    
    //명령어=명령처리Action객체--명령어저장하기위한 용도
    private Map map = new java.util.HashMap(); 
     
    public void init(ServletConfig config) throws ServletException { //서블릿이 객체 생성하면 자동으로 딱한번 --web.xml비교
    	//생성자와는 다름. 서비스 호출되기 전(요청 전) 
        String configFile = config.getInitParameter("configFile"); //web.xml에서 init-param부분. config.properties경로 가져옴
         
        Properties prop = new Properties(); 
        FileInputStream fis = null; 
        try { 
            fis = new FileInputStream(configFile); 
            prop.load(fis); //텍스트를 문자열 키-값으로 prop 객체에 저장
        } catch (IOException e) { 
            throw new ServletException(e); 
        } finally { 
            if (fis != null) try { fis.close(); } catch(IOException ex) {} 
        } 
         
        Iterator keyIter = prop.keySet().iterator(); //키값 iterator로 변환
        while( keyIter.hasNext() ) { 
            String command = (String)keyIter.next(); 
            System.out.println("command: " + command); //키값
 
            String handlerClassName = prop.getProperty(command).trim();  //키값의 value가져옴 
            System.out.println("handlerClassName: " + handlerClassName); 
             
            try { //prop객체의 값을 실제 Action객체로 생성(마지막줄빼고, 마지막줄은 액션객체를 맵에 넣는 부분)
                //클래스를 JVM으로 로딩합니다. 
                Class handlerClass = Class.forName(handlerClassName); //value값 메모리에 올림
                 
                //읽어들인 클래의 객체를 생성합니다. 
                Object handlerInstance = handlerClass.newInstance(); 
                 
                //MAP에 키와 각 클래스별 객체가 저장합니다. 
                map.put(command, handlerInstance); //CreateAction,ListAction,...이 map에 들어감
                
            } catch (ClassNotFoundException e) { 
                throw new ServletException(e); 
            } catch (InstantiationException e) { 
                throw new ServletException(e); 
            } catch (IllegalAccessException e) { 
                throw new ServletException(e); 
            } 
        } 
      
        templatePage = config.getInitParameter("templatePage"); //템플릿페이지 경로가져옴
        
        if (templatePage != null && !templatePage.equals("")) { 
            usingTemplate = true; // 템플릿 페이지 존재 
        }//템플릿페이지 없다면(false) top.jsp사용하지 않겠다는게 됌
    } 
    
    //Controller처리순서 1.HTTP 요청 받음 
    //서비스 호출(*.do)되면 get,post방식에 따라 doGet/doPost
    public void doGet( 
        HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException { 
        process(request, response); 
    } 
    protected void doPost( 
        HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException { 
        process(request, response); 
    } 
    
    private void process( //서비스요청받았을때 처리로직
        HttpServletRequest request, HttpServletResponse response)  
    throws ServletException, IOException { 
    	//Controller처리순서 2.요청기능분석
        String command = request.getRequestURI();//주소에서 uri뽑아내기
        System.out.println("RequestURI: " + request.getRequestURI()); 
        
        //URI:/mvc_bbs/bbs/create.do
        if (command.indexOf(request.getContextPath()) == 0) { //getContextPath는 루트를 나타냄 -> 여기서는 '/mvctest'
            command = command.substring(request.getContextPath().length()); // '/mvc/list.do' 얻어냄
            System.out.println("command: " + command); 
        } 
         
        Action action =  //백엔드컨트롤러임
            (Action)map.get(command); //Object였으니까 Action으로 다운캐스팅
         
        // 핸들러가 없는 경우 (키값 map에 존재하지 않을경우, properties에 없을경우)
        if (action == null) { 
            action = new NullAction(); 
        }//Controller처리순서 2.요청기능분석 end
         
        String viewPage = null; 
        try { 
        	//Controller처리순서 3.model사용, 4.request 결과저장 5.view선택(리턴)
        	//viewPage="/view/createForm.jsp"
            viewPage = action.execute(request, response); 
        } catch(Throwable e) { 
            throw new ServletException(e); 
        } 
         
        if (usingTemplate) { //템플릿페이지가 있다면
            request.setAttribute("CONTENT_PAGE", viewPage);//리턴페이지에 뷰페이지 저장
        }//Controller처리순서 3.model사용, 4.request 결과저장 5.view선택(리턴) end
        
        //Controller처리순서 6.뷰 포워드 처리
        //forward 처리 <jsp:forward page="~"/> 여기 ~에 해당하는 게 dispatcher
        RequestDispatcher dispatcher = 
           request.getRequestDispatcher( 
                   usingTemplate ? templatePage : viewPage); // ~ : 이동할 페이지 결정
        dispatcher.forward(request, response); 
        ////Controller처리순서 6.뷰 포워드 처리 end
    }//Controller처리순서 1.HTTP 요청 받음 end 
} 
```

요청이 오면

1. Controller Servlet이 요청분석
2. config 파일에서 키와 일치하는 Action인터페이스 구현 클래스 검색
3. Action인터페이스 구현 클래스 객체에 있는 execute() 메소드 실행
   1. 필요한 메소드 실행
   2. 실행결과 request객체에 저장
   3. 이동할 페이지 Controller Servlet에 전달
4. Controller Servlet은 RequestDispatcher객체를 이용해 Action에서 리턴된 jsp페이지로 forward
5. jsp페이지는 별다른 처리없이 request객체에서 값 가져와 출력

<br>\> config.properties

- *.do : 일반적으로 명령어 확장자는 do를 사용 

```
# command = Action class Mapping List
/mvc/list.do=action.ListAction
/mvc/create.do=action.CreateAction
```

<br>

\> web.xml

- xml선언문앞에 공백이나 빈문자 있으면 안됌
- \<servlet> : 객체 생성해줘
- \<init-param> : controller의 init메소드에서 꺼내오기
- \<servlet-mapping> : 어떤식으로 요청해
- \<url-pattern>
  - 폴더매핑: /mvc 또는 /mvc/*
  - 확장자매핑: *.do

```
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="https://jakarta.ee/xml/ns/jakartaee" xmlns:web="http://xmlns.jcp.org/xml/ns/javaee" xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_5_0.xsd http://xmlns.jcp.org/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="5.0">
  <display-name>mvc_bbs</display-name>
  <welcome-file-list>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.jsp</welcome-file>
    <welcome-file>index.htm</welcome-file>
    <welcome-file>default.html</welcome-file>
    <welcome-file>default.jsp</welcome-file>
    <welcome-file>default.htm</welcome-file>
  </welcome-file-list>
  <servlet>
  	<servlet-name>Controller</servlet-name>
  	<servlet-class>controller.Controller</servlet-class>
  	<init-param>
  		<param-name>configFile</param-name>
  		<param-value>C:/aistudy/.../WEB-INF/config/config.properties</param-value>
  	</init-param>
  	<init-param>
  		<param-name>templatePage</param-name>
  		<param-value>/template/template.jsp</param-value>
  	</init-param>
  </servlet>
  <servlet-mapping>
  	<servlet-name>Controller</servlet-name>
  	<url-pattern>*.do</url-pattern>
  </servlet-mapping>
</web-app>
```

