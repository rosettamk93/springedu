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

import com.kh.portfolio.board.svc.FboardSVC;
import com.kh.portfolio.board.vo.FboardFileVO;
import com.kh.portfolio.board.vo.FboardVO;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/fboard")
public class FboardController {

	private static final Logger logger
	= LoggerFactory.getLogger(FboardController.class);
	
	@Inject
	FboardSVC fboardSVC;
	
//	@ModelAttribute
//	public void getFboardVO(Model model) {
//		List<FboarVO>
//	}
//	
	//작성양식
	@GetMapping("/writeForm/{returnPage}")
	public String writeForm(
			@ModelAttribute @PathVariable String returnPage,
			Model model, HttpServletRequest request) {
		//case1)
		model.addAttribute("fboardVO", new FboardVO());
	//case2)
			//BoardVO boardVO = new BoardVO();
			//MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
			//boardVO.setBid(memberVO.getId());
			//boardVO.setBnickname(memberVO.getNickname());	
			//model.addAttribute("boardVO",boardVO);
		return "/fboard/writeForm";
	}
	
	//게시글작성
	@PostMapping("/write/{reqPage}")
	public String write(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("fboardVO") FboardVO fboardVO,
			BindingResult result,
			HttpServletRequest request) {
		logger.info("게시글작성 : " + fboardVO.toString());
		
		if(result.hasErrors()) {
			return "/fboard/writeForm";
			
		}
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
		fboardVO.setFbid(memberVO.getId());
		fboardVO.setFbnickname(memberVO.getNickname());
		logger.info("게시글작성2: " + fboardVO.toString());
		fboardSVC.write4(fboardVO);
		return "redirect:/fboard/view/"+returnPage+"/"+fboardVO.getFnum();
	}
	
	//목록
	@GetMapping({"/list",
							 "/list/{reqPage}",
							 "/list/{reqPage}/{searchType}/{keyword}"
 })
	public String listAll(
			@PathVariable(required=false) String reqPage,
			@PathVariable(required=false) String searchType,
			@PathVariable(required=false) String keyword,
			HttpSession session, 
			Model model	) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("member");
//	if(memberVO != null ) {
//		logger.info("세션있음"+memberVO.toString());
//	}else {
//		logger.info("세션없음");
//	}
//	model.addAttribute("list", boardSVC.list());
	//게시글목록
		model.addAttribute("list", fboardSVC.list(reqPage,searchType,keyword));
		//페이지제어
		model.addAttribute("pc", fboardSVC.getPageCriteria(reqPage, searchType, keyword));
		return "fboard/list";
	}
	
	//게시글보기
	@GetMapping("/VIEW/{returnPage}/{fnum}")
	public String view(
			@ModelAttribute @PathVariable String returnPage,
			@PathVariable String fnum,
			Model model	) {
		
		
		Map<String,Object> map = fboardSVC.view4(fnum);
		FboardVO fboardVO = (FboardVO)map.get("fboard");
		logger.info(fboardVO.toString());
		List<FboardFileVO> files = null;
		if(map.get("files") != null) {
			files = (List<FboardFileVO>)map.get("files");
			
		}
		
		model.addAttribute("fboardVO", fboardVO);
		model.addAttribute("files", files);
		//model.addAttribute("returnPage", returnPage);
		
		return "fboard/readForm";
	}

	//첨부파일 다운
	@GetMapping("/file/{fid}")
	public ResponseEntity<byte[]> getFile(@PathVariable String fid) {
	FboardFileVO fboardFileVO = fboardSVC.fileViewf(fid);
	logger.info("getFile " + fboardFileVO.toString());
	
	final HttpHeaders headers = new HttpHeaders();
	String[] mtypes = fboardFileVO.getFtype().split("/");
	headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
	headers.setContentLength(fboardFileVO.getFsize()); 
	/* 첨부파일명이 한글일경우 깨짐 방지 */ 
	String filename = null;
	try {
		filename = new String(fboardFileVO.getFname().getBytes("euc-kr"), "ISO-8859-1");
	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	}
	headers.setContentDispositionFormData("attachment", filename);
	/***************************/
	return new ResponseEntity<byte[]>(fboardFileVO.getFdata(), headers,	HttpStatus.OK);
	}

	//삭제
	@GetMapping("/delete/{returnPage}/{bnum}")
	public String delete(@PathVariable String returnPage,
			@PathVariable String fnum, 
			Model model ) {
		
		//1 게시글 첨부파일 삭제
		fboardSVC.delete4(fnum);
		//목록 가져오기
		model.addAttribute("list", fboardSVC.listf());
		
		return "redirect:/fboard/list/"+returnPage;
	}

	//1건삭제
	@DeleteMapping("/file/{fid}")
	@ResponseBody
	public ResponseEntity<String> fileDelete(
			@PathVariable String fid){

	  int cnt =		fboardSVC.fileDeletef(fid);

	  if(cnt == 1 ) {
	  	return new ResponseEntity<String>("success", HttpStatus.OK);
	  }else {
	  	return new ResponseEntity<String>("fail", HttpStatus.FAILED_DEPENDENCY);
	  }
	}

	//수정
	@PostMapping("/modify/{returnPage}")
	public String modify(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("fboardVO") FboardVO fboardVO,
			BindingResult result
			) {
		if(result.hasErrors()) {
			return "/fboard/readForm";
		}
		logger.info("수정내용" + fboardVO.toString());
		fboardSVC.modify4(fboardVO);
		return "redirect:/fboard/view/"+returnPage+"/"+fboardVO.getFnum();
	}




}
