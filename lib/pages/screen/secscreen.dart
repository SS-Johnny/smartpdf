import 'dart:developer';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as syc;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../widgets/constant.dart';
import '../../widgets/header.dart';

class PdfT extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  const PdfT({Key? key, required this.files, required this.onOpenedFile})
      : super(key: key);

  @override
  State<PdfT> createState() => _PdfTState();
}

//second page building for everything with a second page

class _PdfTState extends State<PdfT> {
  bool isButtonActive = true;
  showPrintedMessage(String title, String msg) {
    Flushbar(
            title: title,
            message: msg,
            duration: const Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            icon: const Icon(Icons.info, color: primaryColor))
        .show(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'PDF to txt page',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: primaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
            itemCount: widget.files.length,
            itemBuilder: (context, index) {
              final file = widget.files[index];
              return buildFile(file);
            },
          ),
        ),
        bottomNavigationBar: SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: const RoundedRectangleBorder(),
              minimumSize: const Size(220, 80),
            ),
            child: const Text(
              'Convert to Text',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (isButtonActive == true) {
                isButtonActive = false;
                log(isButtonActive.toString());
                ElevatedButton.styleFrom(
                    disabledBackgroundColor: buttonColor,
                    backgroundColor: buttonColor);
                showPrintedMessage('Text file Created Successfully',
                    'Saved to Download Folder');
              }
            },
          ),
        ),
      );

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    const color = primaryColor;

    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '.$extension',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              file.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fileSize,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class PdfTT extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  const PdfTT({Key? key, required this.files, required this.onOpenedFile})
      : super(key: key);

  @override
  State<PdfTT> createState() => _PdfTTState();
}

class _PdfTTState extends State<PdfTT> {
  bool isButtonActive = true;
  showPrintedMessage(String title, String msg) {
    Flushbar(
            title: title,
            message: msg,
            duration: const Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            icon: const Icon(Icons.info, color: primaryColor))
        .show(context);
  }

  bool isButton = true;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'TXT to PDF page',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: primaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
            itemCount: widget.files.length,
            itemBuilder: (context, index) {
              final file = widget.files[index];
              return buildFile(file);
            },
          ),
        ),
        bottomNavigationBar: SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              disabledForegroundColor: buttonColor.withOpacity(0.38),
              disabledBackgroundColor: buttonColor.withOpacity(0.12),
              shape: const RoundedRectangleBorder(),
              minimumSize: const Size(220, 80),
            ),
            child: const Text(
              'Convert to PDF',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (isButtonActive == true) {
                isButtonActive = false;
                log(isButtonActive.toString());
                ElevatedButton.styleFrom(
                    disabledBackgroundColor: buttonColor,
                    backgroundColor: buttonColor);
                showPrintedMessage('Pdf file Converted To Text Successfully',
                    'Saved to Download Folder ');
              }
            },
          ),
        ),
      );

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    const color = primaryColor;

    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '.$extension',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              file.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fileSize,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class EncryptSec extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  final String filee;
  const EncryptSec({Key? key, required this.files, required this.onOpenedFile, required this.filee})
      : super(key: key);

  @override
  State<EncryptSec> createState() => _EncryptSecState();
}

class _EncryptSecState extends State<EncryptSec> {
//This function is for saving the encrypted document
  static Future<File> saveEncrypt(
      {required String fileName, required syc.PdfDocument document}) async {
    final appDirectory = await getExternalStorageDirectory();
    log(appDirectory.toString());
    String? fileS = fileName.split("/").last;
    //get file path to append to the file
    final File file = File("/storage/emulated/0/Download/$fileS");
    File(file.path).writeAsBytes(await document.save());
    document.dispose();
    log(file.toString());

    return file;
  }

