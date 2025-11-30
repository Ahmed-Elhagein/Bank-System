🏦 Assembly Bank Management System

A robust, low-level banking simulation developed in x86 Assembly Language using TASM (Turbo Assembler). This project demonstrates core concepts of system programming, memory management, and direct hardware interaction via DOS interrupts.

📜 Table of Contents

Features

Technical Highlights

Prerequisites

Installation & Execution

Code Structure

Author

🚀 Features

🔐 Security & Authentication

Secure PIN Entry: Utilizes INT 21h / AH=07h to accept password input without echoing characters to the screen (masked with *).

Account Verification: Prevents any banking operations (Deposit/Withdraw) unless a valid account is created.

Dynamic PIN Length: Supports variable-length PINs using a custom counter logic.

💸 Banking Operations

Create Account: Initialize user data (Name & PIN) in memory.

Deposit Money: Add funds to the account balance.

Withdraw Money: Logic includes balance validation (prevents withdrawing more than current balance).

Modify Account: Securely update Name and PIN with counter resets.

Reset Account: Wipes data from memory pointers.

🎨 User Interface

ASCII Art: Features custom ASCII graphics for menus and headers.

Clean Navigation: Implements a "Press Enter to Return" logic for smooth UX.

🧠 Technical Highlights

This project implements several advanced Assembly concepts:

Macro Utilization (DRY Principle):

Custom Macros (ISop11, printString, etc.) are used to handle repetitive I/O tasks, reducing code redundancy and improving readability.

Stack Overflow Prevention:

Implements a custom Stack Restoration Mechanism. Since the program uses JMP to return to the main loop (instead of RET), the stack pointer (SP) is manually saved to stacktop at start and restored at every loop iteration to prevent stack overflow crashes.

Direct Video & Memory Manipulation:

Uses INT 21h interrupts for all input/output operations.

Manages memory segments (.DATA and .CODE) efficiently within the .MODEL SMALL architecture.

Data Conversion:

Includes a custom printNumber procedure to convert binary values (stored in registers) into ASCII characters for display using Stack operations (LIFO).

🛠 Prerequisites

To run this project, you need:

DOSBox: An x86 emulator.

TASM (Turbo Assembler): For assembling the code.

TLINK (Turbo Linker): For linking the object file (16-bit version).

⚙️ Installation & Execution

Clone the repository:

git clone [https://github.com/YourUsername/Assembly-Bank-System.git](https://github.com/Ahmed-Elhagein/Bank-System.git)


Mount your directory in DOSBox:
Assuming your TASM folder is at C:\TASM:

mount c c:\tasm
c:


Assemble the code:

tasm Bank_SYS.asm


Output: Bank_SYS.OBJ

Link the object file:

tlink Bank_SYS.obj


(Note: Ensure you use the 16-bit linker, not TLINK32)
Output: Bank_SYS.EXE

Run the executable:

Bank_SYS.exe


📂 Code Structure

Macros Section: Contains reusable logic for string printing and input handling.

Data Segment (.data): Stores ASCII art, user variables (accountName, accountPIN), and system flags.

Code Segment (.code):

Main: The entry point and main menu loop.

Utils: Helper procedures (clearScreen, newLine, printNumber).

Operations: Logic for each menu option (Op1 to Op6).

👨‍💻 Author

Ahmed Reda Elhagein

Built with ❤️ and a lot of MOV instructions.
