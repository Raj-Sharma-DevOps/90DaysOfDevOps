# Day 18 – Shell Scripting: Functions & Strict Mode

## 📌 Overview

On Day 18, I learned how to write cleaner and safer shell scripts using:

- Functions
- Strict Mode (`set -euo pipefail`)
- Local variables
- Structured scripting patterns

The goal was to make scripts more reusable, readable, and production-ready.

---

## 🗂 Scripts Created

- `functions.sh`
- `disk_check.sh`
- `strict_demo.sh`
- `local_demo.sh`
- `system_info.sh`

Each script focuses on a specific concept related to functions and safe scripting.

---

## ⚙️ Explanation of `set -euo pipefail`

Strict mode improves script reliability and prevents silent failures.

### 🔹 `set -e`
Exit the script immediately if any command returns a non-zero (error) status.

### 🔹 `set -u`
Exit the script if an undefined variable is used.

### 🔹 `set -o pipefail`
If any command in a pipeline fails, the entire pipeline fails.



What I Learned

Functions help organize code and improve reusability.

Strict mode prevents hidden errors and makes scripts safer.

Using local variables avoids unintended variable leaks.

Structured scripts with a main() function improve readability.

Debugging becomes easier with safer scripting practices.