---
name: Security Checklist
about: Security review checklist for pull requests with security implications
title: '[SECURITY] '
labels: security
assignees: ''
---

## Security Review Checklist

### Code Review
- [ ] No hardcoded secrets or credentials
- [ ] No sensitive data in logs or error messages
- [ ] Input validation implemented for all user inputs
- [ ] Output encoding applied where needed
- [ ] Error handling doesn't leak sensitive information
- [ ] Authentication/authorization checks in place
- [ ] SQL injection prevention (if applicable)
- [ ] XSS prevention measures implemented
- [ ] CSRF protection enabled (if applicable)
- [ ] Secure random number generation used

### Cryptography
- [ ] No private keys committed
- [ ] Standard cryptographic libraries used
- [ ] No custom cryptographic implementations
- [ ] Proper key management implemented
- [ ] Secure key storage mechanisms
- [ ] Encryption algorithms are industry standard
- [ ] Random number generation is cryptographically secure

### Dependencies
- [ ] New dependencies reviewed for vulnerabilities
- [ ] Dependencies from trusted sources
- [ ] Minimal necessary dependencies added
- [ ] License compatibility verified
- [ ] Dependency versions pinned appropriately

### Data Handling
- [ ] Sensitive data encrypted at rest
- [ ] Sensitive data encrypted in transit
- [ ] No sensitive data in URLs or query parameters
- [ ] Proper data sanitization implemented
- [ ] PII handling complies with privacy requirements
- [ ] Data retention policies followed

### Access Control
- [ ] Principle of least privilege applied
- [ ] Proper authentication mechanisms
- [ ] Authorization checks on all protected resources
- [ ] Session management is secure
- [ ] No privilege escalation vulnerabilities

### Testing
- [ ] Security test cases added
- [ ] Edge cases tested
- [ ] Error conditions tested
- [ ] Negative test cases included
- [ ] Integration tests cover security aspects

### Documentation
- [ ] Security considerations documented
- [ ] Configuration requirements documented
- [ ] Deployment security notes added
- [ ] Security implications explained in PR

### Compliance
- [ ] Follows OWASP best practices
- [ ] Adheres to repository security policies
- [ ] No violations of security standards
- [ ] Cryptocurrency security best practices followed

### Scan Results
- [ ] CodeQL scan passed
- [ ] No new security vulnerabilities introduced
- [ ] Dependency scan passed
- [ ] Secret scanning passed
- [ ] Linting passed

## Security Impact Assessment

**Severity**: [None/Low/Medium/High/Critical]

**Areas Affected**:
- [ ] Authentication
- [ ] Authorization  
- [ ] Data handling
- [ ] Cryptography
- [ ] Network communication
- [ ] File operations
- [ ] External integrations

## Description of Changes

<!-- Describe the security-relevant changes made -->

## Testing Performed

<!-- Describe security testing performed -->

## Additional Notes

<!-- Any additional security considerations -->

## Reviewer Notes

<!-- For security team reviewers -->

---

**Security Team Review Required**: Yes/No
**Additional Review Needed**: Yes/No
