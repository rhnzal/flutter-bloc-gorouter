import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/resource/resource_list_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/user_list/user_list_bloc.dart';
import 'package:flutter_bloc_architecture/src/ui/common/style.dart';

class MultiListPage extends StatelessWidget {
  const MultiListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userListBloc = context.read<UserListBloc>();
    var resourceListBloc = context.read<ResourceListBloc>();

    userListBloc.add(UserListLoadEvent());
    resourceListBloc.add(ResourceListLoadEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi List Page'),
      ),

      body: Column(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - 16) / 2,
            child: BlocBuilder<UserListBloc, UserListState>(
              bloc: userListBloc,
              builder: (context, state) {
                if (state is UserListInitialState) {
                  return const Text('No Data');
                }

                if (state is UserListLoadingState) {
                  return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
                }

                if (state is UserListNoInternetState) {
                  return const Text('Error, No Internet');
                }

                if (state is UserListErrorState) {
                  return const Text('Error, Terjadi kesalahan saaat memuat data, tunggu beberapa saat dan coba lagi');
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    userListBloc.add(UserListReloadEvent());
                  },
                  child: ListView(
                    children: [
                      for (var user in state.userList) ... [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Detail', textAlign: TextAlign.center,),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 72,
                                        backgroundImage: NetworkImage(user.avatar),
                                      ),
                                      const SizedBox(height: 12),
                                      Text('${user.first_name} ${user.last_name}', style: MyTextStyle.bodyMedium,),
                                      const SizedBox(height: 4),
                                      Text(user.email, style: MyTextStyle.caption,),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(user.avatar),
                                ),
                                const SizedBox(width: 12),
                                Text(user.first_name)
                              ],
                            ),
                          ),
                        ),
                        
                      ]
                    ],
                  ),
                );
              },
            ),
          ),
          
          const Divider(),

          Container(
            height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - 16) /2,
            child: BlocBuilder<ResourceListBloc, ResourceListState>(
              bloc: resourceListBloc,
              builder: (context, state) {
                if (state is ResourceListInitialState) {
                  return const Text('No Data');
                }

                if (state is ResourceListLoadingState) {
                  return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
                }

                if (state is ResourceListNoInternetState) {
                  return const Text('Error, No Internet');
                }

                if (state is ResourceListErrorState) {
                  return const Text('Error, Terjadi kesalahan saaat memuat data, tunggu beberapa saat dan coba lagi');
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    resourceListBloc.add(ResourceListReloadEvent());
                  },
                  child: ListView(
                    children: [
                      for (var resource in state.resourceList) ... [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Detail', textAlign: TextAlign.center,),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 72,
                                        backgroundColor: Color(int.parse('0xff${resource.color.substring(1)}')),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(resource.name, style: MyTextStyle.bodyMedium,),
                                      const SizedBox(height: 4),
                                      Text('Year: ${resource.year}', style: MyTextStyle.caption,),
                                      const SizedBox(height: 4),
                                      Text('Hex: ${resource.color}', style: MyTextStyle.caption,),
                                      const SizedBox(height: 4),
                                      Text('Pantone Value: ${resource.pantone_value}', style: MyTextStyle.caption,),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(int.parse('0xff${resource.color.substring(1)}')),
                                ),
                                const SizedBox(width: 12),
                                Text(resource.name)
                              ],
                            ),
                          ),
                        ),
                        
                      ]
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}