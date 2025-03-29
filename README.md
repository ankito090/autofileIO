# autofileIO
![](man/figures/logo.png)
#### By Ankit AKash Kalita
#### Video Overview: https://youtu.be/Jhf7FcmeQ-k?si=TQ5PdTLgK_qSEvsS

## Package Overview

**autofileIO** is an R package designed to simplify file input and output operations. It provides a unified interface for reading and writing various file formats without the need to switch between different functions or packages.

## Main Files 
- **`R/`:** Contains the core R scripts that define the package's functions.  
- **`man/`:** Stores documentation files (`.Rd` files) for each function.  
- **`inst/`:** Holds example datasets.  
- **`tests/`:** Contains unit tests for validating the functionality of the package.  
- **`DESCRIPTION`:** Provides metadata about the package (e.g., name, version, author, dependencies).  
- **`NAMESPACE`:** Lists the functions that are exported for users and those that are imported from other packages.  
- **`LICENSE`:** Defines the licensing terms for your package.  
- **`autofileIO.Rproj`:** RStudio project file for managing the development environment.  
- **`.Rbuildignore`:** Specifies files (like `.Rproj.user/`) that should be excluded from the built package.

## Installation

* **Step 1: Install `devtools` (if not already installed):**

    The `devtools` package is required to install packages from GitHub. If it is not installed, run:

    ```r
    install.packages("devtools")
    ```

* **Step 2: Install `autofileIO` from GitHub:**
    
    Use `devtools::install_github()` to install the package:

    ```r
    devtools::install_github("ankito090/autofileIO")
    ```

* **Step 3:**
    Check if the package was installed successfully by running:

    ```r
    find.package("autofileIO")
    ```

    The `find.package()` function will search for the package in the library paths. If the package is installed, it returns the file path; otherwise, it will throw an error.


* **Step 4: Load the Package**

    Upon successful installation, load the package into your R session:

    ```r
    library(autofileIO)
    ```


## Function Overview

- ### **`supported_formats()`:** List Supported and Unsupported File Formats.

    **Example:**
    ```r
    supported_formats()
    #> ✅ CSV (Comma-Separated Values): .csv
    #> ✅ TSV (Tab-Separated Values): .tsv
    #> ✅ TXT (Plain Text): .txt
    #> ✅ DAT (Data File): .dat
    #> ✅ LOG (Log File): .log
    #> ✅ Excel: .xls (only for reading files), .xlsx
    #> ✅ SQL Databases: DBI connections (e.g., SQLite, PostgreSQL, etc.)
    #> ❌ JSON (JavaScript Object Notation): .json
    #> ❌ RData (R Data File): .RData, .rda
    #> ❌ RDS (R Data Serialization Format): .rds
    #> ❌ SQL (Structured Query Language): .sql
    #> ❌ HTML (HyperText Markup Language): .html
    #> ❌ HDF5 (Hierarchical Data Format): .h5, .hdf5
    #> ❌ Feather (Apache Feather): .feather
    #> ❌ Parquet (Apache Parquet): .parquet
    #> ❌ Stata (Stata Data Format): .dta
    #> ❌ SPSS (Statistical Package for the Social Sciences): .sav
    #> ❌ SAS (Statistical Analysis System): .sas7bdat
    #> ❌ XML (Extensible Markup Language): .xml
    #> ❌ YAML (Yet Another Markup Language): .yaml, .yml
    ```
  
