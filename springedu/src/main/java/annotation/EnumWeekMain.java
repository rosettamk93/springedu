package annotation;

import java.util.Calendar;

public class EnumWeekMain {

	public static void main(String[] args) {
		Week day = null;
		
		Calendar cal = Calendar.getInstance();
		int week = cal.get(Calendar.DAY_OF_WEEK);

		switch(week) {
		case 1: day = Week.SUNDAY;
						break;
		case 2: day = Week.MONDAY;
						break;
		case 3: day = Week.TUESDAY;
						break;
		case 4: day = Week.WEDNESDAY;
						break;
		case 5: day = Week.THURSDAY;
						break;
		case 6: day = Week.FRIDAY;
						break;
		case 7: day = Week.SATURDAY;
		}
		
		System.out.println("오늘 요일:" + day);
		System.out.println("자바공부시간:" + day.getStudyHour());
		
	  System.out.println("요일별 자바공부시간");
	  Week[] weeks = Week.values();
	  for(Week k: weeks) {
	  	System.out.println(
	  			k.name() 
	  			+ ":" 
	  			+ k.getStudyHour()
	  			+ ":"
	  			+	k.getRestHour()
	  			+ ":"
	  			+ k.getRestHour2()
	  			+ ":"
	  			+ k.getSleep()
	  	);
	  		
	  }
	  
	  System.out.println(Week.SUNDAY.getRestHour());
	  System.out.println(Week.SUNDAY.getRestHour2());
	}
}




