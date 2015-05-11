package cmm01.var;

public class No03_EscapeDemo {

	public static void main(String[] args) {
		int kor;//선언 Declaration
		kor= 90;//할당 Allocation
		int eng = 85, sum=0;
		
		sum= kor + eng ;
		System.out.print("성적 처리 \n");
		System.out.println("국\t 영\t 합" );
		System.out.println("kor eng sum");
		System.out.println(kor+"\t"+eng+"\t"+sum );
		
	}
}
