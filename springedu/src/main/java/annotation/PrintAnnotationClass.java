package annotation;

import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class PrintAnnotationClass {

	public static void main(String[] args) {
		//Service 클래스로 부터 메소드 정보를 읽어옴
		Method[] methods= Service.class.getDeclaredMethods();
//		System.out.println(methods.length);
		for(Method method : methods) {
			//PrintAnnotation이 적용되었는지 확인
			if(method.isAnnotationPresent(PrintAnnotation.class)) {
				//PrintAnnotation 객체 얻기
				PrintAnnotation printAnnotation
					= method.getAnnotation(PrintAnnotation.class);
				//메소드 이름 출력
				System.out.println("[" + method.getName() + "]");
				//구분선 출력
				for(int i = 0;i < printAnnotation.number();i++) {
					System.out.print(printAnnotation.value());
				}
				System.out.println();
				
				//메소드 호출
				try {
					method.invoke(new Service());
				} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else {
				System.out.println("runtime nono");
			}
		}
	}

}


















