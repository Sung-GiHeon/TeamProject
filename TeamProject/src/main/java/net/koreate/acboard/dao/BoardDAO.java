package net.koreate.acboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import net.koreate.acboard.provider.BoardQueryProvider;
import net.koreate.acboard.vo.AccidentBoardVO;

import net.koreate.mvc.common.util.SearchCriteria;

public interface BoardDAO {
	
	@Insert("INSERT INTO accidentboard_tbl(title,writer,content,region,userNum,userHidden,uploadCheck)"
			+" VALUES(#{title},#{writer},#{content},#{region},#{userNum},#{userHidden},#{uploadCheck})")
	void register(AccidentBoardVO aboard) throws Exception;
	
	// 검색된 게시물의 페이징 처리
	@SelectProvider(type = BoardQueryProvider.class, method="searchSelectSql")
	List<AccidentBoardVO> listReplyCriteria(SearchCriteria cri) throws Exception;
	
	// 검색된 게시물의 개수
	@SelectProvider(type=BoardQueryProvider.class,method="searchSelectCount")
	int listReplyCount(SearchCriteria cri) throws Exception;

	//토탈카운트
	@Select("SELECT count(*) FROM re_accident_tbl WHERE accidentNum = #{accidentNum}")
	int totalCount(int bno) throws Exception;
	
	// 게시물 조회수 증가
	@Update("UPDATE accidentboard_tbl SET viewcnt = viewcnt + 1 WHERE accidentNum=#{accidentNum}")
	void updateCnt(int accidentNum)throws Exception;

	@Select("SELECT * FROM accidentboard_tbl WHERE accidentNum = #{accidentNum}")
	AccidentBoardVO readReply(int accidentNum) throws Exception;

	// 게시글 수정
	@Update("UPDATE accidentboard_tbl SET "
			+ " title = #{title} ,"
			+ " content = #{content}, "
			+ " updatedate = now() "
			+ " WHERE accidentNum = #{accidentNum}")
	void modify(AccidentBoardVO vo) throws Exception;

	
	@Delete("DELETE FROM accidentboard_tbl WHERE accidentNum = #{accidentNum}")
	void delete(int accidentNum) throws Exception;

	
	
	
	// 첨부파일 등록
	@Insert("INSERT INTO attach_tbl(fullName,accidentNum) "
			+ " VALUES(#{fullName}, LAST_INSERT_ID())")
	void addAttach(String fullName) throws Exception;

	
	// 첨부파일 목록 검색
	@Select("SELECT fullName FROM attach_tbl WHERE accidentNum = #{accidentNum}")
	List<String> getAttach(int accidentNum) throws Exception;

	// 첨부파일 목록 삭제
	@Delete("DELETE FROM attach_tbl WHERE accidentNum = #{accidentNum}")
	void deleteAttach(int accidentNum) throws Exception;

	@Insert("INSERT INTO attach_tbl(accidentNum,fullName) VALUES(#{accidentNum}, #{fullName})")
	void replaceAttach(@Param("accidentNum") int accidentNum, @Param("fullName") String fullName) throws Exception;
	
	
}












