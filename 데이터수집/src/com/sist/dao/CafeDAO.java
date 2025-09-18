package com.sist.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.sist.vo.CafeVO;

public class CafeDAO {
    private Connection conn;
    private PreparedStatement ps;
    private static CafeDAO dao;

    private final String URL="jdbc:oracle:thin:@localhost:1521:XE";

    private CafeDAO() {
        try {
            // 최신 드라이버명 권장
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            // 드라이버 로딩 실패는 바로 원인 보여주기
            e.printStackTrace();
            throw new RuntimeException("Oracle JDBC Driver not found", e);
        }
    }

    public static CafeDAO newInstance() {
        if (dao == null) dao = new CafeDAO();
        return dao;
    }

    private void getConnection() throws SQLException {
        // 실패 원인을 보려고 예외를 던지자
        conn = DriverManager.getConnection(URL,"hr", "happy");
    }

    private void disConnection() {
        try {
            if (ps != null) ps.close();
        } catch (Exception ignore) {}
        try {
            if (conn != null) conn.close();
        } catch (Exception ignore) {}
    }

    // INSERT
    public void cafeInsert(CafeVO vo) {
        try {
            getConnection(); // ← 실패 시 SQLException 터져서 catch에서 로그 보인다
            String sql =
                "INSERT INTO cafe_menu (" +
                " no, cno, image, engname, korname, description," +
                " kcal, sodium, carbohydrate, sugar, protein, caffeine, fat" +
                ") VALUES (" +
                " cm_no_seq.NEXTVAL, ?, ?, ?, ?, ?," +
                " ?, ?, ?, ?, ?, ?, ?" +
                ")";
            ps = conn.prepareStatement(sql);

            ps.setInt(1, vo.getCno());
            ps.setString(2, vo.getImage());
            ps.setString(3, vo.getEngname());
            ps.setString(4, vo.getKorname());
            ps.setString(5, vo.getDescription());

            ps.setObject(6,  vo.getKcal());
            ps.setObject(7,  vo.getSodium());
            ps.setObject(8,  vo.getCarbohydrate());
            ps.setObject(9,  vo.getSugar());
            ps.setObject(10, vo.getProtein());
            ps.setObject(11, vo.getCaffeine());
            ps.setObject(12, vo.getFat());

            ps.executeUpdate();
        } catch (Exception ex) {
            // 여기서 반드시 원인 출력!
            ex.printStackTrace();
        } finally {
            disConnection();
        }
    }

    // 빠르게 접속 체크해보는 유틸
    public boolean ping() {
        try {
            getConnection();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            disConnection();
        }
    }

    // 단독 실행 테스트용
    public static void main(String[] args) {
        CafeDAO d = CafeDAO.newInstance();
        System.out.println("DB 연결 테스트: " + (d.ping() ? "OK" : "FAIL"));
    }
}
