import 'package:flutter_bloc/flutter_bloc.dart';
import 'ar_event.dart';
import 'ar_state.dart';
import '../../domain/usecases/initialize_camera.dart';
import '../../domain/usecases/detect_faces.dart';
import 'package:camera/camera.dart';

class ArBloc extends Bloc<ArEvent, ArState> {
  final InitializeCamera initializeCamera;
  final DetectFaces detectFaces;

  ArBloc({required this.initializeCamera, required this.detectFaces}) : super(ArInitial()) {
    on<InitializeCameraEvent>((event, emit) async {
      emit(ArLoading());
      try {
        final controller = await initializeCamera(event.cameraDescription);
        emit(ArCameraReady(controller));
      } catch (e) {
        emit(ArError('Failed to initialize camera: $e'));
      }
    });

    on<DetectFacesEvent>((event, emit) async {
      try {
        final faces = await detectFaces(event.image, event.cameraDescription);
        emit(ArFacesDetected(faces, event.cameraDescription as CameraController));
      } catch (e) {
        emit(ArError('Failed to detect faces: $e'));
      }
    });

    on<DisposeCameraEvent>((event, emit) async {
      try {
        await event.controller.dispose();
        emit(ArInitial());
      } catch (e) {
        emit(ArError('Failed to dispose camera: $e'));
      }
    });
  }
} 