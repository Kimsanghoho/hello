package cmm03.flow;

import java.util.Scanner;

public class No02_IfelseDemo {
	int big;

	public void getBig(int a, int b, int c) {
		if (a > b && a > c) {
			System.out.println("���� ū ���� A����" + a + "�Դϴ�");

		} else if (b > a && b > c) {
			System.out.println("���� ū ���� B����" + b + "�Դϴ�");

		} else {
			System.out.println("���� ū ���� C����" + c + "�Դϴ�");
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		No02_IfelseDemo instance = new No02_IfelseDemo();
		Scanner scan = new Scanner(System.in);
		
		System.out.println("A���� �Է�");
		int a = scan.nextInt();
		System.out.println("B���� �Է�");
		int b = scan.nextInt();
		System.out.println("C���� �Է�");
		int c = scan.nextInt();

		instance.getBig(a,b,c);
	}

}
