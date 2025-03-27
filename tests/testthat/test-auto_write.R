library(readr)
library(readxl)
library(DBI)
library(RSQLite)

# Test the auto_write() function
describe("auto_write()", {

  # Create a sample dataset
  cs50_instructors <- data.frame(
    "Name" = c("David J. Malan", "Carter Zenke"),
    "Harvard Email" = c("malan@harvard.edu", "carter@cs50.harvard.edu")
  )

  # Create temporary file names for each supported format
  temp_csv   <- tempfile(fileext = ".csv")
  temp_tsv   <- tempfile(fileext = ".tsv")
  temp_txt   <- tempfile(fileext = ".txt")
  temp_dat   <- tempfile(fileext = ".dat")
  temp_log   <- tempfile(fileext = ".log")
  temp_xlsx  <- tempfile(fileext = ".xlsx")
  temp_sqlitedb  <- tempfile(fileext = ".db")

  # Test writing files (CSV, TSV, TXT, DAT, LOG, XLSX)
  it("correctly writes supported file formats", {
    auto_write(cs50_instructors, x = temp_csv)
    auto_write(cs50_instructors, x = temp_tsv)
    auto_write(cs50_instructors, x = temp_txt)
    auto_write(cs50_instructors, x = temp_dat)
    auto_write(cs50_instructors, x = temp_log)
    auto_write(cs50_instructors, x = temp_xlsx)

    csv <- read_csv(temp_csv)
    tsv <- read_tsv(temp_tsv)
    txt <- read_delim(temp_txt)
    dat <- read_delim(temp_dat)
    log <- read_delim(temp_log)
    xlsx <- read_excel(temp_xlsx)

    expect_equal(as.data.frame(cs50_instructors), as.data.frame(csv))
    expect_equal(as.data.frame(cs50_instructors), as.data.frame(tsv))
    expect_equal(as.data.frame(cs50_instructors), as.data.frame(txt))
    expect_equal(as.data.frame(cs50_instructors), as.data.frame(dat))
    expect_equal(as.data.frame(cs50_instructors), as.data.frame(log))
    expect_equal(as.data.frame(cs50_instructors), as.data.frame(xlsx))
  })

  # Test writing to a SQLite database connection
  it("correctly writes a table to a database connection", {
    conn <- dbConnect(SQLite(), temp_sqlitedb)
    auto_write(cs50_instructors, x = conn, name = "CS50 Instructors")

    sqlite <- dbReadTable(conn, "CS50 Instructors")

    expect_equal(as.data.frame(cs50_instructors), as.data.frame(sqlite))

    dbDisconnect(conn)
  })

  # Test error is raised when x is neither an existing file nor a DBI connection
  it(
    paste(
      "raises an error when x is neither a valid file path",
      "nor a database connection"
    ),
    {
      expect_error(auto_write(cs50_instructors, x = "unknown"))
    }
  )

  # Test error when the file extension is not supported
  it("raises an error when the file has unsupported extension", {
    expect_error(auto_write(cs50_instructors, x = "unknown.json"))
  })

  # Test error when the 'name' argument is missing for database connections
  it(
    paste(
      "raises an error when the name argument is not",
      "provided for database connections"
    ),
    {
      conn <- dbConnect(SQLite(), temp_sqlitedb)
      expect_error(auto_write(cs50_instructors, x = conn))
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
      expect_error(auto_write(cs50_instructors, x = temp_xlsx, delim = ","))
      expect_error(auto_write(cs50_instructors, x = temp_xlsx, na = "NA"))
      expect_error(
        auto_write(cs50_instructors, x = temp_xlsx, append = TRUE)
      )
      expect_error(
        auto_write(cs50_instructors, x = temp_xlsx, quote = "needed")
      )
      expect_error(
        auto_write(cs50_instructors, x = temp_xlsx, escape = "double")
      )
      expect_error(
        auto_write(cs50_instructors, x = temp_xlsx, eol = "\n")
      )
    }
  )

  # Test error when excel files arguments are provided for text-delimited files
  it(
    paste(
      "raises an error when excel files arguments are provided",
      "for text-delimited files"
    ),
    {
      expect_error(auto_write(cs50_instructors, x = temp_csv, use_zip64 = TRUE))
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
      conn <- dbConnect(SQLite(), temp_sqlitedb)
      expect_error(auto_write(
        cs50_instructors, x = conn, name = "CS50 Instructors", use_zip64 = TRUE
      ))
      expect_error(auto_write(
        cs50_instructors, x = conn, name = "CS50 Instructors", delim = ","
      ))
      expect_error(auto_write(
        cs50_instructors, x = conn, name = "CS50 Instructors", na = "NA"
      ))
      expect_error(auto_write(
        cs50_instructors, x = conn, name = "CS50 Instructors", quote = "needed"
      ))
      expect_error(auto_write(
        cs50_instructors, x = conn, name = "CS50 Instructors", escape = "double"
      ))
      expect_error(auto_write(
        cs50_instructors, x = conn, name = "CS50 Instructors", eol = "\n"
      ))
      dbDisconnect(conn)
    }
  )

})