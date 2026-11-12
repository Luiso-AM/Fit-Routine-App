import 'package:material_ui/material_ui.dart';

const String kExercisePlaceholderAsset =
    'assets/images/exercise_placeholder.png';

/// Exercise picture, falling back to the placeholder when [imagePath] is
/// `null` or cannot be loaded. [imagePath] is an asset path for now.
class ExerciseImage extends StatelessWidget {
  const ExerciseImage({
    required this.imagePath,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    super.key,
  });

  final String? imagePath;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget placeholder(BuildContext context, Object error, StackTrace? stack) =>
        _asset(kExercisePlaceholderAsset);

    return ClipRRect(
      borderRadius: borderRadius,
      child: imagePath == null
          ? _asset(kExercisePlaceholderAsset)
          : Image.asset(
              imagePath!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: placeholder,
            ),
    );
  }

  Widget _asset(String path) => Image.asset(
    path,
    width: width,
    height: height,
    fit: BoxFit.cover,
    excludeFromSemantics: true,
  );
}
