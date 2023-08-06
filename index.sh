#!/bin/bash

# Check if the required arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <title> <h1_content>"
  exit 1
fi

# Get the title and h1_content from the command-line arguments
title="$1"
h1_content="$2"

# The HTML content to write into the index.html file
HTML_CONTENT="<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"utf-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
	<title>$title</title>
  <link href=\"https://fonts.googleapis.com/css?family=Roboto:400,500,700\" rel=\"stylesheet\" type=\"text/css\">
	<link rel=\"stylesheet\" href=\"static/css/style.css\">
</head>
<body>
	<div class=\"container\">
    <header>
      <h1>$h1_content</h1>
    </header>
    <form method=\"POST\" action=\"{{ url_for('submitted') }}\">
      {% for field in form %}
        {% if field.name != 'csrf_token' %}
          {{ field.label }}
          {{ field }}
        {% endif %}
      {% endfor %}
      <button type=\"submit\">Register</button>
    </form>
    <button><a href=\"{{ url_for('view_database') }}\">View Database</a></button>
	</div>
</body>
</html>"
#current_directory=$(pwd)
#echo "Current Directory: $current_directory"

# Write the HTML content to the index.html file
echo "$HTML_CONTENT" > $(pwd)/templates/index.html
