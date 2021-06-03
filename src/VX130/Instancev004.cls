/// Description
Class VX130.Instancev004 Extends %Persistent
{

/// Description
Property InstanceID As %Integer [ Required ];

/// Description
Property InstanceName As %String(COLLATION = "EXACT") [ Required ];

Property WebPort As %Integer;

Property SSPort As %Integer;

Property IPAddress As %String;

Index MainIndex On InstanceID [ IdKey, PrimaryKey, Unique ];

/// Description
ClassMethod Initialize() As %Status
{
    Set sc = $$$OK
    Try {
        do ..%KillExtent()
        set oref=..%New()
        set oref.InstanceID=100
        set oref.InstanceName=$Piece($SYSTEM,":",2)
        set oref.IPAddress=$Piece($SYSTEM,":",1)
        set oref.SSPort=51773
        set oref.WebPort=52773
        set sc=oref.%Save()
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    Return sc
}

/// Description
ClassMethod GetInstanceId(ByRef id As %Integer) As %Status
{
    Set sc = $$$OK
    Try {
        set instanceName=$Piece($SYSTEM,":",2)
        set ipAddress=$Piece($SYSTEM,":",1)
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    &sql(SELECT ID INTO :id from VX130.Instancev004 WHERE InstanceName=:instanceName and IPAddress=:ipAddress)
    Return sc
}

Storage Default
{
<Data name="Instancev004DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>InstanceName</Value>
</Value>
<Value name="3">
<Value>WebPort</Value>
</Value>
<Value name="4">
<Value>SSPort</Value>
</Value>
<Value name="5">
<Value>IPAddress</Value>
</Value>
</Data>
<DataLocation>^VX130.Instancev004D</DataLocation>
<DefaultData>Instancev004DefaultData</DefaultData>
<IdLocation>^VX130.Instancev004D</IdLocation>
<IndexLocation>^VX130.Instancev004I</IndexLocation>
<StreamLocation>^VX130.Instancev004S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
