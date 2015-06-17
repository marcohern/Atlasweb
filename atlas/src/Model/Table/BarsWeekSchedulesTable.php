<?php

namespace App\Model\Table;

use Cake\ORM\Table;
use App\Controller\Component;

class BarsWeekSchedulesTable extends Table {

	public function initialize(array $config)
    {
        $this->table('bars_week_schedules');
        $this->primaryKey('id');
        $this->belongsTo('Bars');
    }
}