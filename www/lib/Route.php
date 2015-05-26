<?php

class Route {
	private $method;
	private $path;

	private $defCont;
	private $defAction;
	private $paramNames;

	public function __construct($method, $path, $defCont, $defAction) {
		$this->method = $method;
		$this->path = $path;
		$this->defCont = $defCont;
		$this->defAction = $defAction;
	}

	public function resolve($query) {
		
	}
}