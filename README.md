# README

## Getting Started

### Installing

`$ git clone https://github.com/carrola7/availability_checker.git`

### Running tests

Navigate to the project directory and `$ rake test`

### Usage

Navigate to the project directory and `$ ./bin/check`

### About

The executable command kicks off an instance of `AvailabilityChecker::CLI`, which handles the command line interface logic. The main function of this is to set the appropriate path to the CSV file to be processed. It was not clear from the requirements where the user would get the CSV file from so I included options to specify relative and absolute paths as well as processing a default path. The `print_schedule` method then creates an instance of `AvailabilityChecker::Schedule`, which is essentially a wrapper object for the CSV path. This object has a method `#find_doctor`, which accepts a single argument (day of the week) and a block. It will find all the doctor's names that are available on the given day and yield them to the block.

I made the decision not to read the entire CSV file into memory. It is not clear how big this CSV file may get so I thought it was important to avoid future bottlenecks. Also, as we are simply printing availability to the console it would not be a huge benefit at this stage reading the file into memory. The result of this decision meant I had to do without the convenience of instantiating a `CSV` object with headers. I thought the trade off of creating a new class, `AvailabilityChecker::Schedule::Row` was acceptable.



