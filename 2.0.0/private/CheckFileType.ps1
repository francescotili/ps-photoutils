Function CheckFileType {
  <#
    .SYNOPSIS
      Analyze the file type with ExifTool and return the correct operation to make for the PhotoAnalyzer main function
      - 'IsValid' -> Means that the extension and FileType corresponds, so the analyzer can continue the operations
      - 'Rename' -> Means that the extension doesn't match the fileType, so the file extension need to be changed before the analyzer can continue the operations
      - '' -> Means that something is strange with the file or the case is not handled
    
    .PARAMETER inputFile
      Required. A "FILE" object
  #>

  [CmdLetBinding(DefaultParameterSetName)]
  Param (
    [Parameter(Mandatory = $true)]
    $inputFile
  )
  
  $ReturnValue = "" | Select-Object -Property action, extension

  # Define an array of supported extensions
  $SupportedExtensions = @("jpg", "JPG", "jpeg", "JPEG", "heic", "HEIC", "png", "PNG", "gif", "GIF", "mp4", "MP4", "m4v", "M4V", "mov", "MOV", "gif", "GIF", "avi", "AVI", "wmv", "WMV")

  # Define expected extensions based on detected file type
  $extensions = @{
    "JPEG" = "jpg"
    "PNG"  = "png"
    "GIF"  = "gif"
    "MOV"  = "mov"
    "MP4"  = "mp4"
    "HEIC" = "heic"
  }

  # File Types that will be converted
  $conversions = @("AVI", "WMV")

  # Check if extension match and return value
  if ( $SupportedExtensions.Contains( $inputFile.extension ) ) {
    # Check if the extension is the expected based on the FileType
    $fileType = Get-ExifInfo $inputFile "FileType"
    if ( $extensions[$fileType] -ceq $inputFile.extension ) {
      $ReturnValue.action = "IsValid"
    }
    elseif ( $conversions.Contains($fileType)) {
      $ReturnValue.action = "Convert"
    }
    else {
      $ReturnValue.action = "Rename"
      $ReturnValue.extension = $extensions[$fileType]
    }
  }

  return $ReturnValue
}