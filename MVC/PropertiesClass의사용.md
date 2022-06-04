# Properties class의 사용

: 키와 값의 구조를 가지고 있으며 특정 객체를 생성하는 경우 초기값으로 많이 사용

<br>상속구조

java.lang.Object

&nbsp; &nbsp; &nbsp; &nbsp;┕ java.util.Dictionary<K,V>

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;┕ java.util.Hashtable<Object,Object>

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;┕ java.util.Properties<String,String>

<br>

properties파일의 문장끝에 빈공간 없어야 함

<br>

\> PropertyTest.java 예제

```java
package properties;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Properties;

public class PropertyTest {

	public static void main(String[] args) {
		Properties prop = new Properties();
		FileInputStream fis = null;// 파일읽어오는역할
		File file = new File("jdbc.properties");// 파일객체 -- 파일내부 key=value로 구성

		try {
			fis = new FileInputStream(file);
			prop.load(fis);// 파일을 properties안으로 로드
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		Iterator keyIter = prop.keySet().iterator();
		while (keyIter.hasNext()) {
			String key = (String) keyIter.next(); // 키 추출
			String value = prop.getProperty(key); // 키에 따른 값 추출
			System.out.println(key + "=" + value);//파일-> properties변환-> properties읽어오기 : 가져오는 순서는 마음대로
		}

		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        String driver = "";
        String url = "";
        String account = "";
        String password="";

        driver = prop.getProperty("driver");//key로 property의 값 찾아옴
        url = prop.getProperty("url");
        account = prop.getProperty("account");
        password = prop.getProperty("password");

        try {
			Class.forName(driver);//driver를 올리는역할
			con = DriverManager.getConnection(url,account,password);
			sql = " select count(*) cnt from information_schema.tables "
					+" where table_schema='javadb' ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				System.out.println("현재 javadb의 테이블 갯수: "+rs.getInt("cnt"));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
```

---

실습: calc.properties 파일을 이용 사칙연산을 수행하는 프로그램 작성하기

\> calc.properties

```
su1=50
su2=10
```

\> Calc.java

```java
package properties;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class Calc {

	public static void main(String[] args) {
		Properties prop = new Properties();
		FileInputStream fis = null;
		File file = new File("calc.properties");

		try {
			fis = new FileInputStream(file);
			prop.load(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		int su1 = 0;
		int su2 = 0;

		su1 = Integer.parseInt(prop.getProperty("su1"));
		su2 = Integer.parseInt(prop.getProperty("su2"));

		System.out.println("su1 + su2 = "+ (su1+su2));
		System.out.println("su1 - su2 = "+ (su1-su2));
		System.out.println("su1 * su2 = "+ (su1*su2));
		System.out.println("su1 / su2 = "+ (su1/su2));
	}
}
```
