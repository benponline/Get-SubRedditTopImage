$subReddit = "wallpapers"

$pageRequest = Invoke-WebRequest -Uri "www.reddit.com/r/$subReddit/top"
$pageHtml = $pageRequest.RawContent.ToCharArray()

$opener = "https://www.reddit.com/r/$subReddit/comments/".ToCharArray()
$links = @()

for ($i = 0; $i -lt $pageHtml.Count; $i++) {
    $link = ""

    # Check for opener
    $openerStart = $true
    for ($O = 0; $O -lt $opener.Count; $O++) {
        if ($pageHtml[$i + $O] -ne $opener[$O]) {
            $openerStart = $false
            $link = ""
            break
        }

        $link += $pageHtml[$i + $O]
    }

    # When opener is found grab it plus the charactors after it for a total of 200 chars
    if ($openerStart -eq $true) {
        for ($C = $opener.Count + 1; $C -lt $opener.Count + 200; $C++) {
            $link += $pageHtml[$i + $C]
        }

        # Extract the link out of the string
        $link = ($link -split "(/)", 9)[0..15] -join ""

        $links += $link
    }
}

$links