- ### **`auto_read()`:** Automatically Read Data from Files or SQL Database Tables.

    **Examples:**

    The **autofileIO** package includes sample datasets stored in the `inst/extdata` directory.  
    These datasets can be accessed using `system.file()`:
    ```r
    csv_file <- system.file("extdata", "Pizza-Sales-Report.csv", package = "autofileIO")
    tsv_file <- system.file("extdata", "Pizza-Sales-Report.tsv", package = "autofileIO")
    delimited_text_file <- system.file("extdata", "Pizza-Sales-Report.txt", package = "autofileIO")
    excel_file <- system.file("extdata", "Pizza-Sales-Report.xlsx", package = "autofileIO")
    sqlite_file <- system.file("extdata", "Pizza-Sales-Report.db", package = "autofileIO")
    ```
    Read a csv file:
    ```r
    auto_read(csv_file)
    #> # A tibble: 104 x 11
    #>    OrderID `Date-time` Time     `Customer Name` `Pizza Type` `Pizza Name`   `Pizza Size`
    #>      <dbl> <chr>       <time>   <chr>           <chr>        <chr>          <chr>       
    #>  1    1061 01-01-2023  13:15:08 Chris Lee       Veg          Pepperoni Piz~ Small       
    #>  2    1001 01-01-2023  22:01:11 Jane Smith      Veg          Pepperoni Piz~ Medium      
    #>  3    1083 01-01-2023  16:38:46 Chris Lee       Veg          Hawaiian Pizza Medium      
    #>  4    1041 01-01-2023  16:13:19 Laura Jackson   Non-Veg      Margherita Pi~ Small       
    #>  5    1003 04-01-2023  21:10:17 Laura Jackson   Veg          Veggie Suprem~ Small       
    #>  6    1089 04-01-2023  21:10:17 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  7    1089 04-01-2023  11:50:18 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  8    1020 30-01-2023  17:39:59 Michael Brown   Veg          Margherita Pi~ Large       
    #>  9    1017 01-02-2023  19:03:01 Robert Moore    Veg          Veggie Suprem~ Small       
    #> 10    1038 01-02-2023  19:28:28 Sarah Taylor    Veg          Veggie Suprem~ Medium      
    #> # i 94 more rows
    #> # i 4 more variables: `Unit Price` <dbl>, Quantity <dbl>, `Total Price` <dbl>,
    #> #   `Payment Method` <chr>
    ```
    Read a TSV file:
    ```r
    auto_read(tsv_file)
    #> # A tibble: 104 x 11
    #>    OrderID `Date-time` Time     `Customer Name` `Pizza Type` `Pizza Name`   `Pizza Size`
    #>      <dbl> <chr>       <time>   <chr>           <chr>        <chr>          <chr>       
    #>  1    1061 01-01-2023  13:15:08 Chris Lee       Veg          Pepperoni Piz~ Small       
    #>  2    1001 01-01-2023  22:01:11 Jane Smith      Veg          Pepperoni Piz~ Medium      
    #>  3    1083 01-01-2023  16:38:46 Chris Lee       Veg          Hawaiian Pizza Medium      
    #>  4    1041 01-01-2023  16:13:19 Laura Jackson   Non-Veg      Margherita Pi~ Small       
    #>  5    1003 04-01-2023  21:10:17 Laura Jackson   Veg          Veggie Suprem~ Small       
    #>  6    1089 04-01-2023  21:10:17 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  7    1089 04-01-2023  11:50:18 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  8    1020 30-01-2023  17:39:59 Michael Brown   Veg          Margherita Pi~ Large       
    #>  9    1017 01-02-2023  19:03:01 Robert Moore    Veg          Veggie Suprem~ Small       
    #> 10    1038 01-02-2023  19:28:28 Sarah Taylor    Veg          Veggie Suprem~ Medium      
    #> # i 94 more rows
    #> # i 4 more variables: `Unit Price` <dbl>, Quantity <dbl>, `Total Price` <dbl>,
    #> #   `Payment Method` <chr>
    ```
    Read a delimited text file:
    ```r
    auto_read(delimited_text_file)
    #> # A tibble: 104 x 11
    #>    OrderID `Date-time` Time     `Customer Name` `Pizza Type` `Pizza Name`   `Pizza Size`
    #>      <dbl> <chr>       <time>   <chr>           <chr>        <chr>          <chr>       
    #>  1    1061 01-01-2023  13:15:08 Chris Lee       Veg          Pepperoni Piz~ Small       
    #>  2    1001 01-01-2023  22:01:11 Jane Smith      Veg          Pepperoni Piz~ Medium      
    #>  3    1083 01-01-2023  16:38:46 Chris Lee       Veg          Hawaiian Pizza Medium      
    #>  4    1041 01-01-2023  16:13:19 Laura Jackson   Non-Veg      Margherita Pi~ Small       
    #>  5    1003 04-01-2023  21:10:17 Laura Jackson   Veg          Veggie Suprem~ Small       
    #>  6    1089 04-01-2023  21:10:17 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  7    1089 04-01-2023  11:50:18 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  8    1020 30-01-2023  17:39:59 Michael Brown   Veg          Margherita Pi~ Large       
    #>  9    1017 01-02-2023  19:03:01 Robert Moore    Veg          Veggie Suprem~ Small       
    #> 10    1038 01-02-2023  19:28:28 Sarah Taylor    Veg          Veggie Suprem~ Medium      
    #> # i 94 more rows
    #> # i 4 more variables: `Unit Price` <dbl>, Quantity <dbl>, `Total Price` <dbl>,
    #> #   `Payment Method` <chr>
    ```
    Read an Excel file (first sheet):
    ```r
    auto_read(excel_file)
    #> # A tibble: 104 x 11
    #>    OrderID `Date-time` Time     `Customer Name` `Pizza Type` `Pizza Name`   `Pizza Size`
    #>      <dbl> <chr>       <time>   <chr>           <chr>        <chr>          <chr>       
    #>  1    1061 01-01-2023  13:15:08 Chris Lee       Veg          Pepperoni Piz~ Small       
    #>  2    1001 01-01-2023  22:01:11 Jane Smith      Veg          Pepperoni Piz~ Medium      
    #>  3    1083 01-01-2023  16:38:46 Chris Lee       Veg          Hawaiian Pizza Medium      
    #>  4    1041 01-01-2023  16:13:19 Laura Jackson   Non-Veg      Margherita Pi~ Small       
    #>  5    1003 04-01-2023  21:10:17 Laura Jackson   Veg          Veggie Suprem~ Small       
    #>  6    1089 04-01-2023  21:10:17 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  7    1089 04-01-2023  11:50:18 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  8    1020 30-01-2023  17:39:59 Michael Brown   Veg          Margherita Pi~ Large       
    #>  9    1017 01-02-2023  19:03:01 Robert Moore    Veg          Veggie Suprem~ Small       
    #> 10    1038 01-02-2023  19:28:28 Sarah Taylor    Veg          Veggie Suprem~ Medium      
    #> # i 94 more rows
    #> # i 4 more variables: `Unit Price` <dbl>, Quantity <dbl>, `Total Price` <dbl>,
    #> #   `Payment Method` <chr>
    ```
    Read a table from a sql database connection:
    ```r
    library(DBI)
    library(RSQLite)
    conn <- dbConnect(RSQLite::SQLite(), sqlite_file)
    auto_read(conn, name = "SalesReport")
    dbDisconnect(conn)
    #> # A tibble: 104 x 11
    #>    OrderID `Date-time` Time     `Customer Name` `Pizza Type` `Pizza Name`   `Pizza Size`
    #>      <dbl> <chr>       <time>   <chr>           <chr>        <chr>          <chr>       
    #>  1    1061 01-01-2023  13:15:08 Chris Lee       Veg          Pepperoni Piz~ Small       
    #>  2    1001 01-01-2023  22:01:11 Jane Smith      Veg          Pepperoni Piz~ Medium      
    #>  3    1083 01-01-2023  16:38:46 Chris Lee       Veg          Hawaiian Pizza Medium      
    #>  4    1041 01-01-2023  16:13:19 Laura Jackson   Non-Veg      Margherita Pi~ Small       
    #>  5    1003 04-01-2023  21:10:17 Laura Jackson   Veg          Veggie Suprem~ Small       
    #>  6    1089 04-01-2023  21:10:17 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  7    1089 04-01-2023  11:50:18 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>  8    1020 30-01-2023  17:39:59 Michael Brown   Veg          Margherita Pi~ Large       
    #>  9    1017 01-02-2023  19:03:01 Robert Moore    Veg          Veggie Suprem~ Small       
    #> 10    1038 01-02-2023  19:28:28 Sarah Taylor    Veg          Veggie Suprem~ Medium      
    #> # i 94 more rows
    #> # i 4 more variables: `Unit Price` <dbl>, Quantity <dbl>, `Total Price` <dbl>,
    #> #   `Payment Method` <chr>
    ```
    Drop NA values after reading:
    ```r
    auto_read(csv_file, drop_na = TRUE)
    #> # A tibble: 99 x 11
    #> OrderID `Date-time` Time     `Customer Name` `Pizza Type` `Pizza Name`   `Pizza Size`
    #>   <dbl> <chr>       <time>   <chr>           <chr>        <chr>          <chr>       
    #>   1    1061 01-01-2023  13:15:08 Chris Lee       Veg          Pepperoni Piz~ Small       
    #>   2    1001 01-01-2023  22:01:11 Jane Smith      Veg          Pepperoni Piz~ Medium      
    #>   3    1083 01-01-2023  16:38:46 Chris Lee       Veg          Hawaiian Pizza Medium      
    #>   4    1041 01-01-2023  16:13:19 Laura Jackson   Non-Veg      Margherita Pi~ Small       
    #>   5    1003 04-01-2023  21:10:17 Laura Jackson   Veg          Veggie Suprem~ Small       
    #>   6    1089 04-01-2023  21:10:17 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>   7    1089 04-01-2023  11:50:18 Sarah Taylor    Veg          Margherita Pi~ Large       
    #>   8    1020 30-01-2023  17:39:59 Michael Brown   Veg          Margherita Pi~ Large       
    #>   9    1017 01-02-2023  19:03:01 Robert Moore    Veg          Veggie Suprem~ Small       
    #>  10    1038 01-02-2023  19:28:28 Sarah Taylor    Veg          Veggie Suprem~ Medium      
    #>  # i 89 more rows
    #> # i 4 more variables: `Unit Price` <dbl>, Quantity <dbl>, `Total Price` <dbl>,
    #> #   `Payment Method` <chr>
    ```
    
