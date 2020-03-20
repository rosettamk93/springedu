package com.kh.portfolio.board.vo;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Entity;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Entity
@Data
public class AboardVO {

	private long abnum;
	
	@Valid
	private BoardCategoryVO boardCategoryVO;
	@NotNull
	@Size(min=4, max=50, message="제목은 4~50자까지입니다.")
	private String abtitle;
	
	private String abid;
	private String abnickname;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Timestamp abcdate;
	private Timestamp ubcdate;
	private int abhit;
	@NotNull(message="내용을 입력바랍니다!!")
	@Size(min=4, message="내용은 최소 4자 이상 입력 바랍니다.!")	
	private String abcontent;
	private int abgroup;
	private int abstep;						//BSTEP     NOT NULL NUMBER(5)     
	private int abindent;	
	
//첨부파일
	private List<MultipartFile> files;	
}
