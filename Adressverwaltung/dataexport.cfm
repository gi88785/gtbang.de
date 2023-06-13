<html>
<head>
	<title>Exportieren</title>
	<link rel="stylesheet" type="text/css" href="formate.css">
</head>
<body>
<cfquery name="BenutzerExport" datasource="schoger"> 
	SELECT * 
	FROM benutzer	
</cfquery>
<cfset zeitstempel = "#DateFormat(now(), "yyyyMmdd")##TimeFormat(now(), "HHmmss")#">
<cfoutput query="BenutzerExport">
<cfset adresseexport = "#expandpath("export/export_#zeitstempel#.csv")#">
<cffile action="append" file="#adresseexport#" output="#vorname#;#nachname#;#DateTimeformat(geburtstag,"dd.mm.yyyy")#;#adresse#;#stadt#;#postleitzahl#;#email#;#DateTimeformat(datum_hinzugefuegt,"dd.mm.yyyy")#;#DateTimeformat(datum_geaendert,"dd.mm.yyyy")#">
</cfoutput>
<cfoutput>
	<div align="center">
		<div class="box2">
		<table border="0">
			<br>
			<h2>Datei exportieren<h2>
				<tr>
					<th><a href="export/export_#zeitstempel#.csv" download>export_#zeitstempel#.csv</a></th>
				</tr>
				</tr>
				<td align="center">
				<br>
				<br>
					<button type="button" onclick="window.close('dataexport.cfm')"> schliessen </td>
				<br>
				<br>
		</table>
		<br>
		<br>
		<br>
		rechte Maustaste auf den Dateinamen -> "Link speichern unter" zum speichern
	</div>
</cfoutput>

</body>
</html>

