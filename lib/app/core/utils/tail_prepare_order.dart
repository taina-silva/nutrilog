int productOrder(String formulation) {
  final map = {
    'WC': 1,
    'WP': 2,
    'CS': 3,
    'SC': 4,
    'OD': 5,
    'SE': 6,
    'EC': 7,
    'EO': 8,
    'EW': 9,
    'ME': 10,
    'SG': 11,
    'SP': 12,
    'SL': 13,
  };

  return map[formulation] ?? 0;
}
