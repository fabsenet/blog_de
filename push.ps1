$site = dir . -Directory "_site"  | select -exp fullname

& "${env:ProgramFiles(x86)}\WinSCP\winscp.com"  /command "open fabse@fabse.net" `
  "synchronize remote $site /websites/fabsenet/de -delete" `
    "exit"