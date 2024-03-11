// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenericPass extends StatefulWidget {
  const GenericPass({super.key});

  @override
  State<GenericPass> createState() => _GenericPassState();
}

class _GenericPassState extends State<GenericPass> {
  String userName = '';
  String uuid = const Uuid().v4();
  late QrImage qrImage;

  @override
  void initState() {
    final qrCode = QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData(uuid);

    qrImage = QrImage(qrCode);
    super.initState();
  }

  void _updateName(String newName) {
    setState(() {
      userName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(context: context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.go('/summary'),
              icon: const Icon(Icons.navigate_next_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Congrats!! You have earned this certificate',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _updateName(value);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: const Color(0xff45C074),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      'assets/icon/captainzero.png',
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  const Text(
                                    "Captian Zero",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Champion',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        flex: 9,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    height: width / 3.5,
                                    width: width / 3.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Center(
                                    child: SizedBox(
                                      height: width / 4,
                                      width: width / 4,
                                      child: PrettyQrView(
                                        qrImage: qrImage,
                                        decoration: const PrettyQrDecoration(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Center(
                              child: Text(
                                'Certificate Credentials',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                            child: Image.asset(
                              'assets/images/greenery.jpeg',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 1,
              child: Visibility(
                visible: userName.isNotEmpty,
                child: InkWell(
                  onTap: () {
                    _generateAndAddPass(progressDialog);
                  },
                  child: Image.asset(
                    'assets/images/add_to_wallet.png',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _generateAndAddPass(ProgressDialog progressDialog) async {
    progressDialog.show(
      max: 100,
      msg: 'Processing request ...',
      msgColor: Colors.white,
      progressBgColor: Colors.greenAccent,
      backgroundColor: Colors.black,
    );
    final body = {"name": userName, "objectSuffix": uuid};
    const url = 'https://wallet-service-1.onrender.com/createGenericPass';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final link = data['passLink'];
      launchUrl(Uri.parse(link));
      progressDialog.close();
      // navigate
      context.go('/summary');
    } else {
      progressDialog.close();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(response.body),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
