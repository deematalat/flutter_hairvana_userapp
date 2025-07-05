import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import '../../domain/entities/detected_face.dart';
import '../../domain/usecases/initialize_camera.dart';
import '../../domain/usecases/detect_faces.dart';
import '../../data/repositories/ar_repository_impl.dart';
import '../../data/sources/camera_source.dart';
import '../../data/sources/face_detection_source.dart';
import '../bloc/ar_bloc.dart';
import '../bloc/ar_state.dart';
import '../widgets/top_bar.dart';
import '../widgets/match_badge.dart';
import '../widgets/filter_cards.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/face_overlay.dart';
import '../widgets/evaluate_button.dart';
import 'evaluation_screen.dart';
import '../../../../main.dart';

class ARScreen extends StatelessWidget {
  const ARScreen({Key? key}) : super(key: key);

  void _goToEvaluationScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EvaluationScreen()));
  }

  void _exitToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainNavigation(initialIndex: 0)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) {
        // Create a simple repository implementation for demo purposes
        final repository = ArRepositoryImpl(
          cameraSource: CameraSource(),
          faceDetectionSource: FaceDetectionSource(),
        );
        final initializeCamera = InitializeCamera(repository);
        final detectFaces = DetectFaces(repository);
        return ArBloc(
          initializeCamera: initializeCamera,
          detectFaces: detectFaces,
        );
      },
      child: BlocBuilder<ArBloc, ArState>(
        builder: (context, state) {
          CameraController? controller;
          List<DetectedFace> faces = [];
          bool isCameraInitialized = false;
          if (state is ArCameraReady) {
            controller = state.controller;
            isCameraInitialized = true;
          } else if (state is ArFacesDetected) {
            controller = state.controller;
            faces = state.faces;
            isCameraInitialized = true;
          }
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                if (isCameraInitialized && controller != null) CameraPreview(controller),
                if (faces.isNotEmpty)
                  FaceOverlay(faces: faces, screenSize: screenSize),
                TopBar(onClose: () => _exitToHome(context)),
                const MatchBadge(),
                EvaluateButton(onPressed: () => _goToEvaluationScreen(context)),
                const FilterCards(),
                const BottomBar(),
                if (state is ArLoading)
                  const Center(child: CircularProgressIndicator()),
                if (state is ArError)
                  Center(child: Text(state.message, style: const TextStyle(color: Colors.red))),
              ],
            ),
          );
        },
      ),
    );
  }
}
