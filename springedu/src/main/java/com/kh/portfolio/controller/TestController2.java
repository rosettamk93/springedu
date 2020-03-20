package com.kh.portfolio.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController2 {
	
	private static final Logger logger
		=LoggerFactory.getLogger(TestController2.class);

	@GetMapping("/test/t1")
	public String t1(HttpServletRequest request) {
		String name = request.getParameter("name");
		String age = request.getParameter("age");
		logger.info("이름: " + name);
		logger.info("나이: " + age);
		return "test";
	}
	
	//요청파라미터를 매개변수선언시 자동 형변환됨.
	@GetMapping("/test/t2")
	public String t2(
			@RequestParam String name,
			@RequestParam int age) {

		logger.info("이름: " + name);
		logger.info("나이: " + age);
		return "test";
	}
	@GetMapping("/test/t3")
	public String t3(
			@RequestParam("name") String rename,
			@RequestParam("age") int reage) {
		
		logger.info("이름: " + rename);
		logger.info("나이: " + reage);
		return "test";
	}
	@GetMapping("/test/t4")
	public String t4(
			@RequestParam Map<String, String> map) {
		
		logger.info("이름: " + map.get("name"));
		logger.info("나이: " + map.get("age"));
		return "test";
	}
	
	@GetMapping("/test/t5")
	public String t5(Person person) {
		logger.info(person.toString());
		return "test";
	}

	@GetMapping("/test/t6")
	public String t6(Person person, Model model) {
		logger.info(person.toString());
		Map<String,Object> map = model.asMap();
		for(String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString());
		}
		return "test";
	}
	@GetMapping("/test/t7")
	public String t7(@ModelAttribute("per") Person person, Model model) {
		logger.info(person.toString());
		Map<String,Object> map = model.asMap();
		for(String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString());
		}
		
		return "test";
	}	
	
	//입력양식(test2); 이름,나이 url /test/t9 get
	@GetMapping("/test/t9")
	public String t9() {
		return "test2";
	}
	//입력처리 url /test/t10 post
	@PostMapping("/test/t10")
	public String t10(@ModelAttribute("per") Person person, Model model) {
		logger.info(person.toString());
		
	  Map<String,Object> map = model.asMap(); 
	  for(String key : map.keySet()) {
	  	logger.info(key + ":" + map.get(key).toString()); 
	  }
		return "test3";
	}	
	
	@PostMapping("/test/t11")
	public String t11(
			@Valid @ModelAttribute("per") Person person,
			BindingResult result,
			Model model) {
		logger.info(person.toString());
		Map<String,Object> map = model.asMap(); 
		for(String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString()); 
		}
		  
		if(result.hasErrors()) {
			return "test4";
		}
		
		return "test3";
	}		
	
	//Rest 서비스할때 client에서 Ajax호출할때 url요청 표현방식
	@GetMapping("/test/t12/{name}/{age}")
	public String t12(
			@PathVariable("name") String name,
			@PathVariable("age") String age,
			Model model
			) {
		model.addAttribute("name", name);
		model.addAttribute("age", age);
		logger.info("이름: " + name);
		logger.info("나이: " + age);
		
		return "test";
	}	
	@GetMapping("/test/t13/{name}/{age}")
	public ModelAndView t13(
			@PathVariable("name") String name,
			@PathVariable("age") String age
			) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("test");
		mav.addObject("name", name);
		mav.addObject("age", age);
		logger.info("이름: " + name);
		logger.info("나이: " + age);
		
		return mav;
	}	
}












