package net.koreate.guardcomment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.guardcomment.vo.Re_guardVO;
import net.koreate.supboard.util.Criteria;

public interface GuardCommentDAO {
	
	
	@Insert("INSERT INTO re_guard_tbl(content,commentWriter,userNum,regdate,guardNum) "
			+ " VALUES(#{content},#{commentWriter},#{userNum},now(),#{guardNum})")
	void addComment(Re_guardVO vo) throws Exception;
	
	
	@Select("SELECT count(*) FROM re_guard_tbl WHERE guardNum = #{guardNum}")
	int totalCount(int guardNum) throws Exception;
	
	@Select("SELECT * FROM re_guard_tbl WHERE guardNum = #{guardNum} ORDER BY re_guardNum DESC "
			+ " limit #{cri.pageStart}, #{cri.perPageNum}")
	List<Re_guardVO> listPage(
			@Param("guardNum") int guardNum,
			@Param("cri") Criteria cri) throws Exception;
	
	@Update("UPDATE re_guard_tbl SET "
			+ " content = #{content}"
			+ " WHERE re_guardNum = #{re_guardNum}")
	void modifyComment(Re_guardVO vo) throws Exception;

	@Delete("DELETE FROM re_guard_tbl WHERE re_guardNum = #{re_guardNum}")
	void removeComment(int re_guardNum) throws Exception;
	
	@Delete("DELETE FROM re_guard_tbl WHERE guardNum = #{guardNum}")
	void deleteComment(int guardNum) throws Exception;

}
