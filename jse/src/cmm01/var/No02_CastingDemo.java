package cmm01.var;

/*
 Upcasting 
 =변환(Conversion)
 =promotion
 =묵시적(implict) 자동변환
 :자바가 제공하는 자동변환 묵시적인 동작
 데이터 타입의 표현범위가 작은쪽에서 많은쪽으로 변환됭때 가능

 */
public class No02_CastingDemo {
	public static void main(String[] args) {

		byte varByte = 1;
		int varInt = 123;
		double varDou = 123.456d;

		int upByte = (int) varByte;
		double upInt = varInt;

		/*
		 * Down-Casting =캐스팅(casting) 강제 형변환 =프로그램에서 명시적으로 지정하는 타입 축소 변환이 되는경우
		 * 반드시 명시적으로 캐스팅 주의 데이터 손실 방생할 수 있음
		 */
		float varFlo = 123.456f;
		int downFlo = (int) varFlo;
		System.out.println("다운캐스팅 결과값:"+downFlo);
		
		
	}
}
