using Oxygen: get, html, serve

html_string::String = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Random Number Generator</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
        }
        .flex-center {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 60px;
            line-height: 60px;
            background-color: #f5f5f5;
        }
        .custom-btn {
            background-color: #4a90e2;
        }
    </style>
    <script>
        function generateRandomNumber() {
            const randomNumber = Math.floor(Math.random() * 100) + 1;
            document.getElementById("randomNumber").innerText = "Random Number: " + randomNumber;
        }
    </script>
</head>
<body class="bg-white">
    <div class="flex-center flex-col">
        <h1 class="mb-4 text-3xl font-bold">Random Number Generator</h1>
        <button class="custom-btn text-white px-4 py-2 rounded-md shadow-md" onMouseDown="generateRandomNumber()">
            Generate Random Number
        </button>
        <p id="randomNumber" class="text-xl font-semibold"></p>
    </div>
    <footer class="footer text-center text-gray-600">
        <p>
            Powered by
            <a href="https://github.com/OxygenFramework/Oxygen.jl" target="_blank" class="underline">Oxygen.jl</a>
            and
            <a href="https://render.com/" target="_blank" class="underline">Render</a>
        </p>
    </footer>
</body>
</html>
"""

get("/") do
    html(html_string)
end

serve(host="0.0.0.0", port=5050, docs=false, metrics=false)
