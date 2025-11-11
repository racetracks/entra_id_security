Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All", 
"SignInActivity.Read.All" 
$inactivityThreshold = 90

$currentDate = Get-Date 

$users = Get-MgUser -All -Property "DisplayName", "SignInActivity" 
Filter for inactive users 
$inactiveUsers = $users | Where-Object { 
$_.SignInActivity.LastSignInDateTime -lt ($currentDate.AddDays(
$inactivityThreshold)) 
} 

foreach ($user in $inactiveUsers) { 
Set-MgUser -UserId $user.Id -AccountEnabled $false 
Writ
