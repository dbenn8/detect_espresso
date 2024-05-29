import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger_constant.g.dart';

@riverpod
Logger logger(LoggerRef ref) => Logger();
