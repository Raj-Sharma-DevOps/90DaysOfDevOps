# Day 20 – Bash Log Analyzer & Report Generator

## Overview
This project automates the analysis of system log files and generates
a daily summary report including error counts, critical events, and
frequent error messages.

## Script
- log_analyzer.sh

## Features
- Input validation
- Error and failure detection
- Critical event detection with line numbers
- Top 5 error message analysis
- Automatic report generation
- Archive processed logs

## Commands & Tools Used
- grep → search keywords
- awk → text processing
- sort → sorting data
- uniq → counting duplicates
- wc → counting lines
- date → timestamping

## Sample Output
- Console shows error count & critical events
- Report saved as log_report_<date>.txt

## What I Learned
1. Text processing with grep and awk
2. Automating reports using Bash
3. Writing production-ready shell scripts with validation
