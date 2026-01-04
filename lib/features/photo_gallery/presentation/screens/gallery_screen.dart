import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glowstate/core/widgets/error_view.dart';
import 'package:glowstate/core/widgets/loading_indicator.dart';
import 'package:glowstate/features/photo_gallery/presentation/providers/photo_gallery_provider.dart';
import 'package:glowstate/features/photo_gallery/presentation/widgets/photo_grid_item.dart';
import 'package:glowstate/features/photo_gallery/presentation/widgets/photo_detail_sheet.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photoGalleryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Photos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => _showMonthPicker(context, ref),
          ),
        ],
      ),
      body: photosAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, stack) => ErrorView(
          message: 'Failed to load photos: $error',
          onRetry: () => ref.read(photoGalleryProvider.notifier).refresh(),
        ),
        data: (photos) {
          if (photos.isEmpty) {
            return const _EmptyGalleryView();
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(photoGalleryProvider.notifier).refresh(),
            child: _PhotoGrid(photos: photos),
          );
        },
      ),
    );
  }

  void _showMonthPicker(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      ref
          .read(photoGalleryProvider.notifier)
          .loadPhotosForMonth(picked.year, picked.month);
    }
  }
}

class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid({required this.photos});

  final List<PhotoRecord> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return PhotoGridItem(
          photo: photo,
          onTap: () => _showPhotoDetail(context, photo),
        );
      },
    );
  }

  void _showPhotoDetail(BuildContext context, PhotoRecord photo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PhotoDetailSheet(photo: photo),
    );
  }
}

class _EmptyGalleryView extends StatelessWidget {
  const _EmptyGalleryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text('No photos yet', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Take your first photo to start\ntracking your glow up!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
