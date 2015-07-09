<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsZonesController extends AppController {

	private function apply_city(&$conds) {
		if (array_key_exists('city_id',$this->request->query)) {
			$conds['BarsZones.city_id'] = $this->request->query['city_id'];
		}
	}

	public function initialize() {
		parent::initialize();
		$this->Soteira->allow(['index','view','add','edit','delete']);
	}

	public function index() {
		$conds = [];
		$this->apply_city($conds);
		$zones = $this->BarsZones->find()->where($conds);
		$this->return_json($zones);
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