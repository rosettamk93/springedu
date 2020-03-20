package com.kh.portfolio.member.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
public class LoginController {

	private static final Logger logger 
		= LoggerFactory.getLogger(LoginController.class);
	
	@Inject
	MemberSVC memberSVC;
	
	//로그인 양식
	//@RequestMapping(value="/login",method=RequestMethod.GET)
	@GetMapping("/loginForm")
	public String login(
			@RequestParam(value="reqURI", required = false) String reqURI,
			Model model) {
		if(reqURI == null) {
			reqURI = "/";
		}
		model.addAttribute("reqURI", reqURI);
		return "/member/loginForm";
	}
	
	//로그인 처리
	@PostMapping("/login")
	public String loginOk(
			@RequestParam("id") String id, 
			@RequestParam("pw") String pw,
			@RequestParam("reqURI") String reqURI,
			HttpSession session, 
			Model model) {
		
		logger.info("id="+id);
		logger.info("pw="+pw);
		
		MemberVO memberVO = memberSVC.selectMember(id);
		//1) 회원이 없는경우
		if(memberVO == null) {
			model.addAttribute("svr_msg", "가입된 회원정보가 없습니다.");
			//throw new BizException("가입된 회원정보가 없습니다.");
		}else {
		//2) 회원이 있는경우
			//2-1) 비밀번호가 일치하는경우
			if( pw.equals(memberVO.getPw())) {
				session.setAttribute("member", memberVO);
				return "redirect:/";

			}else {
			//2-2) 비밀번호가 다른경우
				model.addAttribute("svr_msg", "비밀번호가 일치하지 않습니다.");	
			}
		}	
		session.invalidate();
		return "/member/loginForm";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate(); 
		return "redirect:/";
	}
}








