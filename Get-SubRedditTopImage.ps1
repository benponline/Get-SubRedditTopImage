[CmdletBinding()]
param (
    [string]$SubReddit = "wallpapers",
    [string]$Path = "."   
)

$uri = "www.reddit.com/r/$SubReddit/top"
$subredditTopPage = Invoke-WebRequest -Uri $uri
$postWebLink = $subredditTopPage.links | Where-Object -Property href -Match "/comments/" | Select-Object -First 1

# Grab image from post
$dateStamp =  Get-Date -UFormat %Y-%m-%d 
$postWebPage = Invoke-WebRequest -Uri $postWebLink.href
$postImageLink = $postWebPage.links | Where-Object -Property href -match "i.redd.it" | Select-Object -First 1 
Invoke-WebRequest -Uri $postImageLink.href -OutFile "$Path\$dateStamp $SubReddit.jpg"
#Invoke-WebRequest -Uri https://i.redd.it/p7dzgl3iptl61.png -OutFile "C:\PowerShellOutput\$dateStamp $subreddit.jpg"