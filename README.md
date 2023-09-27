# line-metrics
This script takes a filename as an argument and returns either the lines greater than a max line length, or the lines sorted by line length (highest number of characters, excluding newline).

It takes two possible arguments:
-n: The max number of lines to return
-l, --length: The max line length. Any lines longer than this length are returned.

## Installation
No additional dependencies required. Clone the repository and make the script executable.

```bash
chmod +x line_metrics.sh
```

## Usage
```bash
./line_metrics.sh filename.txt
```

## Options
 - **-l** or **length** to give a max line length. Any lines longer than this length will be displayed.
 - **-n** limits the max number of lines displayed to this number.

## License
MIT License
