import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweening and Curves',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tweening and Curves'),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  ///NOTE: A tween<double> can have a [Tween.begin] and [Tween.end] of any double value,
  ///however for the demo purposes these values will be constrained between
  ///0 and 1 (begin: 0, end: 1). This is only to facilitate the logic of the [AnimationAndCurveDemo]

  /// LINEAR TWEEN - straight line
  static final linearTween = Tween<double>(begin: 0, end: 1);

  /// SEQUENCE TWEEN - combine a sequence of tweens into one
  static final tweenSequence = TweenSequence(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40.0,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(1.0),
        weight: 20.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 40.0,
      ),
    ],
  );

  /// CHAIN TWEEN EXAMPLE (Note: the [chainTween] goes from 0 to 2, not 0 to 1)
  static final Tween<double> chainTween = Tween<double>(begin: 0, end: 2);

  /// CONSTANT TWEEN - tween with a constant value
  static final constantTween = ConstantTween<double>(1.0);

  /// SAW TOOTH TWEEN - tween that goes from 0 to 1 multiple times,
  /// depending on the value passed in
  static final Curve sawToothCurve = SawTooth(7);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        AnimationAndCurveDemo(
          lable: 'Linear - EaseIn and EaseOut',
          mainCurve: linearTween
              .chain(CurveTween(curve: Curves.easeIn))
              .chain(CurveTween(curve: Curves.easeOut)),
          duration: Duration(seconds: 2),
          size: 200,
        ),
        AnimationAndCurveDemo(
          lable: 'Linear - SawTooth',
          mainCurve: linearTween
              .chain(CurveTween(curve: Curves.bounceOut))
              .chain(CurveTween(curve: sawToothCurve)),
          duration: Duration(seconds: 8),
          size: 200,
        ),
        AnimationAndCurveDemo(
          lable: 'Linear - 0 to 2',
          mainCurve: linearTween.chain(chainTween),
          duration: Duration(seconds: 1),
          size: 200,
        ),
        AnimationAndCurveDemo(
          lable: 'Tween Sequence',
          mainCurve: tweenSequence,
          compareCurve: linearTween,
          kindOfAnim: KindOfAnimation.repeat,
        ),
        AnimationAndCurveDemo(
          lable: 'Custom Curve: Sine',
          mainCurve: linearTween.chain(CurveTween(curve: SineCurve())),
          duration: Duration(seconds: 4),
          kindOfAnim: KindOfAnimation.repeat,
          size: 200,
        ),
        AnimationAndCurveDemo(
          lable: 'Custom Curve: Springy',
          mainCurve: linearTween.chain(CurveTween(curve: SpringCurve())),
          duration: Duration(seconds: 3),
          size: 200,
        ),
        AnimationAndCurveDemo(
          lable: 'Custom Tween: Blocky',
          mainCurve: CustomTweenExample(begin: 0, end: 1),
          duration: Duration(seconds: 1),
          size: 200,
        ),
      ],
    );
  }
}

/// An example illustrating how to create your own Tween Class.
/// For more examples take a look at ColorTween, RectTween, IntTwee, etc.
class CustomTweenExample extends Tween<double> {
  CustomTweenExample({
    double? begin,
    double? end,
  }) : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    // return super.lerp((sin((t - delay) * 2 * pi) + 1) / 2);
    final middle = (end! - begin!) / 2;
    if (t < 0.2) {
      return super.lerp(begin!);
    } else if (t < 0.4) {
      return super.lerp(middle);
    } else if (t < 0.6) {
      return super.lerp(end!);
    } else if (t < 0.8) {
      return super.lerp(middle);
    }
    return super.lerp(end!);
  }
}

/// An example demonstrating how to create your own Curve
/// This example implements a sine curve
class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 3});

  // t = x
  @override
  double transformInternal(double t) {
    var val = sin(count * 2 * pi * t) * 0.5 + 0.5;
    // var val = sin(2 * pi * t);
    return val; //f(x)
  }
}

/// An example demonstrating how to create your own Curve
/// This example implements a spring curve
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}

/// WARNING
/// The code below is used to do the animation demonstration. Feel free to poke around.
/// It is not optimised in any way, purely for demonstration purposes.

enum KindOfAnimation {
  forward,
  repeat,
  repeatAndreverse,
}

class AnimationAndCurveDemo extends StatefulWidget {
  /// NOTE: All tweens ([mainCurve], [compareCurve]) must have an interval between 0 and 1.
  /// The [size] is used to determine the size of the graph and animation. The interval value
  /// is used as a fractional percentage to calculate the size/position of the animations.
  AnimationAndCurveDemo({
    Key? key,
    @required this.mainCurve,
    this.compareCurve,
    this.lable = '',
    this.size = 200,
    this.duration = const Duration(seconds: 1),
    this.kindOfAnim = KindOfAnimation.forward,
  })  : assert(size != null &&
            duration != null &&
            mainCurve != null &&
            kindOfAnim != null),
        super(key: key);

