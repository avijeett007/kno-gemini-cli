#!/bin/bash

# This script simulates the GitHub Action environment locally for testing the kno-gemini-cli.
#
# Prerequisites:
# 1. Your kno-gemini-cli project is built (npm run build).
# 2. Your sample_cred.json file is in the project root.
# 3. You have Node.js installed.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Starting Local Test Simulation ---"

# 1. Set the GEMINI_OAUTH_CREDENTIALS_JSON environment variable
# This reads the content of your sample_cred.json file and sets it as an environment variable.
# The 'tr -d "\n\r"' removes newlines, ensuring it's a single line for the environment variable.
echo "Setting GEMINI_OAUTH_CREDENTIALS_JSON environment variable..."
export GEMINI_OAUTH_CREDENTIALS_JSON=$(cat sample_cred.json | tr -d "\n\r")

# 2. Define a sample diff content (replace with your actual diff if needed)
# This simulates the ${{ steps.pr_diff.outputs.diff }} from the GitHub Action.
echo "Defining sample diff content..."
SAMPLE_DIFF=$(cat << 'EOF_DIFF'
diff --git a/README.md b/README.md
index 7300e45..b2b1f10 100644
--- a/README.md
+++ b/README.md
@@ -2,6 +2,25 @@
 
 This is a test change for local review.
EOF_DIFF
)

# 3. Construct the full review prompt
# This mimics the 'review_prompt' variable in the GitHub Action.
echo "Constructing review prompt..."
REVIEW_PROMPT="You are an expert software engineer. Review the following code changes for potential bugs, style issues, and improvements. Provide your feedback as a list of concise points. Diff:\n\n${SAMPLE_DIFF}"

# 4. Escape the prompt for safe passing as a command-line argument
# This mimics the 'ESCAPED_PROMPT=$(printf %q "$review_prompt")' in the GitHub Action.
echo "Escaping prompt for command-line argument..."
ESCAPED_PROMPT=$(printf %q "$REVIEW_PROMPT")

# 5. Run your kno-gemini-cli with the escaped prompt
# Make sure the path to 'dist/index.js' is correct relative to your current directory.
# This will execute your modified CLI.
echo "Running kno-gemini-cli locally..."
./packages/cli/dist/index.js -p "$ESCAPED_PROMPT"

echo "--- Local Test Simulation Complete ---"
