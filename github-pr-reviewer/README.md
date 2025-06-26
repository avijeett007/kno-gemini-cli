# Gemini PR Reviewer GitHub Action

This GitHub Action uses the Gemini CLI to automatically review pull requests and post comments with feedback.

## How to Use

This action uses the credentials from the interactive "Login with Google" flow. You will need to find the credential file on your local machine and copy its contents into a GitHub secret.

**Security Warning:** This method involves storing sensitive, high-privilege credentials (including a refresh token) as a GitHub secret. This is not a standard practice and carries security risks. Please ensure you understand the implications before proceeding.

1.  **Authenticate with Gemini CLI Locally:**
    *   If you haven't already, install the Gemini CLI and authenticate by running `gemini` and following the "Login with Google" prompts.

2.  **Locate Your OAuth Credentials File:**
    *   The credentials are stored in a JSON file on your local system.
    *   The path to this file is: `~/.gemini/oauth_creds.json` (where `~` is your home directory).

3.  **Copy the Credential Content:**
    *   Open the `oauth_creds.json` file in a text editor.
    *   Copy the entire JSON content of the file to your clipboard.

4.  **Set up GitHub Secrets:**
    *   In the GitHub repository where you want to use this action, navigate to `Settings > Secrets and variables > Actions`.
    *   Click `New repository secret`.
    *   Create a secret named `GEMINI_OAUTH_CREDENTIALS_JSON` and paste the JSON content you copied from the `oauth_creds.json` file.
    *   **Important:** The content should be a single line of JSON. It should look something like this (your values will be different):
    *   ```json
      {"access_token":"ya29.a0Af...","refresh_token":"1//0g...","scope":"https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile","token_type":"Bearer","expiry_date":1729...}
      ```

5.  **Add the Workflow File:**
    *   Copy the `.github/workflows/pr-review.yml` file from this directory into the `.github/workflows` directory of your repository.

6.  **Create a `GEMINI.md` (Optional but Recommended):**
    *   To provide specific coding standards, project context, or review guidelines, create a `GEMINI.md` file in the root of your repository. The action will automatically use this file to inform its review, leading to more relevant feedback.

## How it Works

The action is triggered on every pull request. It performs the following steps:

1.  Checks out the repository.
2.  Calculates the diff of the pull request.
3.  Installs a modified version of the Gemini CLI.
4.  Runs the Gemini CLI in non-interactive mode, using the `GEMINI_OAUTH_CREDENTIALS_JSON` secret to authenticate. It passes the code diff and a prompt to review the code.
5.  Posts the output from the Gemini CLI as a comment on the pull request using the `gh` CLI, which is authenticated with the default `GITHUB_TOKEN`.