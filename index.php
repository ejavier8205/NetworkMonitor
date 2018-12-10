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
echo "    <script src=\"js/reloader.js\"></script>\n";
echo "</head>\n";
echo "<body onload=\"setInterval('getCurrentTime()', 1000);\">\n";
echo "    <header onload=\"reloadData()\">\n";
echo "        <h1><a class=\"Production\">Production</a> Stations Connection Status<input type=\"text\" id=\"myInput\" onkeyup=\"myFunction()\" placeholder=\"Search for customer...\" title=\"Type in a name\"><a id=\"time\"></a></h1>\n";
echo "    </header>\n";




function getdata() {
	echo "<table id=\"statusTable\" class=dataTable>\n";
	echo "        <thead>\n";
	echo "        <tr>\n";
	echo "            <th class=\"CustomerHeader\" onclick=\"sortTable(0)\">Customer</th>\n";
	echo "            <th Class=\"StationHeader\" onclick=\"sortTable(1)\">Station ID</th>\n";
	echo "            <th Class=\"IPHeader\">Customer IP</th>\n";
	echo "            <th class=\"ConnectionHeader\">Last connection</th>\n";
	echo "            <th class=\"TimeHeader\">Time</th>\n";
	echo "        </tr>\n";
	echo "    </thead>";

	$file = fopen("Status.txt", "r") or die("Unable to open file!");
	echo "        <tbody>\n";

		while (!feof($file)){   
			$data = fgets($file);
			echo "<tr Id=\"Row\" class=\"tableRows\"><td>" . str_replace(',','</td><td>',$data) . '</td></tr>';
		}

	echo "    </tbody>\n";
	echo '</table>';
	fclose($file);
}

getdata();

echo "    <div onload=\"setdisconnected();\" class=\"sidepanel\">\n";
echo "\n";
echo "        <h2 class=\"sidePanelTitle\">Ghost imaging network</h2>\n";
echo "\n";
echo "        <div class=\"sidePanelContainer\">\n";
echo "            <p class=\"sidePanelData\">Charles Co.</p>\n";
echo "            <p class=\"sidePanelData\">Baltimore City</p>\n";
echo "            <p class=\"sidePanelData\">St. Johns</p>\n";
echo "            \n";
echo "        </div>\n";
echo "        <div class=\"imagecontainer\">\n";
echo "                <img src=\"images/network.png\" alt=\"NetworkIcon\">\n";
echo "        </div>\n";
echo "        \n";
echo "    </div>\n";
echo "    \n";
echo "</body>\n";
echo "\n";
echo "</html>";

?>