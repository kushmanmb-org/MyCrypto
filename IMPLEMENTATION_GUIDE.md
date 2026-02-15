# Security Rulesets Implementation Guide

This guide provides step-by-step instructions for implementing and managing the security rulesets in the MyCrypto repository.

## Table of Contents

1. [Overview](#overview)
2. [What Has Been Added](#what-has-been-added)
3. [Quick Start](#quick-start)
4. [Detailed Setup Instructions](#detailed-setup-instructions)
5. [Verification](#verification)
6. [Maintenance](#maintenance)
7. [Troubleshooting](#troubleshooting)

## Overview

This implementation adds comprehensive security rulesets and automation to the MyCrypto repository, including:
- Branch and tag protection rules
- Automated security scanning (CodeQL)
- Dependency vulnerability management (Dependabot)
- Secret scanning configuration
- Code ownership definitions
- Security documentation and templates

## What Has Been Added

### Configuration Files

| File | Purpose |
|------|---------|
| `.github/rulesets/branch-protection.json` | Main/master branch protection rules |
| `.github/rulesets/release-tag-protection.json` | Release tag protection rules |
| `.github/workflows/codeql-analysis.yml` | CodeQL security scanning workflow |
| `.github/dependabot.yml` | Automated dependency updates |
| `.github/secret-scanning.yml` | Custom secret patterns for detection |
| `.github/CODEOWNERS` | Code ownership and review requirements |

### Documentation

| File | Purpose |
|------|---------|
| `SECURITY.md` | Enhanced security policy and reporting |
| `.github/SECURITY_RULESETS.md` | Comprehensive security rulesets documentation |
| `.github/rulesets/README.md` | Ruleset configuration details |
| `.github/ISSUE_TEMPLATE/security-checklist.md` | Security review template |

### Management Tools

| File | Purpose |
|------|---------|
| `scripts/manage-security-rulesets.sh` | Script to apply and manage rulesets |
| `scripts/README.md` | Script usage documentation |

## Quick Start

### For Repository Administrators

If you have admin access to the repository and want to apply all security features:

```bash
# 1. Ensure GitHub CLI is installed and authenticated
gh auth login

# 2. Validate configurations
./scripts/manage-security-rulesets.sh check

# 3. Apply repository rulesets
./scripts/manage-security-rulesets.sh apply

# 4. Enable security features in GitHub UI
# Go to Settings → Security & analysis
# Enable: Dependabot alerts, Dependabot security updates, Secret scanning, Code scanning

# 5. Verify everything is working
./scripts/manage-security-rulesets.sh list
```

### For Developers

If you're a contributor, here's what you need to know:

1. **Pull requests now require:**
   - At least 1 approval
   - All CI checks to pass
   - Code coverage requirements met
   - All review threads resolved

2. **Security scanning runs automatically:**
   - CodeQL on every PR
   - Dependency vulnerability checks
   - Secret scanning

3. **Use the security checklist:**
   - For security-sensitive changes, create an issue using the security checklist template

## Detailed Setup Instructions

### Step 1: Enable Repository Security Features

These features must be enabled via GitHub UI (requires admin access):

1. **Navigate to Repository Settings:**
   ```
   Repository → Settings → Security & analysis
   ```

2. **Enable Dependabot:**
   - ✅ Dependabot alerts
   - ✅ Dependabot security updates
   - ✅ Dependabot version updates (already configured via `.github/dependabot.yml`)

3. **Enable Secret Scanning:**
   - ✅ Secret scanning
   - ✅ Push protection (recommended)

4. **Enable Code Scanning:**
   - ✅ CodeQL analysis (workflow already added at `.github/workflows/codeql-analysis.yml`)

### Step 2: Apply Repository Rulesets

Repository rulesets enforce branch protection and tag protection rules.

**Option A: Using the Management Script (Recommended)**

```bash
# Validate ruleset files
./scripts/manage-security-rulesets.sh check

# Apply all rulesets
./scripts/manage-security-rulesets.sh apply

# Verify application
./scripts/manage-security-rulesets.sh list
```

**Option B: Using GitHub CLI Directly**

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

**Option C: Using GitHub Web UI**

1. Go to: `Repository → Settings → Rules → Rulesets`
2. Click "New ruleset"
3. Click "Import a ruleset"
4. Upload `branch-protection.json` and `release-tag-protection.json`

### Step 3: Configure Teams for Code Ownership

The CODEOWNERS file references teams that need to be created:

```bash
# Create teams in your GitHub organization
# Go to: Organization → Teams

# Suggested teams:
# - core-team (main repository maintainers)
# - security-team (security reviewers)
# - devops-team (CI/CD maintainers)
```

Update `.github/CODEOWNERS` with actual team names if different.

### Step 4: Customize Rulesets (Optional)

You may want to customize the rulesets for your specific needs:

**Customize Status Checks:**

Edit `.github/rulesets/branch-protection.json` to match your CI workflow names:

```json
"required_status_checks": [
  {
    "context": "your-workflow-name",
    "integration_id": null
  }
]
```

**Adjust Review Requirements:**

Modify the review count in `branch-protection.json`:

```json
"required_approving_review_count": 2  // Change from 1 to 2
```

**After making changes, reapply:**

```bash
# List rulesets to get ID
./scripts/manage-security-rulesets.sh list

# Update specific ruleset
./scripts/manage-security-rulesets.sh update <RULESET_ID> .github/rulesets/branch-protection.json
```

## Verification

### Verify Branch Protection

Try to push directly to the main branch (should fail):

```bash
git checkout main
# Make a change
git push origin main  # Should be rejected
```

### Verify Pull Request Requirements

1. Create a test PR
2. Verify that it requires:
   - Approving review
   - Passing status checks
   - Resolved review threads

### Verify CodeQL Workflow

1. Go to: `Repository → Actions → CodeQL Security Scan`
2. Verify workflow runs on PR creation
3. Check for any findings

### Verify Dependabot

1. Go to: `Repository → Security → Dependabot`
2. Check for any existing alerts
3. Dependabot should create PRs weekly (Mondays at 3 AM)

### Verify Secret Scanning

1. Go to: `Repository → Security → Secret scanning`
2. Check for any alerts
3. Test by committing a dummy secret (in a test branch)

## Maintenance

### Weekly Tasks

- [ ] Review Dependabot PRs and merge/update as appropriate
- [ ] Check CodeQL scan results for new findings
- [ ] Review secret scanning alerts
- [ ] Monitor security advisories

### Monthly Tasks

- [ ] Review and update ruleset configurations
- [ ] Audit CODEOWNERS file
- [ ] Review bypass actors
- [ ] Update security documentation

### Quarterly Tasks

- [ ] Full security audit
- [ ] Review team access and permissions
- [ ] Comprehensive dependency audit
- [ ] Update security policies

### Responding to Security Alerts

**Dependabot Alerts:**
1. Review the alert details
2. Check if a fix is available
3. Update the dependency or apply a workaround
4. Verify tests pass
5. Merge the fix

**CodeQL Findings:**
1. Review the code path
2. Assess severity and exploitability
3. Implement a fix
4. Add test to prevent regression
5. Re-run CodeQL to verify fix

**Secret Scanning Alerts:**
1. **Immediately** revoke the exposed secret
2. Rotate to a new secret
3. Assess impact (was it accessed?)
4. Update secret storage practices
5. Consider if breach notification is needed

## Troubleshooting

### Rulesets Won't Apply

**Problem:** Management script fails to apply rulesets

**Solutions:**
- Verify you have admin permissions: Check repository settings
- Ensure GitHub CLI is authenticated: `gh auth login`
- Check if repository is a fork: Rulesets can't be applied to forks
- Verify ruleset doesn't already exist: Use `list` command first

### Status Checks Always Failing

**Problem:** PR can't be merged due to failing required status checks

**Solutions:**
- Verify workflow names match: Check `.github/workflows/` vs ruleset config
- Check if workflows are enabled: Repository → Actions
- Review workflow logs: Actions tab → specific workflow
- Update ruleset to remove non-existent checks

### Dependabot Not Creating PRs

**Problem:** Expected dependency updates aren't appearing

**Solutions:**
- Verify Dependabot is enabled: Settings → Security & analysis
- Check configuration: Review `.github/dependabot.yml`
- Check schedule: Updates run weekly on Mondays at 3 AM UTC
- Review Dependabot logs: Security → Dependabot → View logs

### CodeQL Workflow Failing

**Problem:** CodeQL workflow fails to complete

**Solutions:**
- Check workflow file syntax: `.github/workflows/codeql-analysis.yml`
- Review build requirements: CodeQL needs successful build
- Check Actions logs: Actions → CodeQL Security Scan → View logs
- Verify correct languages: JavaScript/TypeScript for this repo

### Secret Scanning False Positives

**Problem:** Secret scanning reports non-secrets as secrets

**Solutions:**
- Review the pattern: Is it actually a secret?
- Dismiss alert: If confirmed false positive
- Update `.github/secret-scanning.yml`: Refine patterns
- Use comments: `# pragma: allowlist secret` to mark exceptions

## Advanced Configuration

### Customizing Dependabot Groups

Edit `.github/dependabot.yml`:

```yaml
groups:
  my-custom-group:
    dependency-type: "production"
    patterns:
      - "react*"
      - "redux*"
```

### Adding Custom Secret Patterns

Edit `.github/secret-scanning.yml`:

```yaml
custom_pattern:
  - pattern: "your-regex-pattern"
    description: "Description of the secret type"
```

### Modifying CodeQL Queries

Edit `.github/workflows/codeql-analysis.yml`:

```yaml
- name: Initialize CodeQL
  with:
    queries: +security-extended  # More comprehensive queries
```

## References

- [Main Security Policy](../../SECURITY.md)
- [Security Rulesets Documentation](.github/SECURITY_RULESETS.md)
- [Rulesets Configuration](.github/rulesets/README.md)
- [Management Scripts](scripts/README.md)
- [GitHub Security Features](https://docs.github.com/en/code-security)
- [Repository Rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)

## Getting Help

For questions or issues:
1. Review this documentation
2. Check [SECURITY_RULESETS.md](.github/SECURITY_RULESETS.md)
3. Create an issue with the `security` label
4. Contact the security team
5. Visit [security.mycrypto.com](https://security.mycrypto.com)

## Summary

You've successfully set up comprehensive security rulesets for the MyCrypto repository! The implementation includes:

✅ Branch and tag protection  
✅ Automated security scanning  
✅ Dependency management  
✅ Secret detection  
✅ Code ownership  
✅ Security documentation  
✅ Management tools  

Remember to:
- Regularly review security alerts
- Keep dependencies updated
- Maintain security documentation
- Train team members on security practices
