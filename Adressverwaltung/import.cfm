<html>
<head>
	<title>Dateiupload</title>
	<link rel="stylesheet" type="text/css" href="formate.css">
		<script type="text/javascript">
				function pruefen() {
						  if( document.getElementById("upload").files.length == 0 ){
							alert("Bitte eine Datei auswählen");
							form_upload.preventDefault();
							window.history.back();
						}
						else
						{
							document.form_upload.submit();
						}
					}
		</script>
</head>
<cfif isdefined("datei_hochladen")>
	<cfquery datasource="schoger">
		DELETE FROM benutzer_temp
	</cfquery>
	<cfset zeitstempel = "#DateFormat(now(), "yyyyMmdd")##TimeFormat(now(), "HHmmss")#">
	<cfset neuer_dateiname = "#ExpandPath("import/import_#zeitstempel#")#">
	<CFFILE ACTION="Upload"
	    FILEFIELD="dateiname"
		NAMECONFLICT="Overwrite"
		DESTINATION="#neuer_dateiname#">
	<cfset neuer_dateiname = replace(neuer_dateiname, "\", "/", "all")>
	<cfquery datasource="schoger" name="Importieren">
				LOAD DATA INFILE '#neuer_dateiname#'
				INTO TABLE benutzer_temp
				FIELDS TERMINATED BY ';'
				(vorname,nachname,geburtstag,adresse,stadt,postleitzahl,email)
	</cfquery>
	<cfquery datasource="schoger"  name="Zeitstemp">
		UPDATE benutzer_temp	
		SET  
			datum_hinzugefuegt = NOW() ,
			datum_geaendert = NOW() ,
			benutzerstatus = "angemeldet"
			
		WHERE datum_hinzugefuegt IS NULL;
	</cfquery>
	<cfquery datasource="schoger" name="eintraege_temp">
		SELECT *
		FROM benutzer_temp
	</cfquery>
	<cfset eintrag_ok = 0>
	<cfset eintrag_fehler = 0>
	<cfoutput query="eintraege_temp">
		<cfquery datasource="schoger" name="email_vorhanden">
			SELECT email
			FROM benutzer
			WHERE email =  <cfqueryparam value = "#email#" maxlength="50">
		</cfquery>
		<cfif email_vorhanden.RecordCount eq 0>
		<cfquery datasource="schoger">
			INSERT INTO benutzer (vorname, nachname, geburtstag, adresse, stadt, postleitzahl, email, datum_hinzugefuegt, datum_geaendert, benutzerstatus)
			SELECT vorname, nachname, geburtstag, adresse, stadt, postleitzahl, email, datum_hinzugefuegt, datum_geaendert, benutzerstatus FROM benutzer_temp
			WHERE benutzer_id =  <cfqueryparam value = #benutzer_id#>
		</cfquery>
		<cfset eintrag_ok = eintrag_ok + 1>
		<cfelse>
		<cfset eintrag_fehler = eintrag_fehler + 1>
		</cfif>
	</cfoutput>
	<cfoutput> #eintrag_ok# erfolgeich </cfoutput>
	<cfoutput> #eintrag_fehler# fehlgeschlagen </cfoutput>
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
	</div>
	<h1>Dateiupload</h1>
	<form method="post"  name="form_upload" action="import.cfm" enctype="multipart/form-data">
	  Datei:
		<input type="hidden" autocomplete="off" name="email">
		<input type="hidden" name="datei_hochladen" value="ja">
		<input type="hidden" name="MAX_FILE_SIZE" value="100000">
		<input type="file" name="dateiname" id="upload" size="40">
		<input type="button" name="Submit" onclick="pruefen()" value="Senden">
	</form>
	</div>
</body>
</html>