package cmm03.flow;

import java.util.Scanner;

public class No02_IfelseDemo {
	int big;

	public void getBig(int a, int b, int c) {
		if (a > b && a > c) {
			System.out.println("가장 큰 수는 A값인" + a + "입니다");

		} else if (b > a && b > c) {
			System.out.println("가장 큰 수는 B값인" + b + "입니다");

		} else {
			System.out.println("가장 큰 수는 C값인" + c + "입니다");
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		No02_IfelseDemo instance = new No02_IfelseDemo();
		Scanner scan = new Scanner(System.in);
		
		System.out.println("A값을 입력");
		int a = scan.nextInt();
		System.out.println("B값을 입력");
		int b = scan.nextInt();
		System.out.println("C값을 입력");
		int c = scan.nextInt();

		instance.getBig(a,b,c);
	}

}
