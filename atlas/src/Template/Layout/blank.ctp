<?php
//atlas.marcohern.com AIzaSyC0kOuurv2PZaAJStxQXkfKLaHbnMFvIRs
//atlas.local AIzaSyD5HhjYgZqtLu8p3H4_TKwxTZ0JpAhxAp4
?><!DOCTYPE html>
<html>
	<head>
    	<?= $this->Html->charset() ?>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>Atlas</title>
    	<?= $this->Html->meta('icon') ?>
        <?= $this->Html->css('toastr.css') ?>
    	<?= $this->Html->css('/bootstrap/css/bootstrap.min.css') ?>
    	<?= $this->Html->css('/bootstrap/css/bootstrap-theme.min.css') ?>
        <?= $this->Html->css('/GioOne/css/style.css') ?>
        <?= $this->Html->script('https://maps.googleapis.com/maps/api/js?key=AIzaSyD5HhjYgZqtLu8p3H4_TKwxTZ0JpAhxAp4') ?>
    </script>
	</head>
	<body>
        <div id="page_content">
            <div id="nav"></div>
            <div id="page_body"></div>
        </div>
    	<?= $this->Html->script('require.js',['data-main' => '/js/main.js']) ?>
        <div id="loading">
            <div class="spinner"></div>
        </div>
	</body>
</html>