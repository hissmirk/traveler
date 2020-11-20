package org.travelmaker.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PageDTO;
import org.travelmaker.service.BoardService;
import org.travelmaker.service.BoarddtService;
import org.travelmaker.service.SchdtService;
import org.travelmaker.service.ScheduleService;
import org.travelmaker.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	@Resource(name="uploadPath")
	private String uploadPath;
	
	private BoardService service;
	
	private ScheduleService service2;
	
	private SchdtService service3;
	
	private BoarddtService service4;

	@GetMapping("/schedulelist")
	public void schedulelist(Model model) {
		log.info("schedulelist");
		model.addAttribute("schedulelist",service2.getList());
	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: "+cri);
		model.addAttribute("list",service.getList(cri));
		//model.addAttribute("pageMaker", new PageDTO(cri,123));
		System.out.println(service.getList(cri));
		int total= service.getTotal(cri);
		log.info("total:" + total);

		model.addAttribute("pageMaker",new PageDTO(cri, total));
	}
	
	
	@GetMapping("/register")
	public void register(@RequestParam("schNo")int schNo,Model model) {
		model.addAttribute("schNo",schNo);
			
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr, MultipartFile file) throws Exception {
		log.info("register: "+board);

		//파일처리 관련 코드
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath =UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		rttr.addFlashAttribute("boardTitle", board.getBoardTitle());
		rttr.addFlashAttribute("result", board.getBoardNo());
		String boardTitle = URLEncoder.encode(board.getBoardTitle(),"UTF-8");
		
		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		board.setBoardImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		board.setThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		System.out.println(board.getBoardImg()+","+board.getThumbImg());
		
		
		
		service.register(board);
		System.out.println(board);
		
		return "redirect:/board/dtregister?boardTitle="+boardTitle;
	}
	
	
	@GetMapping("/dtregister")
	public void dtregister(@RequestParam("boardTitle")String boardTitle,Model model) throws UnsupportedEncodingException {
		
		BoardVO board= new BoardVO();
		
		//board_title = URLEncoder.encode(board_title,"UTF-8");
		
		System.out.println("getdtregister-------"+boardTitle);
		board=service.getbytitle(boardTitle);
		
		int boardNo =board.getBoardNo();
		System.out.println(boardNo);
		model.addAttribute("boardNo",boardNo);
		
	}
	
	@PostMapping("/dtregister")
	public String dtregister(BoarddtVO boarddt, RedirectAttributes rttr, MultipartFile file) throws Exception{
		log.info("dtregister: "+boarddt);
		
		//파일처리 관련 코드
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath =UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		boarddt.setBoarddtImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		boarddt.setDtThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		
		System.out.println(boarddt);
		
		service4.register(boarddt);
		return "redirect:/board/list";
	}
	
	
	
	@GetMapping({"/modify"})
	public void modify(@RequestParam("boardNo")int boardNo, @ModelAttribute("cri") Criteria cri, Model model) {
	
		log.info("/modify");
		model.addAttribute("board",service.get(boardNo));
	
	}
	
	
	@GetMapping({"/get"})
	public void get(@RequestParam("schNo")int schNo, @RequestParam("boardNo")int boardNo, 
			@ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("/get");
		
		model.addAttribute("schedule",service2.getListSchedule(schNo));
		model.addAttribute("schdtplace", service3.getplacetitle(schNo));
		model.addAttribute("boarddt",service4.getList(boardNo));
		model.addAttribute("board",service.get(boardNo));
		model.addAttribute("boardNo",boardNo);
	
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,MultipartFile file) throws Exception {
		log.info("modify:"+board);
		//파일처리 관련 코드
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath =UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		board.setBoardImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		board.setThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		System.out.println(board.getBoardImg()+","+board.getThumbImg());
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
			
			rttr.addAttribute("pageNum",cri.getPageNum());
			rttr.addAttribute("amount",cri.getAmount());
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("boardNo") int boardNo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove..."+boardNo);
		service4.remove(boardNo);
		if(service.remove(boardNo)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amont", cri.getAmount());
		
		return "redirect:/board/list";
	}
}
