$groupmembers = Get-DistributionGroupMember -Identity "Group 2"

foreach ($i in (import-csv .\trustedcontactsdisabledusers.csv)) {
    if ($groupmembers.PrimarySMTPAddress -contains $i.UserPrincipalName) {
        $count = (Get-MailboxFolderStatistics -Identity $i.UserPrincipalName | Where-Object {$_.FolderType -eq "Contacts"}).ItemsInFolder
        Write-Output "$($i.UserPrincipalName) $count"
        #Set-MailboxJunkEmailConfiguration -Identity $i.UserPrincipalName -ContactsTrusted $True
    }
}
