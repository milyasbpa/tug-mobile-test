import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';

// ── Common test fixtures ─────────────────────────────────────────────────────
// Import this file in any test that needs shared test data.  Keeping fixtures
// in one place avoids magic strings scattered across the test suite.

/// A valid [AuthUser] returned by a successful login or register.
const tAuthUser = AuthUser(
  id: 1,
  email: 'test@example.com',
  token: 'mock-token-123',
);

/// A valid [AuthUser] sourced from stored token (no id — token-only flow).
const tStoredAuthUser = AuthUser(
  email: 'test@example.com',
  token: 'stored-token-456',
);

const tEmail = 'test@example.com';
const tPassword = 'password123';
