package com.kh.portfolio.admin.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger
		= LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	MemberSVC memberSVC;
	
	//관리자페이지
	@GetMapping("")
	public String adminPage() {
		
		return "admin/index";
	}
	
	
	//회원목록
	@GetMapping("/memberList")
	public String memberList(Model model) {
		
		List<MemberVO> list = memberSVC.selectAllMember();
		model.addAttribute("memberList", list);
		return "admin/memberList";
	}
}










