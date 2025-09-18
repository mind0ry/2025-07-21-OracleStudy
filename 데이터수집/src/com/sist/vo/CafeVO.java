// package
package com.sist.vo;


public class CafeVO {

	    private int no;
	    private int cno;
	    private String image;
	    private String engname;
	    private String korname;
	    private String description;

	    // 영양성분: null 가능하면 Integer 권장
	    private Integer kcal;
	    private Integer sodium;
	    private Integer carbohydrate;
	    private Integer sugar;
	    private Integer protein;
	    private Integer caffeine;
	    private Integer fat;
	

	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public Integer getKcal() {
		return kcal;
	}
	public void setKcal(Integer kcal) {
		this.kcal = kcal;
	}
	public Integer getSodium() {
		return sodium;
	}
	public void setSodium(Integer sodium) {
		this.sodium = sodium;
	}
	public Integer getCarbohydrate() {
		return carbohydrate;
	}
	public void setCarbohydrate(Integer carbohydrate) {
		this.carbohydrate = carbohydrate;
	}
	public Integer getSugar() {
		return sugar;
	}
	public void setSugar(Integer sugar) {
		this.sugar = sugar;
	}
	public Integer getProtein() {
		return protein;
	}
	public void setProtein(Integer protein) {
		this.protein = protein;
	}
	public Integer getCaffeine() {
		return caffeine;
	}
	public void setCaffeine(Integer caffeine) {
		this.caffeine = caffeine;
	}
	public Integer getFat() {
		return fat;
	}
	public void setFat(Integer fat) {
		this.fat = fat;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getEngname() {
		return engname;
	}
	public void setEngname(String engname) {
		this.engname = engname;
	}
	public String getKorname() {
		return korname;
	}
	public void setKorname(String korname) {
		this.korname = korname;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
    
    
}
