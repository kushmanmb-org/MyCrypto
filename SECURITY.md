# Security Policy

## Reporting Security Vulnerabilities

Please see [https://security.mycrypto.com](https://security.mycrypto.com) for information on how to report security vulnerabilities.

For urgent security issues, please contact our security team directly through the channels listed on our security page.

## Security Standards

MyCrypto follows industry best practices for security:

### Code Security

- **Static Analysis**: All code is scanned using CodeQL for security vulnerabilities
- **Dependency Scanning**: Automated dependency updates and vulnerability scanning via Dependabot
- **Code Review**: All changes require peer review before merging
- **Secure Coding**: TypeScript strict mode and ESLint security rules enforced

### Branch Protection

- Main/master branches are protected with required reviews and status checks
- Force pushes and deletions are blocked
- All commits must pass CI/CD validation
- Code coverage requirements must be met

### Release Security

- Release tags are protected from modification or deletion
- Signed commits are required for releases
- Releases undergo security scanning before deployment

### Dependency Management

- Regular automated dependency updates
- Security patches are prioritized and applied quickly
- Vulnerability scanning on all dependencies
- Minimal dependency footprint to reduce attack surface

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 2.x.x   | :white_check_mark: |
| < 2.0   | :x:                |

## Security Best Practices for Contributors

When contributing to MyCrypto:

1. **Never commit secrets**: Use environment variables for sensitive data
2. **Follow secure coding practices**: Avoid common vulnerabilities (XSS, CSRF, SQL injection, etc.)
3. **Keep dependencies updated**: Regularly update dependencies to patch vulnerabilities
4. **Write secure code**: Follow OWASP guidelines and security best practices
5. **Test security**: Include security test cases for new features
6. **Review carefully**: Review your own code for security issues before submitting

## Security Features

### Automated Security Scanning

- **CodeQL Analysis**: Weekly automated security scans
- **Dependency Scanning**: Daily checks for vulnerable dependencies
- **Secret Scanning**: Automated detection of committed secrets
- **SAST/DAST**: Static and dynamic application security testing

### Continuous Monitoring

- Regular security audits of codebase
- Monitoring of security advisories for dependencies
- Automated alerts for new vulnerabilities

## Compliance

MyCrypto adheres to:

- OWASP Top 10 security guidelines
- Web3 security best practices
- Cryptocurrency wallet security standards

## Incident Response

In case of a security incident:

1. Report immediately via security.mycrypto.com
2. Our security team will acknowledge within 24 hours
3. We will investigate and provide updates
4. A fix will be developed and deployed
5. Public disclosure will be coordinated responsibly

## Bug Bounty Program

MyCrypto participates in responsible disclosure programs. Details available at:
- [https://security.mycrypto.com](https://security.mycrypto.com)

## Contact

For security concerns, please contact:
- Security Email: See security.mycrypto.com
- Security Policy: [https://security.mycrypto.com](https://security.mycrypto.com)
- Bug Bounty: See security.mycrypto.com
