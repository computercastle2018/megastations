#!/bin/bash

# MegaStation iOS Build & Deploy Script
# ==================================================

echo "🚀 Starting MegaStation iOS Build Process..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Flutter clean failed${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Clean completed${NC}"
echo ""

# Step 2: Get Flutter dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Flutter pub get failed${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Dependencies installed${NC}"
echo ""

# Step 3: Install CocoaPods
echo "🍎 Installing CocoaPods dependencies..."
cd ios
pod install
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Pod install failed${NC}"
    echo -e "${YELLOW}💡 Try running: pod repo update${NC}"
    exit 1
fi
cd ..
echo -e "${GREEN}✅ CocoaPods installed${NC}"
echo ""

# Step 4: Generate app icons
echo "🎨 Generating app icons..."
flutter pub run flutter_launcher_icons
if [ $? -ne 0 ]; then
    echo -e "${YELLOW}⚠️  Icon generation failed (optional)${NC}"
fi
echo ""

# Step 5: Build IPA
echo "🔨 Building iOS IPA (Release)..."
echo "This may take several minutes..."
flutter build ipa --release
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed${NC}"
    exit 1
fi
echo -e "${GREEN}✅ IPA built successfully${NC}"
echo ""

# Step 6: Show output location
echo "📍 Build output location:"
echo "   build/ios/archive/Runner.xcarchive"
echo "   build/ios/ipa/*.ipa"
echo ""

# Step 7: Open Xcode workspace
echo "🎯 Next steps:"
echo "1. Open Xcode workspace: ios/Runner.xcworkspace"
echo "2. Select 'Any iOS Device' as target"
echo "3. Go to Product > Archive"
echo "4. Distribute to App Store"
echo ""
echo -e "${YELLOW}Would you like to open Xcode now? (y/n)${NC}"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    open ios/Runner.xcworkspace
    echo -e "${GREEN}✅ Xcode opened${NC}"
fi

echo ""
echo "=========================================="
echo "🎉 Build process completed!"
echo "=========================================="
