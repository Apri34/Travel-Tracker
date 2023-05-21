import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void toggleEditing(bool active) {
    emit(state.copyWith(
      editing: active,
    ));
  }
}
