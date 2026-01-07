# Fetch secrets from AWS Secrets Manager

This composite action fetches a secret (such as an SSH private key or API token) from AWS Secrets Manager. It supports both plain text secrets and JSON-formatted secrets.

## Inputs

| Input | Description | Required |
| :--- | :--- | :--- |
| `secret` | The AWS Secrets Manager secret ID where the secret is stored. | **true** |
| `key` | The key name in the secret JSON to extract. If the secret is stored as a plain string, leave this empty or unused. | `false` |

## Outputs

| Output | Description |
| :--- | :--- |
| `key` | The value fetched from Secrets Manager if treated as a raw string (or if JSON parsing fails). |
| `token` | The value extracted from the JSON secret if the `key` input was provided and found. |

## Usage

Ensure you have configured AWS credentials before running this action.

```yaml
steps:
  - name: Configure AWS credentials
    uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::123456789012:role/my-role
      aws-region: us-east-1

  - name: Fetch SSH Key
    id: fetch_secret
    uses: ./.github/actions/secrets
    with:
      secret: my-secret-name
      key: private_key # Optional: Use only if secret is a JSON object

  - name: Use the secret
    run: echo "Secret is available"
    env:
      MY_SECRET: ${{ steps.fetch_secret.outputs.key }}
```