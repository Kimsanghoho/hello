package cmm01.var;

/*
 Upcasting 
 =��ȯ(Conversion)
 =promotion
 =������(implict) �ڵ���ȯ
 :�ڹٰ� �����ϴ� �ڵ���ȯ �������� ����
 ������ Ÿ���� ǥ�������� �����ʿ��� ���������� ��ȯ�趧 ����

 */
public class No02_CastingDemo {
	public static void main(String[] args) {

		byte varByte = 1;
		int varInt = 123;
		double varDou = 123.456d;

		int upByte = (int) varByte;
		double upInt = varInt;

		/*
		 * Down-Casting =ĳ����(casting) ���� ����ȯ =���α׷����� ��������� �����ϴ� Ÿ�� ��� ��ȯ�� �Ǵ°��
		 * �ݵ�� ��������� ĳ���� ���� ������ �ս� ����� �� ����
		 */
		float varFlo = 123.456f;
		int downFlo = (int) varFlo;
		System.out.println("�ٿ�ĳ���� �����:"+downFlo);
		
		
	}
}
