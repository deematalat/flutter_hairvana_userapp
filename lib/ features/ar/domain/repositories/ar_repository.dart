import '../entities/detected_face.dart';
import 'package:camera/camera.dart';

abstract class ArRepository {
  Future<List<CameraDescription>> getAvailableCameras();
  Future<CameraController> initializeCamera(CameraDescription cameraDescription);
  Future<List<DetectedFace>> detectFaces(CameraImage image, CameraDescription cameraDescription);
  Future<void> disposeCamera(CameraController controller);
} 