package org.travelmaker.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.DaybudVO;
import org.travelmaker.service.DaybudService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

// 10.2.1 목록에 대한 처리와 테스트
// 보드콘트롤러에서 전체 목록을 가져오는 처리를 먼저 작성합니다. 
// 보드콘트롤러는 BoardService 타입의 객체와 같이 연동해야 하므로
// 의존성에 대한 처리도 같이 진행합니다. 
@Controller
@Log4j
@RequestMapping("/daybud/*")
@AllArgsConstructor
public class DaybudController {

//	@InitBinder
//    public void initBinder(WebDataBinder binder) {
//        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
//        sdf.setLenient(true);
//        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
//    }
	 
	private DaybudService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		
		log.info("list");
		
		model.addAttribute("list", service.getList());	
	}
	
	@PostMapping("/register")
	public String register(DaybudVO daybud, RedirectAttributes rttr) {
		
		log.info("register" + daybud);
		
		service.register(daybud);
		
		rttr.addFlashAttribute("result", daybud.getSchno());
		
		return "redirect:/daybud/list?paydate="+daybud.getPaydate();
	}
	
	@PostMapping("/modify")
	public String modify(DaybudVO daybud, RedirectAttributes rttr) {
		log.info("modify : " + daybud);
		
		if (service.modify(daybud)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/daybud/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("schno") Long schno, RedirectAttributes rttr) {
		
		log.info("remove..." + schno);
		if (service.remove(schno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/daybud/list";
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("schno") Long schno, Model model) {
		log.info("/get or modify");
		model.addAttribute("daybud", service.get(schno));
		model.addAttribute("schno", schno);
		model.addAttribute("box", service.box());
	}
	
//	@GetMapping("/get")
//	public void select(Model model) {
//		model.addAttribute("box", service.select());
//	}
}
