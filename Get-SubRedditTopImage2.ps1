[CmdletBinding()]
param (
    [string]$SubReddit = "wallpapers",
    [string]$Path = "."   
)

function Get-TopPostUri {
    [CmdletBinding()]
    param (
        [string]$subReddit
    )
        
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
    
    return $links[0]
}

function Get-TopPostImageUri {
    [CmdletBinding()]
    param (
        [string]$topPostUri
    )

    Write-Host "Function top of Get-TopPostImageUri: $topPostUri"
    
    $pageRequest = Invoke-WebRequest -Uri $topPostUri
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
    
            $link += $pageHtml[$i + $o]
            Write-Host $link
        }
    
        # When opener is found grab it plus the charactors after it for a total of 200 chars
        if ($openerStart -eq $true) {
            Write-Host "Function in closer."
            for ($C = $opener.Count + 1; $C -lt $opener.Count + 200; $C++) {
                $link += $pageHtml[$i + $C]
            }

            # Extract the link out of the string
            $link = ($link -split '"', 0)[0]
            $links += $link
        }
    }
    
    #Write-Host $links
    
    return $links[0]
}

$topPostUri = Get-TopPostUri -subReddit $SubReddit
Write-Host "Top post uri: $topPostUri"
#$dateStamp =  Get-Date -UFormat %Y-%m-%d 
$topPostImageUri = Get-TopPostImageUri -topPostUri $topPostUri
Write-Host "Top post image uri: $topPostImageUri"

# Download the image to the directory the script is in or the directory given by the user.
#Invoke-WebRequest -Uri $topPostImageUri -OutFile "$Path\$dateStamp $SubReddit.jpg"