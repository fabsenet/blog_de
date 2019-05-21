
# find images
$lossy = dir assets -Recurse -Filter *.jpg | Select -ExpandProperty FullName
$lossless = dir assets -Recurse -Filter *.png | Select -ExpandProperty FullName
$animated = dir assets -Recurse -Filter *.gif | Select -ExpandProperty FullName

#ignore existing webp
$webp = dir assets -Recurse -Filter *.webp | select -ExpandProperty FullName

$lossy = $lossy | where { $webp -notcontains ([io.path]::ChangeExtension($_, ".webp")) }
$lossless = $lossless | where { $webp -notcontains [io.path]::ChangeExtension($_, ".webp") }
$animated = $animated | where { $webp -notcontains [io.path]::ChangeExtension($_, ".webp") }

#convert to webp
$lossy | foreach {
    $webpname = [io.path]::ChangeExtension($_, ".webp");
    cwebp.exe -q 75 -mt -m 6 $_ -o $webpname
}
$lossless | foreach {
    $webpname = [io.path]::ChangeExtension($_, ".webp");
    cwebp.exe -lossless -z 9 -mt -m 6 -q 100 $_ -o $webpname
}
$animated | foreach {
    $webpname = [io.path]::ChangeExtension($_, ".webp");
    gif2webp.exe -q 100 -mt -m 6 $_ -o $webpname
}