package com.sist.client;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.table.*;

import com.sist.commons.imageChange;
import com.sist.dao.CafeDAO;
import com.sist.vo.CafeVO;

import java.awt.*;
import java.awt.event.*;
import java.awt.image.BufferedImage;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class Cafe extends JPanel implements ActionListener {
    ControllerPanel cp;

    // 카테고리 버튼 텍스트
    private static final String[] TITLES = {
        "신음료",
        "에스프레소 음료",
        "브루드 커피",
        "티",
        "티 라떼",
        "아이스 블렌디드 (COFFEE)",
        "아이스 블렌디드 (NON-COFFEE)",
        "커피빈 주스(병음료)",
        "기타 제조 음료"
    };

    // DB 카테고리 번호 (cno)
    private static final int[] CNO_MAP = {1, 2, 3, 4, 5, 6, 7, 8, 9};

    // 이미지 요청용 베이스 도메인 및 헤더
    private static final String BASE = "https://www.coffeebeankorea.com";
    private static final String UA =
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
          + "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";

    JButton[] btns = new JButton[TITLES.length];

    JTable table;
    DefaultTableModel model;
    TableColumn column;

    public Cafe(ControllerPanel cp) {
        this.cp = cp;
        setLayout(null);

        // 상단 카테고리 버튼
        JPanel p = new JPanel(new GridLayout(1, TITLES.length, 5, 5));
        for (int i = 0; i < TITLES.length; i++) {
            btns[i] = new JButton(TITLES[i]);
            btns[i].addActionListener(this);
            p.add(btns[i]);
        }
        p.setBounds(80, 15, 940, 35);
        add(p);

        // 테이블 컬럼
        String[] col = {
            "번호", "이미지", "한글명", "영문명",
            "열량(kcal)", "나트륨(mg)", "탄수화물(g)",
            "당(g)", "단백질(g)", "카페인(mg)", "포화지방(g)"
        };
        Object[][] row = new Object[0][col.length];

        model = new DefaultTableModel(row, col) {
            @Override public boolean isCellEditable(int r, int c) { return false; }
            @Override public Class<?> getColumnClass(int columnIndex) {
                if (getRowCount() == 0) return Object.class;
                Object v = getValueAt(0, columnIndex);
                return (v == null) ? Object.class : v.getClass();
            }
        };

        table = new JTable(model);
        table.setRowHeight(40);
        table.getTableHeader().setReorderingAllowed(false);
        table.getTableHeader().setResizingAllowed(false);
        table.setShowVerticalLines(false);
        
        DefaultTableCellRenderer centerRenderer = 
     			new DefaultTableCellRenderer();
     	centerRenderer.setHorizontalAlignment(SwingConstants.CENTER);
     	table.getColumnModel().getColumn(0).
        setCellRenderer(centerRenderer);
     	table.getColumnModel().getColumn(2).
     	                 setCellRenderer(centerRenderer);
     	table.getColumnModel().getColumn(3).
         setCellRenderer(centerRenderer);
     	table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

        JScrollPane js = new JScrollPane(table);
        js.setBounds(60, 60, 980, 520);
        add(js);

        // 컬럼 폭 설정
        for (int i = 0; i < col.length; i++) {
            column = table.getColumnModel().getColumn(i);
            switch (i) {
                case 0: column.setPreferredWidth(60); break;   // 번호
                case 1: column.setPreferredWidth(60); break;   // 이미지
                case 2: column.setPreferredWidth(230); break;  // 한글명
                case 3: column.setPreferredWidth(230); break;  // 영문명
                default: column.setPreferredWidth(90);         // 수치 컬럼
            }
        }

        // 최초 로딩: 신음료
        printByIndex(0);
    }

    /** 버튼 인덱스로 출력 */
    private void printByIndex(int idx) {
        if (idx < 0 || idx >= CNO_MAP.length) return;
        int cno = CNO_MAP[idx];
        printByCno(cno);
    }

    /** cno 기준으로 테이블 갱신 */
    private void printByCno(int cno) {
        // 초기화
        for (int i = model.getRowCount() - 1; i >= 0; i--) model.removeRow(i);

        CafeDAO dao = CafeDAO.newInstance();
        List<CafeVO> list = dao.cafeMenuListData(cno);

        for (CafeVO vo : list) {
            try {
                Image thumb = null;
                String imgUrl = vo.getImage();
                if (imgUrl != null && !imgUrl.isEmpty()) {
                    ImageIcon icon = loadImageIcon(imgUrl, 35, 35); // ← 핵심
                    if (icon != null) {
                        thumb = icon.getImage();
                    }
                }
                Object[] data = {
                    vo.getNo(),
                    (thumb == null ? null : new ImageIcon(thumb)),
                    nz(vo.getKorname()),
                    nz(vo.getEngname()),
                    nz(vo.getKcal()),
                    nz(vo.getSodium()),
                    nz(vo.getCarbohydrate()),
                    nz(vo.getSugar()),
                    nz(vo.getProtein()),
                    nz(vo.getCaffeine()),
                    nz(vo.getFat())
                };
                model.addRow(data);
            } catch (Exception ex) {
                ex.printStackTrace();
                Object[] data = {
                    vo.getNo(), null, nz(vo.getKorname()), nz(vo.getEngname()),
                    nz(vo.getKcal()), nz(vo.getSodium()), nz(vo.getCarbohydrate()),
                    nz(vo.getSugar()), nz(vo.getProtein()), nz(vo.getCaffeine()), nz(vo.getFat())
                };
                model.addRow(data);
            }
        }
    }

    /** 이미지 로딩: 인코딩 + 헤더 세팅 */
    private ImageIcon loadImageIcon(String rawUrl, int w, int h) {
        HttpURLConnection conn = null;
        try {
            URL url = new URL(encodeUrlPreservePct(rawUrl)); // 이미 %xx는 보존하며 나머지만 인코딩
            conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(6000);
            conn.setReadTimeout(9000);
            conn.setInstanceFollowRedirects(true);
            conn.setRequestProperty("User-Agent", UA);
            conn.setRequestProperty("Referer", BASE + "/");
            conn.setRequestProperty("Accept", "image/avif,image/webp,image/apng,image/*,*/*;q=0.8");
            conn.setRequestProperty("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");

            int code = conn.getResponseCode();
            if (code != HttpURLConnection.HTTP_OK) return null;

            BufferedImage img = ImageIO.read(conn.getInputStream());
            if (img == null) return null;

            Image scaled = img.getScaledInstance(w, h, Image.SCALE_SMOOTH);
            return new ImageIcon(scaled);
        } catch (Exception e) {
            // fallback: 공백만 %20 치환 재시도
            try {
                String fb = rawUrl.replace(" ", "%20");
                URL url = new URL(encodeUrlPreservePct(fb));
                BufferedImage img = ImageIO.read(url);
                if (img == null) return null;
                Image scaled = img.getScaledInstance(w, h, Image.SCALE_SMOOTH);
                return new ImageIcon(scaled);
            } catch (Exception ignore) {
                return null;
            }
        } finally {
            if (conn != null) conn.disconnect();
        }
    }

    /**
     * 절대 URL 보장 + PATH/QUERY 인코딩 (이미 %XX는 보존)
     * - 한글/대괄호 등 비ASCII는 UTF-8 퍼센트 인코딩
     * - 기존 %20 등은 그대로 유지 (이중 인코딩 방지)
     */
    private String encodeUrlPreservePct(String raw) throws Exception {
        // 1) 절대 URL 보장
        String abs = raw;
        if (abs.startsWith("//")) abs = "https:" + abs;
        else if (abs.startsWith("/")) abs = BASE + abs;
        else if (!abs.startsWith("http://") && !abs.startsWith("https://"))
            abs = BASE + (abs.startsWith("/") ? "" : "/") + abs;

        URL u = new URL(abs);
        String scheme = u.getProtocol();
        String host = u.getHost();
        int port = u.getPort();

        String rawPath = u.getPath();   // 그대로(섞여있어도) 받아온다
        String rawQuery = u.getQuery(); // null 가능

        // 2) PATH 인코딩 (세그먼트가 아니라 전체 path 기준으로 하되, '/'는 유지)
        String encPath = encodePreservingPct(rawPath, /*isPath*/ true);

        // 3) QUERY 인코딩 (키/값 전체에 대해 %, &, =, ? 등은 보존 규칙으로 처리)
        String encQuery = (rawQuery == null) ? null : encodePreservingPct(rawQuery, /*isPath*/ false);

        // 4) 조립
        StringBuilder sb = new StringBuilder();
        sb.append(scheme).append("://").append(host);
        if (port != -1) sb.append(':').append(port);
        if (encPath != null && !encPath.isEmpty()) sb.append(encPath);
        if (encQuery != null && !encQuery.isEmpty()) sb.append('?').append(encQuery);
        return sb.toString();
    }

    /**
     * 이미 포함된 %XX는 그대로 두고, 나머지 비ASCII/허용되지 않은 문자만 UTF-8로 퍼센트 인코딩
     * isPath=true  -> '/'는 인코딩하지 않음
     * isPath=false -> 쿼리에서는 '&', '=', '+', '?' 등은 필요 시 인코딩
     */
    private String encodePreservingPct(String s, boolean isPath) {
        if (s == null) return null;
        StringBuilder out = new StringBuilder(s.length() + 16);
        final int len = s.length();
        for (int i = 0; i < len; i++) {
            char c = s.charAt(i);

            // 1) 기존 %xx 보존
            if (c == '%' && i + 2 < len && isHex(s.charAt(i + 1)) && isHex(s.charAt(i + 2))) {
                out.append('%').append(s.charAt(i + 1)).append(s.charAt(i + 2));
                i += 2;
                continue;
            }

            // 2) 허용 문자 통과 (RFC3986 unreserved)
            if (isUnreserved(c) || (isPath && c == '/')) {
                out.append(c);
                continue;
            }

            // 3) 나머지는 UTF-8 퍼센트 인코딩
            byte[] bytes = String.valueOf(c).getBytes(StandardCharsets.UTF_8);
            for (byte b : bytes) {
                out.append('%');
                String hex = Integer.toHexString(b & 0xFF).toUpperCase();
                if (hex.length() == 1) out.append('0');
                out.append(hex);
            }
        }
        return out.toString();
    }

    /** RFC3986 unreserved: ALPHA / DIGIT / "-" / "." / "_" / "~" */
    private boolean isUnreserved(char c) {
        return (c >= 'A' && c <= 'Z')
            || (c >= 'a' && c <= 'z')
            || (c >= '0' && c <= '9')
            || c == '-' || c == '.' || c == '_' || c == '~';
    }

    private boolean isHex(char c) {
        return (c >= '0' && c <= '9')
            || (c >= 'A' && c <= 'F')
            || (c >= 'a' && c <= 'f');
    }

    private String nz(String s) { return (s == null) ? "" : s; }
    private Object nz(Integer n) { return (n == null) ? "" : n; }

    @Override
    public void actionPerformed(ActionEvent e) {
        for (int i = 0; i < btns.length; i++) {
            if (e.getSource() == btns[i]) {
                printByIndex(i);
                break;
            }
        }
    }
}
