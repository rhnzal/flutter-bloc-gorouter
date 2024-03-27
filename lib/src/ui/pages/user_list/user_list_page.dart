import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/user_list/user_list_bloc.dart';
import 'package:flutter_bloc_architecture/src/ui/common/style.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // membaca instance bloc dari context yang telah diinjeksi sebelumnya
    var userListBloc = context.read<UserListBloc>();

    // untuk alternatif initstate pada stateless widget, event ditrigger langsung di build method, 
    // selama build method tidak di rebuild maka event ini tidak akan dijalankan lagi
    userListBloc.add(UserListLoadEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),

      body: UserListViewWidget(),
    );
  }
}

class UserListViewWidget extends StatelessWidget {
  const UserListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    var userListBloc = context.read<UserListBloc>();
    return BlocBuilder<UserListBloc, UserListState>(
      bloc: userListBloc,
      builder: (context, state) {
        // membuat UI utk setiap State
        if (state is UserListInitialState) {
          return const Center(child: Text('No data'));
        
        }
    
        if (state is UserListLoadingState) {
          return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
    
        }
    
        if (state is UserListErrorState) {
          return const Center(child: Text('Failed, Error Fetching Data'));
    
        }
    
        if (state is UserListNoInternetState) {
          return const Center(child: Text('Failed, No Internet'));
    
        }
    
        return RefreshIndicator(
          onRefresh: () async {

            // Fungsi refresh masih bisa digunakan selama mendapatkan instance bloc yang sama,
            // contohnya disini instance userListBloc didapat melalui context :
            // var userListBloc = context.read<userListBloc>(); 
            userListBloc.add(UserListReloadEvent());
          },
          child: ListView(
            children: [
              for(var user in state.userList) ... [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.first_name, style: MyTextStyle.bodyMedium),
                            Text(user.email, style: MyTextStyle.caption),
                          ],
                        )
                      )
                    ],
                  ),
                )
              ],
              const SizedBox(height: 24,)
            ],
          ),
        );
    
      },
    );
  }
}