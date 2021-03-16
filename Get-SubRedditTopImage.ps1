[CmdletBinding()]
param (
    [string]$SubReddit = "wallpapers",
    [string]$Path = "."   
) 

$dateStamp =  Get-Date -UFormat %Y-%m-%d
$subredditTopUri = "www.reddit.com/r/$SubReddit/top/"

Write-Verbose "Requesting webpage for $subredditTopUri"
$subredditTopPage = Invoke-WebRequest -Uri $subredditTopUri

# This line extracts the links out of the web request to the subreddit top page.
# The first link that contains "/comments/" in the URI is tipically the URI that points to the post.
# Links with the string "discord" are filtered out to prevent getting links to Discord channels.
$postWebLink = $subredditTopPage.links | 
    Where-Object -Property href -NotMatch "discord" | 
    Where-Object -Property href -Match "/comments/" | 
    Select-Object -First 1

if($postWebLink.href -lt 1){
    Write-Host "Unable to get image from the $SubReddit subreddit"
    return
} 

Write-Verbose ("Requesting webpage for " + $postWebLink.href + ".")
$postWebPage = Invoke-WebRequest -Uri ($postWebLink.href)

# This line extracts the links out of the web request to the post page. This URI that contains the link to the image contains "i.redd.it".
$postImageLink = $postWebPage.links | Where-Object -Property href -match "i.redd.it" | Select-Object -First 1

if($postImageLink.Count -lt 1){
    $postImageLink = $postWebPage.links | Where-Object -Property href -match "i.imgur.com" | Select-Object -First 1
}

Write-Verbose ("Requesting image from " + $postImageLink.href)

if($null -eq $postImageLink.href){
    Write-Host "Unable to get a top image post from the $SubReddit sub Reddit."
}else{
    # Download the image to the directory the script is in or the directory given by the user.
    Invoke-WebRequest -Uri ($postImageLink.href) -OutFile "$Path\$dateStamp $SubReddit.jpg"
    Write-Verbose "Image downloaded from $SubReddit subreddit."
}