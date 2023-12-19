import 'package:flutter/material.dart';
import 'package:newgemini/Pages/ImageToText/imagetotext.dart';
import 'package:newgemini/Pages/TextToText/texttotext.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://github.com/Mr-AshishKSingh');

void main() {
  runApp(const MyApp());
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Welcome User'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Color.fromARGB(255, 0, 0, 0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 75, 76, 80),
        title: Text(widget.title,
            style: TextStyle(color: Color.fromARGB(255, 236, 233, 233))),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            //color of the container
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Container(
                  //color the container
                  color: Color.fromARGB(255, 255, 8, 8),
                  //height of the container

                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    " NOTICE ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  //decoration
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                      "Hey user this application is currently in development u can contribute to the application by visiting the github repository"),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          "Github Repository",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: FloatingActionButton(
                    onPressed: _launchUrl,
                    child: const Icon(Icons.alt_route),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      " Ask something to AI Click the options below as per your usage",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    //radius
                    //border
                    margin: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(252, 6, 231, 92),
                        border: Border.all(
                          color: Color.fromARGB(141, 4, 158, 63),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),

                    //color

                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            child: Column(
                              children: [
                                const Text(
                                  "Text to text ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),

                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 33, 142, 3),
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(255, 20, 142, 4),
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.all(10),
                                    child: Column(children: [
                                      const Text(
                                        " QUESTION ---> TEXT ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const Text(
                                        " RESPONSE ---> TEXT ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ])),

                                SizedBox(
                                  height: 20,
                                ),

                                const Text(
                                  "Here user can ask anything and he will get the response in the form of Text ",
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                FloatingActionButton.extended(
                                  //color
                                  backgroundColor:
                                      Color.fromARGB(255, 144, 240, 26),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const texttotext()),
                                    );
                                    //code
                                  },
                                  label: const Text("Click Here",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 7, 0, 0),
                                          fontWeight: FontWeight.bold)),
                                ),

                                //style
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                Container(
                    //radius
                    //border
                    margin: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 243, 211, 4),
                        border: Border.all(
                          color: Color.fromARGB(141, 150, 158, 4),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),

                    //color

                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            child: Column(
                              children: [
                                const Text(
                                  "Image to Text ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 1, 0, 0)),
                                ),

                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 142, 132, 3),
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(255, 138, 142, 4),
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.all(10),
                                    child: Column(children: [
                                      const Text(
                                        " QUESTION ---> IMAGE ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const Text(
                                        " RESPONSE ---> TEXT ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ])),

                                // SizedBox(
                                //   height: 10,
                                // ),

                                SizedBox(
                                  height: 20,
                                ),

                                const Text(
                                  "Here user inserts Image as a question and he will get the response in the form of Text ",
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                FloatingActionButton.extended(
                                  //color
                                  backgroundColor:
                                      Color.fromARGB(255, 144, 240, 26),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const imagetotext()),
                                    );
                                    //code
                                  },
                                  label: const Text("Click Here",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 7, 0, 0),
                                          fontWeight: FontWeight.bold)),
                                ),

                                //style
                              ],
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
