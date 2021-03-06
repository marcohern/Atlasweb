<?php

use Cake\Core\Plugin;
use Cake\Routing\Router;

Router::defaultRouteClass('Route');

Router::scope('/', function ($routes) {
   
    $routes->connect('/', ['controller' => 'Home', 'action' => 'index']);
    $routes->connect('/pages/*', ['controller' => 'Pages', 'action' => 'display']);
    $routes->fallbacks('InflectedRoute');

    $routes->extensions(['json']);
    $routes->resources('Users');
    $routes->resources('Places');
    $routes->resources('Bars');
    $routes->resources('BarsCategories');
    $routes->resources('BarsGenres');
});

Plugin::routes();
