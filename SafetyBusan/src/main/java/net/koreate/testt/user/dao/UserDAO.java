package net.koreate.testt.user.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.testt.user.vo.BanIPVO;
import net.koreate.testt.user.vo.LoginDTO;
import net.koreate.testt.user.vo.UserVO;


public interface UserDAO {
	
	@Insert("INSERT INTO user_tbl(name,email,password,post,phoneNum,addr,addrDetail)"
			+ "VALUES(#{name},#{email},#{password},#{post},#{phoneNum},#{addr},#{addrDetail})")
	void signUp(UserVO vo) throws Exception;
	
	@Select("SELECT * FROM user_tbl WHERE email = #{email}")
	String checkEmail(String email) throws Exception;

	@Select("SELECT * FROM user_tbl WHERE email = #{email} AND password = #{password}")
	UserVO loginPost(LoginDTO dto) throws Exception;
	
	@Select("SELECT * FROM ban_ip WHERE ip = #{ip} AND email = #{email}")
	BanIPVO getBanIPVO(@Param("ip") String ip, @Param("email") String email) throws Exception;
	
	@Insert("INSERT INTO ban_ip(ip,email) VALUES(#{ip},#{email})")
	void signInFail(@Param("ip") String ip, @Param("email") String email) throws Exception;
	
	@Update("UPDATE ban_ip SET cnt = cnt+1, bandate = now() WHERE ip = #{ip} AND email = #{email}")
	void updateBanIPCnt(@Param("ip")String ip, @Param("email")String email) throws Exception;
	
	@Delete("DELETE FROM ban_ip WHERE ip = #{ip}")
	void removeBanIP(String ip) throws Exception;
	
	@Select("SELECT * FROM user_tbl WHERE email = #{email}")
	UserVO getUserById(String value);
	
}
