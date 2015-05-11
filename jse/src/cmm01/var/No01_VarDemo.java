package cmm01.var;

/*
 변수의 작성 규칙
 1. 알파벳 대소 숫자 _ $ 만 사용 가능
 2. 첫 문자가 숫자 ㄴㄴ
 3. 키워드 와 같으면 ㄴㄴ
 
 */
class  No01_VarDemo{
	//논리형,1바이트,초기값 : false
	boolean result =true;
	//문자형 2바이트 초기값 =\u0000
	char capitalc = 'c';
	//정수형 8 16 32 64
	byte varByte = 1;
	short varShart = 10000;
	int varInt = 10000000;
	long vatrLong = 1000000000;
	//부동소수점타입 32 64
	float varFloat = 10.0f;
	double varDouble = 10.00d;
	
}