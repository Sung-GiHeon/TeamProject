package net.koreate.testt.user.service;

public interface MailService {
	
	public boolean send(String subject, String text, String from, String to, String filePath);

}
