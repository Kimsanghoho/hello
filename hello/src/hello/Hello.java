package hello;

public class Hello {

	public static void main(String[] args) {
		int i, j, result, ii = 1, jj = 0;
		for (i = 1; i < 19; i++) {
			for (j = 2; j < 6; j++) {
				result = ii * (jj + j);
				System.out.print((jj + j) + "*" + ii + "=" + result + "\t");
			}
			System.out.println();
			if (ii == 9) { 
				System.out.println();
				ii = 1;	jj += 4;
			} else {
				ii++;
			}
		}
	}
}
