import 'package:camera/camera.dart';
import '../../domain/entities/detected_face.dart';

abstract class ArState {}

class ArInitial extends ArState {}
class ArLoading extends ArState {}
class ArCameraReady extends ArState {
  final CameraController controller;
  ArCameraReady(this.controller);
}
class ArFacesDetected extends ArState {
  final List<DetectedFace> faces;
  final CameraController controller;
  ArFacesDetected(this.faces, this.controller);
}
class ArError extends ArState {
  final String message;
  ArError(this.message);
} 