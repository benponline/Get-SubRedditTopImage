$pageRequest = Invoke-WebRequest -Uri "https://www.reddit.com/r/wallpapers/comments/m2z4wm/towards_the_sun_2560x1440/" -SessionVariable 'Session'
$pageHtml = $pageRequest.RawContent.ToCharArray()
$opener = "https://i.redd.it/".ToCharArray()
$links = @()

for ($i = 0; $i -lt $pageHtml.Count; $i++) {
    $link = ""
    #$pageHtml[$i]

    # Check for opener
    $openerStart = $true
    for ($o = 0; $o -lt $opener.Count; $o++) {
        if ($pageHtml[$i + $o] -ne $opener[$o]) {
            #Write-Host "No match"
            $openerStart = $false
            $link = ""
            break
        }

        #Write-Host $pageHtml[$i + $o]

        $link += $pageHtml[$i + $o]
    }

    # When opener is found grab it plus the charactors after it for a total of 200 chars
    if ($openerStart -eq $true) {
        for ($C = $opener.Count + 1; $C -lt $opener.Count + 200; $C++) {
            $link += $pageHtml[$i + $C]
        }

        # Extract the link out of the string
        $link = ($link -split '"', 0)[0]
        $links += $link
    }
}

$Session

$links

#Invoke-WebRequest -Uri ($links[0].ToString()) -OutFile ".\testimage2.jpg" -WebSession $Session