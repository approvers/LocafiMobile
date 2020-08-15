import 'dart:core';

class HomeController implements IHomeController {
  String sendPageRoute;
  String receivePageRoute;

  HomeController(String sendPageRoute, String receivePageRoute) {
    this.sendPageRoute = sendPageRoute;
    this.receivePageRoute = receivePageRoute;
  }

  @override
  String getReceivePage() {
    return this.receivePageRoute;
  }

  @override
  String getSendPage() {
    return this.sendPageRoute;
  }

}

abstract class IHomeController {
  String getSendPage();

  String getReceivePage();
}
