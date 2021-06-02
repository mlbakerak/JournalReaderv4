/// Description
Class VX130.JournalReaderHistory Extends %Persistent
{

/// Description
Property Instance As VX130.Instance;

/// Description
Property PropertyName As %String;

Storage Default
{
<Data name="JournalReaderHistoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Instance</Value>
</Value>
<Value name="3">
<Value>PropertyName</Value>
</Value>
</Data>
<DataLocation>^VX130.JournalReaderHistoryD</DataLocation>
<DefaultData>JournalReaderHistoryDefaultData</DefaultData>
<IdLocation>^VX130.JournalReaderHistoryD</IdLocation>
<IndexLocation>^VX130.JournalReaderHistoryI</IndexLocation>
<StreamLocation>^VX130.JournalReaderHistoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
