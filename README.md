# autofileIO
![Main Menu](resources/logo.png)
#### By Ankit AKash Kalita
#### Video Overview: https://youtu.be/Jhf7FcmeQ-k?si=TQ5PdTLgK_qSEvsS

## Package Overview

autofileIO is an R package designed to simplify file input and output operations. It provides a unified interface for reading and writing various file formats without the need to switch between different functions or packages.

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

## Function Overview

- **`supported_formats()`:** List Supported and Unsupported File Formats

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
  
- **`auto_read()`:** Automatically Read Data from Files or SQL Database Tables

    **Examples:**
    ```r
    
    ```

