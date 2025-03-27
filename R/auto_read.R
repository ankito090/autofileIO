# Function: auto_read
auto_read <- function(
  x,
  name,
  col_names,
  na,
  skip,
  n_max,
  trim_ws,
  guess_max,
  name_repair,
  sheet,
  range,
  delim,
  comment,
  quote,
  escape_backslash,
  escape_double,
  skip_empty_rows,
  drop_na = FALSE
) {
  # Validate the 'drop_na' argument to ensure it's a logical value
  if (!is.logical(drop_na)) {
    stop("Expected single logical value for 'drop_na'.")
  }

  # If `x` is an existing file path
  if (is.character(x) && file.exists(x)) {
    # Define supported file formats
    supported_formats <- c("csv", "tsv", "xlsx", "xls", "txt", "dat", "log")

    # Extract file extension and convert to lowercase
    file_extension <- stringr::str_to_lower(tools::file_ext(x = x))

    # Check if the file extension is supported
    if (!(file_extension %in% supported_formats)) {
      stop(paste("Unsupported file format:", file_extension))
    }

    # Ensure name argument is not provided for excel and delimited text files
    if (!missing(name)) {
      stop(paste(
        "The `name` argument is not supported for",
        ifelse(
          file_extension %in% c("xlsx", "xls"),
          "excel",
          file_extension
        ),
        "files."
      ))
    }

    # Set default values to arguments common to both excel
    # and delimited text files
    if (missing(col_names)) {
      col_names <- TRUE
    }
    if (missing(na)) {
      na <- c("", "NA")
    }
    if (missing(trim_ws)) {
      trim_ws <- TRUE
    }
    if (missing(skip)) {
      skip <- 0
    }
    if (missing(n_max)) {
      n_max <- Inf
    }
    if (missing(guess_max)) {
      guess_max <- min(1000, n_max)
    }
    if (missing(name_repair)) {
      name_repair <- "unique"
    }

    # If file is an excel spreadsheet
    if (file_extension %in% c("xlsx", "xls")) {
      # Ensure delimited text files related argument is not provided
      # for excel files
      unsupported_dt_arguments <- c(
        "`delim`" = !missing(delim),
        "`comment`" = !missing(comment),
        "`quote`" = !missing(quote),
        "`escape_backslash`" = !missing(escape_backslash),
        "`escape_double`" = !missing(escape_double),
        "`skip_empty_rows`" = !missing(skip_empty_rows)
      )
      if (any(unsupported_dt_arguments)) {
        stop(paste(
          "The",
          names(unsupported_dt_arguments)[unsupported_dt_arguments][1],
          "argument is not supported for Excel files."
        ))
      }

      # Set default value for excel files related argument if missing
      if (missing(sheet)) {
        sheet <- 1
      }
      if (missing(range)) {
        range <- NULL
      }

      # Read the excel file
      data <- tibble::as_tibble(read_excel(
        path = x,
        col_names = col_names,
        na = na,
        skip = skip,
        n_max = n_max,
        trim_ws = trim_ws,
        guess_max = guess_max,
        .name_repair = name_repair,
        sheet = sheet,
        range = range
      ))
    } else {
      # Ensure excel files related arguments are not provided for
      # delimited text files
      unsupported_excel_arguments <- c(
        "`sheet`" = !missing(sheet),
        "`range`" = !missing(range)
      )
      if (any(unsupported_excel_arguments)) {
        stop(paste(
          "The",
          names(unsupported_excel_arguments)[unsupported_excel_arguments][1],
          "argument is not supported for",
          file_extension,
          "files."
        ))
      }

      # Set default values for delimited text files related arguments if missing
      if (missing(delim)) {
        delim <- NULL
      }
      if (missing(comment)) {
        comment <- ""
      }
      if (missing(quote)) {
        quote <- "\""
      }
      if (missing(escape_backslash)) {
        escape_backslash <- FALSE
      }
      if (missing(escape_double)) {
        escape_double <- TRUE
      }
      if (missing(skip_empty_rows)) {
        skip_empty_rows <- TRUE
      }

      # Read the delimited text file
      data <- suppressMessages(tibble::as_tibble(readr::read_delim(
        file = x,
        col_names = col_names,
        na = na,
        skip = skip,
        n_max = n_max,
        trim_ws = trim_ws,
        guess_max = guess_max,
        name_repair = name_repair,
        delim = delim,
        comment = comment,
        quote = quote,
        skip_empty_rows = skip_empty_rows,
        escape_backslash = escape_backslash,
        escape_double = escape_double
      )))
    }
  } else if (inherits(x, "DBIConnection")) {
    # Ensure file related arguments are not provided for database connections
    unsupported_file_arguments <- c(
      "`col_names`" = !missing(col_names),
      "`na`" = !missing(na),
      "`skip`" = !missing(skip),
      "`n_max`" = !missing(n_max),
      "`guess_max`" = !missing(guess_max),
      "`trim_ws`" = !missing(trim_ws),
      "`name_repair`" = !missing(name_repair),
      "`sheet`" = !missing(sheet),
      "`range`" = !missing(range),
      "`delim`" = !missing(delim),
      "`comment`" = !missing(comment),
      "`quote`" = !missing(quote),
      "`escape_backslash`" = !missing(escape_backslash),
      "`escape_double`" = !missing(escape_double),
      "`skip_empty_rows`" = !missing(skip_empty_rows)
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

    # Read the database table
    data <- tibble::as_tibble(DBI::dbReadTable(conn = x, name = name))
  } else {
    # If 'x' is neither a valid file path nor a DBI connection, throw an error.
    stop(
      "Either an existing file path or a database connection must be provided."
    )
  }


  # Drop missing values if requested
  if (drop_na) {
    data <- tidyr::drop_na(data)
  }

  # Return the tibble
  return(data)
}