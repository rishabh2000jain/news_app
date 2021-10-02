import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchModule extends SearchEvent {
  final int page;
  final String query;

  const SearchModule(
      {required this.page,required this.query});

  @override
  List<Object?> get props => [page,query];
}
