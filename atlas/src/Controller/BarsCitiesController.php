<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsCitiesController extends AppController {

	public function initialize() {
		parent::initialize();
		$this->Soteira->allow(['index','view','add','edit','delete']);
	}

	public function index() {
		$cities = $this->BarsCities->find();
		$this->return_json($cities);
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