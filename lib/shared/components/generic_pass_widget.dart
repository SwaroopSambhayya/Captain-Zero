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
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
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
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          InkWell(
            onTap: () {
              context.go('/summary');
            },
            child: Row(
              children: [
                Text(
                  "Next",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                    size: 28,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Congrats!! You have earned this certificate',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).cardColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).cardColor),
                      ),
                    ),
                    onChanged: (value) {
                      _updateName(value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: const Color(0xff45C074),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
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
                      const SizedBox(height: 8),
                      Column(
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
                      SizedBox(
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
                      )
                    ],
                  )),
            ],
          ),
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
