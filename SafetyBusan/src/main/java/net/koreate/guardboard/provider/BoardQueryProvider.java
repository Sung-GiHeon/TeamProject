package net.koreate.guardboard.provider;

import org.apache.ibatis.jdbc.SQL;

import net.koreate.supboard.util.SearchCriteria;


public class BoardQueryProvider {
	
	
	public String searchSelectSql( final SearchCriteria cri) {
		SQL sql = new SQL() {
			{
				SELECT("*");
				FROM("guardBoard_tbl");
				
				getSearchWhere(cri, this);
				
				ORDER_BY("guardNum DESC");
				LIMIT(cri.getPageStart()+","+cri.getPerPageNum());
			}
		};		
		String query = sql.toString();
		System.out.println(query);
		return query;
	}
	
	public String searchSelectCount( final SearchCriteria cri) {
		return new SQL() {
			{
				SELECT("count(*)");
				FROM("guardBoard_tbl");
				getSearchWhere(cri,this);
			}
		}.toString();
	}
	
	public void getSearchWhere(SearchCriteria cri, SQL sql) {
		
		if(cri.getSearchType() != null) {
			String regionQuery = "region LIKE CONCAT('%','"+cri.getKeyword()+"','%')";
			String titleQuery = "title LIKE CONCAT('%','"+cri.getKeyword()+"','%')";
			String contentQuery = "content LIKE CONCAT('%','"+cri.getKeyword()+"','%')";
			String writerQuery = "writer LIKE CONCAT('%','"+cri.getKeyword()+"','%')";
			
			switch(cri.getSearchType()) {
				case "t" :
					sql.WHERE(titleQuery);
					break;
				case "c" :
					sql.WHERE(contentQuery);
					break;
				case "r" :
					sql.WHERE(regionQuery);
					break;
				case "w" :
					sql.WHERE(writerQuery);
					break;
				case "tc" :
					sql.WHERE(titleQuery).OR().WHERE(contentQuery);
					break;
				case "tr" :
					sql.WHERE(titleQuery).OR().WHERE(regionQuery);
					break;
				case "cw" :
					sql.WHERE(writerQuery).OR().WHERE(contentQuery);
					break;
				case "tcw" :
					sql.WHERE(writerQuery).OR().WHERE(contentQuery).OR().WHERE(titleQuery);
					break;
			}
		}
	}
}




