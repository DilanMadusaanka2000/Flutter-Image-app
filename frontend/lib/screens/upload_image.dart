import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/services/api_service.dart';
import '../services/api_service.dart'; // Import the ApiService
import 'view_images.dart'; // Import the ViewImagesScreen

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _commentController = TextEditingController();
  bool _isUploading = false; // Track upload status to show loading indicator

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Select an image and enter a comment')),
      );
      return;
    }

    setState(() {
      _isUploading = true; // Show loading indicator
    });

    try {
      bool success = await ApiService.uploadImage(_image!, _commentController.text);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
        _commentController.clear();
        setState(() => _image = null); // Clear the image after successful upload
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        actions: [
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewImagesScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!, height: 200)
                : Container(height: 200, color: Colors.grey[300]),
            SizedBox(height: 10),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: 'Enter a comment'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage, 
              child: _isUploading
                  ? CircularProgressIndicator(color: Colors.white) 
                  : Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}