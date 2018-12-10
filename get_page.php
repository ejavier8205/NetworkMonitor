<?phprequire_once("dbcontroller.php");$db_handle = new DBController();$pages = $db_handle->runQuery("SELECT * FROM pages WHERE id = ".$_REQUEST['id']);if(!empty($pages)) {
?><h3><?php echo $pages[0]['title'];?></h3><div><?php echo $pages[0]['content'];?></p><?php } ?>
