$fullread=Get-PhysicalDisk | Sort Size | FT FriendlyName, Size, MediaType, HealthStatus, OperationalStatus -AutoSize | Out-String
$readerr=Get-PhysicalDisk | Sort Size | Select-Object HealthStatus
if($readerr.HealthStatus -like 'Unhealthy' -Or $readerr.HealthStatus -like 'Warning') {

    function sendMail{

         Write-Host "Sending Email"

        $EmailFrom = “<sender_email_address>”

        $EmailTo = “<recipient_email_address>”

        $Subject = “DRIVE HEALTH ALERT”

        $Body = “DRIVE HEALTH WARNING $fullread”

        $SMTPServer = “<FQDN_of_SMTP_Server>”
        $SMTPPort = “<SMTP_Server_Port>”

        $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, $SMTPPort)

        $SMTPClient.EnableSsl = $true

        $SMTPClient.Credentials = New-Object System.Net.NetworkCredential(“<sender_email_address>”, “<password>”);

        $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
 
    }
    
    #Calling function
    sendMail
}
