package org.travelmaker.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.travelmaker.domain.BuddtVO;

public interface BuddtMapper { // xml과  세트 , 서비스는 여기서 가져다가 사용 
	
	//@Select("select * from schedule where sch_no > 0")
	public List<BuddtVO> getList();
	
	public void insert(BuddtVO buddt);
	
	public void insertSelectKey(BuddtVO buddt);

	public List<BuddtVO> read(Date paydate);
	
//	public List<BoardVO> readed();

	public int delete(Long no);
	
	public int update(BuddtVO buddt);
	
	public List<BuddtVO> cateCnt();

	public List<BuddtVO> readAll(long schno);

	public BuddtVO readed(BuddtVO vo);
	
}