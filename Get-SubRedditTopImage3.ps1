[CmdletBinding()]
param (
    [string]$SubReddit = "wallpapers",
    [string]$Path = "."   
) 

$subredditTopUri = "www.reddit.com/r/$SubReddit/top/"
$subredditTopPage = Invoke-WebRequest -Uri $subredditTopUri

#Write-Verbose ($subredditTopPage.headers)

# This line extracts the links out of the web request to the subreddit top page. The first link that contains "/comments/" in the URI is tipically the URI that points to the post.
$postWebLink = $subredditTopPage.links | Where-Object -Property href -NotMatch "discord" | Where-Object -Property href -Match "/comments/" | Select-Object -First 1
#$postWebLink.href

$dateStamp =  Get-Date -UFormat %Y-%m-%d 

Write-Verbose ("Post URI: " + $postWebLink.href)

$postWebPage = Invoke-WebRequest -Uri ($postWebLink.href)

# This line extracts the links out of the web request to the post page. This URI that contains the link to the image contains "i.redd.it".
$postImageLink = $postWebPage.links | Where-Object -Property href -match "i.redd.it" | Select-Object -First 1
$postImageLink

if($postImageLink.Count -lt 1){
    $postImageLink = $postWebPage.links | Where-Object -Property href -match "i.imgur.com" | Select-Object -First 1
    $postImageLink
}

Write-Verbose ("Image URI: " + $postImageLink.href)

# Download the image to the directory the script is in or the directory given by the user.
Invoke-WebRequest -Uri ($postImageLink.href) -OutFile "$Path\$dateStamp $SubReddit.jpg"