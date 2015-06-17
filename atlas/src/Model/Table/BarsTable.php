<?php

namespace App\Model\Table;

use Cake\ORM\Table;
use App\Controller\Component;

class BarsTable extends Table {

	public function initialize(array $config)
    {
        $this->table('bars');
        $this->primaryKey('id');
    }
}