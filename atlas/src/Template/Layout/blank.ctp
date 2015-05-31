<!DOCTYPE html>
<html>
	<head>
    	<?= $this->Html->charset() ?>
    	<title>Atlas</title>
    	<?= $this->Html->meta('icon') ?>
        <?= $this->Html->css('toastr.css') ?>
    	<?= $this->Html->css('/bootstrap/css/bootstrap.min.css') ?>
    	<?= $this->Html->css('/bootstrap/css/bootstrap-theme.min.css') ?>
        <?= $this->Html->css('/GioOne/css/style.css') ?>
	</head>
	<body>
        <div id="page_content">
            <div id="nav"></div>
            <div id="page_body"></div>
        </div>
    	<?= $this->Html->script('require.js',['data-main' => '/js/main.js']) ?>
	</body>
</html>