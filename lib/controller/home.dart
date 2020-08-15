import 'dart:core';

class HomeController implements IHomeController {
  String sendPage;
  String receivePage;

  @override
  String GetReceivePage() {
    throw ;
  }

  @override
  String GetSendPage() {
    // TODO: implement GetSendPage
    throw UnimplementedError();
  }

}

abstract class IHomeController {
  IHomeController(String sendPage, String receivePage);

  String GetSendPage();

  String GetReceivePage();
}
