import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:realm/realm.dart';

/// Class used to generate a windows/linux-only hwid
class HWID {
  static Future<String> generate(DeviceInfoPlugin plugin) async {
    String hwid;
    if (Platform.isWindows) {
      var dInfo = await plugin.windowsInfo;
      var cores = dInfo.numberOfCores;
      var name = dInfo.computerName;
      var memory = dInfo.systemMemoryInMegabytes;
      String temp = "windows-${cores}${name}${memory}";
      return temp;
    }
    if (Platform.isLinux) {
      var dInfo = await plugin.linuxInfo;
      var temp = dInfo.machineId;

      return "linux-${temp}";
    }
    return 'platform-unknown';
  }
}
