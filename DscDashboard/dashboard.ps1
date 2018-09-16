#Requires -Modules DscDashboard

# Load the required Module Version
try {
    Import-Module 'UniversalDashboard.Community' -MinimumVersion 2.0.1
}
catch {
    Import-Module 'UniversalDashboard' -MinimumVersion 2.0.1
}
finally {
    Import-Module 'DscDashboard'
}


$logo = New-UDImage -Height 125 -Width 125 -Url "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IiB3aWR0aD0iMTI4cHgiIGhlaWdodD0iMTI4cHgiIHZpZXdCb3g9IjAgMCAxMjggMTI4IiBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCAxMjggMTI4IiB4bWw6c3BhY2U9InByZXNlcnZlIj48bGluZWFyR3JhZGllbnQgaWQ9IlNWR0lEXzFfIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9Ijk1LjEyMzUiIHkxPSI5MS44MDQ5IiB4Mj0iMjYuODU1IiB5Mj0iMzAuODI0OSI+PHN0b3AgIG9mZnNldD0iMCIgc3R5bGU9InN0b3AtY29sb3I6IzUzOTFGRSIvPjxzdG9wICBvZmZzZXQ9IjEiIHN0eWxlPSJzdG9wLWNvbG9yOiMzRTZEQkYiLz48L2xpbmVhckdyYWRpZW50PjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBmaWxsPSJ1cmwoI1NWR0lEXzFfKSIgZD0iTTkuNDkxLDEwOWMtMS42MiwwLTMuMDIxLTAuNjM4LTMuOTQ0LTEuNzk4Yy0wLjk0NC0xLjE4NS0xLjI2OC0yLjgxNC0wLjg4OS00LjQ3bDE3LjgzNC03Ny45MTFDMjMuMjM5LDIxLjU1NywyNi4zNzYsMTksMjkuNjM0LDE5SDExOC41YzEuNjIsMCwzLjAyMSwwLjYzOCwzLjk0NSwxLjc5OGMwLjk0NCwxLjE4NCwxLjI2OCwyLjgxNCwwLjg4OSw0LjQ3bC0xNy44MzQsNzcuOTExYy0wLjc0NywzLjI2NC0zLjg4NCw1LjgyMi03LjE0Myw1LjgyMkg5LjQ5MXoiLz48bGluZWFyR3JhZGllbnQgaWQ9IlNWR0lEXzJfIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjI2LjE3NzUiIHkxPSIzMC4wMTQ2IiB4Mj0iOTMuNzQ4NSIgeTI9IjkwLjczODEiPjxzdG9wICBvZmZzZXQ9IjAiIHN0eWxlPSJzdG9wLWNvbG9yOiM1MzkxRkUiLz48c3RvcCAgb2Zmc2V0PSIxIiBzdHlsZT0ic3RvcC1jb2xvcjojM0U2REJGIi8+PC9saW5lYXJHcmFkaWVudD48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0idXJsKCNTVkdJRF8yXykiIGQ9Ik0yOS42MzQsMjBIMTE4LjVjMi43NjksMCw0LjQ5NiwyLjI1OSwzLjg1OCw1LjA0NWwtMTcuODM0LDc3LjkxMWMtMC42MzgsMi43ODYtMy4zOTksNS4wNDUtNi4xNjgsNS4wNDVIOS40OTFjLTIuNzY5LDAtNC40OTYtMi4yNTgtMy44NTgtNS4wNDVsMTcuODM0LTc3LjkxMUMyNC4xMDQsMjIuMjU5LDI2Ljg2NiwyMCwyOS42MzQsMjB6Ii8+PHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGZpbGw9IiMyQzU1OTEiIGQ9Ik02NC4xNjUsODcuNTU4aDIxLjYxM2MyLjUxMywwLDQuNTUsMi4xMjUsNC41NSw0Ljc0NmMwLDIuNjIxLTIuMDM3LDQuNzQ3LTQuNTUsNC43NDdINjQuMTY1Yy0yLjUxMywwLTQuNTUtMi4xMjUtNC41NS00Ljc0N0M1OS42MTUsODkuNjgzLDYxLjY1Miw4Ny41NTgsNjQuMTY1LDg3LjU1OHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iIzJDNTU5MSIgZD0iTTc4LjE4NCw2Ni40NTVjLTAuMzcyLDAuNzQ5LTEuMTQ0LDEuNTc1LTIuNTA5LDIuNTM0TDM1LjU2Miw5Ny43OThjLTIuMTksMS41OTEtNS4zMzQsMS4wMDEtNy4wMjEtMS4zMTljLTEuNjg3LTIuMzItMS4yOC01LjQ5LDAuOTEtNy4wODJsMzYuMTczLTI2LjE5NHYtMC41MzhMNDIuODk2LDM4LjQ4N2MtMS44NTQtMS45NzItMS42NjEtNS4xNjEsMC40MzEtNy4xMjRjMi4wOTItMS45NjIsNS4yOS0xLjk1NCw3LjE0NCwwLjAxOGwyNy4yNzEsMjkuMDEyQzc5LjI5LDYyLjA0LDc5LjQwNSw2NC41MzQsNzguMTg0LDY2LjQ1NXoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iI0ZGRkZGRiIgZD0iTTc3LjE4NCw2NS40NTVjLTAuMzcyLDAuNzQ5LTEuMTQ0LDEuNTc1LTIuNTA5LDIuNTM0TDM0LjU2Miw5Ni43OThjLTIuMTksMS41OTEtNS4zMzQsMS4wMDEtNy4wMjEtMS4zMTljLTEuNjg3LTIuMzItMS4yOC01LjQ5LDAuOTEtNy4wODJsMzYuMTczLTI2LjE5NHYtMC41MzhMNDEuODk2LDM3LjQ4N2MtMS44NTQtMS45NzItMS42NjEtNS4xNjEsMC40MzEtNy4xMjRjMi4wOTItMS45NjIsNS4yOS0xLjk1NCw3LjE0NCwwLjAxOGwyNy4yNzEsMjkuMDEyQzc4LjI5LDYxLjA0LDc4LjQwNSw2My41MzQsNzcuMTg0LDY1LjQ1NXoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iI0ZGRkZGRiIgZD0iTTYzLjU1LDg3aDIxLjYxM2MyLjUxMywwLDQuNTUsMi4wMTUsNC41NSw0LjVjMCwyLjQ4NS0yLjAzNyw0LjUtNC41NSw0LjVINjMuNTVDNjEuMDM3LDk2LDU5LDkzLjk4NSw1OSw5MS41QzU5LDg5LjAxNSw2MS4wMzcsODcsNjMuNTUsODd6Ii8+PC9zdmc+"

