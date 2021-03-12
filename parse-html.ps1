$pageRequest = Invoke-WebRequest -Uri "www.reddit.com/r/wallpapers/top"
$pageHtml = $pageRequest.RawContent.ToCharArray()

#$pageHtml = "123456789 HTML 12345676".ToCharArray()

$opener = "html"
$opener = $opener.ToCharArray()
$closer = "</a>"
$links = @()

for ($i = 0; $i -lt $pageHtml.Count; $i++) {
    $link = ""

    # Check for opener
    $openerStart = $true
    for ($O = 0; $O -lt $opener.Count; $O++) {
        #$opener[$O]
        if ($pageHtml[$i + $O] -ne $opener[$O]) {
            $openerStart = $false
            $link = ""
            break
        }

        $link += $pageHtml[$i]
    }

    if($openerStart -eq $true){
        Write-Host "Found Starter." 
        
        #Record charactors untill closer found.
    }
}

$links