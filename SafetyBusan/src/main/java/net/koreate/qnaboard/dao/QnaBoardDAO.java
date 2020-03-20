package net.koreate.qnaboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;


import net.koreate.mvc.common.util.SearchCriteria;
import net.koreate.qnaboard.provider.QnaBoardProvider;
import net.koreate.qnaboard.vo.Re_qnaVO;

public interface QnaBoardDAO {

	@Insert("INSERT INTO re_qna_tbl(title,content,writer,userNum,showBoard) "
			+ " VALUES(#{title},#{content},#{writer},#{userNum},'y')")
	void register(Re_qnaVO board);

	@Update("UPDATE re_qna_tbl SET origin = LAST_INSERT_ID() WHERE re_qnaNum = LAST_INSERT_ID()")
	void updateOrigin();

	@SelectProvider(type = QnaBoardProvider.class, method="searchSelectSql")
	List<Re_qnaVO> listReplyCriteria(SearchCriteria cri);

	@SelectProvider(type=QnaBoardProvider.class,method="searchSelectCount")
	int listReplyCount(SearchCriteria cri);

	@Update("UPDATE re_qna_tbl SET viewcnt = viewcnt + 1 WHERE re_qnaNum=#{re_qnaNum}")
	void updateCnt(int re_qnaNum);

	@Select("SELECT * FROM re_qna_tbl WHERE re_qnaNum = #{re_qnaNum}")
	Re_qnaVO readReply(int re_qnaNum);

	@Update("UPDATE re_qna_tbl SET seq = seq + 1 "
			+ " WHERE origin = #{origin} AND seq > #{seq}")
	void updateReply(Re_qnaVO vo);

	@Insert("INSERT INTO re_qna_tbl(title,content,writer,origin,dept,seq,userNum,showBoard) "
			+ "VALUES(#{title},#{content},#{writer},#{origin},#{dept},#{seq},#{userNum},'y')")
	void replyRegister(Re_qnaVO vo);

	@Update("UPDATE re_qna_tbl SET "
			+ " title = #{title} ,"
			+ " content = #{content}, "
			+ " writer = #{writer} , "
			+ " updatedate = now() "
			+ " WHERE re_qnaNum = #{re_qnaNum}")
	void modify(Re_qnaVO vo);

	@Update("UPDATE re_qna_tbl SET showboard = 'n' WHERE re_qnaNum = #{re_qnaNum}")
	void remove(int re_qnaNum);
}
