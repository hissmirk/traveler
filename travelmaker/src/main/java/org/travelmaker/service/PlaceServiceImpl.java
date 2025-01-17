package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlacePageDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleDtVO;
import org.travelmaker.mapper.PlaceMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class PlaceServiceImpl implements PlaceService {

	@Setter(onMethod_ = @Autowired)
	private PlaceMapper mapper;
	
	@Override
	public void register(PlaceVO place) {
		mapper.insert(place);
	}

	@Override
	public List<PlaceVO> get(String[] plcNoArr) {
		return mapper.read(plcNoArr);
	}
	
	@Override
	public boolean removePlace(long plcNo) {
		
		return mapper.delete(plcNo)==1;
	}

	@Override
	public boolean modify(PlaceVO place) {

		return mapper.update(place) ==1;
	}

	@Override
	public List<PlaceVO> getListWithPaging(Criteria cri) {

		if(cri.getSelected()==null) {
			return mapper.getListWithPaging(cri);
		}
		return mapper.getSortList(cri);
	}

	@Override
	public void updateLikeCnt(PlaceVO vo) {
		mapper.update(vo);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotal(cri);
	}
	
	//종운 메서드
	@Override
	public List<PlaceVO> getList(String title,int regionNo,Criteria cri) {
		log.info("get place List of a map" + title);
		return mapper.getListWithTitle(title,regionNo,cri.getPageNum(),cri.getAmount());
	}

	@Override
	public List<PlaceDTO> getListWithTheme(int regionNo, String themeCode) {
		log.info("get place List with Theme" + regionNo + " " + themeCode);
		return mapper.getListWithTheme(regionNo, themeCode);
	}
   @Override
   public int getSearchResultTotalCnt(String title,int regionNo) {
      return mapper.getSearchResultTotalCnt(title,regionNo);
   }   

   @Override
   public ScheduleDtVO[][] getInitSchWithDistAndDu(ScheduleDtVO[][] schdtVOs) {
      for (ScheduleDtVO[] scheduleDtVOs : schdtVOs) {
         for (ScheduleDtVO scheduleDtVOs2 : scheduleDtVOs) {
//            System.out.println(scheduleDtVOs2.toString());
            setInitSchWithDistAndDu(scheduleDtVOs2);
         }
      }
      return null;
   }
   
   public void setInitSchWithDistAndDu(ScheduleDtVO schdtVO) {
      // WebDriver 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:\\WebDriver\\bin\\chromedriver.exe");
        // WebDriver 옵션 설정 
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--start-maximized");            // 전체화면으로 실행
        options.addArguments("--disable-popup-blocking");    // 팝업 무시
        options.addArguments("--disable-default-apps"); 
        // 기본앱 사용안함
        options.addArguments("headless");
        options.addArguments("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36\r\n");
        // WebDriver 객체 생성
        ChromeDriver driver = new ChromeDriver(options);
        String fromTitle = schdtVO.getFromPlcTitle();
        double fromLat = schdtVO.getFromPlcLat();
        double fromLng = schdtVO.getFromPlcLng();
        String toTitle = schdtVO.getToPlcTitle();
        double toLat = schdtVO.getToPlcLat();
        double toLng = schdtVO.getToPlcLng();
        //웹페이지에서 글제목 말고 query랑 그 document전체를 가져올 수 있는지 보자.
//        String URL = "https://map.kakao.com/link/from/지은이집,37.571210,126.976918/to/종운이형집,37.321590,127.126611"
        //드라이버 로딩
        String URL = "https://map.kakao.com/?map_type=TYPE_MAP&target="+schdtVO.getTransit()+"&rt="+schdtVO.getFromPlcLat()+","+schdtVO.getFromPlcLng()+","+schdtVO.getToPlcLat()+",";
        driver.get("https://map.kakao.com/?map_type=TYPE_MAP&target=car&rt=494902%2C1131020%2C528056%2C1061777&rt1=1&rt2=21&rtIds=%2C&rtTypes=%2C");
        //selector로 지정하기
        WebElement page_summary = driver.findElementByClassName("CarRouteSummaryView");
        if( page_summary != null  ) {
            System.out.println(page_summary.getText() );            
        }
        // 탭 종료
        driver.close();
        
        // 5초 후에 WebDriver 종료
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            // WebDriver 종료
            driver.quit();
        }
    }

	@Override
	public List<PlaceVO> getPlaceByWeather(int regionNo) {
		return mapper.getPlaceByWeather(regionNo);
	}

   @Override
   public List<Map<String,Object>> getYourList(String type,int memNo) {
      // TODO Auto-generated method stub
      return mapper.getYourList(type,memNo);
   }

      
//      return schdtVO;
//   }
//   

   

}
