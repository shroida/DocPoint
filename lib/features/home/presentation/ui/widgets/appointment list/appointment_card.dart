import 'package:docpoint/core/widgets/app_snackbar.dart';
import 'package:docpoint/features/home/domain/usecase/update_status_usecase.dart';
import 'package:docpoint/features/payment/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

class DetailedAppointmentCard extends StatefulWidget {
  final AppointmentEntity appointment;
  final String userType;
  final VoidCallback onStatusUpdated;

  const DetailedAppointmentCard({
    super.key,
    required this.appointment,
    required this.userType,
    required this.onStatusUpdated,
  });

  @override
  State<DetailedAppointmentCard> createState() =>
      _DetailedAppointmentCardState();
}

class _DetailedAppointmentCardState extends State<DetailedAppointmentCard> {
  bool loading = false;
  Future<bool> _makePayment({required int price}) async {
    try {
      setState(() => loading = true);

      // Create a PaymentIntent
      final paymentIntent = await StripeService.createPaymentIntent(
        amount: (price * 100).toString(),
        currency: 'usd',
      );

      // Initialize the Payment Sheet
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Walied Store',
        ),
      );

      // Present the Payment Sheet
      await stripe.Stripe.instance.presentPaymentSheet();

      if (mounted) {
        showAppSnackBar(
          message: "Payment successful!",
          context: context,
          backgroundColor: Colors.green,
        );
      }
      return true; // Payment succeeded
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
      return false; // Payment failed
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildMainInfo(),
            if (_hasNotes) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Text(
                'Notes',
                style: AppStyle.body1.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(widget.appointment.notes!, style: AppStyle.body2),
            ],
            if (_showActions) ...[
              const SizedBox(height: 16),
              _buildActionButtons(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusChip(widget.appointment.status),
        Text(
          DateFormat('MMM dd, yyyy').format(widget.appointment.appointmentTime),
          style: AppStyle.body2.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildMainInfo() {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: _confirmedAndWaitToPat ? 180.h : 60.h,
          decoration: BoxDecoration(
            color: _getStatusColor(widget.appointment.status),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.appointment.category, style: AppStyle.heading3),
              const SizedBox(height: 4),
              Text(
                widget.userType == 'Doctor'
                    ? 'Patient: ${widget.appointment.patientName}'
                    : 'Dr. ${widget.appointment.doctorName}',
                style: AppStyle.body1.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('hh:mm a')
                        .format(widget.appointment.appointmentTime),
                    style: AppStyle.body2,
                  ),
                  if (widget.appointment.duration != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      '• ${widget.appointment.duration!.inMinutes} mins',
                      style: AppStyle.body2,
                    ),
                  ],
                ],
              ),
              if (_confirmedAndWaitToPat && !_paidSuccessed) ...[
                const SizedBox(height: 16),
                _buildPaymentSection(),
              ] else if (_paidSuccessed) ...[
                const SizedBox(height: 16),
                _buildPaidSuccessWidget(),
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaidSuccessWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Received',
                  style: AppStyle.body1.copyWith(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You have successfully paid \$${widget.appointment.price?.toStringAsFixed(2) ?? "0.00"} for this appointment.',
                  style:
                      AppStyle.body2.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointment Fee',
            style: AppStyle.body1.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${widget.appointment.price!.toStringAsFixed(2)}',
                style: AppStyle.heading2.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final success = await _makePayment(
                    price: widget.appointment.price ?? 0,
                  );

                  if (success) {
                    if (mounted) {
                      context
                          .read<HomePageCubit>()
                          .paidSuccessed(appointmentId: widget.appointment.id);
                    }
                  } else {
                    if (mounted) {
                      showAppSnackBar(context: context, message: 'Pay not ');
                    }
                  }
                },
                style: AppStyle.primaryButton.copyWith(
                  backgroundColor: WidgetStateProperty.all(AppColors.primary),
                ),
                icon: const Icon(Icons.payment, color: Colors.white),
                label: const Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: AppStyle.body2.copyWith(color: color),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check, color: Colors.white),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () => _updateStatus(context, 'confirmed'),
          label: const Text('Accept', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          icon: const Icon(Icons.cancel, color: Colors.white),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => _updateStatus(context, 'cancelled'),
          label: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _updateStatus(BuildContext context, String status) async {
    await context.read<HomePageCubit>().updateStatusAppointment(
          UpdateStatusParams(
            appointmentId: widget.appointment.id,
            status: status,
          ),
        );
    widget.onStatusUpdated();
  }

  bool get _hasNotes =>
      widget.appointment.notes != null && widget.appointment.notes!.isNotEmpty;

  bool get _confirmedAndWaitToPat =>
      widget.appointment.price != null && widget.appointment.price != 0;
  bool get _paidSuccessed => (widget.appointment.paid ?? false);

  bool get _showActions =>
      widget.userType == 'Doctor' &&
      widget.appointment.status.toLowerCase() == 'pending';
}
