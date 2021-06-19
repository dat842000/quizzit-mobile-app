class PagingParam {
  int _page=1;
  int _pageSize=10;
  String _sort="id_asc";

  PagingParam({int page=1, int pageSize=3, String sort="id_asc"}) {
    _page = page;
    if (_page < 1)
      _page = 1;
    _pageSize = pageSize;
    if (_pageSize < 3)
      _pageSize = 3;
    _sort = sort;
    if (_sort == null || _sort.trim().isEmpty)
      _sort = "id_asc";
  }

  Map<String, String> build() {
    if (_page < 1) _page = 1;
    if (_pageSize < 3) _pageSize = 3;
    return {
      'Page': _page.toString(),
      'PageSize': _pageSize.toString(),
      'Sort': _sort
    };
  }
}
