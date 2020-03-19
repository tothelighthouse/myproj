package annotation;

public class Service {
	@PrintAnnotation
	public void method1() {
		System.out.println("method1() 실행");
	}
	@PrintAnnotation("*")
	public void method2() {
		System.out.println("method2() 실행");
		
	}
	@PrintAnnotation(value = "*", number = 13)
	public void method3() {
		System.out.println("method3() 실행");
	}
	
}
