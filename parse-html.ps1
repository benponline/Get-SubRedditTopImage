$pageHtml = (Invoke-WebRequest -Uri "www.reddit.com/r/wallpapers/top").RawContent

$open = "<"
$tag = "a"

foreach($char in $pageHtml){

}