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

	    <div class="container">

	      <div>
	        <h1>Bootstrap starter template</h1>
	        <p class="lead">Use this document as a way to quickly start any new project.<br> All you get is this text and a mostly barebones HTML document.</p>
	      </div>

	    </div><!-- /.container -->

    	<?= $this->Html->script('jquery-2.1.4.min.js') ?>
    	<?= $this->Html->script('/bootstrap/js/bootstrap.min.js') ?>
	</body>
</html>