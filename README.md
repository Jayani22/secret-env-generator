# Shell Script for Generating `.env` from Secret Manager

## Overview

This project demonstrates a Bash script that retrieves secrets from a **mock Secret Manager API**, parses the secrets in **JSON format**, and converts them into a properly formatted `.env` file.

The script uses **jq** for JSON parsing and includes error handling, logging and colored terminal output to make the process clear and reliable.

This fetch secrets from a secret management service and convert them into environment variables used by applications.

---

## Requirements

Before running the script, make sure the following tools are installed:

* **jq** (JSON parser)

### Install jq

Ubuntu / Debian:
`sudo apt update`
`sudo apt install jq`

---

## Mock Secret Manager Response

The mock API simulates a secret manager returning JSON secrets:
```
{
  "DB_HOST": "localhost",
  "DB_PORT": "5432",
  "DB_USER": "test_user",
  "DB_PASSWORD": "test_password",
  "API_KEY": "abc123"
}
```

These values are converted into `.env` format.

---

## How the Script Works

1. The script calls the **mock secret API**.
2. It receives secrets in **JSON format**.
3. The JSON is validated using **jq**.
4. The script converts the JSON into **KEY=VALUE pairs**.
5. A `.env` file is generated with the extracted secrets.
6. The process is logged in `script.log`.

---

## Usage

Make the script executable:

`chmod +x generate_env.sh`

Run the script:

`./generate_env.sh`

This will generate a file named:

```
.env
```

---

### Custom Output File

You can specify a custom `.env` filename:

```
./generate_env.sh production.env
```

Output:

```
production.env
```

---

## Example Output

Generated `.env` file:

```
DB_HOST=localhost
DB_PORT=5432
DB_USER=test_user
DB_PASSWORD=test_password
API_KEY=abc123
```

---

## Logging

The script writes execution logs to:

```
script.log
```

Example log entry:

```
Script started at Thu Mar 13 10:45:00
Fetching secrets from mock API...
.env file generated successfully!
Script finished at Thu Mar 13 10:45:01
```

---

## Error Handling

The script detects and handles common issues such as:

* `jq` not installed
* Empty API response
* Invalid JSON format
* Failure to generate the `.env` file

---