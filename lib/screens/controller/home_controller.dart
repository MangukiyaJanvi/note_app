import 'package:get/get.dart';
import 'package:noteapp/utils/database_helper.dart';

class HomeController extends GetxController {
  RxList<Map> noteList = <Map>[].obs;

  Future<void> readData() async {
    noteList.value = await DatabaseHelper.databaseHelper.readNotes();
  }

  void insertData({title, note, color}) {
    DatabaseHelper.databaseHelper
        .insertNotes(title: title, note: note, color: color);
    readData();
  }

  void deleteData(id) {
    DatabaseHelper.databaseHelper.deleteNotes(id);
    readData();
  }

  updateData(id, title, note, color) {
    DatabaseHelper.databaseHelper.updateNotes(id, title, note, color);
    readData();
  }
}
