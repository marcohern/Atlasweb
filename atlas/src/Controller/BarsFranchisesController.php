<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsFranchisesController extends AppController {

	public function initialize() {
		parent::initialize();
		$this->Soteira->allow(['index','view','add','edit','delete']);
	}

	public function index() {
		$franchises = $this->BarsFranchises->find();
		$this->return_json($franchises);
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