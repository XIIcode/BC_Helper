Import-Module -Name "C:\Program Files\Microsoft Dynamics 365 Business Central\190\Service\navadmintool.ps1" 

Function header{
write-host " 
██████╗  ██████╗    ██╗  ██╗███████╗██╗     ██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝    ██║  ██║██╔════╝██║     ██╔══██╗██╔════╝██╔══██╗
██████╔╝██║         ███████║█████╗  ██║     ██████╔╝█████╗  ██████╔╝
██╔══██╗██║         ██╔══██║██╔══╝  ██║     ██╔═══╝ ██╔══╝  ██╔══██╗
██████╔╝╚██████╗    ██║  ██║███████╗███████╗██║     ███████╗██║  ██║
╚═════╝  ╚═════╝    ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝                                                                          
"
Write-Host "`t`t`t`t`t`t  Developed by an Attachee, you can also make it !."
Write-Host "`t`t`t`t`t`t   AGILE BUSINESS SOLUTIONS LIMITED."
Write-Host "`t`t`t`t`t`t   Author Daniel Gitonga.`n`n`n"
}

header

Function Welcome{
    Write-Host "1. View Current Configurations."
    Write-Host "2. Set Configurations to optimal."
    Write-Host "3. Check procedure to configure AL.`n"

    $option = Read-Host "Enter a Number Value only"
    
    switch($option)
  {
    "1"{
          clear
          header
          Write-Host "1.Basic Configurations"
          Write-Host "2.Application Language (AL) IMPORTANT`n"
          $choice = Read-Host "Enter a Number Value only"
          if($choice -eq "1")
          {
            viewBasicInfo
          }
          ElseIf($choice -eq "2")
          {
            clear
            header
            getNavWebServerInstance
          }
       }
    }
}

welcome 
Function viewBasicInfo{
        clear
        header
        Write-Host "Displaying Current Basic Configurations....`n`n"
        getUsernames
        getNavTenant
        getNavServerInstance
        getNavServerConfiguration
        getNavWebServerInstance
}
#NAV SERVER USERS

Function getUsernames{
    Write-Host "`n`t`t`t`t`t Users available in the system include : `n "
    $users = Get-NAVServerUser BC190 
    $user_count = 1
    forEach($user in $users)
    {
            Write-Host `t`t`t`t`t$user_count`n
            Write-Host "UserName    :" $user.UserName
            Write-Host "FullName    :" $user.FullName
            Write-Host "State       :" $user.State
            Write-Host "ProfileID   :" $user.ProfileId
            Write-Host "Company     :" $user.Company
            Write-Host "LanguageId  :" $user.LanguageId
        ++$user_count
    }
}

#NAV TENANT

Function getNavTenant{
    Write-Host "`n`t`t`t`t`t Tenant Data in the System includes `n "
    $tenant_data = Get-NAVTenant BC190
        ForEach($tenant in $tenant_data){
        Write-Host "ServerInstance  :"$tenant.ServerInstance
        Write-Host "Database Name   :"$tenant.DatabaseName
        Write-Host "Database Server :"$tenant.DatabaseServer
        Write-Host "State           :"$tenant.State
        Write-Host "Detailed State  :"$tenant.DetailedState
        Write-Host "Deletion State  :"$tenant.DeletionState
        Write-Host "EnvironmentType :"$tenant.EnvironmentType  
    }
}

#NAV SERVER INSTANCE

Function getNavServerInstance{
    Write-Host "`n`t`t`t`t`t Nav Server Instance `n "
    Get-NAVServerInstance
}

#NAV SERVER CONFIGURATION

Function getNavServerConfiguration{
Write-Host "`n`t`t`t`t`t Nav Server Configuration Data in the System includes `n "
    $Extension_target_level = get-navserverconfiguration  -ServerInstance BC190 -KeyName ExtensionAllowedTargetLevel
    $Developer_Services_enabled = get-navserverconfiguration  -ServerInstance BC190 -KeyName DeveloperServicesSSLEnabled

           Write-Host "Developer Services             : "$Developer_Services_enabled
           Write-Host "Extension Allowed Target Level : "$Extension_target_level
} 


#Nav WEB SERVER INSTANCE

Function getNavWebServerInstance{
    Write-Host "`n`t`t`t`t`t Web Server Instance `n"
    $WebServerInstance = Get-NAVWebServerInstance BC190
    Write-Host "WebServerInstance  :  "$WebServerInstance.WebServerInstance
    Write-Host "URL                : "$WebServerInstance.Uri
    Write-Host "Server             : "$WebServerInstance.Server
    Write-Host "Server Instance    : "$WebServerInstance.ServerInstance
    Write-Host "Version            : "$WebServerInstance.Version
}





