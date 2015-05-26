<?php

class Index {
	private $controller;
	private $action;
	private $query;
	private $q;

	public function __construct() {
		$this->controller = "home";
		$this->action = "index";
		$this->query = "";
		$this->resolveQuery();
		$this->resolveRoute();
	}

	public function resolveQuery() {
		$this->q = "";
		if (array_key_exists('q', $_GET)) {
			$this->q = $_GET['q'];
		}
	}

	public function resolveRoute() {
		$a = explode('/', $this->q);
		if (array_key_exists(0, $a)) {
			$this->controller = $a[0];
		}
		if (array_key_exists(1, $a)) {
			$this->action = $a[1];
		}
	}

	public function run() {
		print_r($this);
	}
}

$index = new Index();
$index->run();