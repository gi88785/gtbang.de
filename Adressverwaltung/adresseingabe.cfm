<html>
<head>
	<title>Eingabe</title>
	<link rel="stylesheet" type="text/css" href="formate.css">
		<script type="text/javascript">
			function pruefen() {
				  if (document.forms["anmeldeformular"]["vorname"].value == "") {
					alert("Feld Vorname muss ausgefüllt sein!"); 
					document.anmeldeformular.vorname.focus();
					return false;
				}		
				 if (document.forms["anmeldeformular"]["nachname"].value == "") {
					alert("Feld Nachname muss ausgefüllt sein!"); 
					document.anmeldeformular.nachname.focus();
					return false;
				}
				 if (document.forms["anmeldeformular"]["geburtstag"].value == "") {
					alert("Feld Geburtstag muss ausgefüllt sein!");
					document.anmeldeformular.geburtstag.focus();
					return false;
				}	
				 var laend = document.getElementById("laend");
				 if (laend.value == "") {
					alert("Bitte Land auswählen!");
					document.anmeldeformular.laend.focus();
					return false;
				}
				 if (document.forms["anmeldeformular"]["adresse"].value == "") {
					alert("Feld Adresse muss ausgefüllt sein!"); 
					document.anmeldeformular.adresse.focus();
					return false;
				}
				 if (document.forms["anmeldeformular"]["stadt"].value == "") {
					alert("Feld Stadt muss ausgefüllt sein!"); 
					document.anmeldeformular.stadt.focus();
					return false;
				}
				 if (document.forms["anmeldeformular"]["postleitzahl"].value == "") {
					alert("Feld Postleitzahl muss ausgefüllt sein!");
					document.anmeldeformular.postleitzahl.focus();					
					return false;
				}
				 if (document.forms["anmeldeformular"]["email"].value == "") {
					alert("Feld Email muss ausgefüllt sein!");
					document.anmeldeformular.email.focus();					
					return false;
				}
				 if	(document.forms["anmeldeformular"]["email"].value.indexOf('@' && '.') == -1) {
					alert("Keine gültige Email!");
					document.anmeldeformular.email.focus();
				    return false;
				}
				 if (document.forms["anmeldeformular"]["geburtstag"].value.length  !=10) {
					alert("Kein gültiges Datum!");
					document.anmeldeformular.geburtstag.focus();
					return false;
				}
				 var currentTime = new Date()
				 var year = currentTime.getFullYear()
				 if (document.forms["anmeldeformular"]["geburtstag"].value.substring(8,10) < 1 || document.forms["anmeldeformular"]["geburtstag"].value.substring(8,10) > 31 || document.forms["anmeldeformular"]["geburtstag"].value.substring(5,7) < 1 || document.forms["anmeldeformular"]["geburtstag"].value.substring(5,7) > 12 || document.forms["anmeldeformular"]["geburtstag"].value.substring(0,4) < 1900 || document.forms["anmeldeformular"]["geburtstag"].value.substring(0,4) > year) {
					alert("Kein gültiges Datum!");
					document.anmeldeformular.geburtstag.focus();
					return false;
				}
			}
	</script>
</head>
<cfif isdefined('user_hinzufuegen')>
	<cfset geburtstag_formatiert = Mid(geburtstag,7,4) & Mid(geburtstag,4,2) & Mid(geburtstag,1,2)>
	<cfquery name="ben_neu" datasource="schoger">
		SELECT email 
		FROM benutzer
		WHERE email = <cfqueryparam value = "#email#" maxlength="50">
	</cfquery>
	<cfquery name="land_auslesen" datasource="schoger">
		SELECT *
		FROM laender
	</cfquery>
	<cfif ben_neu.RecordCount eq 0>
	<cfquery datasource="schoger">
		INSERT INTO benutzer (vorname, nachname, geburtstag, land, adresse, stadt, postleitzahl, email, datum_hinzugefuegt, datum_geaendert, benutzerstatus)
		VALUES(
		<cfqueryparam value ="#vorname#" maxlength="35">,
		<cfqueryparam value ="#nachname#" maxlength="35">,
		<cfqueryparam value ="#geburtstag#" maxlength="10">,
		<cfqueryparam value ="#landname#" maxlength="35">,
		<cfqueryparam value ="#adresse#" maxlength="35">,
		<cfqueryparam value ="#stadt#" maxlength="35">,
		<cfqueryparam value ="#postleitzahl#" maxlength="9">,
		<cfqueryparam value ="#email#" maxlength="50">,
		NOW(),
		NOW(),
		"angemeldet");
	</cfquery>
	<script type="text/javascript">	
		alert("erfolgreich gespeichert");
	</script>
	<cfelse>
		<script type="text/javascript">
			{
				alert("Fehler! diese E-mail-Adresse ist bereits vorhanden.");
			}
		</script>
	</cfif>
</cfif>
<body>
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
			<div align="center">
				<form name="anmeldeformular" method="post" action="adresseingabe.cfm" onSubmit="return pruefen()">
				<input type="hidden" name="user_hinzufuegen" value="ja">
				<table border="4" bordercolor="#000000" border width="40%" cellpadding="0">
				<h1>Adresseingabe<h1>
				<br>
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
					<cfquery name="laenderAuslesen" datasource="schoger"> 
						SELECT landname, kuerzel
						FROM laender
					</cfquery> 
					<tr>
						<td><input type="text" autocomplete="off" name="vorname"      placeholder="Pflichtfeld"      size="10" maxlength="35"></td>
						<td><input type="text" autocomplete="off" name="nachname"     placeholder="Pflichtfeld"      size="10" maxlength="35"></td>
						<td><input type="date" autocomplete="off" name="geburtstag"   placeholder="Pflichtfeld"      size="10" maxlength="10"></td>
						<td><select name="landname" id="laend">
								<option name="landname" value="">bitte auswählen</option>
								<cfoutput query="laenderAuslesen">
								<option name="landname" value="#kuerzel#">#landname#</option>
								</cfoutput>
								</select>
						</td>
						<td><input type="text" autocomplete="off" name="adresse"      placeholder="Pflichtfeld"      size="20" maxlength="35"></td>
						<td><input type="text" autocomplete="off" name="stadt"        placeholder="Pflichtfeld"      size="15" maxlength="35"></td>
						<td><input type="text" autocomplete="off" name="postleitzahl" placeholder="Pflichtfeld"      size="10" maxlength="9"></td>
						<td><input type="text" autocomplete="off" name="email"        placeholder="Pflichtfeld"      size="30" maxlength="50"></td>	
						<td><button type="submit" style="width:130px" "" "> Eingabe speichern</td>
						<td><input type="reset" value="Eingabe löschen" /><br /></td>
					</tr>	
				</table>
				<div align="center">
			<br>
			<br>
			<br>
			bitte füllen sie alle Pflichtfelder aus
		</form>
	</div>
</div>
</div>
</body>
</html>

