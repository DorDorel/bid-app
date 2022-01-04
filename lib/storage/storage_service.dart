import 'dart:io';

import 'package:bid/providers/tenant_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final String tenantId = TenantProvider.tenantId;

  Future<String> _getCurrentTenantFolder() async {
    await TenantProvider().tenantValidation();
    return tenantId;
  }

  Future<String> uploadProductImage(String productName) async {
    final String? _currentTenant = await _getCurrentTenantFolder();
    final _picker = ImagePicker();
    final bucketPath = "$_currentTenant/product_photos/$productName";

    XFile? image;

    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      try {
        image = (await _picker.pickImage(source: ImageSource.gallery))!;
        File file = File(image.path);
        print(image.path);

        var snapshot = await _storage.ref().child(bucketPath).putFile(file);
        String downloadURL = await snapshot.ref.getDownloadURL();

        return downloadURL;
      } catch (err) {
        print(err);
      }
    } else {
      print('Grant Permissions and try again');
      return 'ERROR';
    }
    return 'Failed';
  }

  Future<void> deleteProductImage({required String productImageURL}) async {
    await TenantProvider().tenantValidation();
    try {
      await _storage.refFromURL(productImageURL).delete();
    } catch (err) {
      print('file not removed');
    }
  }
}
