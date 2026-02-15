#!/bin/bash
# Security Rulesets Management Script
# This script helps manage and apply security rulesets for the MyCrypto repository

set -e

REPO_OWNER="${REPO_OWNER:-kushmanmb-org}"
REPO_NAME="${REPO_NAME:-MyCrypto}"
RULESETS_DIR=".github/rulesets"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

print_header() {
    echo ""
    echo "================================"
    echo "$1"
    echo "================================"
}

check_dependencies() {
    print_header "Checking Dependencies"
    
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) is not installed. Please install it first."
        echo "Visit: https://cli.github.com/"
        exit 1
    fi
    print_success "GitHub CLI found"
    
    if ! gh auth status &> /dev/null; then
        print_error "Not authenticated with GitHub CLI. Please run: gh auth login"
        exit 1
    fi
    print_success "GitHub CLI authenticated"
    
    if ! command -v jq &> /dev/null; then
        print_warning "jq is not installed. Some features may not work."
    else
        print_success "jq found"
    fi
}

validate_rulesets() {
    print_header "Validating Ruleset Files"
    
    for file in "$RULESETS_DIR"/*.json; do
        if [ -f "$file" ]; then
            if python3 -m json.tool "$file" > /dev/null 2>&1; then
                print_success "$(basename "$file") is valid JSON"
            else
                print_error "$(basename "$file") is invalid JSON"
                exit 1
            fi
        fi
    done
}

list_rulesets() {
    print_header "Current Rulesets"
    
    gh api "repos/$REPO_OWNER/$REPO_NAME/rulesets" --jq '.[] | "ID: \(.id) - \(.name) (\(.enforcement))"' 2>/dev/null || {
        print_warning "Could not fetch rulesets. Repository may not have any rulesets yet."
    }
}

apply_rulesets() {
    print_header "Applying Rulesets"
    
    for file in "$RULESETS_DIR"/*.json; do
        if [ -f "$file" ]; then
            ruleset_name=$(basename "$file" .json)
            print_warning "Applying $ruleset_name..."
            
            if gh api "repos/$REPO_OWNER/$REPO_NAME/rulesets" \
                --method POST \
                --input "$file" > /dev/null 2>&1; then
                print_success "$ruleset_name applied successfully"
            else
                print_error "Failed to apply $ruleset_name"
                print_warning "This might be because:"
                print_warning "  - You don't have admin permissions"
                print_warning "  - The ruleset already exists"
                print_warning "  - The repository is a fork"
            fi
        fi
    done
}

delete_ruleset() {
    local ruleset_id=$1
    
    if [ -z "$ruleset_id" ]; then
        print_error "Ruleset ID is required"
        echo "Usage: $0 delete <ruleset_id>"
        exit 1
    fi
    
    print_warning "Deleting ruleset ID: $ruleset_id"
    
    if gh api "repos/$REPO_OWNER/$REPO_NAME/rulesets/$ruleset_id" \
        --method DELETE > /dev/null 2>&1; then
        print_success "Ruleset deleted successfully"
    else
        print_error "Failed to delete ruleset"
    fi
}

update_ruleset() {
    local ruleset_id=$1
    local file=$2
    
    if [ -z "$ruleset_id" ] || [ -z "$file" ]; then
        print_error "Ruleset ID and file are required"
        echo "Usage: $0 update <ruleset_id> <file>"
        exit 1
    fi
    
    if [ ! -f "$file" ]; then
        print_error "File not found: $file"
        exit 1
    fi
    
    print_warning "Updating ruleset ID: $ruleset_id"
    
    if gh api "repos/$REPO_OWNER/$REPO_NAME/rulesets/$ruleset_id" \
        --method PUT \
        --input "$file" > /dev/null 2>&1; then
        print_success "Ruleset updated successfully"
    else
        print_error "Failed to update ruleset"
    fi
}

show_help() {
    cat << EOF
Security Rulesets Management Script

Usage: $0 <command> [options]

Commands:
    check       Check dependencies and validate ruleset files
    list        List current rulesets in the repository
    apply       Apply all rulesets from $RULESETS_DIR
    delete      Delete a specific ruleset by ID
    update      Update a specific ruleset by ID
    help        Show this help message

Examples:
    $0 check                                # Validate everything
    $0 list                                 # List current rulesets
    $0 apply                                # Apply all rulesets
    $0 delete 12345                         # Delete ruleset with ID 12345
    $0 update 12345 path/to/ruleset.json    # Update ruleset 12345

Environment Variables:
    REPO_OWNER    Repository owner (default: kushmanmb-org)
    REPO_NAME     Repository name (default: MyCrypto)

Notes:
    - You need admin permissions to manage rulesets
    - GitHub CLI (gh) must be installed and authenticated
    - Rulesets cannot be applied to forks

For more information, see: .github/rulesets/README.md
EOF
}

# Main script logic
case "${1:-help}" in
    check)
        check_dependencies
        validate_rulesets
        ;;
    list)
        check_dependencies
        list_rulesets
        ;;
    apply)
        check_dependencies
        validate_rulesets
        apply_rulesets
        ;;
    delete)
        check_dependencies
        delete_ruleset "$2"
        ;;
    update)
        check_dependencies
        update_ruleset "$2" "$3"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac

print_header "Done"
