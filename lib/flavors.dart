enum Flavor {
  dev,
  staging,
  production,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Notes Dev App';
      case Flavor.staging:
        return 'Notes Stage App';
      case Flavor.production:
        return 'Notes App';
    }
  }

}
