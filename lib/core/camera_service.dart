import 'dart:async';
import 'package:camera/camera.dart';

/// Manages the device camera lifecycle and provides a frame stream
/// for real-time pose detection.
class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  CameraLensDirection _currentDirection = CameraLensDirection.front;

  CameraController? get controller => _controller;
  bool get isInitialized => _controller?.value.isInitialized ?? false;
  CameraLensDirection get currentDirection => _currentDirection;

  /// Initializes the camera at medium resolution.
  Future<void> initialize({CameraLensDirection direction = CameraLensDirection.front}) async {
    _cameras = await availableCameras();
    if (_cameras == null || _cameras!.isEmpty) {
      throw Exception('No cameras available on this device.');
    }

    _currentDirection = direction;

    // Prefer the selected camera for workout tracking.
    final camera = _cameras!.firstWhere(
      (c) => c.lensDirection == _currentDirection,
      orElse: () => _cameras!.first,
    );

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    await _controller!.initialize();
  }

  /// Starts streaming camera frames. [onFrame] is called for each image.
  ///
  /// Only processes every Nth frame (controlled by [skipFrames]) to avoid
  /// overwhelming the inference pipeline.
  Future<void> startImageStream(
    void Function(CameraImage image) onFrame, {
    int skipFrames = 2,
  }) async {
    if (_controller == null || !isInitialized) return;

    int frameCount = 0;
    await _controller!.startImageStream((CameraImage image) {
      frameCount++;
      if (frameCount % (skipFrames + 1) == 0) {
        onFrame(image);
      }
    });
  }

  /// Stops the image stream.
  Future<void> stopImageStream() async {
    if (_controller == null || !isInitialized) return;
    try {
      await _controller!.stopImageStream();
    } catch (_) {
      // Stream may already be stopped.
    }
  }

  /// Switches the camera to the other direction.
  Future<void> switchCamera(void Function(CameraImage image) onFrame, {int skipFrames = 2}) async {
    if (_cameras == null || _cameras!.length < 2) return;

    final newDirection = _currentDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    await stopImageStream();
    await _controller?.dispose();
    _controller = null;

    await initialize(direction: newDirection);
    await startImageStream(onFrame, skipFrames: skipFrames);
  }

  /// Releases all camera resources.
  Future<void> dispose() async {
    await stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }
}
