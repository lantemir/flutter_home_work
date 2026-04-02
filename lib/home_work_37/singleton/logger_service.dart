class LoggerService {
  LoggerService._internal() {
    _instanceCreatedCount++;
  }

  static final LoggerService _instance = LoggerService._internal();

  factory LoggerService() => _instance;

  static int _instanceCreatedCount = 0;

  static int get instanceCreatedCount => _instanceCreatedCount;

  final List<String> _logs = [];

  List<String> get logs => List.unmodifiable(_logs);

  void log(String message) {
    final entry = '[LOG] $message';
    _logs.insert(0, entry);
  }

  void clear() {
    _logs.clear();
  }
}
