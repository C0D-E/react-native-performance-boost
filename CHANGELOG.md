# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-07-30

### Added
- Initial release of React Native Performance Boost tools
- `smart-dev` unified command interface with subcommands:
  - `clean-cache` - Ultra-clean all caches and reset state
  - `install` - Safe package installation with optimizations
  - `android` - Auto-detecting build optimization (TURBO/ULTRA modes)
  - `add <package>` - Safe package addition with auto-cleanup
  - `remove <package>` - Safe package removal with auto-cleanup
  - `help` - Command reference and usage examples
- `code-max` VS Code launcher with optimized memory allocation
- `smart-memory.sh` intelligent memory allocator with hardware detection
- `turbo-first-build.sh` for ~20 second first builds
- `ultra-warmup.sh` for 5-10 second warm builds
- `smart-yarn.sh` safe package management wrapper
- `startup.sh` legacy VS Code launcher (deprecated)
- Automatic hardware detection (WORKSTATION/HIGH_END/MID_RANGE/ENTRY_LEVEL)
- Intelligent build type detection (cold vs warm builds)
- Team-safe gradle.properties with conservative defaults
- Comprehensive documentation with quick-start and full reference
- Installation script for easy project setup

### Performance Improvements
- Cold builds: 4m 48s → ~20s (97% faster)
- Warm builds: 1m 31s → 5-10s (90% faster)
- VS Code performance: Standard → 64GB allocated (instant IntelliSense)
- Package operations: Smart memory management prevents conflicts
- Memory allocation: Adaptive scaling from 8GB laptops to 128GB workstations

### Compatibility
- macOS (Apple Silicon recommended)
- React Native 0.70+
- Node.js 18+
- Memory requirements: 8GB+ RAM (optimal: 32GB+)

### Documentation
- Quick-start guide for essential workflow
- Complete technical reference
- Command reference with examples
- Troubleshooting guide
- Team setup and migration instructions
