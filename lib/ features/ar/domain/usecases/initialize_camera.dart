import '../repositories/ar_repository.dart';
import 'package:camera/camera.dart';

class InitializeCamera {
  final ArRepository repository;
  InitializeCamera(this.repository);

  Future<CameraController> call(CameraDescription cameraDescription) {
    return repository.initializeCamera(cameraDescription);
  }
} 