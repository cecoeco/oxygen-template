module App

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

HTML::String = """
<!DOCTYPE html>
<html>
    <head>
        <title>Oxygen.jl-Render</title>
    </head>
    <style>
        html, 
        body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
    <body>
        <h1>Hello, World!</h1>
    </body>
</html>
"""

Oxygen.get("/") do req::HTTP.Request
    Oxygen.html(HTML)
end

Oxygen.serve(
    host="0.0.0.0",
    port=5050,
    middleware=[CorsHandler],
    docs=false,
    metrics=false
)

end