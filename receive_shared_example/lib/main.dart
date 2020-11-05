import 'package:flutter/material.dart';
import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:http/http.dart' as http;
void main() async {
  var response = await http.get('https://github.com/flutter/flutter');

  // Covert Response to a Document. The utility function `responseToDocument` is provided or you can use own decoder/parser.
  // Covert Response to a Document. The utility function `responseToDocument` is provided or you can use own decoder/parser.
  var document = responseToDocument(response);


  // get metadata
  var data = MetadataParser.htmlMeta(document);
  print(data);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        print("Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        print("Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
      });
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
          setState(() {
            _sharedText = value;
            print("Shared: $_sharedText");
          });
        }, onError: (err) {
          print("getLinkStream error: $err");
        });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        _sharedText = value;
        print("Shared: $_sharedText");
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Shared files:", style: textStyleBold),
              Text(_sharedFiles
                  ?.map((f) =>
              "{Path: ${f.path}, Type: ${f.type.toString().replaceFirst("SharedMediaType.", "")}\n")
                  ?.join(",") ??
                  ""),
              SizedBox(height: 100),
              Text("Shared urls/text:", style: textStyleBold),
              Text(_sharedText ?? ""),
              SimpleUrlPreview(
                url: _sharedText,
                textColor: Colors.black,
                bgColor: Colors.white,
                isClosable: true,
                titleLines: 2,
                descriptionLines: 3,
                imageLoaderColor: Colors.white,
                previewHeight: 150,
                previewContainerPadding: EdgeInsets.all(10),
                onTap: () => print('Hello Flutter URL Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}