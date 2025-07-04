import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import 'evaluation_screen.dart';
import '../../../../main.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({Key? key}) : super(key: key);

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  FaceDetector? _faceDetector;

  bool _isCameraInitialized = false;
  bool _isDetecting = false;
  List<Face> _faces = [];

  @override
  void initState() {
    super.initState();
    _initializeDetector();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceDetector?.close();
    super.dispose();
  }

  void _initializeDetector() {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
      ),
    );
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isEmpty) return;

    _cameraController = CameraController(
      _cameras[1], // Front camera
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    setState(() => _isCameraInitialized = true);

    _cameraController!.startImageStream(_processCameraImage);
  }

  void _processCameraImage(CameraImage image) async {
    if (_isDetecting || _faceDetector == null) return;

    _isDetecting = true;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }

      final bytes = allBytes.done().buffer.asUint8List();
      final rotation = InputImageRotationValue.fromRawValue(_cameras[1].sensorOrientation) ?? InputImageRotation.rotation0deg;

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final faces = await _faceDetector!.processImage(inputImage);
      if (mounted) {
        setState(() => _faces = faces);
      }
    } catch (_) {
      // silently fail
    } finally {
      _isDetecting = false;
    }
  }

  void _goToEvaluationScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EvaluationScreen()));
  }

  void _exitToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainNavigation(initialIndex: 0)),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_isCameraInitialized) CameraPreview(_cameraController!),

          if (_faces.isNotEmpty)
            IgnorePointer(
              child: CustomPaint(
                painter: _FaceOverlayPainter(faces: _faces, screenSize: screenSize),
                child: const SizedBox.expand(),
              ),
            ),

          _buildTopBar(),
          _buildMatchBadge(),
          _buildEvaluateButton(),
          _buildFilterCards(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 40,
      left: 20,
      child: GestureDetector(
        onTap: _exitToHome,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget _buildMatchBadge() {
    return Positioned(
      top: 40,
      left: 80,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFa78bfa), Color(0xFFf472b6)]),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Row(
          children: [
            Icon(Icons.star, color: Colors.white, size: 20),
            SizedBox(width: 6),
            Text('87%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
            Text('AI Match', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildEvaluateButton() {
    return Positioned(
      top: 140,
      left: 0,
      right: 0,
      child: Center(
        child: ElevatedButton.icon(
          onPressed: _goToEvaluationScreen,
          icon: const Icon(Icons.flash_on),
          label: const Text('Evaluate Look'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterCards() {
    final filters = ['Curtain Bangs', 'Beach Waves', 'Pixie Cut'];
    return Positioned(
      bottom: 180,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: filters.map((f) => _FilterCard(label: f)).toList(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomAction(icon: Icons.favorite_border, label: 'Save'),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
          ),
          _BottomAction(icon: Icons.share, label: 'Share'),
        ],
      ),
    );
  }
}

class _FilterCard extends StatelessWidget {
  final String label;
  const _FilterCard({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

class _FaceOverlayPainter extends CustomPainter {
  final List<Face> faces;
  final Size screenSize;

  _FaceOverlayPainter({required this.faces, required this.screenSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple.withOpacity(0.3);

    for (final face in faces) {
      final rect = Rect.fromLTWH(
        face.boundingBox.left * screenSize.width / 480,
        face.boundingBox.top * screenSize.height / 640,
        face.boundingBox.width * screenSize.width / 480,
        face.boundingBox.height * screenSize.height / 640,
      );
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
