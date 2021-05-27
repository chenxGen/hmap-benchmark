# hmap-benchmark

- Method 1 : build whole project with M source files and N pod targets
- Method 2 : build one source file with with N pod targets for 1000 times
- Method 3 : preprocess one source file with with N pod targets for 1000 times

## OPT

- set all pod targets use header map to false

  > DISCUSS: private/project header

- remove all search path for project not require a pod
