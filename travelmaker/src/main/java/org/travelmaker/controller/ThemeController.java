package org.travelmaker.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PageDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ThemeAttachVO;
import org.travelmaker.service.ThemeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class ThemeController {

	private ThemeService service;

	@GetMapping("/theme")
	public String theme(Model model) {

		//List<ThemeVO> list = service.getThemeList();
		List<String> list = service.getThemeList();

		model.addAttribute("list", list);

		return "theme";
	}

	@GetMapping("/themeInfo/{themeNo}")
	//public String themeInfo(@PathVariable("themeNo") int themeNo, @ModelAttribute("theme") String theme, @ModelAttribute("region") String region,  Model model, HttpServletRequest rq) {
	public String themeInfo(@PathVariable("themeNo") int themeNo, Model model, HttpServletRequest rq) {
		
		//System.out.println("test themeName "+theme+"regionName"+region);
		
		service.getAttachment(themeNo);

		List<PlaceVO> list = service.getThemeInfo(themeNo);

		model.addAttribute("list", list);
		/*
		String url = "";
		
		if(s.contains("Info")) {
			
			url = "/admin/themeInfo";
			
		}else {
			
			url = "/admin/modifyTheme";
		}
		
		System.out.println(url);
		*/
		
		String url = "/admin/themeInfo/"+themeNo;
		
		return "themeInfo";
		
	}
	
	
	@GetMapping("/modifyTheme/{themeNo}")
	public String modifyTheme(@PathVariable("themeNo") int themeNo, Model model) {

		List<PlaceVO> list = service.getThemeInfo(themeNo);
		model.addAttribute("list", list);

		return "modifyTheme";

	}

	@PostMapping("/modifyTheme/{themeNo}")
	public String modifyThemeAction(@PathVariable("themeNo") int themeNo, ThemeAttachVO attachment, String[] removedPlaces, String[] addedPlaces,RedirectAttributes rttr) {
			
		attachment.setThemeNo(themeNo);
		
		 Map<String, Integer> result = service.updateTheme(removedPlaces, addedPlaces, themeNo, attachment);
		  
		  if (result.get("deleteResult")== removedPlaces.length&&result.get("insertResult")== addedPlaces.length) {
		  
			  rttr.addFlashAttribute("message", "SUCCESS"); }
		
		/*
		 * if(!(removedPlaces.length==0&&addedPlaces.length==0)) {
		 * 
		 * Map<String, Integer> result = service.updateTheme(removedPlaces, addedPlaces,
		 * themeNo, attachment);
		 * 
		 * if (result.get("deleteResult")==
		 * removedPlaces.length&&result.get("insertResult")== addedPlaces.length) {
		 * 
		 * rttr.addFlashAttribute("message", "SUCCESS"); }
		 * 
		 * }
		 */
		 
		 return "redirect:/admin/themeInfo/"+themeNo;
	}
	
	@GetMapping(value ="/getAttachment", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<ThemeAttachVO> getAttachment(int themeNo){
		
		return new ResponseEntity<>(service.getAttachment(themeNo), HttpStatus.OK);
	}

	@PostMapping("/upload/{themeNo}")
	public ResponseEntity<ThemeAttachVO> uploadFile(@PathVariable("themeNo") int themeNo, RedirectAttributes rttr,
			MultipartFile uploadFile) {

		// 첨부파일 처리
		//AttachFileDTO attachDTO = new AttachFileDTO();
		ThemeAttachVO attachVO = new ThemeAttachVO();
		
		String uploadFolder = "C:\\upload";

		String uploadFileName = uploadFile.getOriginalFilename();

		attachVO.setFileName(uploadFileName);

		UUID uuid = UUID.randomUUID();

		uploadFileName = uuid.toString() + "_" + uploadFile.getOriginalFilename();

		try {

			File saveFile = new File(uploadFolder, uploadFileName);
			uploadFile.transferTo(saveFile);
			
			InputStream in = new FileInputStream(saveFile.getAbsolutePath());

			attachVO.setUuid(uuid.toString());
			attachVO.setUploadPath(uploadFolder);
			
			
			if (checkImageType(saveFile)) {

				attachVO.setImage(true);
				
				
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadFolder, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(in, thumbnail, 100, 100);
				
				//Thumbnailator.createThumbnail(saveFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(attachVO, HttpStatus.OK);

	}

	@GetMapping(value = "/getPlaceList/{keyword}/{pageNum}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<Map<String, Object>> getPlaceList(@PathVariable("keyword") String keyword, @PathVariable("pageNum") int pageNum, Model model) {
				
		Criteria cri = new Criteria();
		
		cri.setPageNum(pageNum);
		cri.setKeyword(keyword);

		int total= service.getTotal(keyword);
		
		PageDTO dto =new PageDTO(cri, total);
		
		Map<String, Object> res = new HashMap<String, Object>();
		
		List<PlaceVO> placeList = service.getPlaceList(cri.getKeyword(),cri.getPageNum());
		
		for(int i =0;i<placeList.size(); i++) {
			
			System.out.println(placeList.get(i).toString());
		}
		
		res.put("pageMaker", dto);
		res.put("list", placeList);

		return new ResponseEntity<Map<String, Object>>(res,HttpStatus.OK);
	}
//	@GetMapping(value = "/getPlaceList/{cri}", produces = { MediaType.APPLICATION_XML_VALUE,
//			MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<List<PlaceVO>> getPlaceList(@PathVariable("cri") Criteria cri, Model model) {
//
//		System.out.println("place list");
//		ResponseEntity<List<PlaceVO>> list = null;
//		list = ResponseEntity.status(HttpStatus.OK).body(service.getPlaceList(cri));
//
//		return list;
//	}

	private boolean checkImageType(File file) {

		System.out.println("ck image type");
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");

		} catch (Exception e) {

			e.printStackTrace();

		}
		return false;
	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("filename : " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		log.info("file : " + file);

		ResponseEntity<byte[]> result = null;

		try {

			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (Exception e) {

			e.printStackTrace();
		}
		
		return result;
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		File file;

		try {

			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			if (type.equals("image")) {

				String largeFileName = file.getAbsolutePath().replace("s_", "");

				file = new File(largeFileName);

				file.delete();

			}

		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}

}
