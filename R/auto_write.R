# Function: auto_write
auto_write <- function(
  object,
  x,
  name,
  col_names,
  append,
  use_zip64,
  delim,
  na,
  quote,
  escape,
  eol,
  row.names,
  overwrite
) {
  if (is.character(x) && tools::file_ext(x) != "") {
    # Define supported file formats
    supported_formats <- c("csv", "tsv", "xlsx", "txt", "dat", "log")

    # Extract file extension and convert to lowercase
    file_extension <- stringr::str_to_lower(tools::file_ext(x = x))

    # Check if the file extension is supported
    if (!(file_extension %in% supported_formats)) {
      stop(paste("Unsupported file format:", file_extension))
    }

    # Ensure database connection related arguments are not provided for files
    unsupported_dbi_arguments <- c(
      "`name`" = !missing(name),
      "`row.names`" = !missing(row.names),
      "`overwrite`" = !missing(overwrite)
    )
    if (any(unsupported_dbi_arguments)) {
      stop(paste(
        "The",
        names(unsupported_dbi_arguments)[unsupported_dbi_arguments][1],
        "argument is not supported for",
        ifelse(
          file_extension %in% c("xlsx", "xls"),
          "Excel",
          file_extension
        ),
        "files."
      ))
    }

    # If file is an Excel spreadsheet
    if (file_extension == "xlsx") {
      # Ensure delimited text files related argument is not provided
      # for excel files
      unsupported_dt_arguments <- c(
        "`delim`" = !missing(delim),
        "`na`" = !missing(na),
        "`append`" = !missing(append),
        "`quote`" = !missing(quote),
        "`escape`" = !missing(escape),
        "`eol`" = !missing(eol)
      )
      if (any(unsupported_dt_arguments)) {
        stop(paste(
          "The",
          names(unsupported_dt_arguments)[unsupported_dt_arguments][1],
          "argument is not supported for Excel files."
        ))
      }

      # Set default values for Excel files related arguments if missing
      if (missing(col_names)) {
        col_names <- TRUE
      }
      if (missing(use_zip64)) {
        use_zip64 <- FALSE
      }

      # Write the Excel file
      writexl::write_xlsx(
        x = object,
        path = x,
        col_names = col_names,
        use_zip64 = use_zip64
      )
    } else {
      # Ensure excel files related arguments are not provided for
      # delimited text files
      if (!missing(use_zip64)) {
        stop(paste(
          "The `use_zip64` argument is not supported for",
          file_extension,
          "files."
        ))
      }

      # Set default values for delimited text files related arguments if missing
      if (missing(delim)) {
        delim <- switch(
          file_extension,
          "csv" = ",",
          "tsv" = "\t",
          " "
        )
      }
      if (missing(na)) {
        na <- "NA"
      }
      if (missing(append)) {
        append <- FALSE
      }
      if (missing(col_names)) {
        col_names <- !append
      }
      if (missing(quote)) {
        quote <- "needed"
      }
      if (missing(escape)) {
        escape <- "double"
      }
      if (missing(eol)) {
        eol <- "\n"
      }

      # Write the delimited text file
      readr::write_delim(
        x = object,
        file = x,
        delim = delim,
        na = na,
        append = append,
        col_names = col_names,
        quote = quote,
        escape = escape,
        eol = eol
      )
    }
  } else if (inherits(x, "DBIConnection")) {
    # Ensure file related arguments are not provided for database connections
    unsupported_file_arguments <- c(
      "`delim`" = !missing(delim),
      "`na`" = !missing(na),
      "`quote`" = !missing(quote),
      "`escape`" = !missing(escape),
      "`eol`" = !missing(eol),
      "`use_zip64`" = !missing(use_zip64)
    )
    if (any(unsupported_file_arguments)) {
      stop(paste(
        "The",
        names(unsupported_file_arguments)[unsupported_file_arguments][1],
        "argument is not supported for Database Connections."
      ))
    }

    # Ensure the name argument is provided for database connections
    if (missing(name)) {
      stop("The name argument must be provided for database connections")
    }

    # Set default value for database connection arguments if missing
    if (missing(row.names)) {
      row.names <- FALSE
    }
    if (missing(overwrite)) {
      overwrite <- FALSE
    }
    if (missing(append)) {
      append <- FALSE
    }

    # Write the database table
    DBI::dbWriteTable(
      conn = x,
      name = name,
      value = object,
      row.names = row.names,
      overwrite = overwrite,
      append = append
    )
  } else {
    # If 'x' is neither a valid file path nor a DBI connection, throw an error.
    stop(
      "Either a valid file path or a database connection must be provided."
    )
  }
}