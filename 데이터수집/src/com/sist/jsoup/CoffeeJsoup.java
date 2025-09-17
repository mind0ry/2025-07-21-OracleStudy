package com.sist.jsoup;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import com.sist.dao.CoffeeDAO;
import com.sist.vo.CoffeeVO;

public class CoffeeJsoup {

    // 카테고리: "63","49","52","66"
    private static final String[] CATS = {"63","49","52","66"};

    public void coffeeCollection() {
        CoffeeDAO dao = CoffeeDAO.newInstance();

        for (String cat : CATS) {
            String url = "https://www.coffeebeankorea.com/product/list.asp?no=" + cat;
            try {
                Document doc = Jsoup.connect(url)
                        .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome Safari")
                        .referrer("https://www.coffeebeankorea.com/")
                        .timeout(10000)
                        .get();

                // 요청한 선택자
                Elements nameEls   = doc.select("p.txt_box span.name");                // 상품명
                Elements exdateEls = doc.select("p.txt_box span.num");                 // 유통기한
                Elements priceEls  = doc.select("p.text_box span.price, p.txt_box span.price"); // 가격(예비)
                Elements imgEls    = doc.select("p.photo img");                        // 이미지

                int n = Math.min(Math.min(nameEls.size(), exdateEls.size()),
                        Math.min(priceEls.size(), imgEls.size()));

                for (int i = 0; i < n; i++) {
                    String name = safeText(nameEls.get(i));
                    String ex   = safeText(exdateEls.get(i));
                    String price= normalizePrice(safeText(priceEls.get(i)));
                    String img  = normalizeImg(imgEls.get(i));

                    if (name.isEmpty()) continue; // 이름은 필수

                    CoffeeVO vo = new CoffeeVO();
                    vo.setName(name);
                    vo.setExdate(ex.isEmpty() ? "유통기한 표기 없음" : ex);
                    vo.setPrice(price.isEmpty() ? "가격 표기 없음" : price);
                    vo.setImage(img.isEmpty() ? "https://" : img); // 빈값 방지

                    dao.coffeeInsert(vo);
                    System.out.printf("[OK] %s | %s | %s | %s%n", vo.getName(), vo.getExdate(), vo.getPrice(), vo.getImage());
                }

            } catch (Exception e) {
                System.err.println("[ERR] cat=" + cat + " / " + e.getMessage());
            }
        }

        System.out.println("데이터수집 완료!!");
    }

    private static String safeText(Element el) {
        return (el == null) ? "" : el.text().trim();
    }

    // "12,900원" -> "12,900원" 그대로(문자열 저장) / 필요하면 숫자만 추출하도록 변경
    private static String normalizePrice(String s) {
        return s == null ? "" : s.replaceAll("\\s+", " ").trim();
    }

    private static String normalizeImg(Element imgEl) {
        if (imgEl == null) return "";
        String src = imgEl.hasAttr("data-src") ? imgEl.absUrl("data-src") : imgEl.absUrl("src");
        if (src == null) src = "";
        if (src.startsWith("//")) src = "https:" + src;
        return src.trim();
    }

    public static void main(String[] args) {
        new CoffeeJsoup().coffeeCollection();
    }
}
