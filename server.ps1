$root = $PSScriptRoot
$port = 3000
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:${port}/")
$listener.Start()
Write-Host "Servidor rodando em http://localhost:${port}" -ForegroundColor Green
Start-Process "http://localhost:${port}/index.html"

try {
    while ($listener.IsListening) {
        $ctx = $listener.GetContext()
        try {
            $path = [System.Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath)
            if ($path -eq '/') { $path = '/index.html' }
            $file = Join-Path $root $path.TrimStart('/')

            if (Test-Path $file -PathType Leaf) {
                $bytes = [System.IO.File]::ReadAllBytes($file)
                $ext = [System.IO.Path]::GetExtension($file).ToLower()
                $ct = switch ($ext) {
                    '.html'  { 'text/html;charset=utf-8' }
                    '.css'   { 'text/css;charset=utf-8' }
                    '.js'    { 'application/javascript;charset=utf-8' }
                    '.png'   { 'image/png' }
                    '.jpg'   { 'image/jpeg' }
                    '.jpeg'  { 'image/jpeg' }
                    '.webp'  { 'image/webp' }
                    '.svg'   { 'image/svg+xml' }
                    '.json'  { 'application/json' }
                    '.ico'   { 'image/x-icon' }
                    default  { 'application/octet-stream' }
                }
                $ctx.Response.ContentType = $ct
                $ctx.Response.ContentLength64 = $bytes.Length
                $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
            } else {
                $ctx.Response.StatusCode = 404
                $msg = [System.Text.Encoding]::UTF8.GetBytes('Not Found')
                $ctx.Response.OutputStream.Write($msg, 0, $msg.Length)
            }
        } catch {
            Write-Warning "Erro ao responder conexao: $_"
        } finally {
            try { $ctx.Response.Close() } catch {}
        }
    }
} finally {
    $listener.Stop()
}