$Link = New-UDLink -Text 'github.com/fvanroie' -Url 'http://github.com/fvanroie' -Icon github -OpenInNewWindow
$nodesLink = New-UDLink -Text 'Nodes' -Url '/Nodes' -FontColor black

$legendOptions =  @{
    legend = @{
        display = $true
        position = 'right'
    }
}

#region DSN Configuration

    $DscConnectionString = $env:DSC_CONNECTIONSTRING
    if (!$DscConnectionString) {
        $DscConnectionString = 'DSN=DscDashboard'
    }

    try {
        Get-ODBCData -ConnectionString $DscConnectionString -query "Select TOP 1 * from Devices;" | Out-Null
    }
    catch {

        Start-UDDashboard -Dashboard (

            New-UDDashboard -Theme $Theme -Title "DSC Dashboard" -Footer $Footer -NavbarLinks $NavBarLinks -Content {
                New-UDHeading -Size 6 -Content { 'Unable to connect to the SQL Database. Please check the DSC_CONNECTIONSTRING environment variable or DscDashboard DSN.' }
            }

        ) -Wait #-Port 4242 -AutoReload # -Wait # This is needed for IIS
        return
    }

    $result = Get-ODBCData -query "select TOP 1 * from StatusReport;" -ConnectionString $DscConnectionString
    if (!$result) {

        Start-UDDashboard -Dashboard (

             New-UDDashboard -Theme $Theme -Title "DSC Dashboard" -Footer $Footer -NavbarLinks $NavBarLinks -Content {
                New-UDHeading -Size 6 -Content { 'SQL query failed' }
             }

        ) -Wait #-Port 4242 -AutoReload # -Wait # This is needed for IIS
        return
    }

#endregion

#region Scheduled Data Loader

    # Refresh the data once every minute
    $Schedule = New-UDEndpointSchedule -Every 60 -Second

    # Cache All Nodes every minute
    $RefreshAllNodes = New-UDEndpoint -Schedule $Schedule -Endpoint {
        $Cache:AllNodes = Get-DscDashboardNodes
    }

#endregion

# Get The pages
$PagesPath = Join-Path $PSScriptRoot "pages"
$Footer = . (Join-Path $PagesPath "footer.ps1")

$Pages = @()
$Pages += . (Join-Path $PagesPath "home.ps1")

Get-ChildItem -Path $PagesPath -Exclude "home.ps1","footer.ps1" | ForEach-Object {
    $Pages += . $_.FullName
}

# Initialize the Dashboard
$Theme = Get-UDTheme "Default"

# These modules need to be loaded in each process
$Initialization = New-UDEndpointInitialization -Module 'DscDashboard'

Start-UDDashboard -Endpoint $RefreshAllNodes -Dashboard (

    New-UDDashboard -Theme $Theme -Title "DSC Dashboard" -Pages $Pages -EndpointInitialization $Initialization -Footer $Footer -NavBarLogo $logo -NavbarLinks $NavBarLinks # -CyclePagesInterval 150 -CyclePages

) -AutoReload -port 442 #-Wait -port 4242 # -Wait is needed for hosting