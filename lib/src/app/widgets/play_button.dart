import 'package:audio/src/app/bloc/bloc.dart';
import 'package:flutter/material.dart';

class PlayButton<S> extends StatelessWidget {
  final bool consumeStream;
  final Color activeColor;
  final Color disabledColor;
  final PlayerState playerState;
  final Stream<S> stream;
  final VoidCallback onPressed;

  PlayButton({
    @required this.playerState,
    @required this.onPressed,
    this.consumeStream = true,
    this.activeColor = Colors.orange,
    this.disabledColor = Colors.grey,
    this.stream,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          child: IconButton(
            iconSize: 80,
            icon: _configureIcon(),
            color: activeColor,
            disabledColor: disabledColor,
            onPressed: _configureState(snapshot),
          ),
        );
      },
    );
  }

  Icon _configureIcon() {
    if (playerState == PlayerState.stopped()) {
      return const Icon(Icons.play_circle_filled);
    } else if (playerState == PlayerState.playing(playerState.position)) {
      return const Icon(Icons.pause);
    } else if (playerState == PlayerState.paused(playerState.position)) {
      return const Icon(Icons.play_circle_filled);
    } else if (playerState == PlayerState.resumed(playerState.position)) {
      return const Icon(Icons.pause);
    } else {
      return const Icon(Icons.stop);
    }
  }

  VoidCallback _configureState(AsyncSnapshot<Object> snapshot) {
    if (consumeStream) {
      return (snapshot.hasData) ? onPressed : null;
    } else {
      return onPressed;
    }
  }
}
