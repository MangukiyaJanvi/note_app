import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:noteapp/screens/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Notes App"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Get.toNamed('/add', arguments: {"statusCode": 1});
          },
          child: Icon(Icons.add),
        ),
        body: Obx(
          () => MasonryGridView.count(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                int id = controller.noteList[index]['id'];
                Get.toNamed(
                  '/add',
                  arguments: {"statusCode": 0, "id": id, "index": index},
                );
              },
              onLongPress: () {
                Get.dialog(
                  AlertDialog(
                    title: Text("Are you sure to delete note?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancle",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          int id = controller.noteList[index]['id'];
                          controller.deleteData(id);
                          Get.back();
                        },
                        child: Text("Delete"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(
                    int.parse(
                      controller.noteList[index]['color'],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.noteList[index]['title']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${controller.noteList[index]['note']}"),
                  ],
                ),
              ),
            ),
            itemCount: controller.noteList.length,
            crossAxisCount: 2,
          ),
        ),
      ),
    );
  }
}
