package com.kh.portfolio.common;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;

public class Util {
	// 이미지를 바이트 배열로 변환
	public static byte[] imageToByteArray(String filePath) throws Exception {
		byte[] changedImg = null;

		try (
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			FileInputStream fis = new FileInputStream(filePath);
		) {

			byte[] buf = new byte[1024];
			int read = 0;

			while ((read = fis.read(buf, 0, buf.length)) != -1) {
				baos.write(buf, 0, read);
			}
			changedImg = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return changedImg;
	}
}
