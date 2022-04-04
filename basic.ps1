Add-Type -AssemblyName System.Windows.Forms

$FormObject=[System.Windows.Forms.Form]
$LabelObject=[System.Windows.Forms.Label]
#$comboBoxObject=[System.Windows.Forms.ComboBox]


$DefaultFont='Verdana,10'

##Setup Base Form
$AppForm=New-Object $FormObject
$AppForm.ClientSize='800,600'
$AppForm.Text='Lipani Security - WebCam Checker'
$AppForm.BackColor='White'
$AppForm.Font=$DefaultFont

#Building The Form
$lblService=New-Object $LabelObject
$lblService.Text='Services :'
$lblService.Autosize=$true
$lblService.Location=New-Object System.Drawing.Point(20, 20)

#$ddlService=New-Object $comboBoxObject
#$ddlService.width='300'
#$ddlService.Location=New-Object System.Drawing.Point(225,20)

#Get-Service | ForEach-Object {$ddlService.Items.Add($_.Name)}

$btn1 = New-Object System.Windows.Forms.Button
$btn1.Text='Disable'
$btn1.Autosize=$true
$btn1.Location=New-Object System.Drawing.Point(100, 150)
$btn1.add_Click($btn1_OnClick)

$btn2 = New-Object System.Windows.Forms.Button
$btn2.Text='Enable'
$btn2.Autosize=$true
$btn2.Location=New-Object System.Drawing.Point(100, 250)
$btn2.add_Click($btn2_OnClick)

$lblForName=New-Object $LabelObject
$lblForName.Text='Services Friendy Name :'
$lblForName.Autosize=$true
$lblForName.Location=New-Object System.Drawing.Point(20, 80)

$lblName=New-Object $LabelObject
$lblName.Text=''
$lblName.Autosize=$true
$lblName.Location=New-Object System.Drawing.Point(450, 80)

$lblForStatus=New-Object $LabelObject
$lblForStatus.Text='Status :'
$lblForStatus.Autosize=$true
$lblForStatus.Location=New-Object System.Drawing.Point(300, 180)

$lblStatus=New-Object $LabelObject
$lblStatus.Text=''
$lblStatus.Autosize=$true
$lblStatus.Location=New-Object System.Drawing.Point(450, 180)

$AppForm.Controls.AddRange(@($lblService, $lblName, $lblForName, $lblForStatus, $lblStatus, $btn1, $btn2))

##Add Funcations

Function GetServiceDetails{
    $ServiceName=$ddlService.SelectedItem
    $details=Get-Service -Name $serviceName | select *
    $lblName.Text=$details.name
    $lblstatus.Text=$details.status
}

##Add functions

#$ddlService.Add_SelectedIndexChanged({GetServiceDetails})

$btn1_OnClick=
{
Disable-PnpDevice -InstanceId (Get-PnpDevice -FriendlyName *webcam* -Class Camera -Status OK).InstanceId
}

$btn2_OnClick=
{
Enable-PnpDevice -InstanceId (Get-PnpDevice -FriendlyName *webcam* -Class Camera -Status Error).InstanceId
}

##Show Form
$AppForm.ShowDialog()

##Garbage Collection
$AppForm.Dispose()

#https://youtu.be/jPhznpFna7E?t=610
