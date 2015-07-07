<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsCategoriesController extends AppController {

	public function initialize() {
		parent::initialize();
		$this->Soteira->allow(['index','view','add','edit','delete']);
	}

	public function index() {
		$categories = $this->BarsCategories->find();
		$this->return_json($categories);
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