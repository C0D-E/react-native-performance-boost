#!/bin/zsh

# ULTIMATE M4 MAX STARTUP
# Launches VS Code with 64GB + Smart Development Setup in one command

echo "🚀 M4 MAX ULTIMATE STARTUP"
echo "💻 Launching VS Code with 64GB memory allocation..."

# Kill any existing VS Code processes to ensure clean start
pkill -f "Visual Studio Code" 2>/dev/null || true
sleep 1

# Launch VS Code with maximum memory and performance flags
open -a "Visual Studio Code" --args \
  --max-memory=65536 \
  --max-old-space-size=65536 \
  --max-semi-space-size=1024 \
  --optimize-for-size \
  --trace-warnings \
  --enable-source-maps

echo "✅ VS Code launched with 64GB allocation"
echo ""

# Wait a moment for VS Code to start
sleep 2

# Now run smart development setup
echo "🧠 Running Smart Development Setup..."
echo ""

# Execute smart-memory.sh from same directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/smart-memory.sh"

echo ""
echo "🎉 ULTIMATE STARTUP COMPLETE!"
echo ""
echo "📋 NEXT STEPS:"
echo "   sy add package-name    # Add packages safely"
echo "   sy install             # Install dependencies" 
echo "   yarn android           # Build your app"
echo "   ./ultra-warmup.sh      # Maximum performance after first build"
echo ""
echo "🎯 Your M4 Max is ready for development! ⚡"
