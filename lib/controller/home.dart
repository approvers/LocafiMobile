import 'dart:core';

class HomeController implements IHomeController {
  String sendPageRoute;
  String receivePageRoute;

  HomeController(String sendPageRoute, String receivePageRoute) {
    this.sendPageRoute = sendPageRoute;
    this.receivePageRoute = receivePageRoute;
  }

  @override
  String GetReceivePage() {
    return this.receivePageRoute;
  }

  @override
  String GetSendPage() {
    return this.sendPageRoute;
  }

}

abstract class IHomeController {
  String GetSendPage();

  String GetReceivePage();
}
