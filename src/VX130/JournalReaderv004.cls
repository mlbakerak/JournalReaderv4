/// Description
Class VX130.JournalReaderv004 Extends %RegisteredObject
{

/// Description
ClassMethod Start(jrhid As %Integer) As %Status
{
    #Dim jrh As VX130.JournalReaderHistoryv004
    Set sc = $$$OK
    Try {
        set jrh=##class(VX130.JournalReaderHistoryv004).%OpenId(jrhid)
        set sc=..ReadFile(jrh,.endOffset,.recordsRead,.setQueue,.killQueue)
        
        set jrh.JournalFile.CurrentlyReadingFile=""
        set jrh.EndDateTime=$ZDATETIME($ZTIMESTAMP,3)
        set jrh.EndOffset=endOffset
        set jrh.NumberOfRecordRead=recordsRead
        set jrh.NumberAddedToSetQueue=setQueue
        set jrh.NumberAddedToKillQueue=killQueue
        if jrh.JournalFile.FileClosed
        {
            set jrh.JournalFile.EntireFileRead=1
            set jrh.JournalFile.EntireFileReadDateTime=$ZDATETIME($ZTIMESTAMP,3)
        }
        do jrh.%Save()
        kill jrh
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    
    Return sc
}

/// Description
ClassMethod ReadFile(jrh As VX130.JournalReaderHistoryv004, ByRef offset As %Integer, ByRef recordsRead As %Integer, ByRef setQueue As %Integer, ByRef killQueue As %Integer) As %Status
{
    Set sc = $$$OK
    #Dim jrec As %SYS.Journal.Record
    Try {
        set (recordsRead,setQueue,killQueue)=0
        set fn=jrh.JournalFile.JournalFileDirectory_jrh.JournalFile.JournalFileName
        set sto=jrh.StartOffset
        Set jfile=##class(%SYS.Journal.File).%OpenId(fn)
        set jrec=jfile.GetRecordAt(sto)
        if '$IsObject(jrec)
        {
            set jrec=jfile.FirstRecordGet()
        }
        while $IsObject(jrec)
        {
            set offset=jrec.Address
            set recordsRead=recordsRead+1
            if (jrec.TypeName="SET")
            {
                set setQueue=setQueue+1
            } 
            elseif (jrec.TypeName="KILL")
            {
                set killQueue=killQueue+1
            }
            set jrec=jrec.NextGet()
        }
        quit
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    Return sc
}

}
