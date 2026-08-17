#!/bin/bash

set -u

MYSQL="mysql -h 127.0.0.1 -P 3306 -u root -proot --protocol=tcp -N -B"

PASS=0
FAIL=0
TOTAL=14

pass() {
    echo "✅ PASS: $1"
    PASS=$((PASS + 1))
}

fail() {
    echo "❌ FAIL: $1"
    FAIL=$((FAIL + 1))
}

echo "=========================================="
echo " STUDENT TABLE - AUTO GRADING"
echo "=========================================="

# --------------------------------------------------
# TEST 1 - CollegeDB
# --------------------------------------------------

DB_EXISTS=$($MYSQL -e "
SELECT SCHEMA_NAME
FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME='CollegeDB';
")

if [ "$DB_EXISTS" = "CollegeDB" ]; then
    pass "CollegeDB database created"
else
    fail "CollegeDB database not created"
fi

if [ "$DB_EXISTS" != "CollegeDB" ]; then
    echo ""
    echo "FINAL SCORE: $PASS / $TOTAL"
    exit 1
fi


# --------------------------------------------------
# TEST 2 - Student Table
# --------------------------------------------------

TABLE_EXISTS=$($MYSQL -e "
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student';
")

if [ "$TABLE_EXISTS" = "Student" ]; then
    pass "Student table created"
else
    fail "Student table not created"
    echo ""
    echo "FINAL SCORE: $PASS / $TOTAL"
    exit 1
fi


# Function: Get column type
get_type() {
    $MYSQL -e "
    SELECT DATA_TYPE
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA='CollegeDB'
    AND TABLE_NAME='Student'
    AND COLUMN_NAME='$1';
    "
}

# Function: Get column length
get_length() {
    $MYSQL -e "
    SELECT CHARACTER_MAXIMUM_LENGTH
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA='CollegeDB'
    AND TABLE_NAME='Student'
    AND COLUMN_NAME='$1';
    "
}

# Function: Get NULL status
get_nullable() {
    $MYSQL -e "
    SELECT IS_NULLABLE
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA='CollegeDB'
    AND TABLE_NAME='Student'
    AND COLUMN_NAME='$1';
    "
}


# --------------------------------------------------
# TEST 3 - StudentID INT
# --------------------------------------------------

if [ "$(get_type StudentID)" = "int" ]; then
    pass "StudentID is INT"
else
    fail "StudentID is not INT"
fi


# --------------------------------------------------
# TEST 4 - StudentID NOT NULL
# --------------------------------------------------

if [ "$(get_nullable StudentID)" = "NO" ]; then
    pass "StudentID is NOT NULL"
else
    fail "StudentID is NULL allowed"
fi


# --------------------------------------------------
# TEST 5 - StudentID PRIMARY KEY
# --------------------------------------------------

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


# --------------------------------------------------
# TEST 6 - StudentName VARCHAR(20)
# --------------------------------------------------

NAME_TYPE=$(get_type StudentName)
NAME_LENGTH=$(get_length StudentName)

if [ "$NAME_TYPE" = "varchar" ] && [ "$NAME_LENGTH" = "20" ]; then
    pass "StudentName is VARCHAR(20)"
else
    fail "StudentName is not VARCHAR(20)"
fi


# --------------------------------------------------
# TEST 7 - StudentName NOT NULL
# --------------------------------------------------

if [ "$(get_nullable StudentName)" = "NO" ]; then
    pass "StudentName is NOT NULL"
else
    fail "StudentName is NULL allowed"
fi


# --------------------------------------------------
# TEST 8 - StudentName UNIQUE
# --------------------------------------------------

UNIQUE_NAME=$($MYSQL -e "
SELECT COUNT(*)
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='StudentName'
AND NON_UNIQUE=0
AND INDEX_NAME <> 'PRIMARY';
")

if [ "$UNIQUE_NAME" -ge 1 ]; then
    pass "StudentName has UNIQUE constraint"
else
    fail "StudentName does not have UNIQUE constraint"
fi


# --------------------------------------------------
# TEST 9 - DOB DATE
# --------------------------------------------------

if [ "$(get_type DOB)" = "date" ]; then
    pass "DOB is DATE"
else
    fail "DOB is not DATE"
fi


# --------------------------------------------------
# TEST 10 - DOB NOT NULL
# --------------------------------------------------

if [ "$(get_nullable DOB)" = "NO" ]; then
    pass "DOB is NOT NULL"
else
    fail "DOB is NULL allowed"
fi


# --------------------------------------------------
# TEST 11 - Gender VARCHAR(10)
# --------------------------------------------------

GENDER_TYPE=$(get_type Gender)
GENDER_LENGTH=$(get_length Gender)

if [ "$GENDER_TYPE" = "varchar" ] && [ "$GENDER_LENGTH" = "10" ]; then
    pass "Gender is VARCHAR(10)"
else
    fail "Gender is not VARCHAR(10)"
fi


# --------------------------------------------------
# TEST 12 - Gender NOT NULL
# --------------------------------------------------

if [ "$(get_nullable Gender)" = "NO" ]; then
    pass "Gender is NOT NULL"
else
    fail "Gender is NULL allowed"
fi


# --------------------------------------------------
# TEST 13 - DepartmentID INT
# --------------------------------------------------

if [ "$(get_type DepartmentID)" = "int" ]; then
    pass "DepartmentID is INT"
else
    fail "DepartmentID is not INT"
fi


# --------------------------------------------------
# TEST 14 - DepartmentID NOT NULL
# --------------------------------------------------

if [ "$(get_nullable DepartmentID)" = "NO" ]; then
    pass "DepartmentID is NOT NULL"
else
    fail "DepartmentID is NULL allowed"
fi


# --------------------------------------------------
# FINAL RESULT
# --------------------------------------------------

FAILED=$((TOTAL - PASS))

echo ""
echo "=========================================="
echo "        AUTO GRADING RESULT"
echo "=========================================="
echo "Total Tests : $TOTAL"
echo "Passed      : $PASS"
echo "Failed      : $FAILED"
echo "Score       : $PASS / $TOTAL"
echo "=========================================="

if [ "$FAILED" -eq 0 ]; then
    echo "🎉 ALL TEST CASES PASSED"
    exit 0
else
    echo "❌ SOME TEST CASES FAILED"
    exit 1
fi

