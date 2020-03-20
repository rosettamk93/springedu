package annotation;

public class Test {

	public static void main(String[] args) {
		String str = "44046,울산 동구 봉수로 250, (전하동, 울산전하푸르지오),110-503";
		String str1 = str.substring(str.lastIndexOf(",")-1);
		String str2 = str.substring(0,5);
		String str3 = str.substring(6,19);
		System.out.println(str);
		System.out.println(str1);
		System.out.println(str2);
		System.out.println(str3);
	}

}
