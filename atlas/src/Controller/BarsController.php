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
		$bars = $this->Bars->find('all');
		$this->return_json($bars);
	}

	public function view($id) {
		$bar = $this->Bars->find()->contain(['BarsWeekSchedules'])->where(['id' => $id])->first();
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