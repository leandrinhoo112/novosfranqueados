$basePath = 'C:\Users\Usuario\.gemini\antigravity\playground\polar-newton\franquias-inspirar'

$htmlLines = @()
$htmlLines += '<!DOCTYPE html>'
$htmlLines += '<html lang="pt-BR">'
$htmlLines += '<head>'
$htmlLines += '<meta charset="UTF-8" />'
$htmlLines += '<meta name="viewport" content="width=device-width, initial-scale=1.0" />'
$htmlLines += '<title>Seja um Franqueado | Faculdade Inspirar</title>'
$htmlLines += '<meta name="description" content="Abra sua unidade da Faculdade Inspirar, a maior rede de franquias de pos-graduacao do Brasil na area da Saude." />'
$htmlLines += '<link rel="preconnect" href="https://fonts.googleapis.com" />'
$htmlLines += '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />'
$htmlLines += '<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />'
$htmlLines += '<link rel="stylesheet" href="styles.css" />'
$htmlLines += '</head>'
$htmlLines += '<body>'
$htmlLines += 'PLACEHOLDER_BODY'
$htmlLines += '<script src="script.js"></script>'
$htmlLines += '</body>'
$htmlLines += '</html>'

$htmlLines | Out-File -FilePath "$basePath\index.html" -Encoding UTF8
Write-Host 'Done writing index.html'
