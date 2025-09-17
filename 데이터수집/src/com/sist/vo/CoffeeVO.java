package com.sist.vo;

import lombok.Data;

/*
NO     NOT NULL NUMBER        
NAME   NOT NULL VARCHAR2(100) 
EXDATE NOT NULL VARCHAR2(200) 
PRICE  NOT NULL VARCHAR2(50)  
IMAGE  NOT NULL VARCHAR2(260) 
 */
@Data
public class CoffeeVO {
	private int no;
	private String name,exdate,price,image;
}
