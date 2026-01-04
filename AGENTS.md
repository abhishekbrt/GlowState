# AI Agent Rules

## Stack & Skills
- **Riverpod** (primary) + `@riverpod` codegen | **Mocktail** (NOT mockito) | **Feature-first** architecture
- Skills: [.opencode/skill/SKILL.md](.opencode/skill/SKILL.md)

## Git Protocol (CRITICAL)
- Running in **Git Worktree** - stay in current directory only
- **NO** `rebase`, `merge main`, or commands affecting global history
- Commits: atomic, format `Type: Description`
- On conflict → **STOP**, ask for instructions

## Quality Gates (MUST PASS)
```bash
flutter analyze --fatal-infos  # Fix ALL before proceeding
dart format --set-exit-if-changed .
flutter test                   # Never delete tests to pass
```

## TDD Protocol (FORBIDDEN to skip)
1. **RED**: Interface → Test → Shell with `throw UnimplementedError()` → STOP, ask user to run test
2. **GREEN**: Minimum code to pass → STOP, ask user to run test  
3. **REFACTOR**: Clean up, ensure tests pass

## Architecture Rules
- **NEVER** instantiate concrete classes in widgets
- `ref.watch()` in `build()`, `ref.read()` in callbacks
- Domain layer: NO Flutter imports, NO external packages (pure Dart)
- **DO NOT** modify `main.dart` or core providers without authorization

## Code Generation
```bash
dart run build_runner build --delete-conflicting-outputs
```
Run after `@riverpod`, `@freezed`, `@JsonSerializable` changes. Never edit `.g.dart` files.

## Security
**NEVER commit**: `.env`, API keys, `google-services.json`, credentials

## Error Protocol
| Situation | Action |
|-----------|--------|
| Merge conflict / Build error | **STOP** - ask for instructions |
| Test failure | Fix implementation, never delete test |

## Definition of Done
- [ ] `analyze` + `format` + `test` pass
- [ ] Codegen run (if applicable)
- [ ] Committed + pushed
