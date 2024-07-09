import 'package:flutter_bloc/flutter_bloc.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(FilterState(
          selectedFilter1: 'Choose a Filter',
          selectedFilter2: 'Choose a Filter',
          tempSelectedFilter1: 'Choose a Filter',
          tempSelectedFilter2: 'Choose a Filter',
          displayText: '',
          businessModel: '',
          subcategory: '',
          address: '',
          visitStatus: '',
          annualSales: 0,
          total: 0,
          visitedCount: 0,
          notVisitedCount: 0,
          ongoingCount: 0,
          dataMap: {},
        )) {
    on<TempFilter1Changed>((event, emit) {
      emit(state.copyWith(tempSelectedFilter1: event.filter));
    });

    on<TempFilter2Changed>((event, emit) {
      emit(state.copyWith(tempSelectedFilter2: event.filter));
    });

    on<ApplyFilters>((event, emit) {
      String selectedFilter1 = state.tempSelectedFilter1;
      String selectedFilter2 = state.tempSelectedFilter2;

      int visitedCount = 0;
      int notVisitedCount = 0;
      int ongoingCount = 0;

      if (selectedFilter1 != 'Choose a Filter' &&
          selectedFilter2 != 'Choose a Filter') {
        switch (selectedFilter2) {
          case 'Today':
            if (selectedFilter1 == 'Company 1') {
              visitedCount = 30;
              notVisitedCount = 20;
              ongoingCount = 5;
            } else if (selectedFilter1 == 'Company 2') {
              visitedCount = 20;
              notVisitedCount = 40;
              ongoingCount = 17;
            } else if (selectedFilter1 == 'All') {
              visitedCount = 50;
              notVisitedCount = 60;
              ongoingCount = 22;
            }
            break;
          case 'Last 7 Days':
            if (selectedFilter1 == 'Company 1') {
              visitedCount = 100;
              notVisitedCount = 100;
              ongoingCount = 30;
            } else if (selectedFilter1 == 'Company 2') {
              visitedCount = 250;
              notVisitedCount = 40;
              ongoingCount = 70;
            } else if (selectedFilter1 == 'All') {
              visitedCount = 350;
              notVisitedCount = 140;
              ongoingCount = 100;
            }
            break;
          case 'Last 30 Days':
            if (selectedFilter1 == 'Company 1') {
              visitedCount = 2000;
              notVisitedCount = 5300;
              ongoingCount = 1000;
            } else if (selectedFilter1 == 'Company 2') {
              visitedCount = 600;
              notVisitedCount = 4200;
              ongoingCount = 900;
            } else if (selectedFilter1 == 'All') {
              visitedCount = 2600;
              notVisitedCount = 9500;
              ongoingCount = 1900;
            }
            break;
          case 'All':
            if (selectedFilter1 == 'Company 1') {
              visitedCount = 35000;
              notVisitedCount = 9000;
              ongoingCount = 4000;
            } else if (selectedFilter1 == 'Company 2') {
              visitedCount = 25000;
              notVisitedCount = 6000;
              ongoingCount = 4800;
            } else if (selectedFilter1 == 'All') {
              visitedCount = 60000;
              notVisitedCount = 15000;
              ongoingCount = 8800;
            }
            break;
        }

        int total = visitedCount + notVisitedCount + ongoingCount;
        String displayText =
            'Filters applied:\nSales Person: $selectedFilter1\nDate: $selectedFilter2\nVisited: $visitedCount\nNot Visited: $notVisitedCount\nOngoing: $ongoingCount\nTotal: $total';

        Map<String, double> dataMap = {
          'Visited': visitedCount.toDouble(),
          'Not Visited': notVisitedCount.toDouble(),
          'Ongoing': ongoingCount.toDouble(),
        };

        emit(state.copyWith(
          selectedFilter1: selectedFilter1,
          selectedFilter2: selectedFilter2,
          displayText: displayText,
          visitedCount: visitedCount,
          notVisitedCount: notVisitedCount,
          ongoingCount: ongoingCount,
          total: total,
          dataMap: dataMap,
        ));
      }
    });
  }
}
