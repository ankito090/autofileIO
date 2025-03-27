# Function: supported_formats
supported_formats <- function() {
  cat(
    "\u2705 CSV (Comma-Separated Values): .csv",
    "\u2705 TSV (Tab-Separated Values): .tsv",
    "\u2705 TXT (Plain Text): .txt",
    "\u2705 DAT (Data File): .dat",
    "\u2705 LOG (Log File): .log",
    "\u2705 Excel: .xls ( only for reading files), .xlsx",
    "\u2705 SQL Databases: DBI connections (e.g., SQLite, PostgreSQL, etc.)",
    "\u274C JSON (JavaScript Object Notation): .json",
    "\u274C RData (R Data File): .RData, .rda",
    "\u274C RDS (R Data Serialization Format): .rds",
    "\u274C SQL (Structured Query Language): .sql",
    "\u274C HTML (HyperText Markup Language): .html",
    "\u274C HDF5 (Hierarchical Data Format): .h5, .hdf5",
    "\u274C Feather (Apache Feather): .feather",
    "\u274C Parquet (Apache Parquet): .parquet",
    "\u274C Stata (Stata Data Format): .dta",
    "\u274C SPSS (Statistical Package for the Social Sciences): .sav",
    "\u274C SAS (Statistical Analysis System): .sas7bdat",
    "\u274C XML (Extensible Markup Language): .xml",
    "\u274C YAML (Yet Another Markup Language): .yaml, .yml",
    sep = "\n"
  )
}
