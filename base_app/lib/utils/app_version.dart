import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final appVersionProvider = FutureProvider<AppVersion>((ref) async {
  final packageInfo = await PackageInfo.fromPlatform();

  return AppVersion(packageInfo);
});

class AppVersion {
  final PackageInfo packageInfo;

  AppVersion(this.packageInfo);

  String get versionAndBuild {
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return '$version($buildNumber)';
  }
}
