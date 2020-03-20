package net.koreate.supcomment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.supboard.util.Criteria;
import net.koreate.supcomment.vo.Re_supportVO;

public interface CommentDAO {
	
	
	@Insert("INSERT INTO re_support_tbl(content,commentWriter,userNum,regdate,supportNum) "
			+ " VALUES(#{content},#{commentWriter},#{userNum},now(),#{supportNum})")
	void addComment(Re_supportVO vo) throws Exception;
	
	
	@Select("SELECT count(*) FROM re_support_tbl WHERE supportNum = #{supportNum}")
	int totalCount(int supportNum) throws Exception;
	
	@Select("SELECT * FROM re_support_tbl WHERE supportNum = #{supportNum} ORDER BY re_supportNum DESC "
			+ " limit #{cri.pageStart}, #{cri.perPageNum}")
	List<Re_supportVO> listPage(
			@Param("supportNum") int supportNum,
			@Param("cri") Criteria cri) throws Exception;
	
	@Update("UPDATE re_support_tbl SET "
			+ " content = #{content}"
			+ " WHERE re_supportNum = #{re_supportNum}")
	void modifyComment(Re_supportVO vo) throws Exception;

	@Delete("DELETE FROM re_support_tbl WHERE re_supportNum = #{re_supportNum}")
	void removeComment(int re_supportNum) throws Exception;
	
	@Delete("DELETE FROM re_support_tbl WHERE supportNum = #{supportNum}")
	void deleteComment(int supportNum) throws Exception;

}
