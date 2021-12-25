import 'package:dart_ipify/dart_ipify.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';

class IpService {
  var ipv4;

  detectIP() async {
    ipv4 = await Ipify.ipv4();
    SharedPrefs.setIpV4(ipv4.toString());
  }
}
