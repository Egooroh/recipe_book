import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageHelper {
  static Future<String?> pickAndSaveImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    final directory = await getApplicationDocumentsDirectory();

    final fileName = '${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}';

    final savedImage = await File(image.path).copy('${directory.path}/$fileName');

    return savedImage.path;
  }
}