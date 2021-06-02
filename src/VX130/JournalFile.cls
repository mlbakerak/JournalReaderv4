/// Description
Class VX130.JournalFile Extends %Persistent
{

/// Description
Property JournalFileName As %String;

/// Description
Property Instance As VX130.Instance;

/// Description
Property JournalFileDirectory As %String;

/// Description
Property JournalFileCreateDateTime As %TimeStamp;

/// Description
Index InstanceIndex On (Instance, JournalFileName) [ Unique ];

/// Description
ClassMethod AddJFiles() As %Status
{
    Set sc = $$$OK
    Try {
        do ##class(VX130.Instance).GetInstanceId(.instanceID)
        set rset=##class(%ResultSet).%New("%SYS.Journal.File:ByTimeReverseOrder")
        do rset.Execute()
        set ctr=1
        while rset.%Next()
        {
            set jf=rset.Name
            do ##class(%File).Deconstruct(jf,.dirs)
            set fn=dirs(dirs)
            set dir=$Piece(jf,fn)
            w !,instanceID,!,fn
            &sql(SELECT ID INTO :id FROM VX130.JournalFile WHERE Instance=:instanceID AND JournalFileName=:fn)
            if $Get(id)']""
            {
                
                set oref=..%New()
                set oref.Instance=##class(VX130.Instance).%OpenId(instanceID)
                set oref.JournalFileName=fn
                set oref.JournalFileDirectory=dir
                set oref.JournalFileCreateDateTime=$ZDateTime($ZTIMESTAMP,3)
                set sc=oref.%Save()
                kill oref
            }
            else
            {
                quit
            }
            set ctr=ctr+1
        }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    Return sc
}

Storage Default
{
<Data name="JournalFileDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>JournalFileName</Value>
</Value>
<Value name="3">
<Value>Instance</Value>
</Value>
<Value name="4">
<Value>JournalFileDirectory</Value>
</Value>
<Value name="5">
<Value>JournalFileCreateDateTime</Value>
</Value>
</Data>
<DataLocation>^VX130.JournalFileD</DataLocation>
<DefaultData>JournalFileDefaultData</DefaultData>
<IdLocation>^VX130.JournalFileD</IdLocation>
<IndexLocation>^VX130.JournalFileI</IndexLocation>
<StreamLocation>^VX130.JournalFileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
