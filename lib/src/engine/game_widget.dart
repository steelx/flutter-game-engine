import 'package:flutter/material.dart' hide Canvas, Size;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterapp01/src/engine/game.dart';

class GameWidget extends StatelessWidget {
  final Game game;

  const GameWidget(this.game);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: _EmbeddedGameWidget(game),
      ),
    );
  }


}


/// This a widget to embed a game inside the Widget tree. You can use it in pair with [SimpleGame] or any other more complex [Game], as desired.
///
/// It handles for you positioning, size constraints and other factors that arise when your game is embedded within the component tree.
/// Provided it with a [Game] instance for your game and the optional size of the widget.
/// Creating this without a fixed size might mess up how other components are rendered with relation to this one in the tree.
/// You can bind Gesture Recognizers immediately around this to add controls to your widgets, with easy coordinate conversions.
class _EmbeddedGameWidget extends LeafRenderObjectWidget {
  final Game game;
  final Size size;

  _EmbeddedGameWidget(this.game, {this.size});

  @override
  RenderBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
        child: GameRenderBox(context, game),
        additionalConstraints:
        BoxConstraints.expand(width: size?.width, height: size?.height));
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderConstrainedBox renderBox) {
    renderBox
      ..child = GameRenderBox(context, game)
      ..additionalConstraints =
      BoxConstraints.expand(width: size?.width, height: size?.height);
  }
}

class GameRenderBox extends RenderBox with WidgetsBindingObserver {
  BuildContext context;
  Game game;

  int _frameCallbackId;

  Duration previous = Duration.zero;

  GameRenderBox(this.context, this.game);

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    super.performResize();
    game.resize(constraints.biggest);
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    game.onAttach();

    _bindLifecycleListener();
  }

  @override
  void detach() {
    super.detach();
    game.onDetach();
    _unscheduleTick();
    _unbindLifecycleListener();
  }

  void _scheduleTick() {
    _frameCallbackId = SchedulerBinding.instance.scheduleFrameCallback(_tick);
  }

  void _unscheduleTick() {
    if (_frameCallbackId != null) {
      SchedulerBinding.instance.cancelFrameCallbackWithId(_frameCallbackId);
    }
  }

  void _tick(Duration timestamp) {
    if (!attached) {
      return;
    }
    _scheduleTick();
    _update(timestamp);
    markNeedsPaint();
  }

  void _update(Duration now) {
    final double dt = _computeDeltaT(now);
    game.update(dt);
  }

  double _computeDeltaT(Duration now) {
    Duration delta = now - previous;
    if (previous == Duration.zero) {
      delta = Duration.zero;
    }
    previous = now;
    return delta.inMicroseconds / Duration.microsecondsPerSecond;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
//    context.canvas.translate(game.builder.offset.dx + offset.dx, game.builder.offset.dy + offset.dy);
    game.render(context.canvas);
    context.canvas.restore();
  }

  void _bindLifecycleListener() {
    WidgetsBinding.instance.addObserver(this);
  }

  void _unbindLifecycleListener() {
    WidgetsBinding.instance.removeObserver(this);
  }

//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    game.lifecycleStateChange(state);
//  }
}
