#!/usr/bin/env bash
# This script automates the creation of the attendance tracker workspace

echo "Welcome to the Attendance Tracker Project Setup!"
echo "Please enter a project name:"
read -r input

if [ -z "$input" ]; then
    echo "Error: Project name cannot be empty!"
    exit 1
fi

project_dir="attendance_tracker_${input}"

cleanup() {
    echo ""
    echo "Setup interrupted! Bundling current state..."
    tar -czf "${project_dir}_archive" "$project_dir" 2>/dev/null
    rm -rf "$project_dir"
    echo "Archive created: ${project_dir}_archive"
    echo "Incomplete directory deleted. Workspace is clean!"
    exit 1
}
trap cleanup SIGINT

echo "Creating project structure..."

if [ -d "$project_dir" ]; then
    echo "Warning: Directory $project_dir already exists!"
    exit 1
fi

mkdir -p "$project_dir/Helpers"
mkdir -p "$project_dir/reports"

cp attendance_checker.py "$project_dir/"
cp assets.csv "$project_dir/Helpers/"
cp config.json "$project_dir/Helpers/"
cp reports.log "$project_dir/reports/"

echo "Directory structure created successfully!"

echo ""
echo "Current attendance thresholds:"
echo "  Warning: 75%"
echo "  Failure: 50%"
echo ""
echo "Do you want to update the attendance thresholds? (yes/no)"
read -r update_config

if [ "$update_config" = "yes" ]; then
    echo "Enter new Warning threshold (numbers only):"
    read -r warning_val
    echo "Enter new Failure threshold (numbers only):"
    read -r failure_val

    if ! echo "$warning_val" | grep -qE '^[0-9]+$' || ! echo "$failure_val" | grep -qE '^[0-9]+$'; then
        echo "Error: Please enter numbers only!"
        exit 1
    fi

    sed -i "s/\"warning\": [0-9]*/\"warning\": $warning_val/" "$project_dir/Helpers/config.json"
    sed -i "s/\"failure\": [0-9]*/\"failure\": $failure_val/" "$project_dir/Helpers/config.json"
    echo "Configuration updated successfully!"
fi

echo ""
echo "Running Health Check..."
if python3 --version 2>/dev/null; then
    echo "✅ Python3 is installed! You are good to go!"
else
    echo "⚠️ Warning: Python3 is not installed. Please install it to run the application."
fi

echo ""
echo "✅ Project setup complete!"
echo "Your project is ready at: $project_dir"
