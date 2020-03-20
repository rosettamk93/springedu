package com.kh.portfolio;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.portfolio.board.svc.AboardSVC;
import com.kh.portfolio.board.svc.BoardSVC;
import com.kh.portfolio.board.svc.NboardSVC;
import com.kh.portfolio.member.vo.MemberVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	NboardSVC nboardSVC;
	@Inject
	AboardSVC aboardSVC;
	@Inject
	BoardSVC boardSVC;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "home"; //  ==> /WEB-INF/views/home.jsp
		return "index";
	}
	
	@GetMapping("/bs/test")
	public String test() {
		return "bstest";
	}
	
	@GetMapping("/bs/test2")
	public String test2() {
		return "bstest2";
	}
	@GetMapping("/information")
	public String infr() {
		return "information";
	}
	@GetMapping("/rboard/rereplyForm")
	public String rereplyForm() {
		return "/board/rereply";
	}
	@GetMapping("/aboard/listForm")
	public String list() {
		return "/aboard/list";
	}
	

	@GetMapping("/fboard/read")
	public String listForm() {
		return "fboard/readForm";
	}
	@GetMapping("/fboard/write")
	public String writef() {
		return "fboard/writeForm";
	}

}
