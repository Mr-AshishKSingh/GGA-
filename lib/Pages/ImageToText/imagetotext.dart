import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';

const apiKey = "AIzaSyBGmM2QmF1DpAEz2sKLb9LFOY7J-tzNBbo";

class imagetotext extends StatefulWidget {
  const imagetotext({super.key});

  @override
  State<imagetotext> createState() => _imagetotextState();
}

class _imagetotextState extends State<imagetotext> {
  bool loading = false;
  List textAndImageChat = [];
  List textWithImageChat = [];
  File? imageFile;

  final ImagePicker picker = ImagePicker();

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  // Create Gemini Instance
  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  void fromTextAndImage({required String query, required File image}) {
    setState(() {
      loading = true;
      textAndImageChat.add({
        "role": "User",
        "text": query,
        "image": image,
      });
      _textController.clear();
      imageFile = null;
    });
    scrollToTheEnd();

    gemini.generateFromTextAndImages(query: query, image: image).then((value) {
      setState(() {
        loading = false;
        textAndImageChat
            .add({"role": "Gemini", "text": value.text, "image": ""});
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textAndImageChat
            .add({"role": "Gemini", "text": error.toString(), "image": ""});
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 191, 3),
        centerTitle: true,
        title: const Text(
          "Image to Text",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(223, 15, 12, 7),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color.fromARGB(255, 212, 196, 48)),
              ),
              child: Column(
                children: [
                  Text(
                    " HERE YOU WILL GET THE IMAGE TO TEXT CONVERSATION ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              )),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: textAndImageChat.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return ColoredBox(
                  color: textAndImageChat[index]["role"] == "User"
                      ? Color.fromARGB(88, 233, 200, 52)
                      : Color.fromARGB(129, 168, 168, 168),
                  child: ListTile(
                    isThreeLine: true,
                    // leading: Container(
                    //   width: 100,
                    //   decoration: BoxDecoration(
                    //     color: textAndImageChat[index]["role"] == "User"
                    //         ? Color.fromARGB(255, 233, 191, 3)
                    //         : Color.fromARGB(255, 212, 196, 48),
                    //     borderRadius: BorderRadius.circular(10.0),
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       textAndImageChat[index]["role"],
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 20),
                    //     ),
                    //   ),
                    // ),
                    leading: textAndImageChat[index]["image"] == ""
                        ? null
                        : Image.file(
                            textAndImageChat[index]["image"],
                            width: 90,
                          ),
                    subtitle: Text(textAndImageChat[index]["text"]),
                    // trailing: textAndImageChat[index]["image"] == ""
                    //     ? null
                    //     : Image.file(
                    //         textAndImageChat[index]["image"],
                    //         width: 90,
                    //       ),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(133, 90, 83, 83),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color.fromARGB(0, 158, 158, 158)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Write a message",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.transparent,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      imageFile = image != null ? File(image.path) : null;
                    });
                  },
                ),
                IconButton(
                  icon: loading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send),
                  onPressed: () {
                    if (imageFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please select an image")));
                      return;
                    }
                    fromTextAndImage(
                        query: _textController.text, image: imageFile!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: imageFile != null
          ? Container(
              margin: const EdgeInsets.only(bottom: 80),
              height: 150,
              child: Image.file(imageFile ?? File("")),
            )
          : null,
    );
  }
}
