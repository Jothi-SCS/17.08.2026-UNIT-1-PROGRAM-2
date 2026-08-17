# Student Table SQL – GitHub Classroom Assignment

## 🎯 Objective

Create a MySQL `Student` table in the `CollegeDB` database using appropriate data types and constraints.

## 📌 Problem Statement

Create a `Student` table with the following fields:

| Field        | Data Type   | Constraint            |
| ------------ | ----------- | --------------------- |
| StudentID    | INT(5)      | PRIMARY KEY, NOT NULL |
| StudentName  | VARCHAR(20) | UNIQUE, NOT NULL      |
| DOB          | DATE        | NOT NULL              |
| Gender       | VARCHAR(10) | NOT NULL              |
| DepartmentID | INT(5)      | NOT NULL              |

## 🔐 Required Constraints

Your table must contain:

* `StudentID` → PRIMARY KEY and NOT NULL
* `StudentName` → UNIQUE and NOT NULL
* `DOB` → NOT NULL
* `Gender` → NOT NULL
* `DepartmentID` → NOT NULL

## 👩‍💻 Instructions for Students

### Step 1 – Accept the Assignment

Accept the GitHub Classroom assignment using your GitHub account.

GitHub will automatically create your individual repository.

### Step 2 – Open Your Repository

Open the repository created for you.

You will find:

```text
solution.sql
```

### Step 3 – Write Your SQL Program

Open `solution.sql` and write the SQL statements required to create the database and table.

Your program must:

1. Create the database `CollegeDB`.
2. Use the database `CollegeDB`.
3. Create the `Student` table.
4. Create all five required columns.
5. Apply PRIMARY KEY.
6. Apply UNIQUE.
7. Apply NOT NULL.

### Step 4 – Save Your Program

Save your changes in:

```text
solution.sql
```

### Step 5 – Commit Your Changes

Use a meaningful commit message such as:

```text
Completed Student Table Assignment
```

Then commit your changes.

### Step 6 – Check GitHub Actions

GitHub Actions will automatically execute the SQL program and test cases.

Go to:

```text
Actions
→ Student Table SQL Autograding
→ grade
```

### Step 7 – Check Your Result

If your program is correct, you will see:

```text
ALL TEST CASES PASSED
```

If any test fails:

1. Read the failed test.
2. Correct `solution.sql`.
3. Commit the changes again.
4. Check GitHub Actions again.

## 🧪 Automatic Test Cases

The autograder checks:

1. CollegeDB database exists
2. Student table exists
3. StudentID is INT
4. StudentID is NOT NULL
5. StudentID is PRIMARY KEY
6. StudentName is VARCHAR(20)
7. StudentName is NOT NULL
8. StudentName is UNIQUE
9. DOB is DATE
10. DOB is NOT NULL
11. Gender is VARCHAR(10)
12. Gender is NOT NULL
13. DepartmentID is INT
14. DepartmentID is NOT NULL

## 📝 Marks – 14

| Criteria                |  Marks |
| ----------------------- | -----: |
| CollegeDB database      |      1 |
| Student table           |      1 |
| StudentID INT           |      1 |
| StudentID NOT NULL      |      1 |
| StudentID PRIMARY KEY   |      1 |
| StudentName VARCHAR(20) |      1 |
| StudentName NOT NULL    |      1 |
| StudentName UNIQUE      |      1 |
| DOB DATE                |      1 |
| DOB NOT NULL            |      1 |
| Gender VARCHAR(10)      |      1 |
| Gender NOT NULL         |      1 |
| DepartmentID INT        |      1 |
| DepartmentID NOT NULL   |      1 |
| **Total**               | **14** |

## ⚠️ Important

Students should modify **ONLY**:

```text
solution.sql
```

Do NOT modify:

```text
tests/test.sh
```

or

```text
.github/workflows/autograding.yml
```

These files are used for automatic evaluation.

## 💡 Expected SQL Structure

Your solution should contain statements equivalent to:

```sql
CREATE DATABASE CollegeDB;

USE CollegeDB;

CREATE TABLE Student (
    StudentID INT(5) NOT NULL PRIMARY KEY,
    StudentName VARCHAR(20) NOT NULL UNIQUE,
    DOB DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    DepartmentID INT(5) NOT NULL
);
```

You must write and submit your own program.

## ✅ Final Submission Checklist

* [ ] Accepted GitHub Classroom assignment
* [ ] Opened `solution.sql`
* [ ] Created/selected `CollegeDB`
* [ ] Created `Student` table
* [ ] Added all required columns
* [ ] Added PRIMARY KEY
* [ ] Added UNIQUE constraint
* [ ] Added NOT NULL constraints
* [ ] Saved the program
* [ ] Committed changes
* [ ] Pushed changes to GitHub
* [ ] Checked GitHub Actions
* [ ] All test cases passed

## 🎓 Submission Rule

**Submit only after GitHub Actions shows:**

```text
ALL TEST CASES PASSED
```
