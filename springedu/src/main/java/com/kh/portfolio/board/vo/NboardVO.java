package com.kh.portfolio.board.vo;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Entity
@Data
public class NboardVO {
	private long nbnum;
	
	@Valid
	private BoardCategoryVO boardCategoryVO;
	@NotNull
	@Size(min=4, max=50, message="제목은 4~50자 까지 입력 가능합니다!")
	private String nbtitle;
	
	private String nbid;
	private String nbnickname;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Timestamp nbcdate;
	private Timestamp nbudate;
	private int nbhit;
	@NotNull(message="내용을 입력해주세요!")
	@Size(min=4, message="내용은 최소 4글자 이상 입력하세요.")
	private String nbcontent;
	
}
