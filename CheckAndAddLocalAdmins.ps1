$Admins = Get-LocalGroupMember "Administrators"
$Admins = $Admins | Select -ExpandProperty Name
$AdminCount = $Admins.Count

If ($AdminCount -lt 5) {
    $User = (Get-WmiObject -ClassName Win32_ComputerSystem | Select username).username
    Add-LocalGroupMember -Group "Administrators" -Member $User
    mkdir C:\AttemptAdd$AdminCount$User
    Break
} ElseIf ($AdminCount -eq 5) {
    mkdir C:\MaxAdmins$AdminCount$User
} Else {
    mkdir C:\SomethingElse$AdminCount$User
    Exit
}