<?php
defined('_JEXEC') or die('Restricted access');
$doc->addStyleSheet(JUri::base() . 'templates/system/css/system.css', $type = 'text/css');
if($expand=="no") { $doc->addStyleSheet(JUri::base() . 'templates/' . $this->template . '/css/fixwidth.css', $type = 'text/css'); }
if($expand=="yes") { $doc->addStyleSheet(JUri::base() . 'templates/' . $this->template . '/css/fixwidth2.css', $type = 'text/css'); }
if($expand=="true") { $doc->addStyleSheet(JUri::base() . 'templates/' . $this->template . '/css/fixwidth3.css', $type = 'text/css'); }
if($jqueryactive=="yes") {$doc->addScript($this->baseurl . '/templates/' . $this->template . '/js/jquery.js', 'text/javascript'); }
?>