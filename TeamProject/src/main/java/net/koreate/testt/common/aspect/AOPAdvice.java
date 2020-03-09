package net.koreate.testt.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class AOPAdvice {
	
	@Around("execution(* net.koreate.*.controller.*.*(..))")
	public Object checkControllerObject(ProceedingJoinPoint pjp) throws Throwable{
		
		System.out.println("----------------AOP CheckController START------------------------");
		//pjp.getArgs메소드의 매개변수
		for(Object o : pjp.getArgs()) {
			System.out.println(o);
		}
		
		Object o = pjp.proceed();
		
		System.out.println(o);
		
		System.out.println("---------------AOP CheckController END----------------------------");
		
		return o;
	}
}
