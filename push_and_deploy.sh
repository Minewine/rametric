#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to echo in color
echo_color() {
    local color=$1
    shift
    echo -e "\033[${color}m$@\033[0m"
}

# Add and commit changes if there are any
commit_changes() {
    echo_color "33" "Checking for changes to commit..."
    if [ -n "$(git status --porcelain)" ]; then  # Check for changes
        echo_color "33" "Changes detected, committing..."
        git add .  # Stage all changes
        git commit -m "Automated commit: $(date +"%Y-%m-%d %H:%M:%S")"  # Commit with a timestamp message
    else
        echo_color "34" "No changes to commit."
    fi
}

# Commit changes if any
commit_changes

# Push to GitHub
echo_color "33" "Pushing to GitHub..."
git push origin main || { echo_color "31" "Failed to push to GitHub"; exit 1; }

# Deploy to web server
echo_color "33" "Deploying to web server..."
ssh -p 21098 -o StrictHostKeyChecking=accept-new ramemvpl@premium66.web-hosting.com << EOF
    set -e
    echo "Current directory: \$(pwd)"
    echo "Changing to repository directory..."
    cd public_html/home || { echo "Failed to change directory"; exit 1; }
    echo "Current directory after change: \$(pwd)"
    
    # Check if this is a Git repository
    if [ ! -d .git ]; then
        echo "Error: Not a Git repository in this directory."
        exit 1
    fi
    
    echo "Pulling changes from GitHub..."
    git pull origin main || { echo "Failed to pull changes"; exit 1; }
    echo "Changes pulled successfully"
    # Add any additional commands here, like restarting services if needed
EOF

echo_color "32" "Changes pushed to GitHub and deployed to web server successfully!"
