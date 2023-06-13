<html>
<head>
	<title>Bearbeiten</title>
	<link rel="stylesheet" type="text/css" href="formate.css">
	<script type="text/javascript">	
		function saveuser(update_id) {
			if (confirm('Wollen sie die Zeile wirklich speichern ?')==true ) {
				document.forms["form_edit"].onsubmit = pruefen();
		   }
		}
		function pruefen()  {
			if (document.forms["form_edit"]["vorname"].value == "") {
				alert("Feld Vorname muss ausgefüllt sein!"); 
				document.form_edit.vorname.focus();
				return false;
			}		
			if (document.forms["form_edit"]["nachname"].value == "") {
				alert("Feld Nachname muss ausgefüllt sein!");
				document.form_edit.nachname.focus();					
				return false;
			}
			if (document.forms["form_edit"]["geburtstag"].value == "") {
				alert("Feld Geburtstag muss ausgefüllt sein!"); 
				document.form_edit.geburtstag.focus();
				return false;
			}	
			var laend = document.getElementById("laend");
			if (laend.value == "") {
				alert("Bitte Land auswählen!");
				document.form_edit.laend.focus();
				return false;
			}
			if (document.forms["form_edit"]["adresse"].value == "") {
				alert("Feld Adresse muss ausgefüllt sein!"); 
				document.form_edit.adresse.focus();
				return false;
			}
			if (document.forms["form_edit"]["stadt"].value == "") {
				alert("Feld Stadt muss ausgefüllt sein!"); 
				document.form_edit.stadt.focus();
				return false;
			}
			if (document.forms["form_edit"]["postleitzahl"].value == "") {
				alert("Feld Postleitzahl muss ausgefüllt sein!"); 
				document.form_edit.postleitzahl.focus();
				return false;
			}
			if (document.forms["form_edit"]["email"].value == "") {
				alert("Feld Email muss ausgefüllt sein!"); 
				document.form_edit.email.focus();
				return false;
			}
			if	(document.forms["form_edit"]["email"].value.indexOf('@' && '.') == -1) {
				alert("Keine gültige Email!");
				document.form_edit.email.focus();
				return false;
			}
			if (document.forms["form_edit"]["geburtstag"].value.length  !=10) {
				alert("Kein gültiges Datum!");
				document.form_edit.geburtstag.focus();
				return false;
			}
			var currentTime = new Date()
			var year = currentTime.getFullYear()
			if (document.forms["form_edit"]["geburtstag"].value.substring(0,2) < 1 || document.forms["form_edit"]["geburtstag"].value.substring(0,2) > 31 || document.forms["form_edit"]["geburtstag"].value.substring(3,5) < 1 || document.forms["form_edit"]["geburtstag"].value.substring(3,5) > 12 || document.forms["form_edit"]["geburtstag"].value.substring(6,10) < 1900 || document.forms["form_edit"]["geburtstag"].value.substring(6,10) > year) {
				alert("Kein gültiges Datum!");
				document.form_edit.geburtstag.focus();
				return false;
			}
			else { 
				document.forms["form_edit"].submit ();
			}
		}
	</script>
</head>
<cfif isdefined('user_updaten')>
	<cfset geburtstag_formatiert = Mid(geburtstag,7,4) & Mid(geburtstag,4,2) & Mid(geburtstag,1,2)>
	<cfquery name="UserUpdate" datasource="schoger">
		UPDATE benutzer		
		SET 
			vorname = <cfqueryparam value = "#vorname#" maxlength="35">, 
			nachname = <cfqueryparam value = "#nachname#" maxlength="35">,
			land =  <cfqueryparam value = "#landname#" maxlength="35">,
			geburtstag =  <cfqueryparam value = "#geburtstag_formatiert#" maxlength="10">,
			adresse =  <cfqueryparam value = "#adresse#" maxlength="35">, 
			stadt =  <cfqueryparam value = "#stadt#" maxlength="35">, 
			postleitzahl = <cfqueryparam value = "#postleitzahl#" maxlength="9">,
			email = <cfqueryparam value = "#email#" maxlength="50"> ,
			datum_geaendert = NOW()
			
		WHERE benutzer_id = <cfqueryparam value ="#edit_id#" maxlength="10">
	</cfquery>
	<script type="text/javascript">	
		alert("erfolgreich gespeichert");
		window.opener.location.reload();
		self.close();
	</script>
</cfif>	
<body>
	<div class="box2">
		<br>
		<h1>Eintrag bearbeiten</h1>
		<form name="form_edit" method="post" action="zeile_edit.cfm">
			<cfoutput>
				<input type="hidden" name="user_updaten" value="ja">
				<input type="hidden" name="edit_id"  value="#edit_id#">
			</cfoutput>
			<cfquery name="laender_Auslesen" datasource="schoger"> 
				SELECT landname, kuerzel
				FROM laender
			</cfquery> 
			<cfquery name="BenutzerEdit" datasource="schoger"> 
				SELECT *
				FROM benutzer
				WHERE benutzer_id = <cfqueryparam value = "#edit_id#" maxlength="10">
			</cfquery> 
			<br><br>
			<table border=5 width='95%' cellpadding='8' align="center">
				<tr>
					<th>Vorname</th>
					<th>Nachname</th>
					<th>Geburtstag</th>
					<th>Land</th>
					<th>Adresse</th>
					<th>Stadt</th>
					<th>Postleitzahl</th>
					<th>Email</th>
				</tr>
				<cfoutput query="BenutzerEdit">
				<cfset land = land>
					<tr>
						<td><input type="text" value="#vorname#"                                 class="eingabefeld"  maxlength="35"                                               autocomplete="off"   name="vorname"></td>
						<td><input type="text" value="#nachname#"                                class="eingabefeld"  maxlength="35"                                               autocomplete="off"   name="nachname"></td>
						<td><input type="text" value="#DateTimeformat(geburtstag,"dd.mm.yyyy")#" class="eingabefeld"  maxlength="10"                                               autocomplete="off"   name="geburtstag"></td>
						<td>
							<select name="landname" id="laend">
								<cfloop query="laender_Auslesen">
									<option name="#landname#" value="#kuerzel#"<cfif kuerzel eq land> selected</cfif>>#landname#</option>
								</cfloop>
							</select>
						</td>
						<td><input type="text" value="#adresse#"                                 class="eingabefeld"  maxlength="35"                                                autocomplete="off"   name="adresse"></td>
						<td><input type="text" value="#stadt#"                                   class="eingabefeld"  maxlength="35"                                               	autocomplete="off"   name="stadt"></td>
						<td><input type="text" value="#postleitzahl#"                            style="width:70px;"  maxlength="9"                                                 autocomplete="off"   name="postleitzahl"></td>
						<td><input type="text" value="#email#"                                   style="width:300px;" maxlength="50"                                                autocomplete="off"   name="email"></td>
						<td><img src="images\save.png" alt="speichern" onmouseover="" style="cursor: pointer;" onclick="pruefen();" value="Speichern" /></td>
					</tr>
				</cfoutput>
			</table>
			<br>
			<br>
			<br>
			<button onclick="self.close()">schlie&szlig;en</button>
		</div>
	</form>
</body>
</html>
	
	

