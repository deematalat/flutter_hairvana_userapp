import 'package:camera/camera.dart';
import '../../domain/entities/detected_face.dart';

abstract class ArEvent {}

class InitializeCameraEvent extends ArEvent {
  final CameraDescription cameraDescription;
  InitializeCameraEvent(this.cameraDescription);
}

class DetectFacesEvent extends ArEvent {
  final CameraImage image;
  final CameraDescription cameraDescription;
  DetectFacesEvent(this.image, this.cameraDescription);
}

class DisposeCameraEvent extends ArEvent {
  final CameraController controller;
  DisposeCameraEvent(this.controller);
} 