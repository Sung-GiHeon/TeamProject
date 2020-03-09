package net.koreate.nboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.mvc.common.util.Criteria;
import net.koreate.nboard.vo.NoticeVO;

public interface NoticeBoardDAO {

	@Insert("INSERT INTO notice_tbl(title,content,userNum)" 
	+" VALUES(#{title},#{content},#{userNum})")
	int create(NoticeVO nboard);

	@Select("SELECT * FROM notice_tbl WHERE noticeNum = #{noticeNum}")
	NoticeVO read(int noticeNum);

	@Update("	UPDATE notice_tbl SET" 
	+" title = #{title}," 
	+" content = #{content}" 
	+" WHERE noticeNum = #{noticeNum}")
	int update(NoticeVO nboard);

	@Delete("DELETE FROM notice_tbl WHERE noticeNum = #{noticeNum}")
	int delete(int noticeNum);

	@Update("UPDATE notice_tbl SET viewCnt = viewCnt + 1 WHERE noticeNum=#{noticeNum}")
	void updateCnt(int noticeNum)throws Exception;	
	
	@Select("SELECT noticeNum,title,regdate,viewCnt FROM notice_tbl ORDER BY noticeNum DESC limit #{pageStart} , #{perPageNum}")
	List<NoticeVO> listCriteria(Criteria cri);
	
	@Select("SELECT count(*) FROM notice_tbl")
	int listCount() throws Exception;

	
	@Select("SELECT * FROM notice_tbl WHERE noticeNum = #{noticeNum}")
	NoticeVO readReply(int noticeNum);

	

}
