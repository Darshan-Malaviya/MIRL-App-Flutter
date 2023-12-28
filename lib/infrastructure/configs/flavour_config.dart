class FlavorConfig {
  FlavorConfig({
    this.appTitle,
    this.baseUrl,
    this.type,
    this.iosBundleId,
    this.iosClientId,
  });

  String? appTitle;
  String? baseUrl;
  String? type;
  String? iosBundleId;
  String? iosClientId;
  bool enableAdvancedSettings = false;
  bool enableTrackerDebug = false;
  String? appIdForIOS;
  String? socketUrl;
}
