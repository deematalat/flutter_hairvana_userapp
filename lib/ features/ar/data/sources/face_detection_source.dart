import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';
import '../../domain/entities/detected_face.dart';

class FaceDetectionSource {
  final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector(
    FaceDetectorOptions(enableContours: true, enableLandmarks: true),
  );

  Future<List<DetectedFace>> detectFaces(CameraImage image, CameraDescription cameraDescription) async {
    // Convert CameraImage to InputImage
    // (This is a simplified version; you may need to adapt for your app)
    final WriteBuffer allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotationValue.fromRawValue(cameraDescription.sensorOrientation) ?? InputImageRotation.rotation0deg,
        format: InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
    final faces = await _faceDetector.processImage(inputImage);
    return faces.map((f) => DetectedFace(
      left: f.boundingBox.left,
      top: f.boundingBox.top,
      width: f.boundingBox.width,
      height: f.boundingBox.height,
    )).toList();
  }

  Future<void> close() async {
    await _faceDetector.close();
  }
} 