import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_events.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


const colors = <String, Color>{
  'BTC': Colors.orange,
  'ETH': Colors.deepPurple,
  'USDT': Colors.green,
  'BNB': Colors.yellow,
  'USDC': Colors.blue,
  'DOGE': Colors.amber,
  'LTC': Colors.grey,
  'XMR': Colors.deepOrangeAccent,
  'TOMO': Colors.black,
};

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();

    return bloc.state.maybeWhen(
        orElse: () => const SizedBox(),
        loaded: (cryptos, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemBuilder: (_, index) {
              final crypto = cryptos[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: Dismissible(
                    key: Key(crypto.id),
                    onDismissed: (_) => context.read<HomeBloc>().add(
                      DeleteEvent(crypto)
                    ),
                    background: Container(color: Colors.red,),
                    child: ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/${crypto.symbol}.svg',
                              width: 30,
                              height: 30,
                              color: colors[crypto.symbol],
                            ),
                          ],
                        ),
                        title: Text(crypto.name),
                        subtitle: Text(crypto.symbol),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                NumberFormat.currency(name: r'$')
                                    .format(crypto.price),
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              '${crypto.changePercent24Hr.toStringAsFixed(2)}%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (crypto.changePercent24Hr.isNegative)
                                    ? Colors.redAccent
                                    : Colors.green,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              );
            },
            itemCount: cryptos.length,
          );
        });
  }
}
