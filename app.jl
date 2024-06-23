using Oxygen, HTTP

const ALLOWED_ORIGINS::Vector{Pair{String,String}} = [
    "Access-Control-Allow-Origin" => "*"
]

const CORS_HEADERS::Vector{Pair{String,String}} = [
    ALLOWED_ORIGINS...,
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "GET, POST, OPTIONS"
]

function CorsHandler(handle::Function)
    return function (req::HTTP.Request)
        if HTTP.method(req) == "OPTIONS"
            return HTTP.Response(200, CORS_HEADERS)
        else
            r = handle(req)
            Base.append!(r.headers, ALLOWED_ORIGINS)
            return r
        end
    end
end

Oxygen.get("/") do
    Oxygen.html(
        """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Random Number Generator</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>
        <body class="container mt-5">
            <h1 class="mb-4">Random Number Generator</h1>
            <button class="btn btn-primary mb-3" onclick="generateRandomNumber()">Generate Random Number</button>
            <p id="randomNumber" class="lead"></p>
            <script>
                function generateRandomNumber() {
                    var randomNumber = Math.floor(Math.random() * 100) + 1;
                    document.getElementById("randomNumber").innerText = "Random Number: " + randomNumber;
                }
            </script>
        </body>
        </html>
        """
    )
end

Oxygen.serve(host="0.0.0.0", port=5050, middleware=[CorsHandler], docs=false, metrics=false)