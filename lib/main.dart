import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_programming/app/data/repositories_impl/auth_repository_impl.dart';
import 'package:functional_programming/app/data/repositories_impl/exchange_repository_impl.dart';
import 'package:functional_programming/app/data/repositories_impl/ws_repository_impl.dart';
import 'package:functional_programming/app/data/services/remote/exchange_api.dart';
import 'package:functional_programming/app/domain/repositories/auth_repository.dart';
import 'package:functional_programming/app/domain/repositories/exchange_repository.dart';
import 'package:functional_programming/app/domain/repositories/ws_repository.dart';
import 'package:functional_programming/app/presentation/modules/global/blocs/session/session_bloc.dart';
import 'package:functional_programming/app/presentation/modules/global/blocs/session/session_state.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'es_ES';
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(),
        ),
        Provider<ExchangeRepository>(
          create: (_) => ExChangeRepositoryImpl(
            ExchangeAPI(
              Client(),
            ),
          ),
        ),
        Provider<WsRepository>(
          create: (_) => WsRepositoryImpl(
            (ids) => WebSocketChannel.connect(
              Uri.parse("wss://ws.coincap.io/prices?assets=${ids.join(',')}"),
            ),
          ),
        ),
      ],
      child: BlocProvider<SessionBloc>(
        create: (_) => SessionBloc(
          SessionState(),
        ),
        child: const MyApp(),
      ),
    ),
  );
}
