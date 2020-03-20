package com.kh.portfolio.board.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.portfolio.board.svc.NboardSVC;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.NboardVO;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/nboard")
public class NboardController {

	private static final Logger logger
	= LoggerFactory.getLogger(NboardController.class);
	
	@Inject
	NboardSVC nboardSVC;
	
//@Inject
//private BoardValidator boardValidator;
//@InitBinder
//private void initBinder(WebDataBinder binder) {
//	binder.setValidator(boardValidator);
//}
	
	@ModelAttribute
	public void getBoardCategory(Model model) {
		List<BoardCategoryVO> boardCategoryVO = nboardSVC.getCategory();
		model.addAttribute("boardCategoryVO", boardCategoryVO);
	}
	
	//게시글작성양식
	@GetMapping("writeForm/{returnPage}")
	public String writeForm(
			@ModelAttribute @PathVariable String returnPage,
			Model model, HttpServletRequest request) {
		//cs1
		model.addAttribute("nboardVO", new NboardVO());
		//cs2
	//BoardVO boardVO = new BoardVO();
		//MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
		//boardVO.setBid(memberVO.getId());
		//boardVO.setBnickname(memberVO.getNickname());	
		//model.addAttribute("boardVO",boardVO);
	
	return "/nboard/writeForm";
	}
	
//게시글 작성
	@PostMapping("/write/{returnPage}")
	public String write(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("nboardVO") NboardVO nboardVO,
			BindingResult result,
			HttpServletRequest request) {
		logger.info("게시글작성 : " + nboardVO.toString());
		
		if(result.hasErrors()) {
			return "/nboard/writeForm";
		}
		
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
		nboardVO.setNbid(memberVO.getId());
		nboardVO.setNbnickname(memberVO.getNickname());
		logger.info("게시글작성2 : " + nboardVO.toString());
		nboardSVC.write3(nboardVO);
		return "redirect:/nboard/view/"+returnPage+"/"+nboardVO.getNbnum();
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
		model.addAttribute("list",nboardSVC.list3(reqPage, searchType, keyword));
		//페이지제어
		model.addAttribute("pc", nboardSVC.getPageCriteria(reqPage, searchType, keyword));
		return "nboard/list";
	}
	
	//게시글보기
	@GetMapping("/view/{returnPage}/{nbnum}")
	public String view(
			@ModelAttribute @PathVariable String returnPage,
			@PathVariable String nbnum,
			Model model) {
		
		Map<String,Object> map = nboardSVC.view3(nbnum);
		NboardVO nboardVO = (NboardVO)map.get("nboard");
		logger.info(nboardVO.toString());
		model.addAttribute("nboardVO", nboardVO);
		return "/nboard/readForm";
	}
	
	//게시글삭제
	@GetMapping("/delete/{returnPage}/{nbnum}")
	public String delete(
			@PathVariable String returnPage,
			@PathVariable String nbnum, 
			Model model) {
		//게시글 삭제
		nboardSVC.delete3(nbnum);
		model.addAttribute("list", nboardSVC.list3());
		
		return "redirect:/nboard/list/"+returnPage;
	}
	
	//게시글수정
	@PostMapping("/modify/{returnPage}")
	public String modify(
			@PathVariable String returnPage,
			@Valid @ModelAttribute("nboardVO") NboardVO nboardVO,
			BindingResult result) {
		if(result.hasErrors()) {
			return "/nboard/readForm";
		}
		logger.info("게시글 수정 내용:" + nboardVO.toString());
		nboardSVC.modify3(nboardVO);
		return "redirect:/nboard/view/"+returnPage+"/"+nboardVO.getNbnum();
	}

}
