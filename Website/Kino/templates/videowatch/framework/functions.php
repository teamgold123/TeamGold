<?php
defined('_JEXEC') or die('Restricted access');
$app = JFactory::getApplication();
$doc = JFactory::getDocument();
$logo = $this->params->get('logo');
$responsive = $this->params->get('responsive');
$fontfamily = $this->params->get('fontfamily');
$expand = $this->params->get('expand');
$showheader = $this->params->get('showheader');
$copyright = $this->params->get('copyright');
$jqueryactive = $this->params->get('jqueryactive');
$unsetjoomjs = $this->params->get('unsetjoomjs');
$unsetmootools = $this->params->get('unsetmootools');
$unsetbootstrap = $this->params->get('unsetbootstrap');
$unsetjquerymin = $this->params->get('unsetjquerymin');
$sitetitle = $app->getCfg('sitename');
global $multicolBlocks;
$multicolBlocks = array(
'block1' => array('user1', 'user2', 'user3'),
'block2' => array('user4', 'user5', 'user6'),
'block3' => array('user7', 'user8', 'user9'),
'block4' => array('footer1', 'footer2', 'footer3', 'footer4', 'footer5'));
$user_count = ($this->countModules('user1')>0) + ($this->countModules('user2')>0) + ($this->countModules('user3')>0);
$user_width = $user_count > 0 ? 'user' . floor(99 / $user_count) : '';
$user2_count = ($this->countModules('user4')>0) + ($this->countModules('user5')>0) + ($this->countModules('user6')>0);
$user2_width = $user2_count > 0 ? 'user' . floor(99 / $user2_count) : '';
$user3_count = ($this->countModules('user7')>0) + ($this->countModules('user8')>0) + ($this->countModules('user9')>0);
$user3_width = $user3_count > 0 ? 'user' . floor(99 / $user3_count) : '';
$footer_count = ($this->countModules('footer1')>0) + ($this->countModules('footer2')>0) + ($this->countModules('footer3')>0) + ($this->countModules('footer4')>0) + ($this->countModules('footer5')>0);
$footer_width = $footer_count > 0 ? 'footer' . floor(99 / $footer_count) : '';
function modulesClasses($case, $loaded_only = false) {
global $multicolBlocks;
$document = JFactory::getDocument();
$modules = '$mainmodulesBlocks[$case]';
$loaded = 0;
$loadedModule = array();
$classes = array();
foreach($multicolBlocks[$case] as $block) if ($document->countModules($block)>0) { $loaded++; array_push($loadedModule, $block); }
if ($loaded_only) return $loaded;
switch ($loaded) {
case 1:
$classes[$loadedModule[0]][0] = 'full';
$classes[$loadedModule[0]][1] = '$width[0]';
break;
case 2: 
for ($i = 0; $i < count($loadedModule); $i++){
if (!$i) {
$classes[$loadedModule[$i]][0] = 'first';
$classes[$loadedModule[$i]][1] = '$width[0]';
} else {
$classes[$loadedModule[$i]][0] = 'second';
$classes[$loadedModule[$i]][1] = '$width[1]';
}
}
break;
case 3:
for ($i = 0; $i < count($loadedModule); $i++){
if (!$i) {
$classes[$loadedModule[$i]][0] = 'first';
$classes[$loadedModule[$i]][1] = '$width[0]';
} elseif ($i == 1) {
$classes[$loadedModule[$i]][0] = 'second';
$classes[$loadedModule[$i]][1] = '$width[1]';
} else {
$classes[$loadedModule[$i]][0] = 'third';
$classes[$loadedModule[$i]][1] = '$width[2]';
}
}
break;
case 4:
for ($i = 0; $i < count($loadedModule); $i++){
if (!$i) {
$classes[$loadedModule[$i]][0] = 'first';
$classes[$loadedModule[$i]][1] = '$width[0]';
} elseif ($i == 1) {
$classes[$loadedModule[$i]][0] = 'second';
$classes[$loadedModule[$i]][1] = '$width[1]';
} elseif ($i == 2) {
$classes[$loadedModule[$i]][0] = 'third';
$classes[$loadedModule[$i]][1] = '$width[2]';
} else {
$classes[$loadedModule[$i]][0] = 'forth';
$classes[$loadedModule[$i]][1] = '$width[3]';
}
}
break;
case 5:
for ($i = 0; $i < count($loadedModule); $i++){
if (!$i) {
$classes[$loadedModule[$i]][0] = 'first';
$classes[$loadedModule[$i]][1] = '$width[0]';
} elseif ($i == 1) {
$classes[$loadedModule[$i]][0] = 'second';
$classes[$loadedModule[$i]][1] = '$width[1]';
} elseif ($i == 2) {
$classes[$loadedModule[$i]][0] = 'third';
$classes[$loadedModule[$i]][1] = '$width[2]';
} elseif ($i == 3) {
$classes[$loadedModule[$i]][0] = 'forth';
$classes[$loadedModule[$i]][1] = '$width[3]';
} else {
$classes[$loadedModule[$i]][0] = 'fifth';
$classes[$loadedModule[$i]][1] = '$width[4]';
}
}
break;
}
return $classes;
}
function getColumns ($left, $right, $center){
if($left && !$right && !$center) { $columns = "-left-only"; }
if($right && !$left && !$center) { $columns = "-right-only"; }
if($left && $right && !$center) { $columns = "-left-right"; }
if(!$left && !$right && !$center) { $columns = "-wide"; }
if($right && !$left && $center) { $columns = "-right-center"; }
if(!$right && $left && $center) { $columns = "-left-center"; }
if($right && $left && $center) { $columns = "-left-right-center"; }
if(!$right && !$left && $center) { $columns = "-center-only"; }
return $columns;
}
$columns = getColumns($this->countModules( 'left' ),$this->countModules( 'right' ),$this->countModules( 'center' ));
if($unsetjoomjs=="yes") {
unset($doc->_scripts[JURI::root(true) . '/media/jui/js/jquery-migrate.min.js']);
unset($doc->_scripts[JURI::root(true) . '/media/system/js/core.js']);
unset($doc->_scripts[JURI::root(true) . '/media/system/js/caption.js']);
}
if($unsetmootools=="yes") {
unset($doc->_scripts[JURI::root(true) . '/media/system/js/mootools-core.js']);
unset($doc->_scripts[JURI::root(true) . '/media/system/js/mootools-more.js']);
}
if($unsetjquerymin=="yes") {
unset($doc->_scripts[JURI::root(true) . '/media/jui/js/jquery.min.js']);
unset($doc->_scripts[JURI::root(true) . '/media/jui/js/jquery-noconflict.js']);
}
if($unsetbootstrap=="yes") {
unset($doc->_scripts[JURI::root(true) . '/media/jui/js/bootstrap.min.js']);
}
if($responsive=="yes") { include dirname(__FILE__).DIRECTORY_SEPARATOR.'responsive.php'; }
elseif($responsive=="no") { include dirname(__FILE__).DIRECTORY_SEPARATOR.'fixwidth.php'; }
function check_designer(){
$file = dirname(__FILE__).DIRECTORY_SEPARATOR.'copyframe.php';
$link = '<a href="http://www.joomlasaver.com" target="_blank" title="www.joomlasaver.com">';
$filedata = fopen($file,'r'); $check = fread($filedata,filesize($file)); fclose($filedata); if(strpos($check, $link)==0){
echo '<br><center>If you want to remove our link<br />please purchase this template at <a href="http://www.joomlasaver.com" target="_blank">JoomlaSaver</a></center>';
die;
}
}
check_designer();
?>