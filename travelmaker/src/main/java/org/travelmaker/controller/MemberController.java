package org.travelmaker.controller;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.loginapi.NaverLoginBO;

import com.github.scribejava.core.model.OAuth2AccessToken;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.service.MemberService;
import org.travelmaker.service.apiLoginService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	@Setter(onMethod_ = @Autowired) // 무조건 주입
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private apiLoginService apiService;
	
	// 로그인에 성공하면 여기루 넘어온다.
	@GetMapping("/success") 
	public void success() {
		log.info("Success");
	}
	
	@GetMapping("/accountInfo") 
	public void accountInfo() {
		log.info("accountInfo");
	}
	
	@GetMapping("/deletePage") 
	public void delete() {
		log.info("deletePage");
	}
	
	// 회원가입정보를 다 입력하고 회원가입 버튼을 누른다. 
	// value : 폼액션에서 넘겨줄 주소이다.
	@RequestMapping(value = "/joinMember", method = RequestMethod.POST)
	public ModelAndView joinMember(MemberVO mVO, HttpSession session, RedirectAttributes rttr) {
		ModelAndView mav = new ModelAndView("redirect:/member/main");
		
		// 이메일, 닉네임 한번 더 검사하자
		if(service.isDuplicateCheck(mVO, rttr)) {
			return mav;
		}
		
		// 중복이 없다면.. 가입 시키자
		service.join(mVO); // 내용을 저장한다.
		rttr.addFlashAttribute("msg", "travel 가족이 되신걸 환영합니다 로그인 해주세요");
		return mav; // 회원가입 후, main으로 이동
	}

	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(MemberVO mVO, HttpSession session, HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr) {
		ModelAndView mav = new ModelAndView("redirect:/member/success");
		
		// 계정 정보가 일치하지 않거나, 탈퇴한 회원이면 fail
		if(service.isMemberStatus(mVO, rttr, session)) {
			mav=new ModelAndView("redirect:/member/main");
			return mav;
		}
		// email 저장하기 여부
		service.RememberEmail(mVO.getEmail(), request, response);	
		
		service.login(mVO); // 로그인 시키자..!
		service.lastLoginSetToday(mVO.getEmail()); // 최종 로그인은 오늘..
		session.setAttribute("email", mVO.getEmail()); // 세션에 이메일 담자
		session.setAttribute("memNo", service.getMemNo(mVO.getEmail())); // 회원 번호 
		return mav;
	
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate(); // 세션 삭제
		
		// 메인으로 이동
		return "redirect:main";
	}
	
	// 회원 조회
	@RequestMapping(value = "/getMember", method = RequestMethod.GET)
	public String getMember(String email, Model model) {
		// 로그인한 정보를 담는다.
		model.addAttribute("member", service.getMember(email));
		// 조회페이지로 이동한다.
		return "/member/accountInfo";
	}
	
	// 비밀번호 변경
	@RequestMapping(value = "/modifyPwd", method = RequestMethod.POST)
	public String modifyPwd(String pwd, String email, Model model) {
		// 비밀번호를 바꾼다.
		service.modifyPwd(pwd, email);
		
		// 바뀐 회원의 정보를 화면에 출력한다.
		model.addAttribute("member", service.getMember(email));
		return "/member/accountInfo";
	}
	
	// Ajax Email체크
	@RequestMapping("/hasEmail")
    @ResponseBody
    public String hasEmail(@RequestParam("email") String email) {
        
        String count = ""+service.hasEmail(email); // 중복되면 1 반환
        
        return count;
    }
	
	// Ajax 닉네임 체크(accountInfo)
	@RequestMapping("/hasNickname")
	@ResponseBody
	public String hasNickname(@RequestParam("nickname") String nickname) {

		String cnt = "" + service.hasNickname(nickname); // 닉네임 있으면 1, 없으면 0을 반환한다.
		System.out.println("닉네임 중복 ? : " + cnt);
			
		return cnt;
	}
	
	// 닉네임 수정(회원정보에서 저장하기 버튼 누르면 실행)
	@RequestMapping(value = "/modifyNickname", method = RequestMethod.POST)
	public String modifyNickname(String nickname, String email, Model model, RedirectAttributes rttr) {

		// 닉네임을 수정하고 저장하기를 눌렀다면..
		if(service.isNicknameTouch(nickname, email, model)) {
			return "/member/accountInfo";
		}
		
		// 중복이 없다면 정보가 정상적으로 저장되었습니다.
		return "/member/accountInfo";
	}
	
	//회원탈퇴 페이지 이동
	@RequestMapping(value = "/deletePage", method = RequestMethod.POST)
	public String deletePage(String email, Model model) {
		// 계정을 삭제하기 위한 페이지로 이동한다. (회원 정보를 가지고)
		model.addAttribute("member", service.getMember(email));
		
		return "/member/deletePage";
	}
	
	// 회원탈퇴(status를 탈퇴로 바꾼다.. 계정이 사라지는게 아님)
	@RequestMapping(value = "/deleteMember", method = RequestMethod.POST)
	public ModelAndView deleteMember(String pwd, String email, HttpSession session, RedirectAttributes rttr) {
		ModelAndView mav;
			
		// 회원이 일치하는지 확인
		// 일치하면 탈퇴, 불일치하면 탈퇴 못함
		if(service.isMemberValid(pwd, email, rttr, session)) {
			mav = new ModelAndView("redirect:/member/deletePage");
			return mav;
		}
		mav = new ModelAndView("redirect:/member/main");
		return mav;
	}
	
	// 네아로
    @RequestMapping("/main")
    public ModelAndView naverLogin(HttpSession session) { // <- 네이버 로그인 성공하면 callback으로..
        /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
        String naverAuthUrl = apiService.getNaverAuthUrl(session);
        
        /* 생성한 인증 URL을 View로 전달 */
        return new ModelAndView("/member/main", "url", naverAuthUrl);
    }
    
	  //네이버 로그인 성공시 callback호출 메소드
	  // 'id'값은 각 애플리케이션마다 회원 별로 유니크한 값
     @RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
     public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, RedirectAttributes rttr) throws IOException, ParseException {
	    System.out.println("여기는 callback");
	    
	    OAuth2AccessToken oauthToken = apiService.getNaverToken(code, state, session);
	    String userInfo = apiService.getNaverUserProfile(oauthToken); // // 로그인한 사용자 정보를 읽어온다.
	    
	    // 데이터 파싱
	    // 토큰과 네이버 프로필을 JSON형태로 
	    JSONObject response_obj = apiService.getJsonByNaver(oauthToken, userInfo);
	    String email = (String)response_obj.get("email"); // 로그인한 사용자의 이메일을 저장한다
	    
	    if(service.hasEmail(email) > 0) { // 이제 sns 회원 테이블 만들어야겠다(회원 번호, 아이디, 성별 정도만 받자..)
	    	session.setAttribute("email",email); // 네이버아이디 == travel가족이면 회원가입 안 해도 됨. 바로 세션 주기
	    }
	    
	    model.addAttribute("result", userInfo);
	    // "oauth_state" 네이버 로그인하면 주는 세션 아이디인듯
	    System.out.println(session.getAttribute("oauth_state"));
	    System.out.println(userInfo); // 네이버 로그인 정보					
	    return "/member/naverSuccess";
	    
     }
    
    
    // 로그인 해야 들어갑니다아
	@RequestMapping(value = "/testPage", method = RequestMethod.GET)
	public String testPage(HttpSession session, RedirectAttributes rttr) {
		System.out.println("testPAge");
		// 회원 로그인
		String result = (String)session.getAttribute("email");
		
		// 로그인 안됐으면 로그인 하라고 알려주자
		if(result == null) {
			rttr.addFlashAttribute("msg", "로그인 해주세요!");
			return "redirect:main";
		}
		
		// testPage로 이동한다.
		return "/member/testPage";
	}
    
}
