package net.koreate.testt.common.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	
	private static Map<String,MediaType> mediaMap;
	// 만약 여기에 해당하는 파일로 넣었을시 이미지 생성이 안된다.
	static {
		mediaMap = new HashMap<>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}

	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}

}
