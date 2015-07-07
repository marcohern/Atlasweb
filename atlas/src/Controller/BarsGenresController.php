<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsGenresController extends AppController {

	public function initialize() {
		parent::initialize();
		$this->Soteira->allow(['index','view','add','edit','delete']);
	}

	public function index() {
		$genres = $this->BarsGenres->find();
		$this->return_json($genres);
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