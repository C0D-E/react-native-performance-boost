#!/bin/bash

# React Native Performance Boost - Installation Script
# This script sets up the performance-boost tools in your React Native project

set -e

echo "🚀 React Native Performance Boost - Installation"
echo "================================================"

# Check if we're in a React Native project
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run this from your React Native project root."
    exit 1
fi

# Check if this is a React Native project
if ! grep -q "react-native" package.json; then
    echo "❌ Error: This doesn't appear to be a React Native project."
    exit 1
fi

echo "✅ React Native project detected"

# Check for macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Error: This tool is designed for macOS with Apple Silicon."
    exit 1
fi

echo "✅ macOS detected"

# Create android directory if it doesn't exist
if [ ! -d "android" ]; then
    mkdir -p android
    echo "📁 Created android directory"
fi

# Copy gradle.properties if it doesn't exist or ask to overwrite
if [ -f "android/gradle.properties" ]; then
    echo "⚠️  android/gradle.properties already exists."
    read -p "Do you want to backup and replace it with optimized version? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp android/gradle.properties android/gradle.properties.backup
        cp android/gradle.properties ./
        echo "✅ Backed up existing gradle.properties and installed optimized version"
    else
        echo "ℹ️  Skipping gradle.properties replacement"
    fi
else
    cp android/gradle.properties ./
    echo "✅ Installed optimized gradle.properties"
fi

# Make scripts executable
chmod +x smart-dev code-max *.sh

echo "✅ Made scripts executable"

# Create symlinks in project root
if [ ! -L "code-max" ]; then
    ln -sf performance-boost/code-max code-max
    echo "✅ Created code-max symlink"
fi

if [ ! -L "smart-dev" ]; then
    ln -sf performance-boost/smart-dev smart-dev
    echo "✅ Created smart-dev symlink"
fi

echo ""
echo "🎉 Installation Complete!"
echo ""
echo "📋 Quick Start:"
echo "  1. Open macOS Terminal and navigate to your project"
echo "  2. Launch optimized VS Code: ./code-max"
echo "  3. In VS Code terminal - Install dependencies: smart-dev install"
echo "  4. In VS Code terminal - Build your app: smart-dev android"
echo ""
echo "📖 For full documentation: cat performance-boost/README.md"
echo "🆘 For help: smart-dev help"
echo ""
echo "🚀 Enjoy lightning-fast React Native development!"
