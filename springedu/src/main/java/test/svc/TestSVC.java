package test.svc;

import java.util.List;

import test.vo.BoardPostVO;

public interface TestSVC {
	int Join(BoardPostVO boardPostVO);
	int Join2(BoardPostVO boardPostVO);
	int Join3(BoardPostVO boardPostVO);
	int modify(BoardPostVO boardPostVO);
	
	List<BoardPostVO> selectTest();
	
	int out(String id, String pw);
}
