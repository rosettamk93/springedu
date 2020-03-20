package annotation;

public enum Week {

	MONDAY(1){
		@Override
		double getRestHour2() {
			return this.getStudyHour() * 1;
		}
	},
	TUESDAY(2){
		@Override
		double getRestHour2() {
			return this.getStudyHour() * 2;
		}		
	},
	WEDNESDAY(3) {
		@Override
		double getRestHour2() {
			return this.getStudyHour() * 3;
		}
	},
	THURSDAY(3) {
		@Override
		double getRestHour2() {
			return this.getStudyHour() * 4;
		}
	},
	FRIDAY(3) {
		@Override
		double getRestHour2() {
			return this.getStudyHour() * 5;
		}
	},
	SATURDAY(0) {
		@Override
		double getRestHour2() {
			return this.getStudyHour() * 6;
		}
	},
	SUNDAY(4,12) {
		int restHour = 7;
		@Override
		double getRestHour2() {
			return this.getStudyHour() * restHour;
		}
	};
	
	private final int hour;  //공부시간
	private final int sleep; //취침시간
	
	Week(int hour){
		this.hour = hour;
		this.sleep = 10;
	}
	Week(int hour, int hour2){
		this.hour = hour;
		this.sleep = hour2;
	}
	
	private static final double restHour = 0.5;//휴식시간
	
	public int getStudyHour() {
		return this.hour;
	}	
	
	public double getRestHour() {
		return this.hour * restHour;
	}
	
	public int getSleep() {
		return this.sleep;
	}
	
	abstract double getRestHour2();
}


