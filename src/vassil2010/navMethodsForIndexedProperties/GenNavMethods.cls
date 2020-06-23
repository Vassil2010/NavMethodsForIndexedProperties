Class vassil2010.navMethodsForIndexedProperties.GenNavMethods Extends %RegisteredObject
{

ClassMethod GenIndexMethods() As %Status
{

    Set ClassDef=##class(%Dictionary.ClassDefinition).%OpenId("vassil2010.navMethodsForIndexedProperties.NavMethodsForIndexedProperties")
    do ClassDef.Methods.Clear()

    set (qClassName,qIndexName,qProperties)=""
    &sql(declare ind cursor for select parent,Name,Properties into :qClassName,:qIndexName,:qProperties 
        from %Dictionary.IndexDefinition where parent->System=0 and not (parent [ '%') and _Unique=0
        group by Name)
    &sql(open ind)
    &sql(fetch ind)
    while SQLCODE=0 {
        set Method  = ..GetOpenMethodDefinition(qIndexName)    
        Do ClassDef.Methods.Insert(Method)
        set Method  = ..GetNextMethodDefinition(qIndexName)    
        Do ClassDef.Methods.Insert(Method)
        set Method  = ..GetPreviousMethodDefinition(qIndexName)    
        Do ClassDef.Methods.Insert(Method)
        set Method  = ..GetFirstMethodDefinition(qIndexName)    
        Do ClassDef.Methods.Insert(Method)
        set Method  = ..GetLastMethodDefinition(qIndexName)    
        Do ClassDef.Methods.Insert(Method)
        
        
        &sql(fetch ind)
    }    
    &sql(close ind)
    Set sc=ClassDef.%Save()
    write $System.Status.GetErrorText(sc)
    Set sc=$System.OBJ.Compile("vassil2010.navMethodsForIndexedProperties.NavMethodsForIndexedProperties","fko1-d")
    write $System.Status.GetErrorText(sc)

    quit $$$OK
}

ClassMethod GetOpenMethodDefinition(IndexName) As %Dictionary.MethodDefinition
{
    Set Method=##class(%Dictionary.MethodDefinition).%New()
    Set Method.Name=IndexName_"Open"
    Set Method.FormalSpec="K1:%String"
    Set Method.ReturnType="%RegisteredObject"
    Set Method.Private=$$$NO
    Set Method.ClassMethod=$$$YES
    Do Method.Implementation.WriteLine(" set return = $$$NULLOREF")
    set (qClassName,qIndexName,qProperties,qSqlTableName)=""
    &sql(declare ind2 cursor for 
        select parent,Name,Properties,parent->SqlTableName 
        into :qClassName,:qIndexName,:qProperties,:qSqlTableName 
        from %Dictionary.IndexDefinition where parent->System=0 and not (parent [ '%') and _Unique=0
        and Name = :IndexName)
    &sql(open ind2)
    &sql(fetch ind2)
    while SQLCODE=0 {
        if qSqlTableName="" set qSqlTableName = ..GetTableName(qClassName)

        Do Method.Implementation.WriteLine(" if ($ClassName()="""_qClassName_""") {")
        Do Method.Implementation.WriteLine("  &sql(SELECT %ID INTO :id FROM "_qSqlTableName)
        Do Method.Implementation.WriteLine("   WHERE (:K1 is not null and "_qProperties_" = :K1) OR (:K1 IS NULL AND "_qProperties_" IS NULL) order by Id)")
        Do Method.Implementation.WriteLine("  if SQLCODE=0 { set return = ##class("_qClassName_").%OpenId(id)}")
        Do Method.Implementation.WriteLine(" }")

        &sql(fetch ind2)
    }    
    &sql(close ind2)
    
    Do Method.Implementation.WriteLine(" Quit return")
    quit Method
}

ClassMethod GetNextMethodDefinition(IndexName) As %Dictionary.MethodDefinition
{
    Set Method=##class(%Dictionary.MethodDefinition).%New()
    Set Method.Name=IndexName_"Next"
    Set Method.FormalSpec="K1:%String"
    Set Method.ReturnType="%RegisteredObject"
    Set Method.Private=$$$NO
    Set Method.ClassMethod=$$$NO
    Do Method.Implementation.WriteLine(" set return = $$$NULLOREF")
    set (qClassName,qIndexName,qProperties,qSqlTableName)=""
    &sql(declare ind3 cursor for 
        select parent,Name,Properties,parent->SqlTableName 
        into :qClassName,:qIndexName,:qProperties,:qSqlTableName 
        from %Dictionary.IndexDefinition where parent->System=0 and not (parent [ '%') and _Unique=0
        and Name = :IndexName)
    &sql(open ind3)
    &sql(fetch ind3)
    while SQLCODE=0 {
        if qSqlTableName="" set qSqlTableName = ..GetTableName(qClassName)

        Do Method.Implementation.WriteLine(" if ($ClassName()="""_qClassName_""") {")
        Do Method.Implementation.WriteLine("  &sql(SELECT List(%ID) INTO :idList FROM "_qSqlTableName)
        Do Method.Implementation.WriteLine("   WHERE (:K1 is not null and "_qProperties_" = :K1) OR (:K1 IS NULL AND "_qProperties_" IS NULL) order by Id) ")
        Do Method.Implementation.WriteLine("  set curId = ..%Id()")
        Do Method.Implementation.WriteLine("  for i = 1:1:$Length(idList,"","") {")
        Do Method.Implementation.WriteLine("   if $Piece(idList,"","",i) = curId {")
        Do Method.Implementation.WriteLine("    set return = ##class("_qClassName_").%OpenId($Piece(idList,"","",i+1))")
        Do Method.Implementation.WriteLine("   }")
        Do Method.Implementation.WriteLine("  }")
        Do Method.Implementation.WriteLine(" }")

        &sql(fetch ind3)
    }    
    &sql(close ind3)
    
    Do Method.Implementation.WriteLine(" Quit return")
    quit Method
}

ClassMethod GetPreviousMethodDefinition(IndexName) As %Dictionary.MethodDefinition
{
    Set Method=##class(%Dictionary.MethodDefinition).%New()
    Set Method.Name=IndexName_"Previous"
    Set Method.FormalSpec="K1:%String"
    Set Method.ReturnType="%RegisteredObject"
    Set Method.Private=$$$NO
    Set Method.ClassMethod=$$$NO
    Do Method.Implementation.WriteLine(" set return = $$$NULLOREF")
    set (qClassName,qIndexName,qProperties,qSqlTableName)=""
    &sql(declare ind4 cursor for 
        select parent,Name,Properties,parent->SqlTableName 
        into :qClassName,:qIndexName,:qProperties,:qSqlTableName 
        from %Dictionary.IndexDefinition where parent->System=0 and not (parent [ '%') and _Unique=0
        and Name = :IndexName)
    &sql(open ind4)
    &sql(fetch ind4)
    while SQLCODE=0 {
        if qSqlTableName="" set qSqlTableName = ..GetTableName(qClassName)

        Do Method.Implementation.WriteLine(" if ($ClassName()="""_qClassName_""") {")
        Do Method.Implementation.WriteLine("  &sql(SELECT List(%ID) INTO :idList FROM "_qSqlTableName)
        Do Method.Implementation.WriteLine("   WHERE (:K1 is not null and "_qProperties_" = :K1) OR (:K1 IS NULL AND "_qProperties_" IS NULL) order by Id) ")
        Do Method.Implementation.WriteLine("  set curId = ..%Id()")
        Do Method.Implementation.WriteLine("  for i = 1:1:$Length(idList,"","") {")
        Do Method.Implementation.WriteLine("   if $Piece(idList,"","",i) = curId {")
        Do Method.Implementation.WriteLine("    set return = ##class("_qClassName_").%OpenId($Piece(idList,"","",i-1))")
        Do Method.Implementation.WriteLine("   }")
        Do Method.Implementation.WriteLine("  }")
        Do Method.Implementation.WriteLine(" }")

        &sql(fetch ind4)
    }    
    &sql(close ind4)
    
    Do Method.Implementation.WriteLine(" Quit return")
    quit Method
}

ClassMethod GetFirstMethodDefinition(IndexName) As %Dictionary.MethodDefinition
{
    Set Method=##class(%Dictionary.MethodDefinition).%New()
    Set Method.Name=IndexName_"First"
    Set Method.FormalSpec="K1:%String"
    Set Method.ReturnType="%RegisteredObject"
    Set Method.Private=$$$NO
    Set Method.ClassMethod=$$$NO
    Do Method.Implementation.WriteLine(" set return = $$$NULLOREF")
    set (qClassName,qIndexName,qProperties,qSqlTableName)=""
    &sql(declare ind5 cursor for 
        select parent,Name,Properties,parent->SqlTableName 
        into :qClassName,:qIndexName,:qProperties,:qSqlTableName 
        from %Dictionary.IndexDefinition where parent->System=0 and not (parent [ '%') and _Unique=0
        and Name = :IndexName)
    &sql(open ind5)
    &sql(fetch ind5)
    while SQLCODE=0 {
        if qSqlTableName="" set qSqlTableName = ..GetTableName(qClassName)

        Do Method.Implementation.WriteLine(" if ($ClassName()="""_qClassName_""") {")
        Do Method.Implementation.WriteLine("  set curId = """"")
        Do Method.Implementation.WriteLine("  &sql(SELECT %ID INTO :curId FROM "_qSqlTableName)
        Do Method.Implementation.WriteLine("   WHERE (:K1 is not null and "_qProperties_" = :K1) OR (:K1 IS NULL AND "_qProperties_" IS NULL) order by Id) ")
        Do Method.Implementation.WriteLine("  set return = ##class("_qClassName_").%OpenId(curId) ")
        Do Method.Implementation.WriteLine(" }")
        &sql(fetch ind5)
    }    
    &sql(close ind5)   
    Do Method.Implementation.WriteLine(" Quit return")
    quit Method
}

ClassMethod GetLastMethodDefinition(IndexName) As %Dictionary.MethodDefinition
{
    Set Method=##class(%Dictionary.MethodDefinition).%New()
    Set Method.Name=IndexName_"Last"
    Set Method.FormalSpec="K1:%String"
    Set Method.ReturnType="%RegisteredObject"
    Set Method.Private=$$$NO
    Set Method.ClassMethod=$$$NO
    Do Method.Implementation.WriteLine(" set return = $$$NULLOREF")
    set (qClassName,qIndexName,qProperties,qSqlTableName)=""
    &sql(declare ind6 cursor for 
        select parent,Name,Properties,parent->SqlTableName 
        into :qClassName,:qIndexName,:qProperties,:qSqlTableName 
        from %Dictionary.IndexDefinition where parent->System=0 and not (parent [ '%') and _Unique=0
        and Name = :IndexName)
    &sql(open ind6)
    &sql(fetch ind6)
    while SQLCODE=0 {
        if qSqlTableName="" set qSqlTableName = ..GetTableName(qClassName)

        Do Method.Implementation.WriteLine(" if ($ClassName()="""_qClassName_""") {")
        Do Method.Implementation.WriteLine("  set curId = """"")
        Do Method.Implementation.WriteLine("  &sql(SELECT %ID INTO :curId FROM "_qSqlTableName)
        Do Method.Implementation.WriteLine("   WHERE (:K1 is not null and "_qProperties_" = :K1) OR (:K1 IS NULL AND "_qProperties_" IS NULL) order by Id desc) ")
        Do Method.Implementation.WriteLine("  set return = ##class("_qClassName_").%OpenId(curId) ")
        Do Method.Implementation.WriteLine(" }")
        &sql(fetch ind6)
    }    
    &sql(close ind6)   
    Do Method.Implementation.WriteLine(" Quit return")
    quit Method
}

ClassMethod GetTableName(ClassName) As %Status
{
    Return $Replace(ClassName,".","_",,$Length(ClassName,".")-2)
}

/*
ClassMethod PhoneIndexOpen(K1) As %RegisteredObject
{
    set return = $$$NULLOREF
    &sql(SELECT %ID INTO :id FROM vassil2010_navMethodsForIndexedProperties_samples.Person 
        WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL) order by Id)
    if SQLCODE=0 { set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(id)}
    Quit return
}

Method PhoneIndexNext(K1) As %RegisteredObject
{
    set return = $$$NULLOREF
    &sql(SELECT List(%ID) INTO :idList FROM vassil2010_navMethodsForIndexedProperties_samples.Person 
        WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL) order by Id)
    set curId = ..%Id()
    for i = 1:1:$Length(idList,",") {
        if $Piece(idList,",",i) = curId {
            set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId($Piece(idList,",",i+1))    
        }
    }
    Quit return
}

Method PhoneIndexPrevious(K1) As %RegisteredObject
{
    set return = $$$NULLOREF
    &sql(SELECT List(%ID) INTO :idList FROM vassil2010_navMethodsForIndexedProperties_samples.Person 
        WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL)
        order by Id)
    set curId = ..%Id()
    for i = 1:1:$Length(idList,",") {
        if $Piece(idList,",",i) = curId {
            set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId($Piece(idList,",",i-1))    
        }
    }
    Quit return
}

Method PhoneIndexFirst(K1) As %RegisteredObject
{
    set return = $$$NULLOREF
    set curId = ""
    &sql(SELECT %ID INTO :curId FROM vassil2010_navMethodsForIndexedProperties_samples.Person 
        WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL)
        order by Id)
    set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(curId)    
    Quit return
}

Method PhoneIndexLast(K1) As %RegisteredObject
{
    set return = $$$NULLOREF
    set curId = ""
    &sql(SELECT %ID INTO :curId FROM vassil2010_navMethodsForIndexedProperties_samples.Person 
        WHERE (:K1 is not null and Phone = :K1) OR (:K1 IS NULL AND Phone IS NULL)
        order by Id desc)
    set return = ##class(vassil2010.navMethodsForIndexedProperties.samples.Person).%OpenId(curId)    
    Quit return
}

ClassMethod ListProperties() [ CodeMode = objectgenerator ]
{
    For i = 1:1:%compiledclass.Properties.Count() {
        Set prop = %compiledclass.Properties.GetAt(i).Name
        Do %code.WriteLine(" Write """ _ prop _ """,!")
    }
    Do %code.WriteLine(" Quit")
    Quit $$$OK
}

ClassMethod Method1()
{
    Set ClassDef=##class(%Dictionary.ClassDefinition).%OpenId("vassil2010.navMethodsForIndexedProperties.samples.Person")
    
    
    
    Set Method=##class(%Dictionary.MethodDefinition).%New()
    Set Method.Name="GenMethod"
    Set Method.FormalSpec=""
    Set Method.ReturnType="%Status"
    Set Method.Private=0
    Set Method.ClassMethod=1
    

    Do Method.Implementation.WriteLine(" S a=3")
    Do Method.Implementation.WriteLine(" S b=5")
    Do Method.Implementation.WriteLine(" W (a*b)")
    Do Method.Implementation.WriteLine(" Q 1")
    Do ClassDef.Methods.Insert(Method)

    
    Set sc=ClassDef.%Save()
    
    // Set sc=$System.OBJ.Compile(..ClassDef,"fko1-d")

    Quit $$$OK
}
*/
}
