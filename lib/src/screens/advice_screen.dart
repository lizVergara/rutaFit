import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/advice_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/advice_skeleton_card.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AdviceController());

    return Scaffold(
      body: Obx(() {
        if (!ctrl.loading.value && ctrl.adviceList.isEmpty) {
          return Center(
            child: ElevatedButton(
              onPressed: ctrl.fetchAdvice,
              child: const Text('Cargar consejos'),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: ctrl.fetchAdvice,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
            itemCount: 10,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              if (ctrl.loading.value) return const AdviceSkeletonCard();
              final tip = ctrl.adviceList[i];
              return AnimationConfiguration.staggeredList(
                position: i,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () async {
                          final uri = Uri.parse(tip.url);
                          try {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          } catch (_) {
                            Get.snackbar(
                                'Error', 'No se pudo abrir el navegador');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor:
                                    AppColors.primary.withOpacity(0.12),
                                child: const Icon(Icons.favorite,
                                    color: AppColors.primary, size: 24),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  tip.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              const Icon(Icons.search,
                                  color: AppColors.textLight),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
