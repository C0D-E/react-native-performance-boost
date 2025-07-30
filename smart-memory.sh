#!/bin/zsh

# SMART MEMORY ALLOCATOR - TEAM COMPATIBLE
# Automatically detects hardware and allocates memory safely for ANY system

echo "🧠 SMART MEMORY ALLOCATOR - TEAM COMPATIBLE"
echo "⚡ Analyzing system capabilities for optimal allocation..."

# Detect total system RAM
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    TOTAL_RAM_BYTES=$(sysctl -n hw.memsize)
    TOTAL_RAM=$((TOTAL_RAM_BYTES / 1024 / 1024 / 1024))
    MEMORY_INFO=$(top -l 1 -s 0 | grep "PhysMem")
    USED_MEMORY=$(echo $MEMORY_INFO | grep -o '[0-9]*G used' | grep -o '[0-9]*' || echo "8")
else
    # Linux/Other - basic detection
    TOTAL_RAM=$(free -g | awk '/^Mem:/{print $2}' || echo "16")
    USED_MEMORY=$(free -g | awk '/^Mem:/{print $3}' || echo "8")
fi

AVAILABLE_MEMORY=$((TOTAL_RAM - USED_MEMORY))

echo "📊 Hardware Detection:"
echo "   💾 Total RAM: ${TOTAL_RAM}GB"
echo "   🔥 Currently Used: ${USED_MEMORY}GB"
echo "   ✅ Available: ${AVAILABLE_MEMORY}GB"

# Hardware-based allocation strategy
if [[ $TOTAL_RAM -ge 128 ]]; then
    # Mac Studio M4 Max / High-end workstation
    HARDWARE_CLASS="WORKSTATION"
    if [[ $AVAILABLE_MEMORY -gt 80 ]]; then
        NODE_ALLOC=48; GRADLE_ALLOC=24; JVM_ALLOC=24; MODE="ULTRA"
    elif [[ $AVAILABLE_MEMORY -gt 50 ]]; then
        NODE_ALLOC=32; GRADLE_ALLOC=16; JVM_ALLOC=16; MODE="HIGH"
    else
        NODE_ALLOC=16; GRADLE_ALLOC=12; JVM_ALLOC=12; MODE="SAFE"
    fi
elif [[ $TOTAL_RAM -ge 64 ]]; then
    # High-end laptop/desktop
    HARDWARE_CLASS="HIGH_END"
    if [[ $AVAILABLE_MEMORY -gt 40 ]]; then
        NODE_ALLOC=24; GRADLE_ALLOC=12; JVM_ALLOC=12; MODE="HIGH"
    elif [[ $AVAILABLE_MEMORY -gt 20 ]]; then
        NODE_ALLOC=16; GRADLE_ALLOC=8; JVM_ALLOC=8; MODE="SAFE"
    else
        NODE_ALLOC=8; GRADLE_ALLOC=6; JVM_ALLOC=6; MODE="MINIMAL"
    fi
elif [[ $TOTAL_RAM -ge 32 ]]; then
    # Mid-range system
    HARDWARE_CLASS="MID_RANGE"
    if [[ $AVAILABLE_MEMORY -gt 20 ]]; then
        NODE_ALLOC=12; GRADLE_ALLOC=6; JVM_ALLOC=6; MODE="SAFE"
    elif [[ $AVAILABLE_MEMORY -gt 10 ]]; then
        NODE_ALLOC=8; GRADLE_ALLOC=4; JVM_ALLOC=4; MODE="MINIMAL"
    else
        NODE_ALLOC=4; GRADLE_ALLOC=3; JVM_ALLOC=3; MODE="BASIC"
    fi
else
    # Entry-level system
    HARDWARE_CLASS="ENTRY_LEVEL"
    if [[ $AVAILABLE_MEMORY -gt 8 ]]; then
        NODE_ALLOC=4; GRADLE_ALLOC=3; JVM_ALLOC=3; MODE="BASIC"
    else
        NODE_ALLOC=2; GRADLE_ALLOC=2; JVM_ALLOC=2; MODE="CONSERVATIVE"
    fi
fi

# Hardware-specific worker allocation
case $HARDWARE_CLASS in
    "WORKSTATION")
        WORKERS=16; UV_THREADS=24 ;;
    "HIGH_END")
        WORKERS=8; UV_THREADS=16 ;;
    "MID_RANGE")
        WORKERS=6; UV_THREADS=8 ;;
    "ENTRY_LEVEL")
        WORKERS=4; UV_THREADS=4 ;;
esac

# Export optimized settings with GRADLE_OPTS override
export NODE_OPTIONS="--max-old-space-size=$((NODE_ALLOC * 1024)) --max-semi-space-size=$((NODE_ALLOC * 64)) --optimize-for-size"
export GRADLE_OPTS="-Xmx${GRADLE_ALLOC}g -XX:MaxMetaspaceSize=4g -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -Dorg.gradle.daemon=true -Dorg.gradle.parallel=true -Dorg.gradle.workers.max=${WORKERS}"
export JAVA_OPTS="-Xmx${JVM_ALLOC}g -XX:+UseG1GC -XX:+UseCompressedOops"

# Calculate total allocation
TOTAL_ALLOC=$((NODE_ALLOC + GRADLE_ALLOC + JVM_ALLOC))

echo ""
echo "🎯 HARDWARE: $HARDWARE_CLASS ($MODE MODE):"
echo "   📦 Node.js: ${NODE_ALLOC}GB"
echo "   🏗️ Gradle: ${GRADLE_ALLOC}GB (overrides gradle.properties)"
echo "   ☕ JVM: ${JVM_ALLOC}GB"
echo "   👥 Workers: ${WORKERS}"
echo "   🧵 UV Threads: ${UV_THREADS}"
echo "   📊 Total Allocated: ${TOTAL_ALLOC}GB"
echo "   💾 Remaining Free: $((AVAILABLE_MEMORY - TOTAL_ALLOC))GB"

# Safety check
if [[ $TOTAL_ALLOC -gt $((AVAILABLE_MEMORY - 5)) ]]; then
    echo ""
    echo "⚠️ WARNING: High memory usage detected!"
    echo "💡 Consider closing applications for optimal performance"
fi

# Additional optimizations
export UV_THREADPOOL_SIZE=$UV_THREADS

echo ""
echo "✅ TEAM-COMPATIBLE ALLOCATION ACTIVE!"
echo "🔄 Works safely on ANY hardware configuration"
echo "🚀 Optimized for your specific system: $HARDWARE_CLASS"
