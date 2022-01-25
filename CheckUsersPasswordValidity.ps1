$Users = Import-CSV C:\Temp\users.csv | Where-Object {$_.Username } | Select-Object *

foreach ($User in $Users) {
    $UserDetails = $User | Select-Object Username, Password
    $Username = $UserDetails.Username
    $Password = $UserDetails.Password

    Function Test-ADAuthentication {
        param(
            $Username,
            $Password)
        
        (New-Object DirectoryServices.DirectoryEntry "",$Username,$Password).psbase.name -ne $null
    }
    $Validity = Test-ADAuthentication -username $Username -password $Password

    #$Username
    #$Password
    #$Validity

    New-Object -TypeName psobject -Property @{
        Username = $Username
        Passwrd = $Password
        Validity = $Validity
    }

    Add-Content -Value "$($Username),$($Password),$($Validity)" -Path C:\Temp\users-out.csv
}
