import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView Example'),
      ),
      body: Container(
        child: Text('test'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(
            // backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            builder: (context) {
              //TODO routine_formを下記のように変更する
              return Container(
                height: Get.height * 0.8,
                width: Get.width * 0.9,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                // ),
                // color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                        ),
                      ),
                      for (var i = 0; i < 20; i++)
                        Card(
                          child: ListTile(
                            title: Text('item $i'),
                          ),
                        )
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
