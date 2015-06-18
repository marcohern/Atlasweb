<?php

namespace App\Model\Table;

use Cake\ORM\Table;
use App\Controller\Component;

class BarsCategoriesTable extends Table {

	public function initialize(array $config)
    {
        $this->table('bars_categories');
        $this->primaryKey('id');
        $this->hasMany('Bars');
    }
}