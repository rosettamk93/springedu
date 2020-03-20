package com.kh.portfolio.board.vo;

import java.util.List;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.ValidatorFactory;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FboardValidator implements Validator, InitializingBean {
	private javax.validation.Validator validator;

	@Override
	public void afterPropertiesSet() throws Exception {
		ValidatorFactory vFactory = Validation.buildDefaultValidatorFactory();
		validator = vFactory.usingContext().getValidator();
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return FboardVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Set<ConstraintViolation<Object>> violations = validator.validate(target);
		for (ConstraintViolation<Object> violation : violations) {
			String propertyPath = violation.getPropertyPath().toString();
			String message = violation.getMessage();
			errors.rejectValue(propertyPath, message, message);
		}

		FboardVO fboardVO = (FboardVO)target;
		List<MultipartFile> filesf = fboardVO.getFilesf();

		long totalSize =	filesf.stream().mapToLong(e->e.getSize()).sum();
		System.out.println("totalSize="+totalSize);
//		ValidationUtils.rejectIfEmpty(errors, "lastName", "emp.lastName.empty", "성을 입력하세요.");
		if(totalSize > 11) { //10485760
			errors.rejectValue("employeeId", "emp.employeeId.lessThenOne", "파일용량초과");
		}		
	}
}
