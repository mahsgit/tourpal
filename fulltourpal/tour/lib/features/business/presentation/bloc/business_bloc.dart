import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_businesses.dart';
import '../../domain/usecases/get_business_details.dart';
import 'business_event.dart';
import 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  final GetBusinesses getBusinesses;
  final GetBusinessDetails getBusinessDetails;

  BusinessBloc({
    required this.getBusinesses,
    required this.getBusinessDetails,
  }) : super(BusinessInitial()) {
    on<LoadBusinesses>(_onLoadBusinesses);
    on<LoadBusinessDetails>(_onLoadBusinessDetails);
    on<LoadMoreBusinesses>(_onLoadMoreBusinesses);
  }

  Future<void> _onLoadBusinesses(
    LoadBusinesses event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessLoading());
    final result = await getBusinesses(GetBusinessesParams());
    result.fold(
      (failure) => emit(BusinessError(message: failure.message)),
      (businesses) => emit(BusinessesLoaded(businesses: businesses)),
    );
  }

  Future<void> _onLoadBusinessDetails(
    LoadBusinessDetails event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessLoading());
    final result = await getBusinessDetails(event.businessId);
    result.fold(
      (failure) => emit(BusinessError(message: failure.message)),
      (business) => emit(BusinessDetailsLoaded(business: business)),
    );
  }

  Future<void> _onLoadMoreBusinesses(
    LoadMoreBusinesses event,
    Emitter<BusinessState> emit,
  ) async {
    if (state is BusinessesLoaded) {
      final currentState = state as BusinessesLoaded;
      final result = await getBusinesses(
        GetBusinessesParams(page: event.page, limit: event.limit),
      );
      result.fold(
        (failure) => emit(BusinessError(message: failure.message)),
        (newBusinesses) => emit(
          BusinessesLoaded(
            businesses: [...currentState.businesses, ...newBusinesses],
          ),
        ),
      );
    }
  }
}

