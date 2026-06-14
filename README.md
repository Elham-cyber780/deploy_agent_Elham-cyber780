# deploy_agent_Elham-cyber780
## Project: Automated Project Bootstrapping & Process Management
This repository contains a shell script that automates the setup of the Student Attendance Tracker workspace.

## How to Run the Script

Step 1 -clone the repository:

git clone https://github.com/Elham-cyber780/deploy_agent_Elham-cyber780.git
cd deploy_agent_Elham-cyber780

Step 2 -Make the script executable: 
chmod +x setup_project.sh

Step 3 -Run the script:
./setup_project.sh

Step 4 - Follow the prompts:
- Enter a project name
- Choose whether to update attendance thresholds
- Enter new Warning and Failure percentages if needed

## How to Trigger the Archive Feature

The archive feature is triggered automatically when you press Ctrl+C during script execution

When Ctrl+C is pressed:
1. The script catches the signal 
2. Bundles the incomplete project into a file named attendance_tracker_{name}_archive.tar.gz
3. Deletes the incomplete folder
4. Exits cleanly 

## Project Structure Created

attendance_tracker_{name}/
- attendance_checker.py
- Helpers/
- assets.csv
- config.json 
- reports/ 
- reports.log

## Requirements
- Ubuntu 20.04 or later
- Python3 installed
- Bash shell 
 
