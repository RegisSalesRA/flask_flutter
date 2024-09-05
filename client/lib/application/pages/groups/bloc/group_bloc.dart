import 'package:bloc/bloc.dart';
import 'package:client/application/helpers/handler_erros_helper.dart';
import 'package:client/data/models/group_model.dart';
import 'package:client/domain/usecases/group_usercase.dart';
import 'package:equatable/equatable.dart';
part 'group_bloc_event.dart';
part 'group_bloc_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupUseCases groupUseCases;

  GroupBloc({required this.groupUseCases}) : super(GroupInitial()) {
    on<LoadGroups>(_onLoadGroups);
    on<AddGroup>(_onAddGroup);
  }

  Future<void> _onLoadGroups(LoadGroups event, Emitter<GroupState> emit) async {
    emit(GroupLoading());
    try {
      final groups = await groupUseCases.getgroups();
      emit(GroupLoaded(groups));
    } catch (e) {
      emit(handleErrorGroup(e));
    }
  }

  Future<void> _onAddGroup(AddGroup event, Emitter<GroupState> emit) async {
    try {
      await groupUseCases.postgroups(event.group);
      final createGroup = List.of((state as GroupLoaded).groups)
        ..add(event.group);
      emit(GroupLoaded(createGroup));
    } catch (e) {
      emit(handleErrorGroup(e));
    }
  }
}
