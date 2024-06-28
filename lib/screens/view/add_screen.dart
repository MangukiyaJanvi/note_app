import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:noteapp/screens/controller/home_controller.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtNote = TextEditingController();
  Map m = {};
  int index = 0;
  int? colorCode;
  @override
  void initState() {
    super.initState();
    m = Get.arguments;
    if (m['statusCode'] == 0) {
      index = m['index'];
      txtTitle =
          TextEditingController(text: "${controller.noteList[index]['title']}");
      txtNote =
          TextEditingController(text: "${controller.noteList[index]['note']}");
      colorCode = int.parse(controller.noteList[index]['color']);
    }
  }

  Color? pickerColor;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (m['statusCode'] == 0) ? Color(colorCode!) : pickerColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
          ),
          title: Text(
            (m['statusCode'] == 1) ? "Add Note" : "update Note",
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                pickerColor = const Color(0xff443a49);
                Color currentColor = const Color(0xff443a49);
                void changeColor(Color color) {
                  setState(() => pickerColor = color);
                }

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: pickerColor!,
                          onColorChanged: changeColor,
                          enableLabel: true,
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Got it'),
                          onPressed: () {
                            setState(
                              () {
                                currentColor = pickerColor!;
                              },
                            );
                            Get.back();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.color_lens,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () async {
                String title = txtTitle.text;
                String note = txtNote.text;
                String colorString =
                    "0x${pickerColor!.value.toRadixString(16)}";
                if (m['statusCode'] == 1) {
                  controller.insertData(
                      note: note, title: title, color: colorString);
                } else {
                  controller.updateData(m['id'], title, note, colorString);
                  Get.back();
                }
                Get.back();
              },
              icon: const Icon(
                Icons.done,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                controller: txtTitle,
                cursorColor: Colors.black,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Title"),
              ),
              TextFormField(
                controller: txtNote,
                cursorColor: Colors.black,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 100,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Start Typing"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
