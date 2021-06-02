/// Description
Class VX130.JournalFileStatus Extends %Persistent
{

/// Description
Property JournalFile As VX130.JournalFile;

/// Description
Property CurrentlyReadingFile As %Boolean;

/// Description
Property EntireFileRead As %Boolean;

/// Description
Property EntireFileReadDateTime As %TimeStamp;

Storage Default
{
<Data name="JournalFileStatusDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>JournalFile</Value>
</Value>
<Value name="3">
<Value>CurrentlyReadingFile</Value>
</Value>
<Value name="4">
<Value>EntireFileRead</Value>
</Value>
<Value name="5">
<Value>EntireFileReadDateTime</Value>
</Value>
</Data>
<DataLocation>^VX130.JournalFileStatusD</DataLocation>
<DefaultData>JournalFileStatusDefaultData</DefaultData>
<IdLocation>^VX130.JournalFileStatusD</IdLocation>
<IndexLocation>^VX130.JournalFileStatusI</IndexLocation>
<StreamLocation>^VX130.JournalFileStatusS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
