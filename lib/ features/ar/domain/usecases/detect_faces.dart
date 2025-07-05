import '../repositories/ar_repository.dart';
import '../entities/detected_face.dart';
import 'package:camera/camera.dart';

class DetectFaces {
  final ArRepository repository;
  DetectFaces(this.repository);

  Future<List<DetectedFace>> call(CameraImage image, CameraDescription cameraDescription) {
    return repository.detectFaces(image, cameraDescription);
  }
} 