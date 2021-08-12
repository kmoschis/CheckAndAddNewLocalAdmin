$Admins = Get-LocalGroupMember "Administrators"
$Admins = $Admins | Select -ExpandProperty Name
$AdminCount = $Admins.Count

If ($AdminCount -lt 2) {
    $User = (Get-WmiObject -ClassName Win32_OperatingSystem | Select username).username
    Add-LocalGroupMember -Group "Administrators" -Member $User
    mkdir C:\AttemptAdd$AdminCount
} ElseIf ($AdminCount -eq 2) {
    mkdir C:\MaxAdmins$AdminCount
} Else {
    mkdir C:\SomethingElse$AdminCount
    Exit
}