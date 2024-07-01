Import-Module -DisableNameChecking -Name "C:\Program Files\Microsoft Dynamics 365 Business Central\190\Service\navadmintool.ps1" 

Function header {
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
    Write-Host "`t`t`t`t`t`t   Support/Contribute at : https://github.com/XIIcode/BC_Helper.git"
}

header

Function Welcome {
    Write-Host "1. View Current Configurations."
    Write-Host "2. Set Configurations to optimal."
    Write-Host "3. Check procedure to configure AL.`n"

    $option = Read-Host "Enter a Number Value only"
    
    switch ($option) {
        "1" {
            clear
            header
            Write-Host "1.Basic Configurations"
            Write-Host "2.Application Language (AL) IMPORTANT`n"
            $choice = Read-Host "Enter a Number Value only"
            if ($choice -eq "1") {
                viewBasicInfo
            }
            ElseIf ($choice -eq "2") {
                clear
                header
                getNavWebServerInstance
            }
        }
        "2" {
            clear
            header
            Write-Host "Setting optimal configurations ...."
            Set-NAVServerConfiguration -ServerInstance BC190 -KeyName ExtensionAllowedTargetLevel -KeyValue OnPrem
            Write-Host "Extension Target Level set to [OnPremise]"
            Set-NAVServerConfiguration -ServerInstance BC190 -KeyName DeveloperServicesEnabled -KeyValue True
            Write-Host "Developer Services [Enabled]"
            Write-Host "Stopping Server Instance..."
            Stop-NAVServerInstance
            Write-Host "Rebooting Server Instance to implement changes...."
            Start-NAVServerInstance 
        }
        "3" {
            clear
            header
            Write-Host "********Environment SetUp********`n`n`n"
            Write-Host "Procedure for Configuring AL involves the following steps....`n`n"
            Write-Host "Step 1: Go to Extension pane in VS Code and install the following extensions : `n"
            Write-Host "1. Al CodeActions"
            Write-Host "2. Al Language extension for Microsoft Dynamic 365 Business Central"
            Write-Host "3. Waldo's CRS AL Language Extension`n`n"
            Write-Host "**********Project Setup**********`n`n`n"
            Write-Host "Step 1 : Launch Command Pallet either click settings panel and select command pallete bar OR ctrl + shift + p `n"
            Write-Host "Step 2 : Input [AL:GO] and select Enter.`n"
            Write-Host "Step 3 : Choose the path you wish to save your project.`n"
            Write-Host "Step 4 : Select the target platform for BC190 as [8.0 Business Central 2021 Release Wave 2]`n"
            Write-Host "Step 5 : Select the Server as [your Own Server]`n"
            Write-Host "Step 6 : Open the Explorer tab to view AL Project`n"
            Write-Host "Step 7 : Click on [.vscode folder] and open the launch.json file and edit the configurations to reflect the following.`n"
            Write-Host "i)  server : http://localhost:8080/BC190`n"
            Write-Host "ii) serverInstance: BC190`n"
            Write-Host "iii) authentication: Windows`n"
            Write-Host "Step 8 : Save the File with ctrl + S`n`n"
            Write-Host "Finally : You are ready to go !!!!."
        }
    }
}


welcome 
Function viewBasicInfo {
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

Function getUsernames {
    Write-Host "`n`t`t`t`t`t Users available in the system include : `n "
    $users = Get-NAVServerUser BC190 
    $user_count = 1
    forEach ($user in $users) {
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

Function getNavTenant {
    Write-Host "`n`t`t`t`t`t Tenant Data in the System includes `n "
    $tenant_data = Get-NAVTenant BC190
    ForEach ($tenant in $tenant_data) {
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

Function getNavServerInstance {
    Write-Host "`n`t`t`t`t`t Nav Server Instance `n "
    Get-NAVServerInstance
}

#NAV SERVER CONFIGURATION

Function getNavServerConfiguration {
    Write-Host "`n`t`t`t`t`t Nav Server Configuration Data in the System includes `n "
    $Extension_target_level = get-navserverconfiguration  -ServerInstance BC190 -KeyName ExtensionAllowedTargetLevel
    $Developer_Services_enabled = get-navserverconfiguration  -ServerInstance BC190 -KeyName DeveloperServicesSSLEnabled

    Write-Host "Developer Services             : "$Developer_Services_enabled
    Write-Host "Extension Allowed Target Level : "$Extension_target_level
} 


#Nav WEB SERVER INSTANCE

Function getNavWebServerInstance {
    Write-Host "`n`t`t`t`t`t Web Server Instance `n"
    $WebServerInstance = Get-NAVWebServerInstance BC190
    Write-Host "WebServerInstance  :  "$WebServerInstance.WebServerInstance
    Write-Host "URL                : "$WebServerInstance.Uri
    Write-Host "Server             : "$WebServerInstance.Server
    Write-Host "Server Instance    : "$WebServerInstance.ServerInstance
    Write-Host "Version            : "$WebServerInstance.Version
}





