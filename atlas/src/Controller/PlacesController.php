<?php

namespace App\Controller;

use Cake\Event\Event;

class PlacesController extends AppController {


	public function initialize() {
        $this->log("PlacesController.initialize");
		parent::initialize();
	}

	public function beforeFilter(Event $e) {
		parent::beforeFilter($e);
	}

	public function index() {
		$places = $this->Places->find('all');

		$this->return_json($places);
	}

	public function view($id) {

	}

	public function add() {

	}

	public function edit($id) {

	}

	public function delete($id) {

	}
}