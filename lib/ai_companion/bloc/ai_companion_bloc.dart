import 'package:ai_client/ai_client.dart';
import 'package:ai_repository/ai_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:uuid/uuid.dart';

part 'ai_companion_event.dart';
part 'ai_companion_state.dart';

/// {@template ai_companion_bloc}
/// BLoC for managing AI companion chat with state persistence.
/// {@endtemplate}
class AiCompanionBloc extends HydratedBloc<AiCompanionEvent, AiCompanionState> {
  /// {@macro ai_companion_bloc}
  AiCompanionBloc({
    required AIRepository aiRepository,
  })  : _aiRepository = aiRepository,
        super(const AiCompanionState()) {
    on<AiCompanionStarted>(_onStarted);
    on<AiCompanionMessageSent>(_onMessageSent);
    on<AiCompanionConversationCleared>(_onConversationCleared);
    on<AiCompanionConversationLoaded>(_onConversationLoaded);
  }

  final AIRepository _aiRepository;
  static const _uuid = Uuid();

  Future<void> _onStarted(
    AiCompanionStarted event,
    Emitter<AiCompanionState> emit,
  ) async {
    emit(state.copyWith(status: AiCompanionStatus.loading));

    try {
      // Try to load last conversation or create new one
      var conversationId = await _aiRepository.getLastConversationId();

      if (conversationId == null) {
        conversationId = _uuid.v4();
        await _aiRepository.setLastConversationId(conversationId);
      }

      final messages = await _aiRepository.getConversation(
        conversationId: conversationId,
      );

      emit(
        state.copyWith(
          status: AiCompanionStatus.ready,
          conversationId: conversationId,
          messages: messages,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AiCompanionStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onMessageSent(
    AiCompanionMessageSent event,
    Emitter<AiCompanionState> emit,
  ) async {
    if (state.conversationId == null) return;

    final conversationId = state.conversationId!;

    try {
      // Update UI to show streaming status
      emit(
        state.copyWith(
          status: AiCompanionStatus.streaming,
          streamingMessage: '',
        ),
      );

      // Stream AI response
      final responseBuffer = StringBuffer();

      await for (final chunk in _aiRepository.sendMessage(
        message: event.message,
        conversationId: conversationId,
      )) {
        responseBuffer.write(chunk);
        emit(
          state.copyWith(
            status: AiCompanionStatus.streaming,
            streamingMessage: responseBuffer.toString(),
          ),
        );
      }

      // Load updated conversation after streaming completes
      final updatedMessages = await _aiRepository.getConversation(
        conversationId: conversationId,
      );

      emit(
        state.copyWith(
          status: AiCompanionStatus.ready,
          messages: updatedMessages,
          streamingMessage: '',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AiCompanionStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onConversationCleared(
    AiCompanionConversationCleared event,
    Emitter<AiCompanionState> emit,
  ) async {
    if (state.conversationId == null) return;

    try {
      await _aiRepository.clearConversation(
        conversationId: state.conversationId!,
      );

      emit(
        state.copyWith(
          messages: [],
          streamingMessage: '',
          status: AiCompanionStatus.ready,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AiCompanionStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onConversationLoaded(
    AiCompanionConversationLoaded event,
    Emitter<AiCompanionState> emit,
  ) async {
    emit(state.copyWith(status: AiCompanionStatus.loading));

    try {
      final messages = await _aiRepository.getConversation(
        conversationId: event.conversationId,
      );

      await _aiRepository.setLastConversationId(event.conversationId);

      emit(
        state.copyWith(
          status: AiCompanionStatus.ready,
          conversationId: event.conversationId,
          messages: messages,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AiCompanionStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  @override
  AiCompanionState? fromJson(Map<String, dynamic> json) {
    try {
      final messagesJson = json['messages'] as List<dynamic>?;
      final messages = messagesJson
              ?.map((e) => AIMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      return AiCompanionState(
        status: AiCompanionStatus.values.byName(
          json['status'] as String? ?? 'initial',
        ),
        messages: messages,
        conversationId: json['conversationId'] as String?,
        streamingMessage: json['streamingMessage'] as String? ?? '',
      );
    } catch (_) {
      // If deserialization fails, return initial state
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AiCompanionState state) {
    // Don't persist error or streaming states
    if (state.status == AiCompanionStatus.failure ||
        state.status == AiCompanionStatus.loading) {
      return null;
    }

    return {
      'status': state.status.name,
      'messages': state.messages.map((m) => m.toJson()).toList(),
      'conversationId': state.conversationId,
      'streamingMessage': '', // Don't persist partial streaming messages
    };
  }
}
