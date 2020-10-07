package com.hk.poom.controller;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hk.poom.dto.FindIdDTO;
import com.hk.poom.dto.LoginDTO;
import com.hk.poom.dto.RegisterPerDTO;
import com.hk.poom.service.MemberService;


@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	MemberService memberService;
	
	@Autowired
	ServletContext sc;
	
	@GetMapping("/poom/register/com")
	public String registerCom( ) {
		
		
		return "member/registerCom";
	}
	
	@PostMapping("/poom/register/com")
	public String registerComPost( ) {
		
		
		return "member/registerComPost";
	}
	
	
	
	@GetMapping("/poom/register/per")
	public String registerPer( ) {
		
		
		return "member/registerPer";
	}
	
	@GetMapping("/poom/register/new")
	public String registerNew( ) {
		logger.info("MemberController_Get_/poom/register/new 실행");
		
		return "member/registerNew";
	}
	
	@PostMapping("/poom/register/new")
	public String registerNewPost( Model model, RegisterPerDTO registerPerDTO, @RequestParam("name") String name ) {
		logger.info("MemberController_Post_/poom/register/new 실행");
		logger.info("신규 개인 회원 입력 정보 = " + registerPerDTO.toString());
		
		memberService.memberRegisterPer(registerPerDTO);
		model.addAttribute("name", name);
		
		return "member/registerNewPost";
	}
	
	
	@GetMapping("/poom/login")
	public String login( ) {
		logger.info("MemberController_Get_/poom/login 실행");
		
		return "member/login";
	}
	
	@PostMapping("/poom/login")
	public String loginPost( HttpServletRequest request, HttpSession session, LoginDTO loginDTO ) {
		logger.info("MemberController_Post_/poom/login 실행");
		logger.info("로그인할 member = " + loginDTO.toString());
		
		LoginDTO loginMember = memberService.memberLogin( loginDTO );
		if ( loginMember!= null ) {
			logger.info("로그인 성공");
			
			session.setAttribute("loginMember", loginMember);
			
			//로그인 성공시 홈으로
			return "home";
		} else {
			logger.info("로그인 실패");
			
			//로그인 실패시
			return "member/loginFail";
		}
		
	}
	
	@GetMapping("/poom/logout")
	public String logout( HttpSession session ) {
		logger.info("MemberController_Get_/poom/logout 실행");
		
		session.invalidate();
		
		return "member/logout";
	}
	
	
	@GetMapping("/poom/find/id")
	public String findId( ) {
		
		
		return "member/findId";
	}
	
	
	@PostMapping("/poom/find/id")
	public String findIdPost( Model model, FindIdDTO findIdDTO) {
		
		model.addAttribute("findIdDTO", memberService.memberFindId(findIdDTO));
		return "member/findIdPost";
	}
	
	@GetMapping("/poom/find/pwd")
	public String findPwd( ) {
		
		
		return "member/findPwd";
	}
	

}
