import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeModule extends HomeEvent {
  final int page;
  final String? country;
  final String? category;

  const HomeModule({required this.page, this.category, this.country});

  @override
  List<Object?> get props => [page];
}