  bool isButtonActive = true;
  showPrintedMessage(String title, String msg) {
    Flushbar(
            title: title,
            message: msg,
            duration: const Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            icon: const Icon(Icons.info, color: primaryColor))
        .show(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Encrypt Document',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: primaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
            itemCount: widget.files.length,
            itemBuilder: (context, index) {
              final file = widget.files[index];
              return buildFile(file);
            },
          ),
        ),
        bottomNavigationBar: SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: const RoundedRectangleBorder(),
              minimumSize: const Size(220, 80),
            ),
            child: const Text(
              'Encrypt Document',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            onPressed: () async{
                      try {
                            if (isButtonActive == true) {
                        isButtonActive = false;
                        log(isButtonActive.toString());
                        ElevatedButton.styleFrom(
                            disabledBackgroundColor: buttonColor,
                            backgroundColor: buttonColor);
                        final String files = widget.filee;
                        String? fileS = files.split("/").last;
                        showPrintedMessage(
                            'File Encrypted Successfully', 'Saved to Download Folder $fileS');
                      }
                      //if file is picked, syc to import syncfusion library
                      final file = widget.filee;
                      final syc.PdfDocument document = syc.PdfDocument(
                          inputBytes: File(file).readAsBytesSync());
                      log(document.toString());
                      final PdfSecurity security = document.security;

                      //Set password.
                      security.userPassword = 'userpassword@123';
                      security.ownerPassword = 'ownerpassword@123';

                      //setting permissions
                      security.permissions.addAll(<PdfPermissionsFlags>[
                        PdfPermissionsFlags.print,
                        PdfPermissionsFlags.editAnnotations
                      ]);

                      //Set AES encryption algorithm.
                      security.algorithm = PdfEncryptionAlgorithm.aesx256Bit;

                      File ourNewFile = await saveEncrypt(
                          fileName: file, document: document);
                      log(ourNewFile.toString());
                      final String filo = file;
                    }
                    catch (e) {
                    log(e.toString());
                    }
                  }
          ),
        ),
      );

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    const color = primaryColor;

    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '.$extension',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              file.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fileSize,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class DecryptSec extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  final String filee;
  const DecryptSec({Key? key, required this.files, required this.onOpenedFile, required this.filee})
      : super(key: key);

  @override
  State<DecryptSec> createState() => _DecryptSecState();
}

class _DecryptSecState extends State<DecryptSec> {
  static Future<File> saveDecrypt(
      {required String fileName, required syc.PdfDocument document}) async {
    final appDirectory = await getExternalStorageDirectory();
    log(appDirectory.toString());
    String? fileS = fileName.split("/").last;
    //get file path to append to the file
    final File file = File("/storage/emulated/0/Download/$fileS");
    File(file.path).writeAsBytes(await document.save());
    document.dispose();
    log(file.toString());

    return file;
  }
  bool isButtonActive = true;
  showPrintedMessage(String title, String msg) {
    Flushbar(
            title: title,
            message: msg,
            duration: const Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            icon: const Icon(Icons.info, color: primaryColor))
        .show(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Decrypt Document',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: primaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
            itemCount: widget.files.length,
            itemBuilder: (context, index) {
              final file = widget.files[index];
              return buildFile(file);
            },
          ),
        ),
        bottomNavigationBar: SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: const RoundedRectangleBorder(),
              minimumSize: const Size(220, 80),
            ),
            child: const Text(
              'Decrypt Document',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            onPressed: () async{
              try{
                if (isButtonActive == true) {
                isButtonActive = false;
                final String file = widget.filee;
                      final syc.PdfDocument document = syc.PdfDocument(
                          inputBytes: File(file).readAsBytesSync(),
                          password: 'userpassword@123');
                          //remove password
                      log(document.toString());
                      final PdfSecurity security = document.security;

                      //remove password.
                      document.security.userPassword = '';
                      document.security.ownerPassword = '';

                      //setting permissions
                      security.permissions.addAll(<PdfPermissionsFlags>[
                        PdfPermissionsFlags.editContent,
                        PdfPermissionsFlags.copyContent,
                        PdfPermissionsFlags.editAnnotations,
                        PdfPermissionsFlags.fillFields,
                        PdfPermissionsFlags.assembleDocument,
                        PdfPermissionsFlags.print,
                        PdfPermissionsFlags.accessibilityCopyContent,
                        PdfPermissionsFlags.assembleDocument,
                        PdfPermissionsFlags.fullQualityPrint
                      ]);
                      File ourNewFile = await saveDecrypt(
                          fileName: file, document: document);
                          //call decrypt function
                      log(ourNewFile.toString());
                      log(isButtonActive.toString());
                ElevatedButton.styleFrom(
                    disabledBackgroundColor: buttonColor,
                    backgroundColor: buttonColor);
                    String? fileS = file.split("/").last;
                    log(file.toString());
                    // log(fileee);
                showPrintedMessage(
                    'File Decrypted Successfully', 'Saved to Download Folder $fileS' );
              } else {
                ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                );
              }
                    }
                  catch (e) {
                    log(e.toString());
                  }
              }
          ),
        ),
      );

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    const color = primaryColor;

    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '.$extension',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              file.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fileSize,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class PasswordSec extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  final String filee;
  const PasswordSec({Key? key,
      required this.files,
      required this.onOpenedFile,
      required this.filee
      })
      : super(key: key);

  @override
  State<PasswordSec> createState() => _PasswordSecState();
}

