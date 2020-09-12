import 'dart:io';

import 'package:locafi_mobile/controller/sender.dart';
import 'package:locafi_mobile/model/sender.dart';
import 'package:flutter_test/flutter_test.dart';

import 'types.dart';

main() async {
  ISenderModel model = TestingModel();
  ISenderController controller = SenderController<TestingFile>(model);
  final serverList = ["Server1", "Server2"];
  await controller.getReceiverNames();
  test(
    "Test for SenderController",
      () async {
        expect(await controller.getReceiverNames(), serverList);
        expect(await controller.onClickSendButton(), false);
      }
  );

 test(
   "Test for after select receiver",
     () async {
        await controller.onSelectReceiver("Server1");
        expect(await controller.onClickSendButton(), true);
     }
 );

 test(
   "Test for invalid url",
     () async {
        expect(await () async {
          try {
            await controller.onSelectReceiver("invalid");
            return false;
          }catch (e) {
            return e is NullThrownError;
          }
        }(), true);
     }
 );

 test(
   "Test for add/delete file",
     () {
        final file = TestingFile(fileName: "fuck you", fileSize: 100);
        expect(controller.getFiles(), []);
        controller.onAddNewFile(file);
        expect(controller.getFiles(), [file]);
        controller.onDeleteFile(0);
        expect(controller.getFiles(), []);
     }
 );
}

class TestingModel implements ISenderModel<TestingFile> {
  List<String> urls;
  @override
  Future<Map<String, String>> getServers() async {
    urls = ["ip1", "ip2"];
    return {"Server1": "ip1", "Server2": "ip2"};
  }

  @override
  Future<int> sendFiles(List<TestingFile> file, String url) async {
    for (var element in urls) {
      if (element == url)
        return HttpStatus.ok;
    }
    return HttpStatus.notFound;
  }
}
