package net.koreate.accomment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.accomment.vo.Re_accidentVO;
import net.koreate.mvc.common.util.Criteria;

public interface Re_AccidentDAO {

	@Insert("INSERT INTO re_accident_tbl(accidentNum,content,userNum,commentWriter) "
			+ " VALUES(#{accidentNum},#{content},#{userNum},#{commentWriter})")
	void addComment(Re_accidentVO vo) throws Exception;
	
	@Select("SELECT count(*) FROM re_accident_tbl WHERE accidentNum = #{accidentNum}")
	int totalCount(int accidentNum) throws Exception;
	
	@Select("SELECT * FROM re_accident_tbl WHERE accidentNum = #{accidentNum} ORDER BY commentNum DESC "
			+ " limit #{cri.pageStart} , #{cri.perPageNum}")
	List<Re_accidentVO> listPage(
					@Param("accidentNum") int accidentNum, 
					@Param("cri")Criteria cri) throws Exception;

	@Update("UPDATE re_accident_tbl SET "
			+ " content = #{content}, "
			+ "regdate = now() "
			+ " WHERE commentNum = #{commentNum}")
	void modifyComment(Re_accidentVO vo) throws Exception;
	
	@Delete("DELETE FROM re_accident_tbl WHERE commentNum = #{commentNum}")
	void removeComment(int commentNum) throws Exception;
	
	@Delete("DELETE FROM re_accident_tbl WHERE accidentNum = #{accidentNum}")
	void deleteComment(int accidentNum) throws Exception;
	
}
