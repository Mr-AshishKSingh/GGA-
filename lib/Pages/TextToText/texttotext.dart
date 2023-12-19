import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';

const apiKey = "AIzaSyBGmM2QmF1DpAEz2sKLb9LFOY7J-tzNBbo";

class texttotext extends StatefulWidget {
  const texttotext({super.key});

  @override
  State<texttotext> createState() => _texttotextState();
}

class _texttotextState extends State<texttotext> {
  bool loading = false;
  List textChat = [];
  List textWithImageChat = [];

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  void fromText({required String query}) {
    setState(() {
      loading = true;
      textChat.add({
        "role": "User",
        "text": query,
      });
      _textController.clear();
    });
    scrollToTheEnd();

    gemini.generateFromText(query).then((value) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": value.text,
        });
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": error.toString(),
        });
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
          shadowColor: Color.fromARGB(255, 151, 235, 16),
          backgroundColor: Color.fromARGB(241, 135, 230, 12),
          centerTitle: true,
          title: const Text("Text to Text",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
        body: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(223, 15, 12, 7),
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: Color.fromARGB(255, 212, 196, 48)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        " HERE YOU WILL GET THE TEXT TO TEXT CONVERSION",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    ],
                  )),
              Expanded(
                //color: Colors.red,
                child: ListView.builder(
                  controller: _controller,
                  itemCount: textChat.length,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    return ColoredBox(
                      color: textChat[index]["role"] == "User"
                          ? Color.fromARGB(134, 146, 238, 26)
                          : Color.fromARGB(125, 88, 82, 82),
                      child: ListTile(
                        isThreeLine: true,
                        // leading: CircleAvatar(
                        //   backgroundColor: Color.fromARGB(255, 138, 255, 4),
                        //   child: Text(textChat[index]["role"].substring(0, 1)),
                        // ),

                        leading: Container(
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                            color: textChat[index]["role"] == "User"
                                ? Color.fromARGB(255, 233, 191, 3)
                                : Color.fromARGB(255, 212, 196, 48),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              textChat[index]["role"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        title: Text(
                          textChat[index]["role"],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(textChat[index]["text"]),
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
                  color: Color.fromARGB(78, 131, 138, 122),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color.fromARGB(0, 247, 20, 20)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Please Ask",
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
                      icon: loading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.add_task_sharp),
                      onPressed: () {
                        fromText(query: _textController.text);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
