package com.sist.jsoup;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.sist.dao.CafeDAO;
import com.sist.vo.CafeVO;

import java.util.LinkedHashMap;
import java.util.Map;

public class CafeJsoup {

    // 커피빈 category 파라미터 → 우리 DB의 cno(카테고리 번호)
    private static final Map<Integer, Integer> CATEGORY_MAP = new LinkedHashMap<>();
    static {
        CATEGORY_MAP.put(32, 1);  // 신음료
        CATEGORY_MAP.put(13, 2);  // 에스프레소 음료
        CATEGORY_MAP.put(14, 3);  // 브루드 커피
        CATEGORY_MAP.put(18, 4);  // 티
        CATEGORY_MAP.put(17, 5);  // 티 라떼
        CATEGORY_MAP.put(12, 6);  // 아이스 블렌디드 (커피)
        CATEGORY_MAP.put(11, 7);  // 아이스 블렌디드 (non-coffee)
        CATEGORY_MAP.put(26, 8);  // 커피빈 주스(병음료)
        CATEGORY_MAP.put(24, 9);  // 기타 제조 음료
    }

    private static final String BASE = "https://www.coffeebeankorea.com";

    public void crawl() {
        CafeDAO dao = CafeDAO.newInstance();

        for (Map.Entry<Integer, Integer> entry : CATEGORY_MAP.entrySet()) {
            int siteCategory = entry.getKey();
            int cno = entry.getValue();

            int page = 1;
            while (true) {
                try {
                    String url = BASE + "/menu/list.asp?category=" + siteCategory + "&page=" + page;
                    Document doc = Jsoup.connect(url)
                            .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
                            .referrer(BASE + "/")
                            .get();

                    Elements items = doc.select("div.list_wrap li");
                    if (items.isEmpty()) break; // 더 이상 페이지 없음

                    for (Element li : items) {
                        try {
                            CafeVO vo = new CafeVO();
                            vo.setCno(cno);

                            // 이미지
                            Element imgEl = li.selectFirst("figure.photo img");
                            String img = (imgEl != null) ? imgEl.attr("src") : null;
                            if (img != null && !img.startsWith("http")) img = BASE + img;
                            vo.setImage(nz(img));

                            // 영어/한글 이름 + 설명
                            vo.setEngname(textOrEmpty(li, "dl.txt span.eng"));
                            vo.setKorname(textOrEmpty(li, "dl.txt span.kor"));
                            vo.setDescription(textOrEmpty(li, "dl.txt dd"));

                            // --- 영양정보: 클래스 기반 매핑 ---
                            // 규칙:
                            // bg1: 첫번째 → kcal, 두번째 → protein
                            // bg2: 첫번째 → sodium, 두번째 → caffeine
                            // bg3: 첫번째 → carbohydrate, 두번째 → fat
                            // bg4: sugar
                            Integer kcal = null, sodium = null, carbohydrate = null,
                                    sugar = null, protein = null, caffeine = null, fat = null;

                            Elements dls = li.select("div.info dl"); // dl 단위로 긁기
                            for (Element dl : dls) {
                                Integer val = parseNumberFromDl(dl); // dt에서 숫자만 추출 (없으면 null)

                                if (hasClass(dl, "bg1")) {
                                    if (kcal == null) kcal = val;
                                    else if (protein == null) protein = val;
                                } else if (hasClass(dl, "bg2")) {
                                    if (sodium == null) sodium = val;
                                    else if (caffeine == null) caffeine = val;
                                } else if (hasClass(dl, "bg3")) {
                                    if (carbohydrate == null) carbohydrate = val;
                                    else if (fat == null) fat = val;
                                } else if (hasClass(dl, "bg4")) {
                                    sugar = val;
                                }
                            }

                            // VO에 세팅 (없는 태그는 그대로 null)
                            vo.setKcal(kcal);
                            vo.setSodium(sodium);
                            vo.setCarbohydrate(carbohydrate);
                            vo.setSugar(sugar);
                            vo.setProtein(protein);
                            vo.setCaffeine(caffeine);
                            vo.setFat(fat);

                            // DB 저장
                            dao.cafeInsert(vo);

                            System.out.printf("[OK] cno=%d, %s / %s%n",
                                    cno, vo.getEngname(), vo.getKorname());

                        } catch (Exception inner) {
                            inner.printStackTrace();
                        }
                    }

                    page++;
                    Thread.sleep(100L); // 요청 간격 딜레이(선택)

                } catch (Exception ex) {
                    ex.printStackTrace();
                    break; // 해당 카테고리 종료
                }
            }
        }
        System.out.println("== 수집 완료 ==");
    }

    // ----- 유틸 -----

    private static boolean hasClass(Element el, String cls) {
        // className이 여러 개인 경우 대비해서 contains 말고 hasClass 사용
        return el != null && el.hasClass(cls);
    }

    private static String textOrEmpty(Element scope, String sel) {
        Element el = scope.selectFirst(sel);
        return (el == null) ? "" : el.text().trim();
    }

    // dl 안의 dt에서 숫자만 추출 → 없으면 null
    private static Integer parseNumberFromDl(Element dl) {
        if (dl == null) return null;
        Element dt = dl.selectFirst("dt");
        if (dt == null) return null;
        String num = dt.text().replaceAll("[^0-9.]", "");
        if (num.isEmpty()) return null;
        return (int)Math.round(Double.parseDouble(num));
    }

    private static String nz(String s) { return (s == null) ? "" : s; }

    public static void main(String[] args) {
        new CafeJsoup().crawl();
    }
}
