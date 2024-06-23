using Oxygen: get, html, serve

html_string::String = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Random Number Generator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="container mt-5">
    <h1 class="mb-4">Random Number Generator</h1>
    <button class="btn btn-primary mb-3" onclick="generateRandomNumber()">
        Generate Random Number
    </button>
    <p id="randomNumber" class="lead"></p>
    <script>
        function generateRandomNumber() {
            var randomNumber = Math.floor(Math.random() * 100) + 1;
            document.getElementById("randomNumber").innerText =
                "Random Number: " + randomNumber;
        }
    </script>
</body>
</html>
"""

get("/") do
    html(html_string)
end

serve(host="0.0.0.0", port=5050, docs=false, metrics=false)