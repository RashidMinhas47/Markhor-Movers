import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markhor_movers/riverpod/riverpod_providers.dart';

class RiverpodHome extends ConsumerStatefulWidget {
  const RiverpodHome({super.key});
  static const String scr = '/RiverpodHome';
  @override
  ConsumerState<RiverpodHome> createState() => _RiverpodHomeState();
}

final number = StateProvider<int>((ref) => 0);
final name = StateProvider<String>((ref) => 'Rashid Minhas Sheikh');
final jsonData = StateProvider<List<Map<String, dynamic>>>((ref) => [
      {'name': 'Rashid', 'class': 9},
      {'name': 'Ejaz sindhi', 'class': 8}
    ]);

class _RiverpodHomeState extends ConsumerState<RiverpodHome> {
  @override
  Widget build(BuildContext context) {
    // final newName = ref.watch(jsonData.select((value) => null));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riverpod Home',
          style: GoogleFonts.inter(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              ref.watch(name).toString(),
              style: GoogleFonts.inter(fontSize: 30),
            ),
            Text(
              ref.watch(number).toString(),
              style: GoogleFonts.inter(fontSize: 30),
            ),
            TextField(
              style: GoogleFonts.inter(fontSize: 24),
              onChanged: (value) {},
            ),
            // Text("${ref.watch(jsonData[0]['name'])} hello dear!"),
            Consumer(builder: (builder, ref, child) {
              return ref.read(userData).when(data: (data) {
                return Text(data);
              }, error: (error, stk) {
                return Text(error.toString());
              }, loading: () {
                return const CircularProgressIndicator();
              });
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(number.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
