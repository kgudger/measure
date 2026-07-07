import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_provider.g.dart';

@riverpod
class CurrentPageIndex extends _$CurrentPageIndex {
  @override
  int build() => 0; 

  void setPage(int index) {
    state = index; 
  }
}
