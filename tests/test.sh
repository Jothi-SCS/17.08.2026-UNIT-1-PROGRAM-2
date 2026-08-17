#!/bin/bash

set -u

MYSQL="mysql -h 127.0.0.1 -P 3306 -u root -proot --protocol=tcp -N -B"

PASS=0
FAIL=0

pass() {
    echo "PASS: $1"
    PASS=$((PASS + 1))
}

fail() {
    echo "FAIL: $1"
    FAIL=$((FAIL + 1))
}

echo "=========================================="
echo " STUDENT TABLE AUTOGRADER"
echo "=========================================="

# Test 1: CollegeDB exists
DB_EXISTS=$($MYSQL -e "
SELECT SCHEMA_NAME
FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME='CollegeDB';
")

if [ "$DB_EXISTS" = "CollegeDB" ]; then
    pass "CollegeDB database exists"
else
    fail "CollegeDB database does not exist"
fi

if [ "$DB_EXISTS" != "CollegeDB" ]; then
    echo "Cannot continue."
    exit 1
fi

# Test 2: Student table exists
TABLE_EXISTS=$($MYSQL -e "
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student';
")

if [ "$TABLE_EXISTS" = "Student" ]; then
    pass "Student table exists"
else
    fail "Student table does not exist"
    exit 1
fi

# Test 3: StudentID INT
TYPE=$($MYSQL -e "
SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='StudentID';
")

if [ "$TYPE" = "int" ]; then
    pass "StudentID is INT"
else
    fail "StudentID is not INT"
fi

# Test 4: StudentID NOT NULL
NULLABLE=$($MYSQL -e "
SELECT IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='StudentID';
")

if [ "$NULLABLE" = "NO" ]; then
    pass "StudentID is NOT NULL"
else
    fail "StudentID is nullable"
fi

# Test 5: StudentID PRIMARY KEY
PK=$($MYSQL -e "
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND CONSTRAINT_NAME='PRIMARY'
AND COLUMN_NAME='StudentID';
")

if [ "$PK" = "StudentID" ]; then
    pass "StudentID is PRIMARY KEY"
else
    fail "StudentID is not PRIMARY KEY"
fi

# Test 6: StudentName VARCHAR(20)
TYPE=$($MYSQL -e "
SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='StudentName';
")

LENGTH=$($MYSQL -e "
SELECT CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='StudentName';
")

if [ "$TYPE" = "varchar" ] && [ "$LENGTH" = "20" ]; then
    pass "StudentName is VARCHAR(20)"
else
    fail "StudentName is not VARCHAR(20)"
fi

# Test 7: StudentName NOT NULL
NULLABLE=$($MYSQL -e "
SELECT IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='StudentName';
")

if [ "$NULLABLE" = "NO" ]; then
    pass "StudentName is NOT NULL"
else
    fail "StudentName is nullable"
fi

# Test 8: StudentName UNIQUE
UNIQUE_COUNT=$($MYSQL -e "
SELECT COUNT(*)
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE ku
ON tc.CONSTRAINT_SCHEMA=ku.CONSTRAINT_SCHEMA
AND tc.TABLE_NAME=ku.TABLE_NAME
AND tc.CONSTRAINT_NAME=ku.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_SCHEMA='CollegeDB'
AND tc.TABLE_NAME='Student'
AND tc.CONSTRAINT_TYPE='UNIQUE'
AND ku.COLUMN_NAME='StudentName';
")

if [ "$UNIQUE_COUNT" -ge 1 ]; then
    pass "StudentName has UNIQUE constraint"
else
    fail "StudentName does not have UNIQUE constraint"
fi

# Test 9: DOB DATE
TYPE=$($MYSQL -e "
SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='DOB';
")

if [ "$TYPE" = "date" ]; then
    pass "DOB is DATE"
else
    fail "DOB is not DATE"
fi

# Test 10: DOB NOT NULL
NULLABLE=$($MYSQL -e "
SELECT IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='DOB';
")

if [ "$NULLABLE" = "NO" ]; then
    pass "DOB is NOT NULL"
else
    fail "DOB is nullable"
fi

# Test 11: Gender VARCHAR(10)
TYPE=$($MYSQL -e "
SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='Gender';
")

LENGTH=$($MYSQL -e "
SELECT CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='Gender';
")

if [ "$TYPE" = "varchar" ] && [ "$LENGTH" = "10" ]; then
    pass "Gender is VARCHAR(10)"
else
    fail "Gender is not VARCHAR(10)"
fi

# Test 12: Gender NOT NULL
NULLABLE=$($MYSQL -e "
SELECT IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='Gender';
")

if [ "$NULLABLE" = "NO" ]; then
    pass "Gender is NOT NULL"
else
    fail "Gender is nullable"
fi

# Test 13: DepartmentID INT
TYPE=$($MYSQL -e "
SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='DepartmentID';
")

if [ "$TYPE" = "int" ]; then
    pass "DepartmentID is INT"
else
    fail "DepartmentID is not INT"
fi

# Test 14: DepartmentID NOT NULL
NULLABLE=$($MYSQL -e "
SELECT IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='DepartmentID';
")

if [ "$NULLABLE" = "NO" ]; then
    pass "DepartmentID is NOT NULL"
else
    fail "DepartmentID is nullable"
fi

echo ""
echo "=========================================="
echo " AUTOGRADING SUMMARY"
echo "=========================================="
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo "Total : $((PASS + FAIL))"
echo "=========================================="

if [ "$FAIL" -eq 0 ]; then
    echo "ALL TEST CASES PASSED"
    exit 0
else
    echo "SOME TEST CASES FAILED"
    exit 1
fi
