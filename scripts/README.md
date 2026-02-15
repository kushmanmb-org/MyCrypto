# Security Management Scripts

This directory contains scripts for managing security rulesets and configurations in the MyCrypto repository.

## Available Scripts

### manage-security-rulesets.sh

A comprehensive script for managing GitHub repository rulesets.

**Prerequisites:**
- [GitHub CLI (gh)](https://cli.github.com/) installed
- Authenticated with GitHub CLI (`gh auth login`)
- Admin permissions on the repository

**Usage:**

```bash
# Check dependencies and validate ruleset files
./scripts/manage-security-rulesets.sh check

# List current rulesets in the repository
./scripts/manage-security-rulesets.sh list

# Apply all rulesets
./scripts/manage-security-rulesets.sh apply

# Delete a specific ruleset (by ID)
./scripts/manage-security-rulesets.sh delete 12345

# Update a specific ruleset (by ID)
./scripts/manage-security-rulesets.sh update 12345 .github/rulesets/branch-protection.json

# Show help
./scripts/manage-security-rulesets.sh help
```

**Environment Variables:**

- `REPO_OWNER`: Repository owner (default: `kushmanmb-org`)
- `REPO_NAME`: Repository name (default: `MyCrypto`)

**Example with custom repository:**

```bash
REPO_OWNER="myorg" REPO_NAME="myrepo" ./scripts/manage-security-rulesets.sh apply
```

## Setting Up Security Rulesets

### 1. Validate Configuration

First, validate that all ruleset files are correctly formatted:

```bash
./scripts/manage-security-rulesets.sh check
```

### 2. Review Rulesets

Review the ruleset configurations in `.github/rulesets/`:
- `branch-protection.json` - Branch protection for main/master
- `release-tag-protection.json` - Tag protection for releases

### 3. Apply Rulesets

Apply the rulesets to your repository:

```bash
./scripts/manage-security-rulesets.sh apply
```

### 4. Verify Application

Check that rulesets were applied successfully:

```bash
./scripts/manage-security-rulesets.sh list
```

You can also verify in GitHub UI:
1. Go to repository Settings
2. Navigate to Rules → Rulesets
3. Verify that rulesets are listed and active

## Troubleshooting

### "Not authenticated with GitHub CLI"

Run: `gh auth login` and follow the prompts.

### "Failed to apply ruleset"

Possible reasons:
- You don't have admin permissions on the repository
- The ruleset already exists (use `update` command instead)
- The repository is a fork (rulesets can't be applied to forks)
- The API endpoint returned an error (check GitHub status)

### "Ruleset already exists"

If a ruleset already exists, you need to update it instead:

1. List rulesets to get the ID: `./scripts/manage-security-rulesets.sh list`
2. Update the ruleset: `./scripts/manage-security-rulesets.sh update <ID> <file>`

## Manual Application

If you prefer not to use the script, you can apply rulesets manually:

### Via GitHub Web UI

1. Go to repository Settings
2. Navigate to Rules → Rulesets
3. Click "New ruleset" or "Import a ruleset"
4. Upload the JSON files from `.github/rulesets/`

### Via GitHub CLI

```bash
# Apply branch protection
gh api repos/kushmanmb-org/MyCrypto/rulesets \
  --method POST \
  --input .github/rulesets/branch-protection.json

# Apply tag protection
gh api repos/kushmanmb-org/MyCrypto/rulesets \
  --method POST \
  --input .github/rulesets/release-tag-protection.json
```

### Via curl

```bash
# Apply branch protection
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR_TOKEN>" \
  https://api.github.com/repos/kushmanmb-org/MyCrypto/rulesets \
  -d @.github/rulesets/branch-protection.json
```

## Best Practices

1. **Test First**: Start with `enforcement: "evaluate"` to test without blocking
2. **Review Impact**: Consider existing workflows before applying rules
3. **Communicate**: Inform team members before applying restrictive rules
4. **Document**: Keep ruleset documentation up-to-date
5. **Monitor**: Regularly check ruleset effectiveness

## Additional Resources

- [GitHub Rulesets Documentation](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)
- [Security Rulesets Guide](../.github/SECURITY_RULESETS.md)
- [Rulesets Configuration](../.github/rulesets/README.md)
