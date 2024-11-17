import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../service/firebaseAuthService.dart';


class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final _picker = ImagePicker();
  String? _profileImageUrl;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final User? user = Auth().currentUser;
    _nameController.text = user?.displayName ?? '';
    _emailController.text = user?.email ?? '';
    _profileImageUrl = user?.photoURL;
  }

  Future<void> _uploadProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {

      final storageRef = FirebaseStorage.instance.ref().child('profile_images/${Auth().currentUser?.uid}');
      try {
        await storageRef.putFile(File(pickedFile.path));
        final url = await storageRef.getDownloadURL();
        setState(() {
          _profileImageUrl = url;
        });
      } on FirebaseException catch (e) {

        print("Error uploading profile image: ${e.message}");
      }
    }
  }

  Future<void> _updateUserProfile() async {
    final User? user = Auth().currentUser;

    if (user != null) {
      try {
        await user.updateDisplayName(_nameController.text);
        await user.updateEmail(_emailController.text);
        if (_profileImageUrl != null) {
          await user.updatePhotoURL(_profileImageUrl);
        }

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditDialog();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileImage(),
            const SizedBox(height: 20),
            _buildUserInfo(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserProfile,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: GestureDetector(
        onTap: _uploadProfileImage,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: _profileImageUrl != null ? NetworkImage(_profileImageUrl!) : null,
          child: _profileImageUrl == null
              ? const Icon(
            Icons.camera_alt,
            size: 40,
            color: Colors.grey,
          )
              : null,
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoField("Name", _nameController),
        const SizedBox(height: 10),
        _buildInfoField("Email", _emailController),
      ],
    );
  }


  Widget _buildInfoField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }


  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInfoField("Name", _nameController),
            const SizedBox(height: 10),
            _buildInfoField("Email", _emailController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _updateUserProfile();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
