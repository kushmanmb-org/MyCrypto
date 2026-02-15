# Security Rulesets and Management

This document describes the security rulesets and management practices for the MyCrypto repository.

## Overview

Security rulesets provide automated enforcement of security policies across the repository. They help ensure code quality, prevent security vulnerabilities, and maintain consistent security standards.

## Repository Rulesets

### Branch Protection Rules

Located in `.github/rulesets/branch-protection.json`

**Protected Branches**: `main`, `master`

**Rules Enforced**:
1. **Pull Request Reviews**
   - Minimum 1 approval required
   - Stale reviews dismissed on new commits
   - Review threads must be resolved

2. **Status Checks**
   - CI validation must pass
   - Tests must pass
   - Code coverage requirements met
   - Checks must be up-to-date

3. **Protection Rules**
   - Branch deletion blocked
   - Force push blocked
   - Commit signatures required

### Tag Protection Rules

Located in `.github/rulesets/release-tag-protection.json`

**Protected Tags**: `v*`, `release-*`

**Rules Enforced**:
1. **Creation**: Restricted to authorized users
2. **Deletion**: Blocked to preserve history
3. **Updates**: Blocked to ensure integrity

## Security Workflows

### CodeQL Analysis

**File**: `.github/workflows/codeql-analysis.yml`

**Purpose**: Automated security vulnerability scanning

**Triggers**:
- Push to main/master/develop branches
- Pull requests to main/master/develop
- Weekly scheduled scan (Mondays at midnight)

**Coverage**:
- JavaScript security analysis
- TypeScript security analysis
- Security and quality queries

### Dependency Management

**File**: `.github/dependabot.yml`

**Purpose**: Automated dependency updates and vulnerability patching

**Configuration**:
- Weekly NPM dependency updates
- Weekly GitHub Actions updates
- Grouped updates to reduce PR noise
- Automatic security patch applications

## Secret Scanning

**File**: `.github/secret-scanning.yml`

**Purpose**: Detect and prevent secret leakage

**Patterns Detected**:
- Private keys (RSA, EC, DSA, OpenSSH)
- API keys and access tokens
- Ethereum private keys
- Mnemonic seed phrases
- Database credentials
- AWS credentials
- JWT tokens

## Code Owners

**File**: `.github/CODEOWNERS`

**Purpose**: Define ownership and required reviewers

**Critical Paths**:
- Security files: Security team review required
- CI/CD workflows: DevOps team review required
- Wallet code: Security + Core team review required
- Package files: Core team review required

## Security Layers

### 1. Pre-Commit Protection

- ESLint security rules
- TypeScript strict mode
- Prettier formatting
- Git hooks (Husky)

### 2. Pull Request Protection

- Required code reviews
- Status check requirements
- Review thread resolution
- Dismiss stale reviews

### 3. Branch Protection

- Force push prevention
- Branch deletion prevention
- Signed commits required
- Linear history enforcement

### 4. Automated Scanning

- CodeQL security analysis
- Dependency vulnerability scanning
- Secret scanning
- Code coverage checks

### 5. Release Protection

- Tag protection rules
- Release approval process
- Signed releases
- Immutable release history

## Implementation Guide

### Step 1: Apply Repository Rulesets

Using GitHub CLI:
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

Using GitHub Web UI:
1. Go to Settings → Rules → Rulesets
2. Click "New ruleset"
3. Click "Import a ruleset"
4. Upload JSON files

### Step 2: Enable Security Features

1. **Enable Dependabot**:
   - Settings → Security → Dependabot
   - Enable "Dependabot alerts"
   - Enable "Dependabot security updates"
   - Enable "Dependabot version updates"

2. **Enable Secret Scanning**:
   - Settings → Security → Secret scanning
   - Enable "Secret scanning"
   - Enable "Push protection"

3. **Enable Code Scanning**:
   - Settings → Security → Code scanning
   - Enable "CodeQL analysis"
   - Configure via workflow (already created)

### Step 3: Configure Teams

Create GitHub teams for code ownership:
- `@kushmanmb-org/core-team`
- `@kushmanmb-org/security-team`
- `@kushmanmb-org/devops-team`

### Step 4: Verify Configuration

1. Test branch protection by attempting force push
2. Create test PR to verify status checks
3. Verify CodeQL workflow runs
4. Check Dependabot is creating PRs
5. Test secret scanning with dummy key

## Maintenance

### Weekly Tasks

- Review Dependabot PRs
- Check CodeQL scan results
- Review secret scanning alerts
- Monitor security advisories

### Monthly Tasks

- Review and update ruleset configurations
- Audit code owners
- Review bypass actors
- Update security documentation

### Quarterly Tasks

- Full security audit
- Review and update security policies
- Team access review
- Dependency audit

## Monitoring and Alerts

### GitHub Security Tab

Monitor the Security tab for:
- Security advisories
- Dependabot alerts
- Secret scanning alerts
- Code scanning alerts

### Notifications

Configure notifications for:
- Failed security scans
- New vulnerabilities
- Dependabot updates
- Secret scanning alerts

## Incident Response

### If Security Vulnerability Found

1. **Assess Severity**: Determine CVSS score
2. **Create Security Advisory**: Use GitHub Security Advisories
3. **Develop Fix**: Create private fork if needed
4. **Test Fix**: Ensure no regressions
5. **Deploy**: Merge and release
6. **Disclose**: Coordinate responsible disclosure

### If Secret Leaked

1. **Revoke Immediately**: Invalidate exposed secret
2. **Assess Impact**: Determine what was exposed
3. **Rotate**: Generate new secrets
4. **Investigate**: How did it leak?
5. **Prevent**: Update scanning patterns

## Best Practices

### For Developers

1. Never commit secrets or credentials
2. Use environment variables for sensitive data
3. Run security checks before committing
4. Review dependency updates carefully
5. Follow secure coding guidelines
6. Report security issues promptly

### For Reviewers

1. Check for hardcoded secrets
2. Review dependency changes
3. Verify security test coverage
4. Check for common vulnerabilities
5. Ensure proper error handling
6. Validate input sanitization

### For Maintainers

1. Keep rulesets up-to-date
2. Monitor security advisories
3. Respond to alerts promptly
4. Maintain security documentation
5. Conduct regular audits
6. Train team on security

## Security Checklist

Before every release:

- [ ] All security scans passed
- [ ] No open security advisories
- [ ] Dependencies up-to-date
- [ ] No known vulnerabilities
- [ ] Code reviewed by security team
- [ ] Secrets verified not committed
- [ ] Documentation updated
- [ ] Tests include security cases

## Resources

### Internal

- [SECURITY.md](../../SECURITY.md) - Security policy
- [CODEOWNERS](.github/CODEOWNERS) - Code ownership
- [Ruleset README](.github/rulesets/README.md) - Ruleset details

### External

- [GitHub Security Features](https://docs.github.com/en/code-security)
- [Repository Rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Web3 Security](https://ethereum.org/en/developers/docs/security/)

## Support

For questions or issues:
- Create an issue with `security` label
- Contact security team
- See [security.mycrypto.com](https://security.mycrypto.com)
