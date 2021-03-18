# Get-SubRedditTopImage

Gets the first image from a subreddit's top posts page. The wallpapers subreddit is the default, but can be changed by passing in a different one.

Saves image as jpg. If the subreddit's top page does not have many images the script might fail. This script is meant to be used on subreddits that focus on posts with images. 

Only compatable with PowerShell Core.

## Install PowerShell Core
1. Download the lastest Long Term Support version of PowerShell Core at https://github.com/powershell/powershell.
2. Install PowerShell Core.

## How to use
1. Download the Get-SubRedditTopImage.ps1 file.
2. Open PowerShell and run the following command: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`
3. This will allow PowerShell to run the script.
4. Navigate to the directory where Get-SubRedditTopImage.ps1 is located. You can use `Set-Location` for this.
5. Use the command `.\Get-SubRedditTopImage.ps1` to run the script. 