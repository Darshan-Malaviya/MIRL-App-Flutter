class FlavorConfig {
  FlavorConfig({
    this.appTitle,
    this.baseUrl,
    this.type,
    this.appId,
    this.iosBundleId,
    this.iosClientId,
  });

  String? appTitle;
  String? baseUrl;
  String? type;
  String? appId;
  String? iosBundleId;
  String? iosClientId;
  bool enableAdvancedSettings = false;
  bool enableTrackerDebug = false;
}
