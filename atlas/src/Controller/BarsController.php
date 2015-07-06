<?php
namespace App\Controller;

use Cake\Event\Event;

class BarsController extends AppController {

	private $index_fields = [
		'Bars.id','Bars.name','Bars.slug','Bars.address','Bars.color','Bars.price','Bars.cover','Bars.enabled','Bars.ex_image_url',
		'Bars.city_id','Bars.zone_id','Bars.category_id','Bars.franchise_id','Bars.lat','Bars.lng'
	];
	private $index_contains = ['BarsCategories','BarsFranchises'];

	private $detail_fields = [
		//Bar attributes
		'Bars.id','Bars.name','Bars.slug','Bars.description',
		'Bars.address','Bars.phones','Bars.lat','Bars.lng','Bars.price','Bars.cover','Bars.color','Bars.genre','Bars.hits','Bars.likes',
		'Bars.enabled','Bars.verified','Bars.ex_image_url','Bars.created','Bars.updated',

		//Bar foreign keys
		'Bars.category_id','Bars.franchise_id','Bars.city_id','Bars.zone_id',

		//City
		'BarsCities.id','BarsCities.name','BarsCities.slug',

		//Zones
		'BarsZones.id','BarsZones.name','BarsZones.slug','BarsZones.lat','BarsZones.lng',

		//Categories
		'BarsCategories.id','BarsCategories.name','BarsCategories.slug',

		//Franchises
		'BarsFranchises.id','BarsFranchises.name','BarsFranchises.slug',
	];
	private $detail_contains = ['BarsCities','BarsZones','BarsCategories','BarsFranchises','BarsWeekSchedules'];

	public function initialize() {
        $this->log("BarsController.initialize");
		parent::initialize();

        $this->Soteira->allow(['index','near','view','add','edit','delete']);
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

	public function near() {

		$lat = $this->get_query_numeric('lat',0.0);//4.665352733333333333;
		$lng = $this->get_query_numeric('lng',0.0);//-74.070351933333333333;
		$r = $this->get_query_numeric('r',2.0);
		$eradius = 6371;
		$fields = $this->index_fields;
		$fields['distance'] = "($eradius * ACOS(COS(RADIANS($lat))*COS(RADIANS(lat))*COS(RADIANS(lng)-RADIANS($lng))+SIN(RADIANS($lat))*SIN(RADIANS(lat))))";
		$q = $this->Bars->find()->where(['Bars.enabled' => 'TRUE']);
		$q->select($fields)->having(['distance <=' => $r]);
		//debug($q);
		$this->return_json($q);
	}

	public function index() {
		$limit = $this->get_qlimit();
		$offset = $this->get_qoffset();
		$conds = ['Bars.enabled' => 'TRUE'];
		$this->apply_bar_category($conds);
		$this->apply_bar_q($conds);
		$this->log($conds);

		$bars = $this->Bars->find()
			->contain($this->index_contains)
			->where($conds);
			
		if ($this->is_count()) {
			$bars->select([
				'count' => $bars->func()->count('*'),
			]);
		} else {
			$bars->select($this->index_fields)->limit($limit)->offset($offset);
		}
		//debug($bars);
		$this->return_json($bars);
	}

	public function view($id) {
		$bar = $this->Bars->find()
			->select($this->detail_fields)
			->contain($this->detail_contains)
			->where(['Bars.id' => $id])
			->first();

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