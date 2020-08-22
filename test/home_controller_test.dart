import 'package:locafi_mobile/controller/home.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  IHomeController controller = HomeController("/send", "/receive");
  test(
    "Test code for HomeController",
    () {
      expect(controller.getSendPage(), equals("/send"));
      expect(controller.getReceivePage(), equals("/receive"));
    }
  );
}
