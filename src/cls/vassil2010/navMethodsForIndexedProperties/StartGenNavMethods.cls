Class vassil2010.navMethodsForIndexedProperties.StartGenNavMethods [ DependsOn = (vassil2010.navMethodsForIndexedProperties.NavMethodsForIndexedProperties, vassil2010.navMethodsForIndexedProperties.GenNavMethods) ]
{

ClassMethod OnCompile() [ CodeMode = generator, Internal, ServerOnly = 1 ]
{
  s tSC=$$$OK
  set tSC = ##class(vassil2010.navMethodsForIndexedProperties.GenNavMethods).GenIndexMethods()
  quit tSC
}

}
