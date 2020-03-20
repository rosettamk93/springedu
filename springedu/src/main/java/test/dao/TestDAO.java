package test.dao;

import java.util.List;

import test.vo.BoardPostVO;

public interface TestDAO {
	
	int Join(BoardPostVO testVO);
	
	int modify(BoardPostVO testVO);
	
	List<BoardPostVO> selectTest();
	
	int out(String id, String pw);
}
