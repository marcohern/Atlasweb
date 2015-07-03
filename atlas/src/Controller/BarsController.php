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

	private function apply_bar_category(&$conds) {
		if (array_key_exists('category', $this->request->query)) {
			$conds['BarsCategories.slug'] = $this->request->query['category'];
		}
	}

	private function apply_bar_q(&$conds) {
		$q = $this->get_q();
		$OR = [];
		if (!empty($q)) {
			$words = explode(' ', $q);
			foreach ($words as $w) {
				$ew = addslashes($w);
				$OR[] = ["Bars.name LIKE" => "%$ew%"];
				$OR[] = ["BarsFranchises.id IS NOT" => null,"BarsFranchises.name LIKE" => "%$ew%"];
			}
		}
		if (!empty($OR)) $conds['OR'] = $OR;
	}

	public function index() {
		$limit = $this->get_qlimit();
		$offset = $this->get_qoffset();
		$conds = ['Bars.enabled' => 'TRUE'];
		$this->apply_bar_category($conds);
		$this->apply_bar_q($conds);
		$this->log($conds);

		$bars = $this->Bars->find()->contain(['BarsWeekSchedules','BarsCategories','BarsFranchises']);
			
		if ($this->is_count()) {
			$bars->select([
				'count' => $bars->func()->count('*'),
			])->where($conds);
		} else {
			$bars->where($conds)
				->limit($limit)->offset($offset);
		}

		//debug($bars);
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