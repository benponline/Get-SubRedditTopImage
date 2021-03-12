$a = 'https://www.reddit.com/r/wallpapers/comments/2z4wm/towards_the_sun_2560x1440/","events":[],"ev'

$b = ($a -split "(/)", 9)[0..15] -join ""
#$b = $b[0..15] -join ""
$b

#$b = ((($a -split "(/)", -4)[0]) + "/")
#$b