<!DOCTYPE html>
<html>
	<head>
    	<?= $this->Html->charset() ?>
    	<title>Atlas</title>
    	<?= $this->Html->meta('icon') ?>
    	<?= $this->Html->css('/bootstrap/css/bootstrap.min.css') ?>
    	<?= $this->Html->css('/bootstrap/css/bootstrap-theme.min.css') ?>
    	<?= $this->Html->css('/GioOne/css/style.css') ?>
	</head>
	<body>
		<?= $this->element('GioOne/nav'); ?>

	    <?= $this->fetch('content') ?>

    	<?= $this->Html->script('jquery-2.1.4.min.js') ?>
    	<?= $this->Html->script('/bootstrap/js/bootstrap.min.js') ?>
	</body>
</html>