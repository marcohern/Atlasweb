<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsProvincesController extends AppController {

	public function initialize() {
		parent::initialize();
		$this->Soteira->allow(['index','view','add','edit','delete']);
	}

	public function index() {
		$provinces = $this->BarsProvinces->find();
		$this->return_json($provinces);
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