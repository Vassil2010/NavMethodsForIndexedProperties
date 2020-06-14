Include %occKeyword

/// 
Class vassil2010.navMethodsForIndexedProperties.samples.Person Extends (%Persistent, vassil2010.navMethodsForIndexedProperties.NavMethodsForIndexedProperties, %Populate)
{

Index SerialNumberIndex On SerialNumber [ Unique ];

Property SerialNumber As %String;

Index NameIndex On Name;

Property Name As %String;

Index PhoneIndex On Phone;

Property Phone As %String;

ClassMethod SamplesWithUniqueIndex() As %Status
{
    /// 
    Write !, ..SerialNumberIndexExists("no val")
    Write !, ..SerialNumberIndexExists("G1582")

    set obj = ..SerialNumberIndexOpen("G1582")
    Write:$IsObject(obj) !,obj.Name
    quit $$$OK
}

ClassMethod SamplesWithNoUniqueIndex() As %Status
{
    /// 
    Write !, ..PhoneIndexExists("no val")
    Write !, ..PhoneIndexExists("880-555-4323")

    #; set obj = ..PhoneIndexOpen("G1582")
    #; if $IsObject(obj) {
    #;     Write !,obj.Name
    #; } else {
    #;     Write !,"No object"
    #; }
    quit $$$OK
}

ClassMethod PhoneIndexExample()
{
    set person = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).PhoneIndexOpen("880-555-4323")
    While $IsObject(person) {
        write !, person.Name
        set person = person.PhoneIndexNext("880-555-4323")
    }
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>SerialNumber</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>Phone</Value>
</Value>
</Data>
<DataLocation>^vassil2010.navMethoDE44.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^vassil2010.navMethoDE44.PersonD</IdLocation>
<IndexLocation>^vassil2010.navMethoDE44.PersonI</IndexLocation>
<StreamLocation>^vassil2010.navMethoDE44.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
