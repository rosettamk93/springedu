package com.kh.portfolio.board.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.portfolio.board.svc.AboardSVC;
import com.kh.portfolio.board.vo.AboardFileVO;
import com.kh.portfolio.board.vo.AboardVO;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/aboard")
public class AboardController {

	private static final Logger logger
		= LoggerFactory.getLogger(AboardController.class);
	
	@Inject
	AboardSVC aboardSVC;
	
//@Inject
//private BoardValidator boardValidator;
//@InitBinder
//private void initBinder(WebDataBinder binder) {
//	binder.setValidator(boardValidator);
//}
	
	@ModelAttribute
	public void getBoardCategory(Model model) {
		List<BoardCategoryVO> boardCategoryVO = aboardSVC.getCategory();
		model.addAttribute("boardCategoryVO", boardCategoryVO);
	}
	
	//게시글 작성양식
	@GetMapping("/writeForm/{returnPage}")
	public String writeForm(
			@ModelAttribute @PathVariable String returnPage,
			Model model, HttpServletRequest request) {
		//case1
		model.addAttribute("aboardVO", new AboardVO());
		//case2)
	//BoardVO boardVO = new BoardVO();
			//MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
			//boardVO.setBid(memberVO.getId());
			//boardVO.setBnickname(memberVO.getNickname());	
			//model.addAttribute("boardVO",boardVO);
		
		return "/aboard/writeForm";
	}
	
	//게시글 작성
	@PostMapping("/write/{returnPage}")
	public String write(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("aboardVO") AboardVO aboardVO,
			BindingResult result,
			HttpServletRequest request) {
		logger.info("게시글작성 : " + aboardVO.toString());
		
		if(result.hasErrors()) {
			return "/aboard/writeForm";
		}
			
			MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
			aboardVO.setAbid(memberVO.getId());
			aboardVO.setAbnickname(memberVO.getNickname());
			logger.info("게시글작성2 : " + aboardVO.toString());
			aboardSVC.write2(aboardVO);
			return "redirect:/aboard/view/"+returnPage+"/"+aboardVO.getAbnum();
	}
	
	//목록보기
	@GetMapping({"/list",
							"/list/{reqPage}",
						  "/list/{reqPage}/{searchType}/{keyword}"
	})
	public String listAll(
			@PathVariable(required=false) String reqPage,
			@PathVariable(required=false) String searchType,
			@PathVariable(required=false) String keyword,
			HttpSession session, 
			Model model) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("member");
//	if(memberVO != null ) {
//	logger.info("세션있음"+memberVO.toString());
//}else {
//	logger.info("세션없음");
//}
//model.addAttribute("list", boardSVC.list());
//게시글목록
		model.addAttribute("list", aboardSVC.list2(reqPage, searchType, keyword));
		//페이지제어
		model.addAttribute("pc", aboardSVC.getPageCriteria(reqPage, searchType, keyword));
return "aboard/list";		
	}
	
	//게시글보기
	@GetMapping("/view/{returnPage}/{abnum}")
	public String view(
			@ModelAttribute @PathVariable String returnPage,
			@PathVariable String abnum,
			Model model) {
		
		Map<String,Object> map = aboardSVC.view2(abnum);
		AboardVO aboardVO = (AboardVO)map.get("aboard");
		logger.info(aboardVO.toString());
		List<AboardFileVO> files = null;
		if(map.get("files") != null) {
			files = (List<AboardFileVO>)map.get("files");
		}
		
		model.addAttribute("aboardVO", aboardVO);
		model.addAttribute("files", files);
		
		return "/aboard/readForm";
	}
	
	//첨부파일 다운
	@GetMapping("/file/{fid}")
	public ResponseEntity<byte[]> getFile(@PathVariable String fid) {
		AboardFileVO aboardVoFileVO = aboardSVC.fileview2(fid);
		logger.info("getFile " + aboardVoFileVO.toString());
		
		final HttpHeaders headers = new HttpHeaders();
		String[] mtypes = aboardVoFileVO.getFtype().split("/");
		headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
		headers.setContentLength(aboardVoFileVO.getFsize());
		/* 첨부파일명이 한글일경우 깨짐 방지 */ 
		String filename = null;
		try {
			filename = new String(aboardVoFileVO.getFname().getBytes("euc-kr"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		headers.setContentDispositionFormData("attachment", filename);
		/***************************/
		return new ResponseEntity<byte[]>(aboardVoFileVO.getFdata(), headers,	HttpStatus.OK);
	}
		
	//게시글 삭제
	@GetMapping("/delete/{returnPage}/{abnum}")
	public String delete(
			@PathVariable String returnPage,
			@PathVariable String abnum, 
			Model model) {
		
		//1) 게시글 / 첨부파일 삭제
		aboardSVC.delete2(abnum);
		//2) 게시글 목록 가져오기
		model.addAttribute("list", aboardSVC.list2());
		
		return "redirect:/aboard/list/"+returnPage;
	}
	
	//첨부파일 1건삭제
	@DeleteMapping("/file/{fid}")
	@ResponseBody
	public ResponseEntity<String> fileDelete(
			@PathVariable String fid){
		
		int cnt = aboardSVC.fileDelete2(fid);
		
		if(cnt ==1 ) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("fail", HttpStatus.FAILED_DEPENDENCY);
		}
	}
	
	//게시글수정
	@PostMapping("/modify/{returnPage}")
	public String modify(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("aboardVO") AboardVO aboardVO,
			BindingResult result) {
		if(result.hasErrors()) {
			return "/aboard/readForm";
		}
		logger.info("게시글 수정 내용:" + aboardVO.toString());
		aboardSVC.modify2(aboardVO);
		return "redirect:/aboard/view/"+returnPage+"/"+aboardVO.getAbnum();
	}
	
	//답글양식
	@GetMapping("/replyForm/{returnPage}/{abnum}")
	public String replyForm(
			@ModelAttribute @PathVariable String returnPage,
			@PathVariable String abnum,
			Model model) {
		
		Map<String,Object> map = aboardSVC.view2(abnum);
		AboardVO aboardVO = (AboardVO)map.get("aboard");
//	List<BoardFileVO> files = null;
//	if(map.get("files") != null) {
//		files = (List<BoardFileVO>)map.get("files");
//	}
		aboardVO.setAbtitle("[답글]" + aboardVO.getAbtitle());
		aboardVO.setAbcontent("[원글]" + aboardVO.getAbcontent());
		model.addAttribute("aboardVO", aboardVO);
		//	model.addAttribute("files", files);
		
	return "/aboard/replyForm";

	}
	
	//답글처리
	@PostMapping("reply/{returnPage}")
	public String reply(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("aboardVO") AboardVO aboardVO,
			BindingResult result,
			HttpServletRequest request) {
		logger.info("답글처리 :" + aboardVO.toString());
		if(result.hasErrors()) {
			return "/aboard/replyForm";
		}
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
		aboardVO.setAbid(memberVO.getId());
		aboardVO.setAbnickname(memberVO.getNickname());
		aboardSVC.reply2(aboardVO);
		
		return "redirect:/aboard/list/"+returnPage;
	}
	
	
	
	
	
	
	
	
	
}
