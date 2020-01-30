
#define universal Variables

#mail settings. The below are for office 365
$SMTPserver = "smtp.office365.com"
$creds = (get-credential)
$smtpport = 587

#change from address to who is sending the email
$from = "Youremail@email.com"

#import CSV
$users = import-csv -path .\users.csv 



#send email to each user in the csv
foreach ($user in $users) {
$toaddress = $user.personalemail
$corpemail = $user.Corpemail
$username =  $corpemail -replace "@.*"

#email body. edit as needed. below instructions are for 365
$body = @"
Hello and Welcome to COMPANY

The following email address has been created for you:

$corpemail

To set your password and access your inbox, please follow these instructions:
1. Navigate to COMPANYWEBSITE 
2. Log in with the account information below:
	user name: $username
	Current Password: [TEMPPASSWORD]
3. Click Okay. .
** you may be required to add a phone number for password resets**	
4. At the top Right, click on your initials.
5. Click "My Account"
6. Click "Security & Privacy"
7. Click "Password"
8. Fill in your password information and click Submit.

If you encounter any issues, please call the IT Department at [IT PHONE NUMBER]


"@

$mailparam = @{
    To = $toaddress
    From = $from
    subject = 'Email Created'
    body = $body
    smtp = $smtpserver
    port = $smtpport
    Credential = $creds
    }
Write-Output "Sending email to $toaddress"
send-mailmessage @mailparam -usessl
}
pause