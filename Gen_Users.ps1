param ([Parameter(Mandatory = $true)] $JSONFile, [switch]$Undo, [string]$ChangePassword)

$users = get-content $JSONFile | convertFrom-json

function CreateNewUser() {
    param ([Parameter(Mandatory = $true)] $userObject)
    $name = $userObject.name
    $fullname = $userObject.fullname
    $password = $userObject.password

    New-LocalUser -name $name -fullname $fullname -password (ConvertTo-SecureString $password -AsPlainText -Force)
}

function RemoveUsers() {
    param ([Parameter(Mandatory = $true)] $userObject)
    $name = $userObject.name
    Remove-LocalUser -name $name
}

function ChangeUserPassword() {
    param ([Parameter(Mandatory = $true)] $userObject)
    $name = $userObject.name
    Set-LocalUser -Name $name -Password (ConvertTo-SecureString $ChangePassword -AsPlainText -Force)
}
foreach ($new_object in $users) {
    if ($Undo) {
        RemoveUsers($new_object)
    }
    else {
        if ($ChangePassword) {  
            ChangeUserPassword($new_object)
            
        }
        else {
            CreateNewUser($new_object)
        }
         
    }
   
}