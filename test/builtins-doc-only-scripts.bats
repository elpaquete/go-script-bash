#! /usr/bin/env bats
#
# These scripts exist to provide help documentation and a uniform means of
# listing all builtin commands via a glob (to aid with 'go help builtins' and
# tab completion), but should never be executed, as their corresponding commands
# are implemented in the @go and environment functions.
#
# Though these scripts should never get executed, these tests ensure they fail
# loudly in case something goes wrong and they are.

setup() {
  declare -g TEST_GO_SCRIPT="$BATS_TMPDIR/go"
  echo . "$_GO_ROOTDIR/go-core.bash" '.' >>"$TEST_GO_SCRIPT"

  # Avoid having to fold our test strings.
  COLUMNS='1000'
}

@test "builtin 'edit' script should exit with an error" {
  echo "_@go.source_builtin 'edit'" >>"$TEST_GO_SCRIPT"
  run "$BASH" "$TEST_GO_SCRIPT"
  [[ "$status" -eq '1' ]]

  local expected="ERROR: \"$TEST_GO_SCRIPT edit\" "
  expected+='is implemented directly within the @go function.'
  [[ "$output" = "$expected" ]]
}

@test "builtin 'run' script should exit with an error" {
  echo "_@go.source_builtin 'run'" >>"$TEST_GO_SCRIPT"
  run "$BASH" "$TEST_GO_SCRIPT"
  [[ "$status" -eq '1' ]]

  local expected="ERROR: \"$TEST_GO_SCRIPT run\" "
  expected+='is implemented directly within the @go function.'
  [[ "$output" = "$expected" ]]
}

@test "builtin 'unenv' script should exit with an error" {
  echo "_@go.source_builtin 'unenv'" >>"$TEST_GO_SCRIPT"
  run "$BASH" "$TEST_GO_SCRIPT"
  [[ "$status" -eq '1' ]]

  local expected="ERROR: \"$TEST_GO_SCRIPT unenv\" "
  expected+='is implemented in the function generated by '
  expected+="\"$TEST_GO_SCRIPT env\"."
  echo "EXPECTED: '$expected'" >&2
  echo "ACTUAL:   '$output'" >&2
  [[ "$output" = "$expected" ]]
}

teardown() {
  rm "$TEST_GO_SCRIPT"
}
