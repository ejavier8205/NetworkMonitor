$(document).ready(function() {
    
    $.get('Status.txt', function(data) {

        // start the table
        var html = '<table">';
        
        // split into lines
        var rows = data.split("\n");
        
        // parse lines
        rows.forEach( function getvalues(ourrow) {
        
        // start a table row
        html += "<tr>";
        
        // split line into columns
        var columns = ourrow.split(",");
        
        html += "<td>" + columns[0] + "</td>";
        html += "<td>" + columns[1] + "</td>";
        html += "<td>" + columns[2] + "</td>";
        
        // close row
        html += "</tr>";
        })
        // close table
        html += "</table>";
        
        // insert into div
        $('#container').append(html);
        
        });
});