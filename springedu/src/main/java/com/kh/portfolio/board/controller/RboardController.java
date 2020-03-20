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

import com.kh.portfolio.board.svc.RboardSVC;
import com.kh.portfolio.board.vo.RboardVO;
import com.kh.portfolio.board.vo.VoteVO;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;

@RestController
@RequestMapping("/rboard")
public class RboardController {

	private static Logger logger 
		= LoggerFactory.getLogger(RboardController.class);
	
	@Inject
	RboardSVC rboardSVC;
	
	//댓글 작성
	@PostMapping(value="", produces="application/json")
	public ResponseEntity<String> write(
			@RequestBody(required = true) RboardVO rboardVO){
		ResponseEntity res = null;
		logger.info("write() 호출됨!");
		logger.info("rboardVO : " + rboardVO.toString());
		
		//유효성체크
		if(rboardVO.getBnum() > 0 				&&
			 rboardVO.getRid() !=null 			&&
			 rboardVO.getRnickname() !=null &&
			 rboardVO.getRcontent() !=null) {
		
			//댓글작성
			rboardSVC.write(rboardVO);
			//성공
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			//실패
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
		return res;
	}
	//댓글 수정
	@PutMapping(value="", produces="application/json")
	public ResponseEntity<String> modify(
			@RequestBody(required = true) RboardVO rboardVO){
		ResponseEntity<String> res = null;
		//유효성체크
		if(rboardVO.getRcontent() != null &&
		   rboardVO.getRnum() > 0) {
		//댓글수정
			rboardSVC.modify(rboardVO);
		//성공
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
		//실패
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
		return res;
	}
	//댓글 삭제
	@DeleteMapping(value="/{rnum}", produces="application/json;charset=UTF-8")
	public ResponseEntity<String> delete(
		@PathVariable(required=true) String rnum){
		
		ResponseEntity<String> res = null;
		int cnt = rboardSVC.delete(rnum);
		if(cnt == 1) {
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
		return res;
	}
	//대댓글 작성
	@PostMapping(value="/reply", produces="application/json")
	public ResponseEntity<String> reply(
			@RequestBody(required = true) RboardVO rboardVO){
		ResponseEntity res = null;
		logger.info("write() 호출됨!");
		logger.info("rboardVO : " + rboardVO.toString());
		
		//유효성체크
		if(rboardVO.getPrnum() > 0 				&&
  		 rboardVO.getRid() !=null 			&&
			 rboardVO.getRnickname() !=null &&
			 rboardVO.getRcontent() !=null) {
		
			//대댓글작성
			rboardSVC.reply(rboardVO);
			//성공
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			//실패
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
		return res;
	}	
	//댓글 선호, 비선호
	@PutMapping(value="/vote", produces="application/json")
	public ResponseEntity<String> vote(
			@RequestBody VoteVO voteVO){
		ResponseEntity<String> res = null;
		logger.info("댓글 선호, 비선호 호출됨!");
		//유효성체크
		if(voteVO.getRnum() > 0 		&&		// 댓글번호
			 voteVO.getBnum() > 0 		&&		// 원글번호
			 voteVO.getRid()  != null &&		// 투표자 아이디
			 voteVO.getVote() != null				// '1':선호, '2':비선호
				) {		
			//댓글선호,비선호 반영
			rboardSVC.mergeVote(voteVO);
			//성공
			res = new ResponseEntity<String>("success",HttpStatus.OK);	//200
		}else {
			//실패
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}		
		return res;
	}
	//댓글목록조회
	@GetMapping(value="/{page}/{bnum}", produces="application/json")
	public ResponseEntity<Map<String,Object>> list(
		@PathVariable String page,
		@PathVariable(required=true) String bnum){
		
		ResponseEntity<Map<String,Object>> res = null;
		Map<String,Object> map = new HashMap<>();
		logger.info("댓글 목록 호출됨!");		
		
		try {
			//페이지정보
			RecordCriteria rc = new RecordCriteria(Integer.valueOf(page));
			PageCriteria pc = new PageCriteria(rc, rboardSVC.replyTotalRec(bnum));
			//댓글목록
			List<RboardVO> list = rboardSVC.list(Integer.valueOf(bnum), 
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
















