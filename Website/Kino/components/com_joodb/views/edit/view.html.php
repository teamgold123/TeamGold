<?php
/**
* @package		JooDatabase - http://joodb.feenders.de
* @copyright	Copyright (C) Computer - Daten - Netze : Feenders. All rights reserved.
* @license		GNU/GPL, see LICENSE.php
* @author		Dirk Hoeschen (hoeschen@feenders.de)
*
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );

jimport( 'joomla.application.component.view');

/**
 * HTML Edit class for the JooDatabase single element
 */
class JoodbViewEdit extends JViewLegacy
{
	var $joobase = null;
	var $item = null;
	var $params = null;
	var $menu = null;

    public function display($tpl = null)
	{

		// Load the menu object and parameters
		// Get some objects from the JApplication
		$app = JFactory::getApplication();
		$document = JFactory::getDocument();
		
		// Get the current menu item
        // Get the current menu item
        $menus	= JSite::getMenu();
        $this->menu	= $menus->getActive();

		$this->params = $app->getParams();

		//get the data page
		$this->item = $this->get('data');

		// read database configuration from joobase table
		$this->joobase = &$this->get('joobase');

		if (!$this->params->get( 'page_title' ) )
			$this->params->set('page_title',	JText::_( $this->joobase->name ));

		if (!$this->params->get( 'page_heading' ) )
			$this->params->set('page_heading',JText::_( $this->joobase->name ));

		//set document title			
		$document->setTitle( $this->joobase->name." - ".$app->getCfg('sitename') );

		//set pathway
		$pathway  = $app->getPathway();
		$pathway->addItem(JoodbHelper::wrapText($this->joobase->name,20), '');		

		// add joodb style
		$document->addStyleSheet(JURI::root(true)."/components/com_joodb/assets/joodb.css");
				
		JHTML::_('behavior.modal');
        JHtml::_('behavior.keepalive');
		JHTML::_('behavior.formvalidation');

		parent::display($tpl);
	}
}
?>
