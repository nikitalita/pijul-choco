import-module au

$releases = 'https://github.com/boringcactus/pijul-windows-builds/releases/latest'

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x64:).*"           = "`${1} $($Latest.URL64)"
            "(?i)(\s+checksum64:).*"    = "`${1} $($Latest.Checksum64)"
            "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}


function global:au_BeforeUpdate { Get-RemoteFiles -Purge }


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
    $regex = '.exe$'
    $url = $download_page.links | ? href -match $regex | Select-Object -First 1 -expand href
    
    $version = $url -split '/' | select -Last 1 -Skip 1 
    $version = $version -replace "-", ""
    $version = $version -replace "alpha", ""
    
    $url64 = 'https://github.com' + $url
    
    $Latest = @{ URL64 = $url64; Version = $version; PackageName = 'pijul' }
    return $Latest
}
#global:au_GetLatest
update -ChecksumFor none
