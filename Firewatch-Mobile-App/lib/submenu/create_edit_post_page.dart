import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class CreateEditPostPage extends StatefulWidget {
  final Post? post;

  const CreateEditPostPage({Key? key, this.post}) : super(key: key);

  @override
  _CreateEditPostPageState createState() => _CreateEditPostPageState();
}

class _CreateEditPostPageState extends State<CreateEditPostPage> {
  File? _selectedImage;
  bool _isLoading = false;
  bool isEditing = false;
  String? _existingImageUrl;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      isEditing = true;
      _titleController.text = widget.post!.postTitle;
      _contentController.text = widget.post!.postContent;
      if (widget.post!.image.isNotEmpty) {
        _existingImageUrl = widget.post!.image;
      }
    }
  }

  @override
  void dispose() {
    // ... existing code ...
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ... existing code ...
    return Scaffold(
      // ... existing code ...
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ... existing code ...
            if (_selectedImage != null || (isEditing && _existingImageUrl != null && _existingImageUrl!.isNotEmpty)) ...[
              Image.file(
                _selectedImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ] else if (isEditing && _existingImageUrl != null && _existingImageUrl!.isNotEmpty) ...[
              Image.network(
                _existingImageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading existing image in edit page: $_existingImageUrl');
                  print('Error details: $error');
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported),
                  );
                },
              ),
            ],
            TextButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: Icon(Icons.photo_library),
              label: Text('Gallery'),
            ),
            TextButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: Icon(Icons.camera_alt),
              label: Text('Camera'),
            ),
            if (_selectedImage != null || (isEditing && _existingImageUrl != null && _existingImageUrl!.isNotEmpty)) ...[
              TextButton.icon(
                onPressed: _removeImage,
                icon: Icon(Icons.clear),
                label: Text('Hapus Gambar'),
                style: TextButton.styleFrom(primary: Colors.red),
              ),
            ],
            SizedBox(height: 16),
            // ... existing code ...
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    // ... existing code ...
  }

  Future<void> _removeImage() async {
    // ... existing code ...
  }

  Future<String?> _handleImageUpload() async {
    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await ApiService.uploadImage(_selectedImage!);
    } else if (isEditing && _existingImageUrl != null) {
      imageUrl = _existingImageUrl;
    } else if (isEditing && _existingImageUrl == null && widget.post!.image.isEmpty) {
      imageUrl = null;
    }

    final postData = {
      'post_title': _titleController.text,
      'post_content': _contentController.text,
      'post_image': imageUrl,
    };

    try {
      // ... existing code ...
    } catch (e) {
      // ... existing code ...
    }
  }
} 