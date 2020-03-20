package net.koreate.supboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import net.koreate.supboard.provider.BoardQueryProvider;
import net.koreate.supboard.util.SearchCriteria;
import net.koreate.supboard.vo.SupportBoardVO;

public interface Support_DAO {

	@Insert("INSERT INTO supportBoard_tbl("
			+ " region,title,content,regdate,writer,"
			+ " enddate,viewCnt,updatedate,"
			+ " recm,userNum,uploadCheck)"
			+ " VALUES(#{region},#{title},#{content},"
			+ " now(),#{writer},#{enddate},#{viewCnt},now(),"
			+ " #{recm},#{userNum},"
			+ " 'n'"
			+ ")")
	void register(SupportBoardVO vo) throws Exception;
	
	@Insert("INSERT INTO supportBoard_tbl("
			+ " region,title,content,regdate,writer,"
			+ " enddate,viewCnt,updatedate,"
			+ " recm,userNum,uploadCheck)"
			+ " VALUES(#{region},#{title},#{content},"
			+ " now(),#{writer},#{enddate},#{viewCnt},now(),"
			+ " #{recm},#{userNum},"
			+ " 'y'"
			+ ")")
	void Upload_register(SupportBoardVO vo) throws Exception;
	

	// 검색된 게시물의 개수
	@SelectProvider(type=BoardQueryProvider.class,method="searchSelectCount")
	int listCount(SearchCriteria cri) throws Exception;

	
	@Update("UPDATE supportBoard_tbl SET "
			+ " region = #{region},title=#{title},content=#{content}"
			+ ",regdate=#{regdate},writer=#{writer},"
			+ " enddate=#{enddate},updatedate=now(),"
			+ " recm=#{recm},userNum=#{userNum}"
			+ ",uploadCheck=#{uploadCheck}"
			+ " WHERE supportNum = #{supportNum}")
	void modify(SupportBoardVO vo) throws Exception;
	
	// 게시물 조회수 증가
	@Update("UPDATE supportBoard_tbl SET viewCnt = viewCnt + 1 WHERE supportNum=#{supportNum}")
	void updateCnt(int supportNum)throws Exception;
		
	// 검색된 게시물의 페이징 처리 
	@SelectProvider(type = BoardQueryProvider.class, method="searchSelectSql")
	List<SupportBoardVO> listCriteria(SearchCriteria cri) throws Exception;


	@Select("SELECT * FROM supportBoard_tbl WHERE supportNum = #{supportNum}")
	SupportBoardVO read(int supportNum) throws Exception;

	@Update("UPDATE supportBoard_tbl SET " + 
			"		region = #{region} , " + 
			"		title = #{title} , " + 
			"		content = #{content} , " + 
			"		regdate = #{regdate} ," + 
			"		writer = #{writer} ," + 
			"		enddate = #{enddate} ," + 
			"		updatedate = now(), " +
			"		userNum = #{userNum}, " +
			"		uploadCheck = #{uploadCheck} " +
			"		WHERE supportNum = #{supportNum} ")
	int update(SupportBoardVO board) throws Exception;

	// 업로드가 되었으면 체크 y 변경
	@Update("UPDATE supportBoard_tbl SET "
			+ " uploadCheck = 'y' "
			+ " WHERE supportNum = #{supportNum}")
	void UploadYCheck(SupportBoardVO board) throws Exception;
	
	// 업로드가 되었으면 체크 n 변경
	@Update("UPDATE supportBoard_tbl SET "
			+ " uploadCheck = 'n' "
			+ " WHERE supportNum = #{supportNum}")
	void UploadNCheck(SupportBoardVO board) throws Exception;
	
	@Delete("DELETE FROM supportBoard_tbl WHERE supportNum = #{supportNum} ")
	int remove(int supportNum) throws Exception;
	
	// 첨부파일 등록
	@Insert("INSERT INTO attach_tbl(fullName,supportNum,regdate) "
			+ " VALUES(#{fullName}, LAST_INSERT_ID(),now())")
	void addAttach(String fullName) throws Exception;
	
	// 첨부파일 목록 검색
	@Select("SELECT fullName FROM attach_tbl WHERE supportNum = #{supportNum}")
	List<String> getAttach(int supportNum) throws Exception;
	
	// 첨부파일 목록 삭제
	@Delete("DELETE FROM attach_tbl WHERE supportNum = #{supportNum}")
	void deleteAttach(int supportNum) throws Exception;
	
	@Insert("INSERT INTO attach_tbl(supportNum,fullName) VALUES(#{supportNum}, #{fullName})")
	void replaceAttach(@Param("supportNum") int supportNum, @Param("fullName") String fullName) throws Exception;

	@Update("UPDATE supportBoard_tbl SET"
			+ " enddate=#{enddate}"
			+ " WHERE supportNum=#{supportNum}")
	void Timerout(SupportBoardVO vo) throws Exception;
	
	// 모집마감 -> 모집중
	@Update("UPDATE supportBoard_tbl SET"
			+ " recm = 'y' "
			+ " WHERE supportNum = #{supportNum}")
	void recmYCheck(SupportBoardVO vo) throws Exception;
	
	// 모집중 -> 모집마감
	@Update("UPDATE supportBoard_tbl SET"
			+ " recm = 'n' "
			+ " WHERE supportNum = #{supportNum}")
	void recmNCheck(SupportBoardVO vo) throws Exception;
	
	
}
