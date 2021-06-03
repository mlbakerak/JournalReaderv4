/// Description
Class VX130.JournalReaderHistoryv004 Extends %Persistent
{

/// Description
Property Instance As VX130.Instancev004;

/// Description
Property JournalFile As VX130.JournalFilev004;

/// Description
Property StartOffset As %Integer;

/// Description
Property StartDateTime As %TimeStamp;

/// Description
Property EndOffset As %Integer;

/// Description
Property EndDateTime As %TimeStamp;

/// Description
Property NumberOfRecordRead As %Integer;

/// Description
Property NumberAddedToSetQueue As %Integer;

/// Description
Property NumberAddedToKillQueue As %Integer;

/// Description
Index InstanceIndex On (Instance, JournalFile);

/// Description
ClassMethod Start() As %Status
{
    Set sc = $$$OK
    Try {
        do ##class(VX130.Instancev004).GetInstanceId(.instId)
        quit:'instId
        set sc=..GetJournalData(instId,.journals)
        set itr = journals.%GetIterator()
        while itr.%GetNext(.key,.jf)
        {
            set ojfh=..%New()
            set ojfh.Instance=##class(VX130.Instancev004).%OpenId(instId)
            set ojfh.JournalFile=##class(VX130.JournalFilev004).%OpenId(jf.id)
            set ojfh.JournalFile.CurrentlyReadingFile=1
            set ojfh.StartOffset=jf.StartOffset
            set ojfh.StartDateTime=$ZDATETIME($ZTIMESTAMP,3)
            set sc=ojfh.%Save()
        }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    Return sc
}

/// Description
ClassMethod GetJournalData(instId As %String, ByRef journals As %DynamicArray) As %Status
{
    Set sc = $$$OK
    Try {
        set rset=##class(%ResultSet).%New("VX130.JournalFilev004:IncompleteJournalFiles")
        set sc=rset.Execute(instId)
        set journals=[]
        while rset.%Next()
        {
            set jfile={}
            set id=rset.JournalFile
            set jfile.id=id
            set jfile.JournalFile=rset.JournalFileDirectory_rset.JournalFileName
            &sql(SELECT TOP 1 EndOffset INTO :end FROM VX130.JournalReaderHistoryv004 WHERE Instance=:instId and JournalFile=:id ORDER BY EndDateTime DESC)
            set jfile.StartOffset=$Select($Get(end):end,1:"0")
            do journals.%Push(jfile)
        }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    
    Return sc
}

Storage Default
{
<Data name="JournalReaderHistoryv004DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Instance</Value>
</Value>
<Value name="3">
<Value>JournalFile</Value>
</Value>
<Value name="4">
<Value>StartOffset</Value>
</Value>
<Value name="5">
<Value>StartDateTime</Value>
</Value>
<Value name="6">
<Value>EndOffset</Value>
</Value>
<Value name="7">
<Value>EndDateTime</Value>
</Value>
<Value name="8">
<Value>NumberOfRecordRead</Value>
</Value>
<Value name="9">
<Value>NumberAddedToSetQueue</Value>
</Value>
<Value name="10">
<Value>NumberAddedToKillQueue</Value>
</Value>
</Data>
<DataLocation>^VX130.JournalReadFABCD</DataLocation>
<DefaultData>JournalReaderHistoryv004DefaultData</DefaultData>
<IdLocation>^VX130.JournalReadFABCD</IdLocation>
<IndexLocation>^VX130.JournalReadFABCI</IndexLocation>
<StreamLocation>^VX130.JournalReadFABCS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
