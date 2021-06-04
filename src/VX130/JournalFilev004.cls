/// Description
Class VX130.JournalFilev004 Extends %Persistent
{

/// Description
Property JournalFileName As %String;

/// Description
Property Instance As VX130.Instancev004;

/// Description
Property JournalFileDirectory As %String;

/// Description
Property JournalFileCreateDateTime As %TimeStamp;

/// Description
Property FileClosed As %Boolean;

/// Description
Property CurrentlyReadingFile As %Boolean;

/// Description
Property EntireFileRead As %Boolean;

/// Description
Property EntireFileReadDateTime As %TimeStamp;

/// Description
Index InstanceIndex On (Instance, JournalFileName) [ Unique ];

/// Description
Index EntireFileReadIndex On (Instance, EntireFileRead);

/// Description
ClassMethod AddFiles() As %Status
{
    Set sc = $$$OK
    Try {
        do ##class(VX130.Instancev004).GetInstanceId(.instanceID)
        set oInst=##class(VX130.Instancev004).%OpenId(instanceID)
        set rset=##class(%ResultSet).%New("%SYS.Journal.File:ByTimeReverseOrder")
        do rset.Execute()
        set ctr=0
        while rset.%Next()
        {
            set ctr=ctr+1
            set jf=rset.Name
            set fn=##class(%File).GetFilename(jf)
            set dir=##class(%File).GetDirectory(jf,1)
            set jFile(ctr)=fn_"^"_dir
        }
        // For each file starting with oldest to newest
        for i=ctr:-1:1
        {
            set fn=$Piece(jFile(i),"^",1)
            set dir=$Piece(jFile(i),"^",2)
            &sql(SELECT %NOLOCK ID INTO :id FROM VX130.JournalFile WHERE Instance=:instanceID AND JournalFileName=:fn)
            // If we haven't seen the file before
              if $Get(id)']""
            {
                set ojf=..%New()
                set ojf.Instance=oInst
                set ojf.JournalFileName=fn
                set ojf.JournalFileDirectory=dir
                set ojf.JournalFileCreateDateTime=$ZDateTime($ZTIMESTAMP,3)
                set sc=ojf.%Save()
                do:(i>1) ojf.setFileClosed()
                kill ojf
            }
            else //If not the first time we have seen the file.
            {
                // If not the most recent file
                if (i>1)
                {
                    set ojf=..%OpenId(id)
                    do ojf.setFileClosed()
                    kill ojf
                } // if not most recent file.
            } // if first time we have seen the file.
        } // for each file.
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    Return sc
}

/// Description
Method setFileClosed() As %Status
{
    Set sc = $$$OK
    if ('..FileClosed)
    {
        set ..FileClosed=1
        set sc=..%Save()
    }
    Return sc
}

/// Description
Query IncompleteJournalFiles(instanceId As %String) As %SQLQuery [ SqlProc ]
{
    SELECT ID As JournalFile, JournalFileName, JournalFileDirectory, FileClosed
    FROM VX130.JournalFilev004
    WHERE Instance=:instanceId
    AND EntireFileRead IS NULL
    AND CurrentlyReadingFile IS NULL
    ORDER BY ID
}

Storage Default
{
<Data name="JournalFilev004DefaultData">
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
<Value name="6">
<Value>FileClosed</Value>
</Value>
<Value name="7">
<Value>CurrentlyReadingFile</Value>
</Value>
<Value name="8">
<Value>EntireFileRead</Value>
</Value>
<Value name="9">
<Value>EntireFileReadDateTime</Value>
</Value>
</Data>
<DataLocation>^VX130.JournalFilev004D</DataLocation>
<DefaultData>JournalFilev004DefaultData</DefaultData>
<IdLocation>^VX130.JournalFilev004D</IdLocation>
<IndexLocation>^VX130.JournalFilev004I</IndexLocation>
<StreamLocation>^VX130.JournalFilev004S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
