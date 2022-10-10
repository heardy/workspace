### Find files

`find . -name '*.svelte'`

##### Case insensitive

`find . -iname '*.svelte'`

##### Max depth

`find . -iname "*portal*" -maxdepth 2`

##### Exlude folders

`find . -name '*.svelte' -not -path './node_modules/*'`

-or-

Use the -`prune` primary. For example, if you want to exclude `./misc`:

`find . -path ./misc -prune -o -name '*.txt' -print`

To exclude multiple directories, OR them between parentheses.

`find . -type d \( -path ./dir1 -o -path ./dir2 -o -path ./dir3 \) -prune -o -name '*.txt' -print`

And, to exclude directories with a specific name at any level, use the -name primary instead of -path.

`find . -type d -name node_modules -prune -o -name '*.json' -print`

### Find string in files

Example of finding the node version within all node module package.json files

`grep -ho '"node":.*' node_modules/*/package.json | sort`

