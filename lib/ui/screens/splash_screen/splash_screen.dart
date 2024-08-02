import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  var isLoginIn;
  @override
  void initState() {
    super.initState();
    getLoginStatus();
    _controller = VideoPlayerController.asset('assets/gif/splash.mp4')
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown after the video is initialized.
        _controller.play();
      })
      ..setLooping(false);

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _onVideoCompleted();
      }
    });
  }

  Future<void> getLoginStatus() async {
    isLoginIn = await SharedPrefHelper.getUserData;
  }

  Future<void> _onVideoCompleted() async {
    if (isLoginIn.isNotEmpty) {
      context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
    } else {
      context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Center(
        child: _controller.value.isInitialized
            ? VideoPlayer(_controller)
            : SizedBox.shrink(),
      ),
    );
  }
}

class CustomTooltip extends StatelessWidget {
  final String text;
  final Offset position;

  const CustomTooltip({
    super.key,
    required this.text,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: CustomShapePainter(color: Colors.blue),
        size: Size(200, 200), // Adjust the size as needed
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  final Color color; // Optional property for customization

  const CustomShapePainter({this.color = Colors.blue}); // Default color

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color // Use the provided color or default
      ..style = PaintingStyle.fill; // Fill the shape

    final path = Path();

    // *Replace the following with code specific to your shape:*

    // Example lines and curves:
    path.moveTo(size.width * 0.2, size.height * 0.2); // Top left corner
    path.lineTo(size.width * 0.8, size.height * 0.8); // Right side line
    path.quadraticBezierTo(size.width * 0.5, size.height, size.width * 0.2, size.height * 0.8); // Bottom curve
    path.close();

    // *Add or modify path segments as needed based on your shape's components.*

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
