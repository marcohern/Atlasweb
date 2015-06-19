<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsController extends AppController {

	public function initialize() {
        $this->log("BarsController.initialize");
		parent::initialize();

        $this->Soteira->allow(['index','view','add','edit','delete']);
	}

	public function beforeFilter(Event $e) {
		parent::beforeFilter($e);
	}

	public function index() {
		$limit = 5;
		$offset = 0;
		$conds = ['Bars.enabled' => 'TRUE'];
		if (array_key_exists('category', $this->request->query)) {
			$conds['BarsCategories.slug'] = $this->request->query['category'];
		}
		if (array_key_exists('l', $this->request->query)) {
			$limit = $this->request->query['l'];
		}
		if (array_key_exists('o', $this->request->query)) {
			$offset = $this->request->query['o'];
		}

		$bars = $this->Bars->find()->contain(['BarsWeekSchedules','BarsCategories'])->where($conds)->limit($limit)->offset($offset);
		$this->return_json($bars);
	}

	public function view($id) {
		$bar = $this->Bars->find()->contain(['BarsWeekSchedules','BarsCategories'])->where(['Bars.id' => $id])->first();
		if ($bar) $this->return_json($bar);
		else new AppError('bar not found');
	}

	public function add() {

	}

	public function edit($id) {

	}

	public function delete($id) {

	}
}