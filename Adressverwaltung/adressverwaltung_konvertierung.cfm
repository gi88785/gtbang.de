<html>
<head>
	<title>Benutzerliste</title>
	<link rel="stylesheet" type="text/css" href="formate.css">
	<script type="text/javascript">
		function deletezeile(loesch_id) {
		   if (confirm('Wollen sie die Zeile wirklich löschen?')==true ) {
			 window.location.href ='adressverwaltung.cfm?user_loeschen='+loesch_id;
		   } 
		}
	</script>	
	<script type="text/javascript">
		function edituser(edit_id) {
			var editfenster = window.open("zeile_edit.cfm?edit_id="+edit_id, "editfenster","width=1920,height=400,overflow: hidden;");
}
		
	</script>
	<script type="text/javascript">
	function openexp
	window.open("", "dataexport.cfm", "width=1000,height=1000");
	
	</script>
</head>
<body>
<cfif isdefined('user_loeschen')>
	<cfquery  datasource="schoger">
		DELETE 
		FROM benutzer 	
		WHERE benutzer_id = <cfqueryparam value ="#user_loeschen#" maxlength="10">
	</cfquery>
</cfif>
	<div class="box2">
	<div align="center">
			<table border="0" cellpadding="7">
				<tr>
					<th><a href="index.cfm">Start</a></th>
					<th><a href="adresseingabe.cfm" >Adresseingabe</a></th>
					<th><a href="adressverwaltung.cfm" >Adressverwaltung</a></th>
					<th><a href="import.cfm" >Import</a></th>
				</tr>
			</table>
			<hr>
			<h1>Adressverwaltung</h1>
					<div align="right">
						<img src="images\export.png" alt="exportieren" onmouseover="" style="cursor: pointer;" onclick="window.open('dataexport.cfm','mywin','width=1600,height=400');; ">
						<input type="button" value="konvertieren zu PDF">
					</div>
		<br>
			<cfparam name="absteigend" default="">
			<cfif absteigend is "">
				<cfset absteigend = " DESC">
			<cfelse>
				<cfset absteigend = "">
			</cfif>
			<cfset zeitstempel = "#DateFormat(now(), "yyyyMmdd")##TimeFormat(now(), "HHmmss")#">
			<cfdocument format="PDF" filename="Adressverwaltung_Liste_#zeitstempel#.pdf" overwrite="Yes">
			<div align="center"><h1>Adressverwaltung</h1></div>
		<table border="1" bordercolor="#000000" border width="140%" cellpadding="4" style="font-family:Arial">
			<cfparam name="sortierung" default="nachname">
			<cfquery name="BenutzerAuslesen" datasource="schoger"> 
				SELECT *
				FROM benutzer
				LEFT JOIN laender ON benutzer.land = laender.kuerzel
				ORDER BY #sortierung#
			</cfquery> 
			<tr>
				<th>Vorname</th>
				<th>Nachname</th>
				<th>Geburtsdatum</th>
				<th>Nationalität</th>
				<th>Adresse</th>
				<th>Stadt</th>
				<th>Postleitzahl</th>
				<th>Email-Adresse</th>
				<th>Hinzugefügt</th>
				<th>letzte Änderung</th>
				<th>Status</th>
			</tr>
			<cfoutput query="BenutzerAuslesen">
				<tr>
					<td> #vorname# </td>
					<td> #nachname# </td>
					<td> #DateTimeformat(geburtstag,"dd.mm.yyyy")# </td>
					<td> #landname# </td>
					<td> #adresse# </td>
					<td> #stadt# </td>
					<td> #postleitzahl# </td>
					<td> #email# </td>
					<td> #DateTimeformat(datum_hinzugefuegt,"dd.mm.yyyy")# </td>
					<td> #DateTimeformat(datum_geaendert,"dd.mm.yyyy")# </td>
					<td> #benutzerstatus# </td>				
				</tr>
			</cfoutput>
		</table>
	</div>	
</body>
</html>
</cfdocument>
<cfheader name="Content-Disposition" value="attachment;filename=Adressverwaltung_Liste_#zeitstempel#.pdf">
<cfcontent type="application/octet-stream" file="#expandPath('.')#\Adressverwaltung_Liste_#zeitstempel#.pdf">



	