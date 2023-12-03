import 'dart:io';

import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/features/admin/repository/admin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<CommonState> {
  final AdminRepository adminRepository;
  AdminCubit({required this.adminRepository}) : super(CommonInitialState());

  postProduct({
    required String name,
    required String description,
    required List<File> images,
    required double price,
    required double quantity,
    required String category,
  }) async {
    emit(CommonLoadingState());
    final res = await adminRepository.sellProduct(
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      category: category,
      images: images,
    );
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }

  
}
