part of 'resource_list_bloc.dart';

sealed class ResourceListState extends Equatable {
  ResourceListState(this.resourceList);
  
  List<Resource> resourceList;

  @override
  List<Object> get props => [resourceList];
}

final class ResourceListInitialState extends ResourceListState {
  ResourceListInitialState(super.resourceList);
}

final class ResourceListLoadingState extends ResourceListState {
  ResourceListLoadingState(super.resourceList);
}

final class ResourceListSuccessState extends ResourceListState {
  ResourceListSuccessState(super.resourceList);
}

final class ResourceListNoInternetState extends ResourceListState {
  ResourceListNoInternetState(super.resourceList);
}

final class ResourceListErrorState extends ResourceListState {
  ResourceListErrorState(super.resourceList);
}
