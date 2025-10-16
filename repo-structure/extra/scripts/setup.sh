#!/bin/bash

############################################################
# Quick Setup Script for Lichess OAuth
# Sets up .env file and validates token
############################################################

echo "🎯 LICHESS OAUTH QUICK SETUP"
echo "============================"
echo

# Check if we're in the right directory
if [[ ! -f "oauth_helper.R" ]]; then
    echo "❌ Please run this script from the extra/scripts directory"
    echo "   cd extra/scripts && ./setup.sh"
    exit 1
fi

# Go to the extra directory (parent of scripts)
cd ..

echo "📁 Current directory: $(pwd)"
echo

# Check if .env.example exists
if [[ ! -f ".env.example" ]]; then
    echo "❌ .env.example file not found!"
    exit 1
fi

# Copy .env.example if .env doesn't exist
if [[ ! -f ".env" ]]; then
    echo "📋 Creating .env file from template..."
    cp .env.example .env
    echo "✅ Created .env file"
else
    echo "📋 .env file already exists"
fi

echo
echo "🔑 STEP 1: Get your Lichess token"
echo "  1. Go to: https://lichess.org/account/oauth/token"
echo "  2. Click 'New personal access token'"
echo "  3. Description: 'Data Science Research'"
echo "  4. Select scopes: preference:read, challenge:read, puzzle:read, tournament:read, study:read, follow:read"
echo "  5. Click 'Create' and copy the token (starts with 'lip_')"
echo

# Ask if user wants to enter token now
read -p "Do you want to enter your token now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Enter your Lichess token: " token
    
    if [[ $token == lip_* ]]; then
        # Update .env file
        if grep -q "LICHESS_ACCESS_TOKEN=" .env; then
            # Replace existing line
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS
                sed -i '' "s/LICHESS_ACCESS_TOKEN=.*/LICHESS_ACCESS_TOKEN=$token/" .env
            else
                # Linux
                sed -i "s/LICHESS_ACCESS_TOKEN=.*/LICHESS_ACCESS_TOKEN=$token/" .env
            fi
        else
            # Add new line
            echo "LICHESS_ACCESS_TOKEN=$token" >> .env
        fi
        
        echo "✅ Token saved to .env file"
        
        # Test the token
        echo
        echo "🧪 Testing token..."
        cd scripts
        Rscript oauth_helper.R test
        
    else
        echo "⚠️  Warning: Token doesn't start with 'lip_' - please check if it's correct"
        echo "💡 You can manually edit the .env file later"
    fi
else
    echo "💡 You can manually edit the .env file:"
    echo "   nano .env"
    echo "   # Replace 'lip_your_token_here' with your actual token"
fi

echo
echo "🎉 Setup complete!"
echo
echo "📊 NEXT STEPS:"
echo "  1. Run data collection: Rscript data_import.R"
echo "  2. Or test first: Rscript oauth_helper.R test"
echo
echo "📚 For help: cat ../README_OAUTH.md"