part of 'resource_list_bloc.dart';

sealed class ResourceListEvent extends Equatable {
  const ResourceListEvent();

  @override
  List<Object> get props => [];
}

final class ResourceListLoadEvent extends ResourceListEvent {}

final class ResourceListReloadEvent extends ResourceListEvent {}
