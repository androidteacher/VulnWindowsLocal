$first_names = [System.Collections.ArrayList](Get-Content data/first_names.txt)
$last_names = [System.Collections.ArrayList](Get-Content data/last_names.txt)
$passwords = [System.Collections.ArrayList](Get-Content data/passwords.txt)


$num_users = 5

$users = @()


for ($i = 0; $i -lt $num_users; $i = $i + 1) {
   
    $first_name = (Get-Random -InputObject $first_names)
    $last_name = (Get-Random -InputObject $last_names)
    $password = (Get-Random -InputObject $passwords)
   

    $new_user = @{
        "fullname" = "$first_name $last_name"
       
        "name"     = $first_name.substring(0, 1) + "$last_name"
       
        "password" = "$password"
     
       
    }
    $users += $new_user
    

    $first_names.Remove($first_name)
    $last_names.Remove($last_name)
    $passwords.Remove($password)
   

    
}
$users | ConvertTo-JSON | out-file userlist.json