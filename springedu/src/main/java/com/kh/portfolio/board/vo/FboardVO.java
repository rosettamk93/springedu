package com.kh.portfolio.board.vo;

import java.util.List;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Entity
@Data
public class FboardVO {
	private long fnum;				//제품번호
	@NotNull
	@Size(min=4, max=40, message="제품명은 최소 4자, 최대 5자입니다.")
	private String ftitle;		//제품명
	private String fsubtitle;	//제품영제
	@NotNull(message="제조사를 입력하세요.")
	private String fmaker;		//제조사
	private int price; 			  //가격
	private String fcode;			//제품코드
	@NotNull(message="무게 미확인시 미정으로 입력하세요.")
	private String fweight;		//무게
	@NotNull(message="높이 미확인시 미정으로 입력하세요.")
	private String fheight;		//무게
	@NotNull(message="길이 미확인시 미정으로 입력하세요.")
	private String flenght;		//무게
	@NotNull(message="폭 미확인시 미정으로 입력하세요.")
	private String fwidth;		//무게
	private String fbid;
	private String fbnickname;
	//첨부파일
	
	private List<MultipartFile> filesf;
}
