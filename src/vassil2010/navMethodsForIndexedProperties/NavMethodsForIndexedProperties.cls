Class vassil2010.navMethodsForIndexedProperties.NavMethodsForIndexedProperties Extends %RegisteredObject [ Abstract ]
{

Method NameIndexFirst(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  set curId = ""
  &sql(SELECT %ID INTO :curId FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Name = :K1) OR (:K1 IS NULL AND Name IS NULL) order by Id) 
  set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(curId) 
 }
 Quit return
}

Method NameIndexLast(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  set curId = ""
  &sql(SELECT %ID INTO :curId FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Name = :K1) OR (:K1 IS NULL AND Name IS NULL) order by Id desc) 
  set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(curId) 
 }
 Quit return
}

Method NameIndexNext(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  &sql(SELECT List(%ID) INTO :idList FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Name = :K1) OR (:K1 IS NULL AND Name IS NULL) order by Id) 
  set curId = ..%Id()
  for i = 1:1:$Length(idList,",") {
   if $Piece(idList,",",i) = curId {
    set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId($Piece(idList,",",i+1))
   }
  }
 }
 Quit return
}

ClassMethod NameIndexOpen(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  &sql(SELECT %ID INTO :id FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Name = :K1) OR (:K1 IS NULL AND Name IS NULL) order by Id)
  if SQLCODE=0 { set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(id)}
 }
 Quit return
}

Method NameIndexPrevious(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  &sql(SELECT List(%ID) INTO :idList FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Name = :K1) OR (:K1 IS NULL AND Name IS NULL) order by Id) 
  set curId = ..%Id()
  for i = 1:1:$Length(idList,",") {
   if $Piece(idList,",",i) = curId {
    set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId($Piece(idList,",",i-1))
   }
  }
 }
 Quit return
}

Method PhoneIndexFirst(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  set curId = ""
  &sql(SELECT %ID INTO :curId FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL) order by Id) 
  set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(curId) 
 }
 Quit return
}

Method PhoneIndexLast(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  set curId = ""
  &sql(SELECT %ID INTO :curId FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL) order by Id desc) 
  set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(curId) 
 }
 Quit return
}

Method PhoneIndexNext(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  &sql(SELECT List(%ID) INTO :idList FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL) order by Id) 
  set curId = ..%Id()
  for i = 1:1:$Length(idList,",") {
   if $Piece(idList,",",i) = curId {
    set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId($Piece(idList,",",i+1))
   }
  }
 }
 Quit return
}

ClassMethod PhoneIndexOpen(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  &sql(SELECT %ID INTO :id FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL) order by Id)
  if SQLCODE=0 { set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(id)}
 }
 Quit return
}

Method PhoneIndexPrevious(K1 As %String) As %RegisteredObject
{
 set return = $$$NULLOREF
 if ($ClassName()="vassil2010.navMethodsForIndexedProperties.samples.Person") {
  &sql(SELECT List(%ID) INTO :idList FROM vassil2010_navMethodsForIndexedProperties_samples.Person
   WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL) order by Id) 
  set curId = ..%Id()
  for i = 1:1:$Length(idList,",") {
   if $Piece(idList,",",i) = curId {
    set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId($Piece(idList,",",i-1))
   }
  }
 }
 Quit return
}

}
