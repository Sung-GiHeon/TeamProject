package net.koreate.testt.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface TaskTestDAO {
   
   @Insert("INSERT INTO attach_tbl(fullName,supportNum,regdate) VALUES(#{fullName},LAST_INSERT_ID(), date_add(now(), interval -1 day))")
   void testAttach(String fullName) throws Exception;
   
   @Select("SELECT fullName FROM attach_tbl "
        + " WHERE DATE_FORMAT(regdate,'%Y-%m-%d') "
        + " = "
        + " DATE_FORMAT(date_add(now(),interval 0 day),'%Y-%m-%d')")
   List<String> getTrashAttach()throws Exception;

   @Select("SELECT DATE_FORMAT(date_add(now(),interval 0 day),'/%Y/%m/%d/')")
   String getPath() throws Exception;
   

}