-  ### **`auto_write()`:** Automatically detects the file type based on the provided extension and writes the data accordingly.

    **Examples:**

    Create a sample dataset:
    ```r
    sample_dataset <- data.frame(
      Name = c("Alice", "Bob", "Charlie", "David", "Eve"),
      Age = c(25, 30, 35, 40, 45)
    )
    ```
    Write to a CSV file:
    ```r
    auto_write(sample_dataset, x = "sample_dataset.csv")
    ```
    Write to a TSV file:
    ```r
    auto_write(sample_dataset, x = "sample_dataset.tsv")
    ```
    Write to a delimited text file:
    ```r
    auto_write(sample_dataset, x = "sample_dataset.txt")
    auto_write(sample_dataset, x = "sample_dataset.dat")
    auto_write(sample_dataset, x = "sample_dataset.log")
    ```
    Write to an Excel file:
    ```r
    auto_write(sample_dataset, x = "sample_dataset.xlsx")
    ```
    Write to a SQL database:
    ```r
    library(DBI) 
    library(RSQLite)
    conn <- dbConnect(SQLite(), "sample_dataset.db")
    auto_write(sample_dataset, x = conn, name = "sample_table") 
    ```

## Contribution

Contributions are welcome! If you encounter any issues or have ideas for enhancements, please feel free to submit an issue or pull request.
