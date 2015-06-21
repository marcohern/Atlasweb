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
		$limit = $this->get_qlimit();
		$offset = $this->get_qoffset();
		$places = $this->Places->find('all')->limit($limit)->offset($offset);
		//$count = $places->count();

		$this->return_json($places);
	}

	public function view($id) {
		$place = $this->Places->find()->where(['id' => $id])->first();
		$this->return_json($place);
	}

	public function add() {
		$data = $this->get_payload();
		$place = $this->Places->newEntity($data);
		$place->created = new \Datetime();
		if ($this->Places->save($place)) {
			$this->return_json(['added' => true, 'id' => $place->id]);
		} else {
			throw new AppError('unable to add place');
		}
	}

	public function edit($id) {
		$data = $this->get_payload();
		$oldPlace = $this->Places->get($id);
		if ($oldPlace) {
			$newPlace = $this->Places->newEntity($data);
			$this->Places->save($newPlace);
			$this->return_json($newPlace);
		} else {
			throw new AppError('unable to edit place');
		}
	}

	public function delete($id) {
		$place = $this->Places->get($id);
		if ($place) {
			$this->Places->delete($place);
			$this->return_json(['deleted' => true, 'id' => $place->id]);
		} else {
			throw new AppError('Place not found');
		}
	}
}