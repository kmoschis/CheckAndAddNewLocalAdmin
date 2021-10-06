# Checks for local admins on a machine, then if that count is less than 5, it adds the current user as an admin
# Otherwiise, if more than 5, it does nothing / makes a directory (for debugging)

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
