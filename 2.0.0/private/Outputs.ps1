Function OutputScriptHeader {
  $title = @"
 _____________________________________________________
|                                                     |
|             _____  _           _                    |
|            |  __ \| |         | |                   |
|            | |__) | |__   ___ | |_ ___              |
|            |  ___/| '_ \ / _ \| __/ _ \             |
|            | |    | | | | (_) | |_ (_) |            |
|            |_|    |_| |_|\___/ \__\___/             |
|                           _                         |
|         /\               | |                        |
|        /  \   _ __   __ _| |_   _ _______ _ __      |
|       / /\ \ | '_ \ / _' | | | | |_  / _ \ '__|     |
|      / ____ \| | | | (_| | | |_| |/ /  __/ |        |
|     /_/    \_\_| |_|\__,_|_|\__, /___\___|_|        |
|                              __/ |                  |
|                             |___/                   |
|                                                     |
|                                                     |
|           ~~ Welcome to Photo Analzyer ~~           |
|         A script for image and video sorting        |
|                                                     |
|                                                     |
|  Author: Francesco Tili                             |
|_____________________________________________________|
"@

  for ( $i=0; $i -lt $title.Length; $i++ ) {
    Write-Host $title[$i] -NoNewline
  }
  Write-Host ""
  Write-Host ""
}

function OutputSpacer {
  for ($i=0; $i -le 10; $i++) { Write-Host "" }
}

function OutputScriptFooter {
  (New-Object System.Media.SoundPlayer "$env:windir\Media\Windows Unlock.wav").Play()
  Write-Host "=============================================="
  Write-Host ""
  Write-Host " >> $($Emojis["check"]) Operation completed" -BackgroundColor DarkGreen -ForegroundColor White
  Write-Host ""
  if ( $ScriptMode -eq "Normal" ) {
    $UserChoice = Read-Host " >> >> Would you like to delete *.*_original backup files? s/n"
    switch ($UserChoice) {
      's' { # User wants to delete backup files from exiftool
        CleanBackups
       }
      Default { # User doesn't want to delete backup files
      (New-Object System.Media.SoundPlayer "$env:windir\Media\Ring06.wav").Play()
       Read-Host "Press enter to exit"
      }    
    }
  }
}