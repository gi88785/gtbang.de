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
			<cfparam name="sortierung" default="nachname">
			<hr>
			<h1>Adressverwaltung</h1>
					<cfoutput>
						<div align="right">
							<img src="images\export.png" alt="exportieren" onmouseover="" style="cursor: pointer;" onclick="window.open('dataexport.cfm','mywin','width=1600,height=400');; ">
							<a href="adressverwaltung_konvertierung.cfm?sortierung=#sortierung#"><button>zu Pdf konvertieren</button></a>
							<a href="fpdf/export.php?sortierung=#sortierung#"><button>PhP Export</button></a>
						</div>
					</cfoutput>
		<br>
			<cfparam name="absteigend" default="">
			<cfif absteigend is "">
				<cfset absteigend = " DESC">
			<cfelse>
				<cfset absteigend = "">
			</cfif>
		<table border="5" bordercolor="#000000" border width="90%" cellpadding="3">
			<cfquery name="BenutzerAuslesen" datasource="schoger"> 
				SELECT *
				FROM benutzer
				LEFT JOIN laender ON benutzer.land = laender.kuerzel
				ORDER BY #sortierung# 
			</cfquery> 
			<tr>
			<cfoutput>
				<th><a href="adressverwaltung.cfm?sortierung=vorname#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "vorname">Vorname&darr;<cfelseif sortierung eq "vorname DESC">Vorname&uarr;<cfelse>Vorname</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=nachname#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "nachname">Nachname&darr;<cfelseif sortierung eq "nachname DESC">Nachname&uarr;<cfelse>Nachname</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=geburtstag#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "geburtstag">Geburtsdatum&darr;<cfelseif sortierung eq "geburtstag DESC">Geburtsdatum&uarr;<cfelse>Geburtsdatum</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=landname#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "landname">Nationalität&darr;<cfelseif sortierung eq "landname DESC">Nationalität&uarr;<cfelse>Nationalität</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=adresse#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "adresse">Adresse&darr;<cfelseif sortierung eq "adresse DESC">Adresse&uarr;<cfelse>Adresse</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=stadt#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "stadt">Stadt&darr;<cfelseif sortierung eq "stadt DESC">Stadt&uarr;<cfelse>Stadt</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=length(postleitzahl)#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "length(postleitzahl)">Postleitzahl&darr;<cfelseif sortierung eq "length(postleitzahl) DESC">Postleitzahl&uarr;<cfelse>Postleitzahl</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=email#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "email">Email-Adresse&darr;<cfelseif sortierung eq "email DESC">Email-Adresse&uarr;<cfelse>Email-Adresse</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=datum_hinzugefuegt#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "datum_hinzugefuegt">Hinzugefügt&darr;<cfelseif sortierung eq "datum_hinzugefuegt DESC">Hinzugefügt&uarr;<cfelse>Hinzugefügt</cfif></a></th>
				<th><a href="adressverwaltung.cfm?sortierung=datum_geaendert#absteigend#&absteigend=#absteigend#"><cfif sortierung eq "datum_geaendert">letzte Änderung&darr;<cfelseif sortierung eq "datum_geaendert DESC">letzte Änderung&uarr;<cfelse>letzte Änderung</cfif></a></th>
				<th>Status</th>
			</cfoutput>
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
					<td  align="center"><img src="images\edit.png" alt="editieren" onmouseover="" style="cursor: pointer;" onclick="edituser('#benutzer_id#')" value="Bearbeiten" /> &nbsp; <img src="images\papierkorb.png" alt="Papierkorb" onmouseover="" style="cursor: pointer;" onclick="deletezeile('#benutzer_id#');" value="Zeile löschen" /></td>
				</tr>
			</cfoutput>
		</table>
	</div>	
</body>
</html>


	