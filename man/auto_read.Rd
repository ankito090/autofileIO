\name{auto_read}
\alias{auto_read}
\title{Automatically Read Data from Files or SQL Database Tables}
\description{
  Automatically detects whether the input \code{x} is a file path or a database connection.
  If \code{x} is a file path (a character string corresponding to an existing file), the function reads the file using
  the appropriate method (\code{read_excel()} for Excel files or \code{read_delim()} for delimited text files).
  If \code{x} is a DBI connection, it reads the table specified by the \code{name} argument using \code{dbReadTable()}.
}
\usage{
auto_read(x, name, col_names = TRUE, na = c("", "NA"), skip = 0, 
          n_max = Inf, trim_ws = FALSE, guess_max = min(1000, n_max), 
          name_repair = "unique", sheet = 1, range = NULL, delim = NULL, 
          comment = "", quote = "\"", escape_backslash = FALSE, 
          escape_double = TRUE, skip_empty_rows = TRUE, drop_na = FALSE)
}
\arguments{
  \item{x}{
    Either a character string specifying the path to an existing file, or a DBI connection object.
    For file-based reading, the file extension determines the reading method.
    For a database connection, the table specified by \code{name} is read.
  }
  \item{name}{
    A character string specifying the table name in a database.
    This argument is required when \code{x} is a DBI connection and must not be provided when \code{x} is a file path.
  }
  \item{col_names}{
    For file-based reading, a logical value or a character vector indicating whether to use the first row as column names.
    Defaults to \code{TRUE} for file-based reading. Not applicable to database connections.
  }
  \item{na}{
    For file-based reading, a character vector of strings to interpret as missing values.
    Defaults to \code{c("", "NA")}. Not applicable to database connections.
  }
  \item{skip}{
    For file-based reading, the number of lines to skip before reading data.
    Defaults to \code{0}. Not applicable to database connections.
  }
  \item{n_max}{
    For file-based reading, the maximum number of rows to read.
    Defaults to \code{Inf}. Not applicable to database connections.
  }
  \item{trim_ws}{
    For file-based reading, a logical value indicating whether to trim leading and trailing whitespace.
    Defaults to \code{FALSE}. Not applicable to database connections.
  }
  \item{guess_max}{
    For file-based reading, the number of rows used to guess column types.
    Defaults to \code{min(1000, n_max)}. Not applicable to database connections.
  }
  \item{name_repair}{
    For file-based reading, a method or function to repair column names.
    Defaults to \code{"unique"}. Not applicable to database connections.
  }
  \item{sheet}{For Excel files, the sheet number or name to read. Default is \code{1}. Not applicable to delimited text files or database connections.}
  \item{range}{For Excel files, a cell range to read (e.g., \code{"A1:D10"}). Default is \code{NULL}. Not applicable to delimited text files or database connections.}
  \item{delim}{For text-delimited files, the delimiter (e.g., \code{","}, \code{"\t"}, \code{"|"}). Default is \code{NULL} (auto-detected). Not applicable to Excel files or database connections.}
  \item{comment}{
    For delimited text files, a character string that specifies a comment marker; lines beginning with this string are ignored.
    Defaults to \code{""}. Not applicable to Excel files or database connections.
  }
  \item{quote}{
    For delimited text files, the character used for quoting string values.
    Defaults to \code{"\""} (a double quote). Not applicable to Excel files or database connections.
  }
  \item{escape_backslash}{
    For delimited text files, a logical value indicating whether to use backslashes for escaping.
    Defaults to the behavior of \code{read_delim()} if not provided.
    Not applicable to Excel files or database connections.
  }
  \item{escape_double}{
    For delimited text files, a logical value indicating whether quotes within fields are escaped by doubling.
    Defaults to the behavior of \code{read_delim()} if not provided.
    Not applicable to Excel files or database connections.
  }
  \item{skip_empty_rows}{
    For delimited text files, a logical value indicating whether to skip empty rows.
    Defaults to \code{TRUE}. Not applicable to Excel files or database connections.
  }
  \item{drop_na}{If \code{TRUE}, drops all rows containing NA values after reading the data. Default is \code{FALSE}.}
}
\value{
  Tibble containing the dataset from the specified file.
}
\examples{
# Locate the example files inside the package
csv_file <- system.file("extdata", "Pizza-Sales-Report.csv", package = "autofileIO")
tsv_file <- system.file("extdata", "Pizza-Sales-Report.tsv", package = "autofileIO")
delimited_text_file <- system.file("extdata", "Pizza-Sales-Report.txt", package = "autofileIO")
excel_file <- system.file("extdata", "Pizza-Sales-Report.xlsx", package = "autofileIO")
sqlite_file <- system.file("extdata", "Pizza-Sales-Report.db", package = "autofileIO")

# Read a CSV file
auto_read(csv_file)

# Read a TSV file
auto_read(tsv_file)

# Read a delimited text file
auto_read(delimited_text_file)

# Read an Excel file (first sheet)
auto_read(excel_file)

# Read a table from a sql database connection
library(DBI)
library(RSQLite)
conn <- dbConnect(RSQLite::SQLite(), sqlite_file)
auto_read(conn, name = "SalesReport") 
dbDisconnect(conn)

# Drop NA values after reading
auto_read(csv_file, drop_na = TRUE)
}