import 'package:camera/camera.dart';



class CameraSource {
  Future<List<CameraDescription>> getAvailableCameras() async {
    return await availableCameras();
  }

  Future<CameraController> initializeCamera(CameraDescription cameraDescription) async {
    final controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await controller.initialize();
    return controller;
  }

  Future<void> disposeCamera(CameraController controller) async {
    await controller.dispose();
  }
} 