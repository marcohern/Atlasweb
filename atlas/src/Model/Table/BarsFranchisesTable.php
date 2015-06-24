<?php

namespace App\Model\Table;

use Cake\ORM\Table;
use App\Controller\Component;

class BarsFranchisesTable extends Table {

	public function initialize(array $config)
    {
        $this->table('bars_franchises');
        $this->primaryKey('id');
        $this->hasMany('Bars');
    }
}