package com.kh.portfolio.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.portfolio.board.svc.ArboardSVC;
import com.kh.portfolio.board.vo.ArboardVO;
import com.kh.portfolio.board.vo.AvoteVO;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;

@RestController
@RequestMapping("/arboard")
public class ArboardController {
	
	private static Logger logger 
	= LoggerFactory.getLogger(ArboardController.class);
	
	@Inject
	ArboardSVC arboardSVC;
	
	//댓작
	@PostMapping(value="", produces="application/json")
	public ResponseEntity<String> write(
			@RequestBody(required = true) ArboardVO arboardVO){
		ResponseEntity res = null;
		logger.info("write()호출됨");
		logger.info("arboardVO:"+arboardVO.toString());
	
		//유효성
		if(arboardVO.getArbnum() > 0      	&&
			 arboardVO.getArid() != null			&&
			 arboardVO.getArnickname() !=null &&
			 arboardVO.getArcontent() !=null) {
			
			//댓작
			arboardSVC.write(arboardVO);
			//성
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
		return res;
	}
	//댓수정
	@PutMapping(value="", produces="application/json")
	public ResponseEntity<String> modify(
			@RequestBody(required = true) ArboardVO arboardVO){
		ResponseEntity<String> res = null;
		//유효성
		if(arboardVO.getArcontent() != null &&
			 arboardVO.getArnum() > 0) {
			//수정
			arboardSVC.modify(arboardVO);
			//성
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
			return res;
	}
	//댓삭
	@DeleteMapping(value="/{arnum}", produces="application/json;charset=UTF-8")
	public ResponseEntity<String> delete(
			@PathVariable(required = true) String arnum){
		
		ResponseEntity<String> res = null;
		int cnt = arboardSVC.delete(arnum);
		if(cnt == 1) {
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
		return res;
	}
	//대댓작
	@PostMapping(value="/reply", produces="application/json")
	public ResponseEntity<String> reply(
			@RequestBody(required = true) ArboardVO arboardVO){
		ResponseEntity res = null;
		logger.info("write() 호출됨!");
		logger.info("rboardVO : " + arboardVO.toString());
		
		//유효성
		if(arboardVO.getAprnum() > 0          &&
			 arboardVO.getArid() != null				&&
			 arboardVO.getArnickname() != null	&&
			 arboardVO.getArcontent() != null) {
			
			//대댓작
			arboardSVC.reply(arboardVO);
			//성
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
		return res;
	}
	//댓좋싫
	@PutMapping(value = "/avote", produces = "application/json")
	public ResponseEntity<String> vote(
			@RequestBody AvoteVO avoteVO){
		ResponseEntity<String> res = null;
		logger.info("댓글 선호, 비선호 호출됨!");
		//유효성체크
		if(avoteVO.getArnum() > 0     &&
			 avoteVO.getAbnum() > 0     &&
			 avoteVO.getArid() != null  &&
			 avoteVO.getAvote() != null
			 ) {
			//댓호불반영
			arboardSVC.mergeVote(avoteVO);
			//성
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
			return res;
	}
	//댓목록   혹시 목록 오류는 여기서
	@GetMapping(value="/{page}/{abnum}", produces="application/json")
	public ResponseEntity<Map<String,Object>> list(
			@PathVariable String page,
			@PathVariable(required=true) String abnum){
		
		ResponseEntity<Map<String,Object>> res = null;
		Map<String,Object> map = new HashMap<>();
		logger.info("댓글 목록 호출됨!");		
		
		try {
			//페이지정보
			RecordCriteria rc = new RecordCriteria(Integer.valueOf(page));
			PageCriteria pc = new PageCriteria(rc, arboardSVC.replyTotalRec(abnum));
			//댓목
			List<ArboardVO> list = arboardSVC.list(Integer.valueOf(abnum), 
																						 rc.getStartRec(), 
																						 rc.getEndRec());
			map.put("pc", pc);
			map.put("list", list);
			res = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			res = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		return res;		

	}
	
	
	
	
}
