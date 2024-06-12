import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/remote/place_api_data_source.dart';
import '../../../domain/utils/place_suggestions.dart';
import '../../../bloc/create_schedule_bloc.dart';

class PlacesSearchBar extends StatefulWidget {
  const PlacesSearchBar({super.key});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<PlacesSearchBar> {
  final _searchController = TextEditingController();
  List<String> _searchResults = [];
  String? _selectedResult; // Variable to track the selected item
  final PlaceApiDataSource _dataSource = PlaceApiDataSource(Dio());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(30.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search your address',
              prefixIcon: const Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onSubmitted: (value) {
              _fetchPlaceSuggestions(value);
            },
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return RadioListTile<String>(
                title: Text(_searchResults[index]),
                value: _searchResults[index],
                groupValue: _selectedResult,
                onChanged: (value) {
                  setState(() {
                    _selectedResult = value;
                    context.read<CreateScheduleBloc>().add(LocationStageStarted(startLocation:value!));
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _fetchPlaceSuggestions(String query) async {
    if (query.isNotEmpty) {
      try {
        String jsonResponse = await _dataSource.fetchPlaceSuggestions(query);
        List<String> mainTexts = PlaceSuggestions.getMainTexts(jsonResponse);
        setState(() {
          _searchResults = mainTexts;
          _selectedResult = null; // Reset selection on new search
        });
      } catch (e) {
        print('Failed to fetch place suggestions: $e');
      }
    }
  }
}
