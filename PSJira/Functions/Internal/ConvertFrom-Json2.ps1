function ConvertFrom-Json2
{
	[CmdletBinding()]
	param
	(
	    [parameter(ParameterSetName = 'object', ValueFromPipeline = $true, Position = 0, Mandatory = $true)]
	    [string]$InputObject,

	    [parameter(ParameterSetName = 'object', ValueFromPipeline = $true, Position = 1, Mandatory = $false)]
	    [int]$MaxJsonLength = [int]::MaxValue
	)

	process
	{
		[System.Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions") | Out-Null
	    $jsonserial = New-Object System.Web.Script.Serialization.JavaScriptSerializer

	    $jsonserial.MaxJsonLength = $MaxJsonLength

	    $deserializedJson = $jsonserial.DeserializeObject($InputObject)

	    foreach($desJsonObj in $deserializedJson){
	        $psObject = New-Object -TypeName psobject -Property $desJsonObj
	        $dicMembers = $psObject | Get-Member -MemberType NoteProperty
	        $psObject
	    }
	}
}
