<?php


echo "<DOCTYPE <!DOCTYPE html>\n";
echo "<html>\n";
echo "<head>\n";
echo "    <link href=\"https://fonts.googleapis.com/css?family=Noto+Sans\" rel=\"stylesheet\">\n";
echo "    <meta charset=\"utf-8\" />\n";
echo "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n";
echo "    <title>Bench Status</title>\n";
echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n";
echo "    <!--<meta http-equiv=\"refresh\" content=\"10\">-->\n";
echo "    <link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"css/main.css\" />\n";
echo "    <script src=\"js/main.js\"></script>\n";
echo "</head>\n";
echo "<body onload=\"setInterval('getCurrentTime()', 1000);\">\n";
echo "    <header onload=\"reloadData()\">\n";
echo "        <h1><a class=\"nodeTitle\">STATIONS 1 to 3</a><a id=\"time\"></a></h1>\n";
echo "    </header>\n";

echo "<div class=\"nodeContainer\">";
function getdata() {
	$file = fopen("Status.txt", "r") or die("<td>Unable to open file!</td>");


		while (!feof($file)){   
			$data = fgets($file);
			list($customer, $stationName, $ipAddress, $statusDate, $statusTime) = explode(",", $data);

			if($stationName == "RACK 1") {echo "<div class=\"stationName\">$stationName</div><div class=\"customerName\">$customer</div>\n";}
			if($stationName == "RACK 2") {echo "<div class=\"stationName\">$stationName</div><div class=\"customerName\">$customer</div>\n";}
			if($stationName == "RACK 3") {echo "<div class=\"stationName\">$stationName</div><div class=\"customerName\">$customer</div>\n";}
			}


	fclose($file);
	
}

getdata();

echo "</div>";
echo "</body>";

echo "</html>";
?>