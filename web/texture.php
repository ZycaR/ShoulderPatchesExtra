<html>
  <head>
    <link rel="stylesheet" type="text/css" href="jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="texture.css">
  </head>
  <body>

<h1>Patches<h1>
  <div id="tiles">
<?php

	$xmax = 4;
	$ymax = 4;

	for ($x = 0; $x < $xmax; $x++) {
		echo '<div class="row">';
		for ($y = 0; $y < $ymax; $y++) {
			$index = $y + $x * $ymax;
			echo '<div class="cell">';
			echo '<img src="images/'.$index.'.png" title="'.$index.'.png"></img>';
			echo '</div>';
			
		}
		echo '</div>';
	}

?>
  </div>

<div id="popup" title="Upload Shoulder Patch" style="display: none;">
  <form action="upload.php" method="post" enctype="multipart/form-data">
	<label for="patchName">Patch Name:</label><br/>
	<input type="text" name="patchName" id="patchName"><br/><br/>
	
    <label for="patchImage">Patch Image:</label><br/>
	<input type="file" name="patchImage" id="patchImage"><br/><br/>
  </form>
</div>

<script type="application/javascript" src="jquery.js"></script>
<script type="application/javascript" src="jquery-ui.js"></script>
<script type="text/javascript">
  $( function() {
	var form, dialog = $("#popup").dialog({
	  autoOpen: false,
      width: 350,
      modal: true,
	  buttons: {
        "Upload Image": function(){},
        Cancel: function() { dialog.dialog( "close" ); }
      },
      close: function() {
        form[ 0 ].reset();
      }
	});
    $( "img" ).on( "click", function() { dialog.dialog( "open" ); });
	form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      // upload image
    });	
	
    $( document ).tooltip({
		position: {
			my: "center bottom",
			at: "center bottom"
		}
	});
  } );
</script>

</body>
</html>