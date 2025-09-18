package com.sist.client;

import javax.swing.JFrame;
/*
 *	윈도우 
 *		=> 상속 : extends => 확장해서 사용
 *		=> 상속은 속도가 느리다 => 사용빈도가 없다
 *		   -------------------------------- 독립적인 클래스 (POJO)
 *			=> 결합성이 낮은 프로그램 (로드 존슨)
 *		=> 기본 상속 : 인터페이스 
 *			----------------- 오버라이딩 (재사용 , 재정의)
 */
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;
import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
public class IdCheck extends JFrame {
	JLabel la,rla; // <label>
	JTextField tf; // <input type=text>
	JButton ok,check; // <input type=button> => CSS
	public IdCheck() {
		la=new JLabel("입력");
		tf=new JTextField();
		ok=new JButton("확인");
		ok.setVisible(false);
		check=new JButton("검색");
		rla=new JLabel("",JLabel.CENTER);
		setLayout(null);
		
		la.setBounds(10,15,60,30);
		tf.setBounds(75,15,120,30);
		check.setBounds(200,15,100,30);
		
		add(la);add(tf);add(check);
		
		rla.setBounds(10,50,290,30);
		add(rla);
		
		JPanel p=new JPanel();
		p.add(ok);
		p.setBounds(10,90,290,35);
		add(p);
		
		setSize(330,165);
		//setVisible(true);
		
	}
//	public static void main(String[] args) {
//		new IdCheck();
//	}
	
}
