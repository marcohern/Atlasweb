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
		$user = $this->Users->find()->where(['id' => $id])->first();
		$this->return_json($user);
	}

	public function add() {
		$data = $this->get_payload();
		$place = $this->Place->newEntity($data);
		$place->created = new \Datetime();
		if ($this->Users->save($user)) {
			$this->return_json(['added' => true, 'id' => $place->id]);
		} else {
			throw new AppError('unable to add place');
		}
	}

	public function edit($id) {

	}

	public function delete($id) {

	}
}