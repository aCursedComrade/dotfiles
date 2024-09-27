# powershell 7.x custom profile

# dont add any command to history starting with a space
# a common unix shell config
Set-PSReadLineOption -AddToHistoryHandler {
    param($command)
    if ($command -like ' *') {
        return $false
    }
    return $true
}

#custom aliases
Set-Alias -Name pn -Value pnpm

# custom functions
function Get-Hash {
    [CmdletBinding()]
    param (
        # file to hash
        [Parameter(Mandatory=$true)]
        [string]$filePath,

        # algorithm
        [Parameter(Mandatory=$false)]
        [ValidateSet('md5','sha1','sha256','sha384','sha512')]
        [string]$algorithm
    )
    
    # $hash = Get-FileHash -Algorithm SHA256 -Path $filePath | Select-Object -ExpandProperty Hash
    # Write-Output $hash.ToLower()

    $checkPath = Test-Path $filePath

    if ($checkPath -eq $true) {

        function CalcHash($hashAlgorithm) {
            $fs = [System.IO.File]::OpenRead((Resolve-Path $filePath))
            $engine = [System.Security.Cryptography.HashAlgorithm]::Create($hashAlgorithm)
            $hash = $engine.ComputeHash($fs)
            $fs.Close()
            $fs.Dispose()
            $hash = [System.BitConverter]::ToString($hash).Replace('-','').ToLower()
            Write-Output "$hashAlgorithm : $hash"
        }

        if ($algorithm) {
            CalcHash $algorithm
        } else {
            CalcHash 'md5'
            CalcHash 'sha256'
        }

    } else {
        Write-Output "Invalid file path"
    }
}

function base64Encode {
    [CmdletBinding()]
    param (
        # string to encode
        [Parameter(ValueFromPipeline=$true)]
        [string]$string
    )
    
    [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($string))
}

function base64Decode {
    [CmdletBinding()]
    param (
        # string to decode
        [Parameter(ValueFromPipeline=$true)]
        [string]$string
    )
    
    [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($string))
}

# https://transfer.sh/
function transfer {
    param(
        [Parameter(Mandatory=$true)]
        [String]$file
    )

    $absolute_path = Resolve-Path $file
    $file_name = Split-Path -Leaf $absolute_path
    $parent = Split-Path -Parent $absolute_path

    if(-Not (Test-Path $file)) {
        Write-Error "$file does not exist"
        return
    }

    if(Test-Path -PathType Container $file) {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $zipfile = "$parent\$file_name.zip"
        [IO.Compression.ZipFile]::CreateFromDirectory($absolute_path, $zipfile)

        try {
            $response = Invoke-WebRequest -Uri "https://transfer.sh/$file_name.zip" -InFile $zipfile -Method Put
            $response.Content
        }
        finally {
            Remove-Item $zipfile
        }
    } else {
        $response = Invoke-WebRequest -Uri "https://transfer.sh/$file_name" -InFile $file -Method Put
        $response.Content
    }
}
