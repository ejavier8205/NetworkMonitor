<?php
function getdata() {
	$file = fopen("Status.txt", "r") or die("<td>Unable to open file!</td>");


		while (!feof($file)){   
			$data = fgets($file);
			list($customer, $StationName, $ipAddress, $statusDate, $statusTime) = explode(",", $data);

			if($customer == "Anne Arundel Co.") {
				$customerID = "AACPS";
			} else {
				$customerID = "None";
			}
			echo "<tr Id=\"Row\" class=\"tableRows\"><td id=\"$customerID\" class=\"customer\">$customer</td><td class=\"station\">$StationName</td><td class=\"ip\">$ipAddress</td><td class=\"date\">$statusDate</td><td class=\"time\">$statusTime</td></tr>\n";
		}

	
	fclose($file);
	
}

getdata();

?>