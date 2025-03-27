\name{auto_write}
\alias{auto_write}
\title{Automatically Write Data to Files or SQL Database Tables}
\description{
  Automatically detects whether the input \code{x} is a file path or a database connection.
  If \code{x} is a file path (a character string corresponding to a valid file extension), the function writes the file using
  the appropriate method (\code{write_xlsx()} for Excel files or \code{write_delim()} for delimited text files).
  If \code{x} is a DBI connection, it writes the data to a database table specified by the \code{name} argument using \code{dbWriteTable()}.
}
\usage{
auto_write(object, x, name, col_names, append = FALSE, use_zip64 = FALSE, 
           delim, na = "NA", quote = "needed", escape = "double", eol = "\n", 
           row.names = FALSE, overwrite = FALSE)
}
\arguments{
  \item{object}{
    A data frame, tibble, or similar object containing the data to be written.
  }
  \item{x}{
    Either a character string specifying the file path where the data should be written, or a DBI connection object. 
    In the case of file paths, the file extension determines the writing method.
  }
  \item{name}{
    For database connections, a character string specifying the name of the table to write the data into.
    This argument is required when \code{x} is a DBI connection and must not be provided when \code{x} is a file path.
  }
  \item{col_names}{
    For file-based writing, a logical value or character vector indicating whether to write column names.
    Defaults to \code{TRUE} for Excel files and to \code{!append} for delimited text files.
    Not applicable to database connections.
  }
  \item{append}{
    For delimited text files, a logical value indicating whether to append data to an existing file.
    For database connections, this controls whether to append rows to an existing table.
    Defaults to \code{FALSE}. Not applicable to Excel files.
  }
   \item{use_zip64}{
    For Excel files, a logical value indicating whether to use ZIP64 format (necessary for files larger than 4GB).
    Defaults to \code{FALSE}. Not applicable to delimited text files or database connections.
  }
  \item{delim}{
    For delimited text files, a character string specifying the delimiter to use.
    If missing, the default is determined by the file extension (e.g., \code{","} for CSV, \code{"\t"} for TSV, 
    \code{" "} for other text formats).
    Not applicable to Excel files or database connections.
  }
  \item{na}{
    For delimited text files, a character vector of strings to interpret as missing values.
    Defaults to \code{"NA"}. Not applicable to Excel files or database connections.
  }
  \item{quote}{
    For delimited text files, a character string indicating the quoting style for string fields.
    Defaults to \code{"needed"}. Not applicable to Excel files or database connections.
  }
  \item{escape}{
    For delimited text files, specifies how quotes inside fields are escaped. 
    Defaults to \code{"double"}. Not applicable to Excel files or database connections.
  }
  \item{eol}{
    For delimited text files, a character string specifying the end-of-line character.
    Defaults to \code{"\n"}. Not applicable to Excel files or database connections.
  }
  \item{row.names}{
    For database connections, a logical value indicating whether to include row names when writing the table.
    Defaults to \code{FALSE}. Not applicable to file-based writing.
  }
  \item{overwrite}{
    For database connections, a logical value indicating whether to overwrite an existing table.
    Defaults to \code{FALSE}. Not applicable to file-based writing.
  }
}
\value{
  The function writes the specified file and returns \code{NULL} invisibly.
}
\examples{
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

# Write to a CSV file
auto_write(cs50_instructors, x = temp_csv)

# Write to a TSV file
auto_write(cs50_instructors, x = temp_tsv)

# Write to a delimited text file
auto_write(cs50_instructors, x = temp_txt)
auto_write(cs50_instructors, x = temp_dat)
auto_write(cs50_instructors, x = temp_log)

# Write to an Excel file (first sheet)
auto_write(cs50_instructors, x = temp_xlsx)

# Write to a SQL database
library(DBI) 
library(RSQLite)
conn <- dbConnect(SQLite(), temp_sqlitedb)
auto_write(cs50_instructors, x = conn, name = "CS50 Instructors") 
}
