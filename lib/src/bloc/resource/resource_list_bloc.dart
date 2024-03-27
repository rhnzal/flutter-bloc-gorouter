import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_architecture/src/data/models/response.dart';
import 'package:flutter_bloc_architecture/src/data/services/resource_services.dart';

import '../../data/models/resource.dart';

part 'resource_list_event.dart';
part 'resource_list_state.dart';

class ResourceListBloc extends Bloc<ResourceListEvent, ResourceListState> {
  ResourceListBloc() : super(ResourceListInitialState([])) {
    
    on<ResourceListLoadEvent>((event, emit) async {
      emit(ResourceListLoadingState([]));

      var response = await ResourceService.getResourcesData();

      if (response.isSuccess) {
        List<Resource> resourceList = List.from(state.resourceList);

        for(var resource in response.data) {
          resourceList.add(Resource.fromJson(resource));

        }
        
        emit(ResourceListSuccessState(resourceList));
      
      } else if (response.status == HTTPResponseStatus.noInternet) {
        emit(ResourceListNoInternetState(state.resourceList));
        
      } else {
        emit(ResourceListErrorState(state.resourceList));

      }

    });

    on<ResourceListReloadEvent>((event, emit) {
      emit(ResourceListLoadingState([]));

      add(ResourceListLoadEvent());
    });
  }
}
