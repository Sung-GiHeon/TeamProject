package net.koreate.guardboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import net.koreate.guardboard.provider.BoardQueryProvider;
import net.koreate.guardboard.vo.GuardBoardVO;
import net.koreate.supboard.util.SearchCriteria;

public interface GuardBoard_DAO {

		@Insert("INSERT INTO guardBoard_tbl(region,title,writer,content"
				+ ",regdate,viewCnt,userNum,uploadCheck) "
				+ " VALUES(#{region},#{title},#{writer},#{content},"
				+ "now(),#{viewCnt},#{userNum},'n' )")
		void register(GuardBoardVO board) throws Exception;
		
		@Insert("INSERT INTO guardBoard_tbl(region,title,writer,content"
				+ ",regdate,viewCnt,userNum,uploadCheck) "
				+ " VALUES(#{region},#{title},#{writer},#{content},"
				+ "now(),#{viewCnt},#{userNum},'y')")
		void Upload_register(GuardBoardVO board) throws Exception;
	
		
		@Update("UPDATE guardBoard_tbl SET "
				+ " region = #{region},title=#{title},writer=#{writer}"
				+ ",content=#{content},regdate=now(),"
				+ " userNum=#{userNum},updatedate=now(),"
				+ "uploadCheck='n'"
				+ " WHERE guardNum = #{guardNum}")
		void modify(GuardBoardVO vo) throws Exception;
		
		
		@Select("SELECT * FROM guardBoard_tbl WHERE guardNum = #{guardNum}")
		GuardBoardVO read(int guardNum) throws Exception;

		
		@Update("UPDATE guardBoard_tbl SET "
				+ " region = #{region},title=#{title},writer=#{writer}"
				+ ",content= #{content},regdate=now(),"
				+ " userNum=#{userNum},updatedate=now()"
				+ ",uploadCheck='y'"
				+ " WHERE guardNum = #{guardNum}")
		void Upload_modify(GuardBoardVO vo) throws Exception;
		
		
		// 게시물 조회수 증가
		@Update("UPDATE guardBoard_tbl SET viewCnt = viewCnt + 1 WHERE guardNum=#{guardNum}")
		void updateCnt(int guardNum)throws Exception;
			
		
		@Delete("DELETE FROM guardBoard_tbl WHERE guardNum = #{guardNum} ")
		int remove(int guardNum) throws Exception;
		
		
		// 검색된 게시물의 페이징 처리 / 
		@SelectProvider(type = BoardQueryProvider.class, method="searchSelectSql")
		List<GuardBoardVO> listReplyCriteria(SearchCriteria cri) throws Exception;

		// 검색된 게시물의 페이징 처리 
		@SelectProvider(type = BoardQueryProvider.class, method="searchSelectSql")
		List<GuardBoardVO> listCriteria(SearchCriteria cri) throws Exception;
		

		// 검색된 게시물의 개수
		@SelectProvider(type=BoardQueryProvider.class,method="searchSelectCount")
		int listCount(SearchCriteria cri) throws Exception;

		// 첨부파일 등록
		@Insert("INSERT INTO attach_tbl(fullName,guardNum,regdate) "
				+ " VALUES(#{fullName}, LAST_INSERT_ID(),now())")
		void addAttach(String fullName) throws Exception;

		// 첨부파일 목록 검색
		@Select("SELECT fullName FROM attach_tbl WHERE guardNum = #{guardNum}")
		List<String> getAttach(int guardNum) throws Exception;
		
		// 첨부파일 목록 삭제
		@Delete("DELETE FROM attach_tbl WHERE guardNum = #{guardNum}")
		void deleteAttach(int guardNum) throws Exception;
		
		// 첨부파일 수정
		@Insert("INSERT INTO attach_tbl(guardNum,fullName) VALUES(#{guardNum}, #{fullName})")
		void replaceAttach(@Param("guardNum") int guardNum, @Param("fullName") String fullName) throws Exception;

}
