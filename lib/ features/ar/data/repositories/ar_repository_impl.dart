import '../../domain/repositories/ar_repository.dart';
import '../../domain/entities/detected_face.dart';
import '../sources/camera_source.dart';
import '../sources/face_detection_source.dart';
import 'package:camera/camera.dart';

class ArRepositoryImpl implements ArRepository {
  final CameraSource cameraSource;
  final FaceDetectionSource faceDetectionSource;

  ArRepositoryImpl({required this.cameraSource, required this.faceDetectionSource});

  @override
  Future<List<CameraDescription>> getAvailableCameras() {
    return cameraSource.getAvailableCameras();
  }

  @override
  Future<CameraController> initializeCamera(CameraDescription cameraDescription) {
    return cameraSource.initializeCamera(cameraDescription);
  }

  @override
  Future<List<DetectedFace>> detectFaces(CameraImage image, CameraDescription cameraDescription) {
    return faceDetectionSource.detectFaces(image, cameraDescription);
  }

  @override
  Future<void> disposeCamera(CameraController controller) {
    return cameraSource.disposeCamera(controller);
  }
} 