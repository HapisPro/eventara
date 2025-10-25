import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventara/core/app_snackbar_widget.dart';
import 'package:eventara/data/models/event_model.dart';
import 'package:eventara/features/add_event/widgets/date_picker_field.dart';
import 'package:eventara/features/add_event/widgets/image_upload_box.dart';
import 'package:eventara/features/add_event/widgets/time_picker_field.dart';
import 'package:eventara/features/auth/widgets/custom_text_field.dart';
import 'package:eventara/features/auth/widgets/primary_button.dart';
import 'package:eventara/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:eventara/data/state/event_state.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _ticketController = TextEditingController();
  final _organizerController = TextEditingController();
  final _contactController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _ticketController.dispose();
    _organizerController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? xfile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 80,
    );
    if (xfile != null) {
      setState(() {
        _pickedImage = File(xfile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Consumer<EventProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EventSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBarWidget.showSuccess(context, state.message);
              _resetForm();
              provider.reset();
            });
          }

          if (state is EventError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBarWidget.showError(context, state.message);

              provider.reset();
            });
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ImageUploadBox(
                    image: _pickedImage,
                    onTap: _pickImageFromGallery,
                    placeholderText: "Upload Gambar Event",
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle("Informasi Event", theme),
                  const SizedBox(height: 12),

                  CustomTextField(
                    controller: _titleController,
                    label: "Nama Event",
                    icon: Icons.event_rounded,
                    validator: (v) =>
                        v!.isEmpty ? "Nama event wajib diisi" : null,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _descController,
                    label: "Deskripsi",
                    maxLines: 3,
                    icon: Icons.description_rounded,
                    validator: (v) =>
                        v!.isEmpty ? "Deskripsi wajib diisi" : null,
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle("Lokasi", theme),
                  const SizedBox(height: 12),

                  CustomTextField(
                    controller: _addressController,
                    label: "Alamat Lengkap",
                    icon: Icons.place_rounded,
                    validator: (v) => v!.isEmpty ? "Alamat wajib diisi" : null,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _cityController,
                          label: "Kota",
                          icon: Icons.location_city_rounded,
                          validator: (v) =>
                              v!.isEmpty ? "Kota wajib diisi" : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomTextField(
                          controller: _provinceController,
                          label: "Provinsi",
                          icon: Icons.map_rounded,
                          validator: (v) =>
                              v!.isEmpty ? "Provinsi wajib diisi" : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle("Jadwal", theme),
                  const SizedBox(height: 12),

                  DatePickerField(
                    selectedDate: selectedDate,
                    onDateSelected: (date) =>
                        setState(() => selectedDate = date),
                    label: "Pilih tanggal event",
                  ),
                  const SizedBox(height: 16),

                  TimePickerField(
                    selectedTime: selectedTime,
                    onTimeSelected: (time) =>
                        setState(() => selectedTime = time),
                    label: "Pilih jam dimulai",
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle("Tiket & Kontak", theme),
                  const SizedBox(height: 12),

                  CustomTextField(
                    controller: _ticketController,
                    label: "Harga Tiket",
                    icon: Icons.confirmation_number_rounded,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v!.isEmpty ? "Harga tiket wajib diisi" : null,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _organizerController,
                    label: "Penyelenggara",
                    icon: Icons.people_rounded,
                    validator: (v) =>
                        v!.isEmpty ? "Penyelenggara wajib diisi" : null,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _contactController,
                    label: "Kontak",
                    icon: Icons.phone_rounded,
                    keyboardType: TextInputType.phone,
                    validator: (v) => v!.isEmpty ? "Kontak wajib diisi" : null,
                  ),
                  const SizedBox(height: 32),

                  PrimaryButton(
                    text: "Simpan Event",
                    onPressed: () => _submit(context, provider),
                    isLoading: false,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }

  Future<void> _submit(BuildContext context, EventProvider provider) async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDate == null) {
      AppSnackBarWidget.showWarning(context, "Silahkan pilih tanggal event");
      return;
    }

    if (selectedTime == null) {
      AppSnackBarWidget.showWarning(context, "Silahkan pilih jam mulai");
      return;
    }

    final eventDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    final docRef = _firestore.collection('events').doc();
    final event = EventModel(
      id: docRef.id,
      title: _titleController.text,
      description: _descController.text,
      address: _addressController.text,
      city: _cityController.text,
      province: _provinceController.text,
      ticketInfo: _ticketController.text,
      date: selectedDate!,
      startTime: eventDateTime,
      organizer: _organizerController.text,
      contact: _contactController.text,
      imageUrl: null,
    );

    await provider.addEventToFireStore(event, imageFile: _pickedImage);
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _descController.clear();
    _addressController.clear();
    _cityController.clear();
    _provinceController.clear();
    _ticketController.clear();
    _organizerController.clear();
    _contactController.clear();
    setState(() {
      _pickedImage = null;
      selectedDate = null;
      selectedTime = null;
    });
  }
}
