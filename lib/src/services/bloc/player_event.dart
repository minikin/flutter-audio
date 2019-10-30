library player_event;

import 'package:audio/src/services/models/models.dart';
import 'package:built_value/built_value.dart';

part 'player_event.g.dart';

abstract class PlayerEvent {}

abstract class PauseEvent extends PlayerEvent
    implements Built<PauseEvent, PauseEventBuilder> {
  PauseEvent._();

  factory PauseEvent([void Function(PauseEventBuilder) updates]) = _$PauseEvent;
}

abstract class PlayEvent extends PlayerEvent
    implements Built<PlayEvent, PlayEventBuilder> {
  Tune get tune;

  PlayEvent._();

  factory PlayEvent([void Function(PlayEventBuilder) updates]) = _$PlayEvent;
}

abstract class ResumeEvent extends PlayerEvent
    implements Built<ResumeEvent, ResumeEventBuilder> {
  ResumeEvent._();

  factory ResumeEvent([void Function(ResumeEventBuilder) updates]) =
      _$ResumeEvent;
}

abstract class StopEvent extends PlayerEvent
    implements Built<StopEvent, StopEventBuilder> {
  StopEvent._();

  factory StopEvent([void Function(StopEventBuilder) updates]) = _$StopEvent;
}

class TickEvent extends PlayerEvent {
  final int position;
  TickEvent({this.position = 0});
}

class SeekEvent extends PlayerEvent {
  final int seekToPosition;

  SeekEvent({this.seekToPosition});
}
