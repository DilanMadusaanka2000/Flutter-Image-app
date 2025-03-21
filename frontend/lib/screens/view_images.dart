import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ViewImagesScreen extends StatefulWidget {
  @override
  _ViewImagesScreenState createState() => _ViewImagesScreenState();
}

class _ViewImagesScreenState extends State<ViewImagesScreen> {
  List<Map<String, dynamic>> _images = [];

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    List<Map<String, dynamic>> images = await ApiService.fetchImages();
    setState(() => _images = images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Uploaded Images')),
      body: RefreshIndicator(
        onRefresh: _fetchImages,
        child: _images.isEmpty
            ? Center(child: Text('No images uploaded yet.'))
            : ListView.builder(
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(_images[index]['image_url'], height: 200, width: double.infinity, fit: BoxFit.cover),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _images[index]['comment'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "Uploaded: ${_images[index]['created_at']}",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
