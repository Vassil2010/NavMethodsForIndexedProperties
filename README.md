# Navigation methods for InterSystems Objects Indexed properties

The project creates auto-generated methods for non-unique indices.

Creates the following methods:
- *IndexName*Open(val)
- *IndexName*First(val)
- *IndexName*Last(val)
- *IndexName*Next(val)
- *IndexName*Previous(val)

# Examples
- set person = ##class(samples.Person).NameIndexOpen("Daniel")
- SET person = person.NameIndexFirst("Daniel")
- SET person = person.NameIndexLast("Daniel")
- SET person = person.NameIndexNext("Daniel")
- SET person = person.NameIndexPrevious("Daniel")

```
set person = ##class(samples.Person).PhoneIndexOpen("880-555-4323")
While $IsObject(person) {
    write !, person.Name
    set person = person.PhoneIndexNext("880-555-4323")
}
```

# Install:

1. USER> zpm
2. zpm: USER>install bondar-nav
3. Add to persistent classes Extends bondar.indexnav.IndexNav

Example: 
```
Class samples.Person Extends (%Persistent, bondar.indexnav.IndexNav, %Populate)
```

4. Compile the project
