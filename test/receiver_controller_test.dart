import 'package:flutter_test/flutter_test.dart';
import 'package:locafi_mobile/controller/receiver.dart';
import 'package:locafi_mobile/model/receiver.dart';

import 'types.dart';

main() async {
  final files = [
    TestingFile(fileName: "file1", fileSize: 100),
    TestingFile(fileName: "file2", fileSize: 200),
    TestingFile(fileName: "file3", fileSize: 300),
  ];

  IReceiverServerModel serverModel = TestReceiverServerModel(receivedFileList: files);
  TestReceiverFileSaverModel saverModel = TestReceiverFileSaverModel();
  IReceiverController controller = ReceiverController(serverModel, saverModel);

  test(
      "Test for start and finish server",
          () async {
        expect(await controller.startServer("serverName"), true);
        expect(await controller.startServer("invalid"), false);
        expect(await controller.finishServer(), true);
        expect(await controller.finishServer(), false);
      }
  );
  
  test(
      "Receive file",
          () async {
        await controller.startServer("serverName");
        expect(await controller.waitFiles(), files);
        expect(controller.getFileList(), files);
        await controller.finishServer();
      }
  );

  test(
      "Delete received file",
          () async {
        await controller.startServer("serverName");
        final files = await controller.waitFiles();
        controller.deleteFile(0);
        expect(controller.getFileList(), files.where((file) => file.getFileName() != "file1").toList());
        expect(controller.deleteFile(100), false);
        await controller.finishServer();
      }
  );

  test(
      "Save received file",
          () async {
        await controller.startServer("serverName");
        await controller.waitFiles();
        await controller.saveFile(0);
        expect(saverModel.savedFiles[0].getFileName(), "file1");
        expect(await controller.saveFile(100), false);

        await controller.finishServer();
      }
  );
}

class TestReceiverServerModel implements IReceiverServerModel<TestingFile> {
  bool serverAvailable = false;
  final List<TestingFile> receivedFileList;

  TestReceiverServerModel({this.receivedFileList});

  @override
  Future<bool> finishServer() async {
    if (serverAvailable) {
      serverAvailable = false;

      return true;
    }

    return false;
  }

  @override
  Future<List<TestingFile>> getFileList() async => this.receivedFileList;

  @override
  Future<bool> startServer(String serverName) async {
    if (!serverAvailable) {
      serverAvailable = true;

      return true;
    }

    return false;
  }

}

class TestReceiverFileSaverModel implements IReceiverFileSaverModel<TestingFile> {
  final List<TestingFile> savedFiles = [];

  @override
  Future<bool> saveFile(TestingFile file) async {
    if (file == null) return false;
    savedFiles.add(file);

  return true;
  }
  
}