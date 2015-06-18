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
		$conds = ['Bars.enabled' => 'TRUE'];
		if (array_key_exists('category', $this->request->query)) {
			$conds['BarsCategories.slug'] = $this->request->query['category'];
		}
		$bars = $this->Bars->find()->contain(['BarsWeekSchedules','BarsCategories'])->where($conds);
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