#!/bin/zsh

# SMART YARN WRAPPER
# Automatically handles performance optimization around yarn operations

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🧠 SMART YARN - Intelligent package management"

# Function to check if this is a package-changing operation
is_package_operation() {
    case "$1" in
        "add"|"remove"|"install"|"upgrade"|"upgrade-interactive")
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Store original yarn.lock hash before operation
YARN_LOCK_BEFORE=""
if [[ -f "yarn.lock" ]]; then
    YARN_LOCK_BEFORE=$(shasum yarn.lock 2>/dev/null | cut -d' ' -f1)
fi

# Check if this is a package-changing operation
if is_package_operation "$1"; then
    echo "📦 Package operation detected: yarn $*"
    echo "🔄 Setting up safe environment..."
    
    # Ensure safe environment
    "$SCRIPT_DIR/smart-memory.sh" >/dev/null 2>&1
    
    # Run yarn with safe environment
    echo "🚀 Executing: yarn $*"
    yarn "$@"
    
    # Check if yarn.lock actually changed
    YARN_LOCK_AFTER=""
    if [[ -f "yarn.lock" ]]; then
        YARN_LOCK_AFTER=$(shasum yarn.lock 2>/dev/null | cut -d' ' -f1)
    fi
    
    if [[ "$YARN_LOCK_BEFORE" != "$YARN_LOCK_AFTER" ]]; then
        echo "✅ Package operation completed successfully!"
        echo "🔄 Automatically optimizing for TURBO first build..."
        
        # Auto-trigger TURBO optimization for first build
        echo "🚀 Activating TURBO mode for ~20 second builds..."
        source "$SCRIPT_DIR/turbo-first-build.sh"
        
        echo ""
        echo "🎉 TURBO READY! Run 'yarn android' for ~20 second build!"
        echo "💡 After first build, use './ultra-warmup.sh' for 5-10 second builds"
    else
        echo "ℹ️  No package changes detected (operation may have been cancelled)"
    fi
    
else
    echo "🏃‍♂️ Non-package operation: yarn $*"
    echo "🚀 Running with current environment..."
    yarn "$@"
fi
