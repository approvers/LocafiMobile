import 'package:flutter_app/controller/home.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  IHomeController controller = HomeController("/send", "/receive");
  test(
    "Test code for HomeController",
    () {
      expect(controller.GetSendPage(), equals("/send"));
      expect(controller.GetReceivePage(), equals("/receive"));
    }
  );
}