# GitHub Repository Rulesets

This directory contains GitHub repository ruleset configurations for managing branch protection, tag protection, and other security policies.

## Overview

Repository rulesets provide a centralized way to manage branch protection rules, tag protection, and other repository policies. These rulesets help ensure code quality, security, and collaboration standards.

## Rulesets

### 1. Branch Protection (`branch-protection.json`)

Protects the main/master branches with the following rules:

- **Pull Request Requirements**:
  - Minimum 1 approving review required
  - Stale reviews are dismissed when new commits are pushed
  - All review threads must be resolved before merging
  
- **Required Status Checks**:
  - CI validation must pass
  - Tests must pass
  - Code coverage requirements must be met (Codecov)
  - Status checks must be up-to-date before merging

- **Protection Rules**:
  - Branch deletion is prevented
  - Force pushes are blocked
  - Commit signatures are required

### 2. Release Tag Protection (`release-tag-protection.json`)

Protects release tags (v*, release-*) with the following rules:

- **Tag Creation**: Restricted to authorized users
- **Tag Deletion**: Prevented to maintain release history
- **Tag Updates**: Blocked to ensure release integrity

## Applying Rulesets

### Via GitHub Web Interface

1. Go to your repository settings
2. Navigate to "Rules" → "Rulesets"
3. Click "New ruleset" → "Import a ruleset"
4. Upload the JSON files from this directory

### Via GitHub CLI

```bash
# Create branch protection ruleset
gh api repos/{owner}/{repo}/rulesets \
  --method POST \
  --input .github/rulesets/branch-protection.json

# Create tag protection ruleset
gh api repos/{owner}/{repo}/rulesets \
  --method POST \
  --input .github/rulesets/release-tag-protection.json
```

### Via REST API

```bash
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <token>" \
  https://api.github.com/repos/{owner}/{repo}/rulesets \
  -d @.github/rulesets/branch-protection.json
```

## Customization

### Modifying Status Checks

Update the `required_status_checks` array in `branch-protection.json`:

```json
{
  "context": "your-check-name",
  "integration_id": null
}
```

### Adding Bypass Actors

To allow specific teams or users to bypass rules, modify the `bypass_actors` array:

```json
{
  "actor_id": 5,
  "actor_type": "Team",
  "bypass_mode": "pull_request"
}
```

Actor types:
- `RepositoryRole`: Repository admin (actor_id: 1), maintain (actor_id: 2), write (actor_id: 4), bypass (actor_id: 5)
- `Team`: Team within the organization
- `Integration`: GitHub Apps
- `OrganizationAdmin`: All organization admins

## Best Practices

1. **Start with Evaluate Mode**: Set `"enforcement": "evaluate"` initially to test rules without blocking
2. **Review Bypass Actors**: Minimize the number of users who can bypass rules
3. **Keep Status Checks Updated**: Ensure required status checks match your CI/CD workflows
4. **Monitor Rule Effectiveness**: Use GitHub Insights to track rule enforcement
5. **Document Exceptions**: If rules are bypassed, document the reason

## Security Considerations

- **Require Signed Commits**: Ensures commit authenticity
- **Enforce Status Checks**: Prevents merging untested or unvalidated code
- **Restrict Tag Creation**: Prevents unauthorized releases
- **Block Force Pushes**: Maintains commit history integrity
- **Require Reviews**: Ensures code is peer-reviewed

## Troubleshooting

### Rules Not Applying

- Verify the branch/tag name patterns in `conditions.ref_name`
- Check that `enforcement` is set to `"active"`
- Ensure you have admin permissions to apply rulesets

### Status Checks Failing

- Verify status check names match your CI workflow names
- Check that all required workflows are configured in your repository
- Review workflow permissions in `.github/workflows/`

## References

- [GitHub Rulesets Documentation](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)
- [REST API Rulesets](https://docs.github.com/en/rest/repos/rules)
- [Branch Protection Best Practices](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)
