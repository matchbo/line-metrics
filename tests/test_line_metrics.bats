#!/usr/local/bin/bats

setup() {
  # Check if in the correct directory by looking for a specific file or folder
  if [ ! -f "data/test.sh" ]; then
    echo "You must run this script from the correct directory. Exiting."
    exit 1
  fi
}

@test "Check with -l 50 max line length and -n 5 number of lines" {
  run ../line_metrics.sh -l 50 -n 5 ./data/test.py
  echo "Debug: status = $status, output = $output"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 4 ] # There should be 4 long lines, less than the requested 5
  expected=$(cat << END
12,131:print("Another extremely long line that far surpasses the 120 character limit to serve as an example. xxxxxxxxxxxxxxxxxxxxxxxxxxx")
6,131:print("This is an example Python line that is so incredibly, exceedingly, amazingly long that it exceeds the 120 character limit.")
5,65:# The next line is intentionally much longer than 120 characters.
1,57:# This is an example Python file for line length testing.
END
)
  [ "$output" == "$expected" ]
}

@test "check default returns all lines" {
  run ../line_metrics.sh ./data/sentence.txt
  echo "Debug: status = $status, output = $output"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 9 ]
  expected=$(cat << END
5,6:jumped
2,5:quick
3,5:brown
6,4:over
8,4:lazy
1,3:The
4,3:fox
7,3:the
9,3:dog
END
)
  [ "$output" == "$expected" ]
}

@test "Check with -n 2 lines" {
  run ../line_metrics.sh -n 2 ./data/sentence.txt
  echo "Debug: status = $status, output = $output"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 2 ]
}

@test "Check with -l 80 max line length" {
  run ../line_metrics.sh -l 80 ./data/test.c
  echo "Debug: status = $status, output = $output"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 2 ] # There should be 2 long lines
}

@test "Check for non-existent file" {
  run ../line_metrics.sh ./data/non_existent.txt
  echo "Debug: status = $status, output = $output"
  [ "$status" -eq 1 ]
}

@test "Check with -l 120 max line length" {
  run ../line_metrics.sh -l 120 ./data/test.py
  echo "Debug: status = $status, output = $output"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 2 ] # There should be 2 long lines
}