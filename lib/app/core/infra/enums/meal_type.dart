enum MealType {
  breakfast,
  morningSnack,
  lunch,
  afternoonSnack,
  dinner,
  nightSnack;

  const MealType();

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
}
