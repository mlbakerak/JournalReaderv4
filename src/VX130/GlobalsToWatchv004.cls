/// Description
Class VX130.GlobalsToWatchv004 Extends %Persistent
{

/// Description
Property GlobalName As %String(COLLATION = "EXACT") [ Required ];

/// Description
Property NumberOfSubscripts As %Integer [ Required ];

/// Description
Property FirstSubscript As %String;

/// Description
Property SubscriptCompare As %String;

/// Description
Property ClassName As %String;

/// Description
Index GlobalNameIndex On GlobalName;

/// Description
Index ClassNameIndex On ClassName;

/// Description
ClassMethod GetGTW(ByRef gtw As %String) As %Status
{
        Set sc = $$$OK
        Try {
            set rset=##class(%ResultSet).%New("VX130.GlobalsToWatchv004:GetAllGTW")
            set sc=rset.Execute()
            while rset.%Next()
            {
                set gn=rset.GlobalName
                set ns=rset.NumberOfSubscripts
                set fs=rset.FirstSubscript
                set cs=rset.SubscriptCompare
                set cn=rset.GTWClassName
                set gtw(gn,ns,cn)=""
                set:(cs]"") gtw(gn,ns,cn,"SC",cs)=""
                set:(fs]"") gtw(gn,ns,cn,"FS",fs)=""
            }
        }
        Catch ex {
            Set sc=ex.AsStatus()
        }
        Return sc
}

/// Description
Query GetAllGTW() As %SQLQuery [ SqlProc ]
{
    SELECT %NOLOCK GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName As GTWClassName
    FROM VX130.GlobalsToWatchv004
    ORDER BY GlobalName
}

/// Description
ClassMethod Initialize() As %Status
{
    Set sc = $$$OK
    do ..%KillExtent()
    &sql(INSERT INTO VX130.GlobalsToWatchv004(GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName)
        VALUES('^DPT', 2, NULL, NULL, 'SPatient.SPatient2v123'))
    &sql(INSERT INTO VX130.GlobalsToWatchv004(GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName)
        VALUES('^DPT', 4, NULL, '3:"S"', 'Appt.Appointment298v003'))
    &sql(INSERT INTO VX130.GlobalsToWatchv004(GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName)
        VALUES('^PSRX', 2, NULL, NULL, 'RxOut.RxOutpat52v003'))
    &sql(INSERT INTO VX130.GlobalsToWatchv004(GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName)
        VALUES('^PSRX', 2, NULL, NULL, 'RxOut.RxOutpatOriginalFill52v003'))
    &sql(INSERT INTO VX130.GlobalsToWatchv004(GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName)
        VALUES('^PSRX', 4, NULL, '3:"1"', 'RxOut.RxOutpatReFill5201v003'))
    &sql(INSERT INTO VX130.GlobalsToWatchv004(GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName)
        VALUES('^PSRX', 2, NULL, NULL, 'RxOut.RxOutpatReFill5201v003'))
    &sql(INSERT INTO VX130.GlobalsToWatchv004(GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName)
        VALUES('^VA', 3, '200', NULL, 'SStaff.SStaff200v006'))
    &sql(INSERT INTO VX130.GlobalsToWatchv004(GlobalName, NumberOfSubscripts, FirstSubscript, SubscriptCompare, ClassName)
        VALUES('^VA', 5, '200', NULL, 'SStaff.SStaff200v006'))
    Return sc
}

Storage Default
{
<Data name="GlobalsToWatchv004DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>GlobalName</Value>
</Value>
<Value name="3">
<Value>NumberOfSubscripts</Value>
</Value>
<Value name="4">
<Value>FirstSubscript</Value>
</Value>
<Value name="5">
<Value>SubscriptCompare</Value>
</Value>
<Value name="6">
<Value>ClassName</Value>
</Value>
</Data>
<DataLocation>^VX130.GlobalsToWatchv004D</DataLocation>
<DefaultData>GlobalsToWatchv004DefaultData</DefaultData>
<IdLocation>^VX130.GlobalsToWatchv004D</IdLocation>
<IndexLocation>^VX130.GlobalsToWatchv004I</IndexLocation>
<StreamLocation>^VX130.GlobalsToWatchv004S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
