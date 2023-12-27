enum Flavor {
  PROD,
  DEV,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'Nutrilog';
      case Flavor.DEV:
        return 'Nutrilog DEV';
      default:
        return 'title';
    }
  }

}
