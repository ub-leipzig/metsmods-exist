xquery version "1.0";

declare default element namespace "http://www.loc.gov/mods/v3"; 

declare namespace metsmods="metsmods";

declare function metsmods:list-titles($colName as xs:string) as element(*)
{
    <mods>
    {
        let $items := collection($colName)//title
        for $item in $items
        return $item  
    }  
    </mods>
};
metsmods:list-titles('/db/apps/metsmods/data')