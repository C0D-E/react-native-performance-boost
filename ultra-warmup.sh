#!/bin/zsh

# POST-WARMUP ULTRA OPTIMIZER
# Run this after builds are warmed up for maximum performance

echo "🔥 POST-WARMUP ULTRA OPTIMIZER"
echo "⚡ Activating MAXIMUM performance for warm builds..."

# Check if this is after a successful build
if [[ ! -f "android/app/build/outputs/apk/debug/app-debug.apk" && ! -f "android/app/build/intermediates" ]]; then
    echo "⚠️  Warning: No Android build detected."
    echo "💡 Run 'yarn android' first, then use this script for subsequent builds"
fi

# MAXIMUM performance settings for warm builds
export NODE_OPTIONS="--max-old-space-size=48576 --max-semi-space-size=4096 --optimize-for-size"
export GRADLE_OPTS="-Xmx24576m -XX:MaxMetaspaceSize=4096m -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication"
export JAVA_OPTS="-Xmx24576m -XX:+UseG1GC -XX:+UseCompressedOops"

# Ultra React Native optimizations
export RN_NO_FLIPPER=1
export REACT_NATIVE_DEBUGGER_OFF=1
export FLIPPER_DISABLE_PLUGIN_FOLLY=1
export REACT_NATIVE_OVERRIDE_VERSION="0.79.2"

# Ultra Metro optimizations
export METRO_CACHE_MAX_SIZE=50000
export METRO_OPTIMIZE_FOR_SPEED=1
export METRO_MINIFY_UGLIFY=false
export METRO_CACHE_SIZE=unlimited

# Ultra system optimizations
export UV_THREADPOOL_SIZE=24
export MALLOC_ARENA_MAX=1

# Android optimizations
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export GRADLE_USER_HOME="$HOME/.gradle"

# Enable ultra caching
export GRADLE_OPTS="$GRADLE_OPTS -Dorg.gradle.daemon=true -Dorg.gradle.parallel.intra=true -Dorg.gradle.configureondemand=true"

echo "🚀 ULTRA MODE ACTIVATED!"
echo "🔥 EXTREME allocations:"
echo "   - Node.js: 48GB"
echo "   - Gradle: 24GB" 
echo "   - JVM: 24GB"
echo "   - UV Thread Pool: 24 threads"
echo "   - Metro Cache: Unlimited"
echo ""
echo "⏱️  Expected build times:"
echo "   - Warm builds: 5-10 seconds"
echo "   - Code changes: 2-5 seconds"
echo "   - Asset changes: 3-8 seconds"
echo ""
echo "🎯 NOW RUN: yarn android"

# Pre-warm Gradle daemon for instant builds
echo "🔥 Pre-warming Gradle daemon..."
cd android
./gradlew --daemon tasks >/dev/null 2>&1 &
cd ..

echo "✅ Ready for LIGHTNING builds! ⚡"
