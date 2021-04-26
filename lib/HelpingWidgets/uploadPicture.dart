import 'dart:io';
import 'package:clima_app/Screens/Complaint/complaint_home.dart';
import 'package:clima_app/Services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class UploadPicture extends StatefulWidget {
  @override
  _UploadPictureState createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {

  UploadTask task;
  File file;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = path.basename(file.path);
    final destination = 'files/$fileName';


    task = DatabaseMethods.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL().whenComplete(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ComplaintHome()));
    });

    Provider.of<DatabaseMethods>(context, listen: false).initComplaintPost = urlDownload;
    print("DownloadUrl:");
    print(Provider.of<DatabaseMethods>(context, listen: false).getInitComplaintPost);
  }


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? path.basename(file.path) : 'No File Selected';
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Picture"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.3,),
              ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.add_a_photo_outlined, color: Colors.white,),
                    SizedBox(width: 5,),
                    Text(
                      'Select an Image',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  primary:  Color(0xFF229062),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: selectFile,
              ),
              SizedBox(height: 5,),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.add_a_photo_outlined, color: Colors.white,),
                    SizedBox(width: 5,),
                    Text(
                      'Upload',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  primary:  Color(0xFF229062),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: uploadFile,
              ),
            ],
        ),
      ),
    );
  }
}
