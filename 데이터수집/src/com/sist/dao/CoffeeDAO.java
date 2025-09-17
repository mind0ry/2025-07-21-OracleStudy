package com.sist.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import com.sist.vo.CoffeeVO;

public class CoffeeDAO {
    private Connection conn;
    private PreparedStatement ps;
    private static CoffeeDAO dao;
    private final String URL="jdbc:oracle:thin:@localhost:1521:XE";

    public CoffeeDAO() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch(Exception ex) {}
    }
    public static CoffeeDAO newInstance() {
        if(dao==null) dao=new CoffeeDAO();
        return dao;
    }
    public void getConnection() {
        try {
            conn=DriverManager.getConnection(URL,"hr","happy");
        } catch(Exception ex) {}
    }
    public void disConnection() {
        try {
            if(ps!=null) ps.close();
            if(conn!=null) conn.close();
        } catch(Exception ex) {}
    }

    /*
    NO     NOT NULL NUMBER        (cf_no_seq.nextval)
    NAME   NOT NULL VARCHAR2(100)
    EXDATE NOT NULL VARCHAR2(200)
    PRICE  NOT NULL VARCHAR2(50)
    IMAGE  NOT NULL VARCHAR2(260)
    */
    public void coffeeInsert(CoffeeVO vo) {
        try {
            getConnection();
            String sql="INSERT INTO coffee(no,name,exdate,price,image) "
                     + "VALUES(cf_no_seq.nextval,?,?,?,?)";
            ps=conn.prepareStatement(sql);
            // no는 시퀀스라 바인딩하지 않습니다.
            ps.setString(1, vo.getName());
            ps.setString(2, vo.getExdate());
            ps.setString(3, vo.getPrice());
            ps.setString(4, vo.getImage());
            ps.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            disConnection();
        }
    }
}
