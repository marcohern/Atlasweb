<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsCountriesController extends AppController {

	public function initialize() {
		parent::initialize();
		$this->Soteira->allow(['index','view','add','edit','delete']);
	}

	public function index() {
		$countries = $this->BarsCountries->find();
		$this->return_json($countries);
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