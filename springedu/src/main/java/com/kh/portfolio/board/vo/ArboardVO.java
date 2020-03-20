package com.kh.portfolio.board.vo;

import java.sql.Timestamp;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ArboardVO {

	private long arnum;
	private long arbnum;
	private String arid;
	private String arnickname;
	@JsonFormat(pattern= "yyyy-MM-dd h:mm a", timezone= "Asia/Seoul")
	private Timestamp arcdate;
	@JsonFormat(pattern= "yyyy-MM-dd h:mm a", timezone= "Asia/Seoul")
	private Timestamp arudate;
	private String arcontent;
	private int argroup;
	private int arstep;
	private int arindent;
	private int aprnum;
	private String aprid;
	private String aprnickname;
	
	//선호도조사
	private int good;
	private int bad;
	
	//공개투표시사용
//	List<AvoteVO> voteList;
}
