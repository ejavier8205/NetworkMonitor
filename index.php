<?phprequire_once("dbcontroller.php");$db_handle = new DBController();$pages = $db_handle->runQuery("SELECT * FROM pages");?><html>
<head>
<title>Load Dynamic Content using jQuery AJAX</title><script src="http://code.jquery.com/jquery-2.1.1.js"></script><style type="text/css" media="screen">	body{width:610;}	#menu{background: #D8F9D3;height: 40px;border-top: #F0F0F0 2px solid;}	#menu input[type="button"]{margin-left: 2px;padding: 0px 15px;height: 40px;border: 0px;background: #F0F0F0;}
	#output{min-height:300px;border:#F0F0F0 1px solid;padding:15px;}
</style><script type="text/javascript">function getPage(id) {	$('#output').html('<img src="LoaderIcon.gif" />');	jQuery.ajax({		url: "get_page.php",		data:'id='+id,		type: "POST",		success:function(data){$('#output').html(data);}	});}getPage(1);
</script>
</head>
<body><?php if(!empty($pages)) {?>
<div id="menu"><?php foreach($pages as $page) { ?><input type="button" value="<?php echo $page["title"]; ?>" onClick="getPage(<?php echo $page["id"]; ?>);" /><?php }?>	
</div><?php } ?>	<div id="output"></div>
</body>
</html>