class _PasswordSecState extends State<PasswordSec> {
  bool isButtonActive = true;
  showPrintedMessage(String title, String msg) {
    Flushbar(
            title: title,
            message: msg,
            duration: const Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            icon: const Icon(Icons.info, color: primaryColor))
        .show(context);
  }
  bool isPassword = false;
  final password = TextEditingController();
  // String passwords = password.text;
  Widget buildPassword() => TextField(
    // onSubmitted: (value ) => setState(() =>this.password = value),
    // onChanged: (value ) => setState(() =>this.password = value),
        decoration: InputDecoration(
          hintText: 'Enter Password',
          labelText: 'Password',
          errorText: 'Choose an easy to remember password',
          suffixIcon: IconButton(
            icon: isPassword
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
            onPressed: () =>
            setState(() => isPassword = !isPassword),),
          border: const OutlineInputBorder(),
        ),
        obscureText: isPassword,
      );
      @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Password Protection',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: primaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 250,
              child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2),
                        itemCount: widget.files.length,
                        itemBuilder: (context, index) {
                          final file = widget.files[index];
                          // buildPassword();
                          return buildFile(file);
                        },
                        scrollDirection: Axis.vertical,
                      ),
            ),
            SizedBox(
              width: 350,
              child:
              // buildPassword()
              TextFormField(
                validator: (value){
                return value!.length < 8
                ? 'Name must be greater than two characters'
                : null;
                },
                controller: password,
                // onSubmitted: (value ) => setState(() =>password.clear()),
                // onChanged: (value ) => setState(() =>this.password = value),
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      labelText: 'Password',
                      errorText: 'Password has to be 8 digit length',
                      suffixIcon: IconButton(
                        icon: isPassword
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                        onPressed: () =>
                        setState(() => isPassword = !isPassword),),
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: isPassword,
                  )
              ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: const RoundedRectangleBorder(),
              minimumSize: const Size(220, 80),
            ),
            child: const Text(
              'Password Document',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              if (isButtonActive == true) {
                final String file = widget.filee;
                final syc.PdfDocument document =
                    syc.PdfDocument(inputBytes: File(file).readAsBytesSync());
                log(document.toString());
                final PdfSecurity security = document.security;

                //Set password.
                security.userPassword = password.text;
                security.ownerPassword = password.text;
                log(password.text);

                //setting permissions
                security.permissions.addAll(<PdfPermissionsFlags>[
                  PdfPermissionsFlags.print,
                  PdfPermissionsFlags.editAnnotations
                ]);

                //Set AES encryption algorithm.
                security.algorithm = PdfEncryptionAlgorithm.aesx256Bit;

                File ourNewFile =
                    await savePassword(fileName: file, document: document);
                log(ourNewFile.toString());
                isButtonActive = false;
                log(isButtonActive.toString());
                String? fileS = file.split("/").last;
                log(file.toString());
                ElevatedButton.styleFrom(
                    disabledBackgroundColor: buttonColor,
                    backgroundColor: buttonColor);
                final passwords = password.text;
                showPrintedMessage('Passworded Added to Document Successfully',
                    'Saved with $passwords  to Download Folder as $fileS');
                password.clear();
              } else {
                ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                );
              }
            },
          ),
        ),
      );

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    const color = primaryColor;

    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '.$extension',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              file.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fileSize,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
  static Future<File> savePassword(
      {required String fileName, required syc.PdfDocument document}) async {
    final appDirectory = await getExternalStorageDirectory();
    log(appDirectory.toString());
    String? fileS = fileName.split("/").last;
    final File file = File("/storage/emulated/0/Download/$fileS");
    File(file.path).writeAsBytes(await document.save());
    document.dispose();
    log(file.toString());

    return file;
  }
}
