# Load the required packages
library(DBI)
library(RSQLite)

# Test the auto_read() function
describe("auto_read()", {

  # Define paths to the example files in inst/extdata/
  csv_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.csv",
    package = "autofileIO"
  )
  tsv_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.tsv",
    package = "autofileIO"
  )
  txt_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.txt",
    package = "autofileIO"
  )
  dat_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.dat",
    package = "autofileIO"
  )
  log_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.log",
    package = "autofileIO"
  )
  xlsx_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.xlsx",
    package = "autofileIO"
  )
  xls_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.xls",
    package = "autofileIO"
  )
  sqlite_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.db",
    package = "autofileIO"
  )
  json_file <- system.file(
    "extdata",
    "Pizza-Sales-Report.json",
    package = "autofileIO"
  )

  # Test reading delimited text files (CSV, TSV, TXT, DAT, LOG)
  it("reads delimited text files of the supported formats", {
    expect_s3_class(auto_read(csv_file), "tbl_df")
    expect_s3_class(auto_read(tsv_file), "tbl_df")
    expect_s3_class(auto_read(txt_file), "tbl_df")
    expect_s3_class(auto_read(dat_file), "tbl_df")
    expect_s3_class(auto_read(log_file), "tbl_df")
  })

  # Test reading Excel files (XLSX and XLS)
  it("reads excel files of the supported formats", {
    expect_s3_class(auto_read(xlsx_file), "tbl_df")
    expect_s3_class(auto_read(xls_file), "tbl_df")
  })

  # Test reading from a SQLite database connection
  it("reads a table from a sql database connection", {
    conn <- dbConnect(SQLite(), sqlite_file)
    expect_s3_class(auto_read(conn, "SalesReport"), "tbl_df")
    dbDisconnect(conn)
  })

  # Test error is raised when x is neither an existing file nor a DBI connection
  it(
    paste(
      "raises an error when x is neither a valid file path",
      "nor a database connection"
    ),
    {
      expect_error(auto_read("unknown"))
    }
  )

  # Test error when the file extension is not supported
  it("raises an error when the file has unsupported extension", {
    expect_error(auto_read(json_file))
  })

  # Test error when the 'name' argument is missing for database connections
  it(
    paste(
      "raises an error when the name argument is not",
      "provided for database connections"
    ),
    {
      conn <- dbConnect(SQLite(), sqlite_file)
      expect_error(auto_read(conn))
      dbDisconnect(conn)
    }
  )

  # Test error when text-delimited files arguments are provided for excel files
  it(
    paste(
      "raises an error when text-delimited files arguments are provided",
      "for excel files"
    ),
    {
      expect_error(auto_read(xlsx_file, delim = " "))
      expect_error(auto_read(xls_file, delim = " "))

      expect_error(auto_read(xlsx_file, comment = ""))
      expect_error(auto_read(xls_file, comment = ""))

      expect_error(auto_read(xlsx_file, quote = "\""))
      expect_error(auto_read(xls_file, quote = "\""))

      expect_error(auto_read(xlsx_file, escape_backslash = FALSE))
      expect_error(auto_read(xls_file, escape_backslash = FALSE))

      expect_error(auto_read(xlsx_file, escape_double = TRUE))
      expect_error(auto_read(xls_file, escape_double = TRUE))

      expect_error(auto_read(xlsx_file, skip_empty_rows =  TRUE))
      expect_error(auto_read(xls_file, skip_empty_rows =  TRUE))
    }
  )

  # Test error when excel files arguments are provided for text-delimited files
  it(
    paste(
      "raises an error when excel files arguments are provided",
      "for text-delimited files"
    ),
    {
      expect_error(auto_read(csv_file, sheet = 1))
      expect_error(auto_read(csv_file, range = "A1:D4"))
    }
  )

  # Test error when text-delimited and excel file arguments are provided
  # for a database connection
  it(
    paste(
      "raises an error when text-delimited and excel files arguments",
      "are provided for database connection"
    ),
    {
      conn <- dbConnect(SQLite(), sqlite_file)
      expect_error(auto_read(conn, name = "SalesReport", sheet = 1))
      expect_error(auto_read(conn, name = "SalesReport", range = "A1:D4"))
      expect_error(auto_read(conn, name = "SalesReport", delim = " "))
      expect_error(auto_read(conn, name = "SalesReport", comment = ""))
      expect_error(auto_read(conn, name = "SalesReport", quote = "\""))
      expect_error(
        auto_read(conn, name = "SalesReport", escape_backslash = FALSE)
      )
      expect_error(auto_read(conn, name = "SalesReport", escape_double = TRUE))
      expect_error(
        auto_read(conn, name = "SalesReport", skip_empty_rows =  TRUE)
      )
      dbDisconnect(conn)
    }
  )

  # Test error when drop_na argument is not logical
  it("raises an error when the drop_na argument is not logical", {
    expect_error(auto_read(csv_file, drop_na = "Yes"))
  })

  # Test drop NA values when drop_na is TRUE
  it("drops na values when drop_na is TRUE", {
    data <- auto_read(csv_file, na = "NA", drop_na = TRUE)
    expect_false(any(is.na(data)))
  })

})
