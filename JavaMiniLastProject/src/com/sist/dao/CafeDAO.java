package com.sist.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sist.vo.CafeVO;

public class CafeDAO {
    private Connection conn;
    private PreparedStatement ps;
    private static CafeDAO dao;

    private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String USER = "hr";
    private static final String PASS = "happy";

    private CafeDAO() {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Oracle JDBC Driver not found", e);
        }
    }

    public static CafeDAO newInstance() {
        if (dao == null) dao = new CafeDAO();
        return dao;
    }

    private void getConnection() throws SQLException {
        conn = DriverManager.getConnection(URL, USER, PASS);
    }

    private void disConnection() {
        try { if (ps != null) ps.close(); } catch (Exception ignore) {}
        try { if (conn != null) conn.close(); } catch (Exception ignore) {}
    }

    // INSERT (필요시 사용)
    public void cafeInsert(CafeVO vo) {
        try {
            getConnection();
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
            ps.setObject(6, vo.getKcal());
            ps.setObject(7, vo.getSodium());
            ps.setObject(8, vo.getCarbohydrate());
            ps.setObject(9, vo.getSugar());
            ps.setObject(10, vo.getProtein());
            ps.setObject(11, vo.getCaffeine());
            ps.setObject(12, vo.getFat());

            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            disConnection();
        }
    }

    // 연결 확인
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

    // 🔥 BigDecimal → Integer 변환 헬퍼
    private Integer getIntOrNull(ResultSet rs, String col) throws SQLException {
        java.math.BigDecimal bd = rs.getBigDecimal(col);
        return (bd == null) ? null : bd.intValue();
    }

    /** 카테고리별 메뉴 리스트 */
    public List<CafeVO> cafeMenuListData(int cno) {
        List<CafeVO> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            getConnection();

            String sql =
                "SELECT /*+ INDEX_ASC(cafe_menu cm_no_pk) */ " +
                " no, cno, image, engname, korname, description, " +
                " kcal, sodium, carbohydrate, sugar, protein, caffeine, fat " +
                "FROM cafe_menu " +
                "WHERE cno = ? " +
                "ORDER BY no";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, cno);

            rs = ps.executeQuery();
            while (rs.next()) {
                CafeVO vo = new CafeVO();
                vo.setNo(rs.getInt("no"));
                vo.setCno(rs.getInt("cno"));
                vo.setImage(rs.getString("image"));
                vo.setEngname(rs.getString("engname"));
                vo.setKorname(rs.getString("korname"));
                vo.setDescription(rs.getString("description"));

                // 🔥 BigDecimal → Integer 변환
                vo.setKcal(getIntOrNull(rs, "kcal"));
                vo.setSodium(getIntOrNull(rs, "sodium"));
                vo.setCarbohydrate(getIntOrNull(rs, "carbohydrate"));
                vo.setSugar(getIntOrNull(rs, "sugar"));
                vo.setProtein(getIntOrNull(rs, "protein"));
                vo.setCaffeine(getIntOrNull(rs, "caffeine"));
                vo.setFat(getIntOrNull(rs, "fat"));

                list.add(vo);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignore) {}
            disConnection();
        }
        return list;
    }

    // 단독 실행 테스트
    public static void main(String[] args) {
        CafeDAO d = CafeDAO.newInstance();
        System.out.println("DB 연결 테스트: " + (d.ping() ? "OK" : "FAIL"));
    }
}
