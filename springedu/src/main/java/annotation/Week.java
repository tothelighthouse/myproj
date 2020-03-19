package annotation;

public enum Week {
	MONDAY(1) {
		@Override
		double getRestHour2() {
			return this.getStudyHour() * 1;
		}
	},
	TUESDAY(2) {
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
//	SUNDAY(4,12) {
//		@Override
//		double getRestHour2() {
//			return this.getStudyHour() * 7;
//		}
//	};
	
	SUNDAY(4,12) {
		@Override
		double getRestHour2() {
			return this.getStudyHour() * 7;
		}
	};
	
	private final int hour;
	private final int sleep;
	Week(int hour){
		this.hour = hour;
		this.sleep = 0;
	}
	
	Week(int hour, int hour2){
		this.hour = hour;
		this.sleep = hour2;
	}
	
	private final double restHour = 0.5;
	
	public int getStudyHour() {
		return this.hour;
	}
	public int getSleepHour() {
		return this.sleep;
	}
	
	public double getRestHour() {;
		return this.hour * restHour;
	}

	
	abstract double getRestHour2();
	
	
}
