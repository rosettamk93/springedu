package com.kh.portfolio.board.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class FboardFileVO {
  private long fid;
  private long fnum;
  private String fname;
  private long fsize;
  private String ftype;
  private byte[] fdata;
  private Timestamp fcdate;
  private Timestamp fudate;
}
