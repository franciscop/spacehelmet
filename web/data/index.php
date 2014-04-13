<?php
$origin_data = file_get_contents("data.txt");
$origin = (array)json_decode($origin_data);

$planets = [0 => "", 1 => "La Luna", 2 => "La Tierra", 3 => "Space App", 4 => "El Sol"];

if (isset($_GET['show']))
  $origin['show'] = $planets[$_GET['show']];

if (isset($_GET['ldr']))
  $origin['ldr'] = 15 * $_GET['ldr'] / 1024;

if (isset($_GET['temp']))
  $origin['temp'] = $_GET['temp'];

$json = json_encode($origin);
file_put_contents("data.txt", $json);

