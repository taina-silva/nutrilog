enum MealType {
  breakfast,
  morningSnack,
  lunch,
  afternoonSnack,
  dinner,
  nightSnack;

  const MealType();

  factory MealType.fromStr(String str) {
    switch (str) {
      case 'breakfast':
        return breakfast;
      case 'morning-snack':
        return morningSnack;
      case 'lunch':
        return lunch;
      case 'afternoon-snack':
        return afternoonSnack;
      case 'dinner':
        return dinner;
      case 'night-snack':
        return nightSnack;
      default:
        return breakfast;
    }
  }

  String get title {
    switch (this) {
      case breakfast:
        return 'Café da manhã';
      case morningSnack:
        return 'Lanche da manhã';
      case lunch:
        return 'Almoço';
      case afternoonSnack:
        return 'Café da tarde';
      case dinner:
        return 'Jantar';
      case nightSnack:
        return 'Lanche da noite';
    }
  }

  String get key {
    switch (this) {
      case breakfast:
        return 'breakfast';
      case morningSnack:
        return 'morning-snack';
      case lunch:
        return 'lunch';
      case afternoonSnack:
        return 'afternoon-snack';
      case dinner:
        return 'dinner';
      case nightSnack:
        return 'night-snack';
    }
  }
}
