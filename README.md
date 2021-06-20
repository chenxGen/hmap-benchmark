# hmap-benchmark

Benckmark Project for cocoapods plugin [cocoapods-project-hmap](https://github.com/chenxGen/cocoapods-project-hmap).

## Requirement

- Install bundler : `sudo gem install bundler`

## Usage

- run benckmark for demo project : `ruby run_benchmark.rb --cases='[[100, 200], [1, 200]]' --build-times=3`
  - **cases :** The string with an array of test case, each case is also an array, the first number is the source files to add, the second number is the pods to add, all available pods list in : `available_pods.rb`, you can add your pod here.
  - **build-times :** Build time for each build task, if we have M cases, it will build M\*build_times\*2 times.

- run benckmark for any other project: Make sure you had installed [cocoapods-project-hmap](https://github.com/chenxGen/cocoapods-project-hmap), and then run command `ruby run_for_any_project.rb --project=path/to/your/project/root --build-times=3`
  - **project :** Directory of the project you want to run benckmark.
  - **build-times :** Build time for each build task, it will build build_times\*2 times.
