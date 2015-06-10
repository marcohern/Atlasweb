<?php

namespace App\Controller;

use Cake\Event\Event;

class HomeController extends AppController {

	public function initialize() {
        $this->log("HomeController.initialize");
        parent::initialize();
		$this->Soteira->allow(['index']);
	}

	public function beforeFilter(Event $e) {
        $this->log("HomeController.beforeFilter");
		parent::beforeFilter($e);
	}

	public function index() {

	}
}