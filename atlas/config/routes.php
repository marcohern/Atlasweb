<?php

use Cake\Core\Plugin;
use Cake\Routing\Router;

Router::defaultRouteClass('Route');

Router::scope('/', function ($routes) {
   
    $routes->connect('/', ['controller' => 'Home', 'action' => 'index']);
    $routes->connect('/pages/*', ['controller' => 'Pages', 'action' => 'display']);
    $routes->fallbacks('InflectedRoute');
});

Plugin::routes();