  final Animatable<double>? mainCurve;
  final Animatable<double>? compareCurve;
  final String? lable;
  final double? size;
  final Duration? duration;
  final KindOfAnimation? kindOfAnim;

  @override
  _AnimationAndCurveDemoState createState() => _AnimationAndCurveDemoState();
}

class _AnimationAndCurveDemoState extends State<AnimationAndCurveDemo>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  Animatable<double> get _mainCurve => widget.mainCurve!;
  Animatable<double> get _compareCurve => widget.compareCurve!;
  String get _label => widget.lable!;
  double get _size => widget.size!;
  Duration get _duration => widget.duration!;
  KindOfAnimation get _kindOfAnim => widget.kindOfAnim!;

  /// the shadow path of the animation curve - dotted line
  Path? _shadowPath;

  /// path to compare the current animation to - only drawn if not null
  Path? _comparePath;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _shadowPath = _buildGraph(_mainCurve);
    if (_compareCurve != null) {
      _comparePath = _buildGraph(_compareCurve);
    }

    super.initState();
  }

  Path _buildGraph(Animatable animatable) {
    var val = 0.0;
    var path = Path();
    for (var t = 0.0; t <= 1; t += 0.01) {
      val = -animatable.transform(t) * _size;
      path.lineTo(t * _size, val);
    }
    // return dashPath(path, dashArray: CircularIntervalList<double>([15.0, 10]));
    return path;
  }

  void _playAnimation() {
    _controller?.reset();
    if (_kindOfAnim == KindOfAnimation.forward) {
      _controller?.forward();
    } else if (_kindOfAnim == KindOfAnimation.repeat) {
      _controller?.repeat();
    } else {
      _controller?.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var intervalValue = 0.0;
    var followPath = Path();
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_label, style: Theme.of(context).textTheme.headline4),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedBuilder(
              animation: _controller!,
              builder: (context, child) {
                return Align(
                  alignment: Alignment(
                      lerpDouble(-1, 1, _mainCurve.evaluate(_controller!))!, 0),
                  child: child,
                );
              },
              child: FlutterLogo(
                size: 150,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _playAnimation,
            child: Text('Tween'),
          ),
        ),
        SizedBox(
          height: 300,
          child: AnimatedBuilder(
            animation: _controller!,
            builder: (_, child) {
              // rest the follow path when the controller is finished
              if (intervalValue >= _controller!.value) {
                followPath.reset();
              }
              intervalValue = _controller!.value;

              final val = _mainCurve.evaluate(_controller!);
              followPath.lineTo(_controller!.value * _size, -val * _size);

              return CustomPaint(
                painter: GraphPainter(
                  shadowPath: _shadowPath!,
                  followPath: followPath,
                  comparePath: _comparePath!,
                  currentPoint: Offset(
                    _controller!.value * _size,
                    val * _size,
                  ),
                  graphSize: _size,
                ),
                child: Container(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class GraphPainter extends CustomPainter {
  final Offset? currentPoint;
  final Path? shadowPath;
  final Path? followPath;
  final Path? comparePath;
  final double? graphSize;
  GraphPainter({
    @required this.currentPoint,
    @required this.shadowPath,
    @required this.followPath,
    @required this.comparePath,
    @required this.graphSize,
  });
  static final backgroundPaint = Paint()..color = Colors.grey[200]!;
  static final currentPointPaint = Paint()..color = Colors.red;
  static final shadowPaint = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  static final comparePaint = Paint()
    ..color = Colors.green[500]!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  static final followPaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;
  static final borderPaint = Paint()
    ..color = Colors.grey[700]!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    canvas.translate(
        size.width / 2 - graphSize! / 2, size.height / 2 - graphSize! / 2);
    _drawBorder(canvas, size);
    canvas.translate(0, graphSize!);
    if (comparePath != null) {
      canvas.drawPath(comparePath!, comparePaint);
    }
    canvas.drawPath(shadowPath!, shadowPaint);
    canvas.drawPath(followPath!, followPaint);
    canvas.drawCircle(
        Offset(currentPoint!.dx, -currentPoint!.dy), 4, currentPointPaint);
  }

  void _drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
  }

  void _drawBorder(Canvas canvas, Size size) {
    canvas.drawLine(Offset(0, 0), Offset(0, graphSize!), borderPaint);
    canvas.drawLine(
        Offset(0, graphSize!), Offset(graphSize!, graphSize!), borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
