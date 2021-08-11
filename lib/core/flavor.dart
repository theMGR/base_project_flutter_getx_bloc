// ignore_for_file: non_constant_identifier_names
class Flavor {
  static String FLAVOR = const String.fromEnvironment('flavor', defaultValue: FlavorTypes.APP1_DEV);

  static String get() => FLAVOR;
}

class FlavorTypes {
  //app 1 start
  static const String APP1_DEV = "app1_dev";
  static const String APP1_UAT = "app1_uat";
  static const String APP1_DEMO = "app1_demo";
  static const String APP1_LIVE = "app1_live";

  //app 2 start
  static const String APP2_DEV = "app2_dev";
  static const String APP2_UAT = "app2_uat";
  static const String APP2_DEMO = "app2_demo";
  static const String APP2_LIVE = "app2_live";

}
