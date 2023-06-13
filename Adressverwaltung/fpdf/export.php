<?php
require('fpdf.php');
ini_set('display_errors', 1);
error_reporting(E_ALL);
set_time_limit('180');
extract($_REQUEST, EXTR_PREFIX_ALL|EXTR_REFS, 'rvar');
// Ueberpruefung der uebergebenen Variablen START
//	if(!preg_match("/^DE$|^EN$/", $rvar_sprache)){$rvar_sprache="";}
//	if(!preg_match("/^[0-9]*$/", $rvar_lieferantennr)){$rvar_lieferantennr="";}
//	if(!preg_match("/^[0-9]*$/", $rvar_su_artikelnr)){$rvar_su_artikelnr="";}
//	if(!preg_match("/^[0-9]*$/", $rvar_su_bestgruppe)){$rvar_su_bestgruppe="";}
//	if(!preg_match("/^[0-9]*$/", $rvar_su_statistikgruppe)){$rvar_su_statistikgruppe="";}
//	if(!preg_match("/^J$|^N$/", $rvar_su_bestellbarkeit)){$rvar_su_bestellbarkeit="";}
//	if(!preg_match("/^[0-9a-zA-Z ]{1,15}$/", $rvar_su_artikelbez)){$rvar_su_artikelbez="";}
//	if(!preg_match("/^[0-9a-zA-Z ]{1,16}$/", $rvar_su_liefartikelnr)){$rvar_su_liefartikelnr="";}
//	if(!preg_match("/^artikelnr$|^tmp_lieferantenartikelnr$|^artikelbez$|^bestellgruppe$|^statistikgruppe$|^bestandsschluessel$/", $rvar_sort1)){$rvar_sort1="";}
//	if(!preg_match("/^artikelnr$|^tmp_lieferantenartikelnr$|^artikelbez$|^bestellgruppe$|^statistikgruppe$|^bestandsschluessel$/", $rvar_sort2)){$rvar_sort2="";}
//	if(!preg_match("/^artikelnr$|^tmp_lieferantenartikelnr$|^artikelbez$|^bestellgruppe$|^statistikgruppe$|^bestandsschluessel$/", $rvar_sort3)){$rvar_sort3="";}
// Ueberpruefung der uebergebenen Variablen ENDE
$prn_con = mysqli_connect('localhost', 'root', '');
mysqli_select_db($prn_con, 'schoger');

$title = 'Export';
$FileN = 'Export.pdf';

class PDF extends FPDF
{
	function Header(){
    $this->SetFont('Arial','B',15);
    $this->Cell(110);
    $this->Cell(50,0,'Adressverwaltung',0,0,'C');
    $this->Ln(20);

	}
	function Footer(){
	}
}

$pdf=new PDF('L');
$pdf->AliasNbPages();
$pdf->AddPage();
$pdf->SetTitle($title);
$pdf->SetAuthor('Schoger');
$pdf->SetCreator('Schoger');
$pdf->SetFont('Arial','',7);
$pdf->SetFont('Arial','',7);
$pdf->SetFillColor(225);



$pdf->SetFont('Arial','B',9);
$pdf->Cell(25,5,'Vorname',1,0,);
$pdf->Cell(25,5,'Nachname',1,0);
$pdf->Cell(25,5,'Geburtsdatum',1,0);
$pdf->Cell(25,5,'Nationalität',1,0);
$pdf->Cell(25,5,'Adresse',1,0);
$pdf->Cell(25,5,'Stadt',1,0);
$pdf->Cell(25,5,'Postleitzahl',1,0);
$pdf->Cell(25,5,'Email',1,0);
$pdf->Cell(25,5,'Hinzugefügt',1,0);
$pdf->Cell(25,5,'letzte Änderung',1,0);
$pdf->Cell(25,5,'Status',1,1);
$pdf->SetFont('Arial','',7);


$i=0; 
$result = mysqli_query($prn_con, 'SELECT * FROM benutzer LEFT JOIN laender ON benutzer.land = laender.kuerzel ORDER BY '.$rvar_sortierung.' ');


$fCount = mysqli_num_fields($result);


while($row=mysqli_fetch_row($result)){
	while ($i < $fCount)
	{ 
		$fName = mysqli_field_name($result, $i); 
		${'P'.$fName} = trim($row[$i]);
		$i++; 
	}
	$pdf->Cell(25,5,$Pvorname,1,0);
	$pdf->Cell(25,5,$Pnachname,1,0);
	$pdf->Cell(25,5,$Pgeburtstag = date("d.m.Y", strtotime($Pgeburtstag)),1,0);
	$pdf->Cell(25,5,$Plandname,1,0);
	$pdf->Cell(25,5,$Padresse,1,0);
	$pdf->Cell(25,5,$Pstadt,1,0);
	$pdf->Cell(25,5,$Ppostleitzahl,1,0);
	$pdf->Cell(25,5,$Pemail,1,0);
	$pdf->Cell(25,5,$Pdatum_hinzugefuegt = date("d.m.Y", strtotime($Pdatum_hinzugefuegt)),1,0);
	$pdf->Cell(25,5,$Pdatum_geaendert = date("d.m.Y", strtotime($Pdatum_geaendert)),1,0);
	$pdf->Cell(25,5,$Pbenutzerstatus,1,1);
	$i=0;
}

mysqli_close($prn_con);

$pdf->Output($FileN, 'D');

?>
