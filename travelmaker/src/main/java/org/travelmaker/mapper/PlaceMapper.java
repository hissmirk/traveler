package org.travelmaker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;

public interface PlaceMapper {

	//순규 메서드
	public List<PlaceVO> getList();
	
	public void insert(PlaceVO vo);
	
	public PlaceVO read(long plcNo);
	
	public int delete(long plcNo);
	
	public int update(PlaceVO place);
	
	public List<PlaceVO> getListWithPaging(Criteria cri);
	
	public void upSet(long plcNo);
	
	public void downSet(long plcNo);
	
	public List<PlaceVO> sortLike(Criteria cri);
	public List<PlaceVO> sortNewest(Criteria cri);
	public List<PlaceVO> sortOldest(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	//종운 메서드
	public List<PlaceVO> getListWithTitle(String title);
	
	// 추천 장소 검색하려는 기능인데... 우리랑은 상관없는 기능 mainController를 위한 기능
	public List<PlaceDTO> getListWithTheme(@Param("regionNo") int region_no, @Param("themeNum") int themeNum);
	
	
}
