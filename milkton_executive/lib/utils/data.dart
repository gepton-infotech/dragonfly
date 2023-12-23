final DateTime _today = DateTime.now();
final _serverDate = _today.add(const Duration(minutes: 210));
final String today =
    "${_serverDate.day.toString().padLeft(2, '0')}-${_serverDate.month.toString().padLeft(2, '0')}-${_serverDate.year.toString().padLeft(2, '0')}";
