import 'package:eventara/data/models/event_model.dart';

sealed class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventSuccess extends EventState {
  final String message;
  EventSuccess(this.message);
}

class EventError extends EventState {
  final String message;
  EventError(this.message);
}

class EventListLoaded extends EventState {
  final List<EventModel> events;
  EventListLoaded(this.events);
}
