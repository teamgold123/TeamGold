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
 * HTML View class for the JooDatabase cataloges
 */
class JoodbViewCatalog extends JViewLegacy
{
	var $joobase = null;
	var $items = null;
	var $subitems = null;	
	var $params = null;
	var $pagination = null;

    public function display($tpl = null)
	{
		$app = JFactory::getApplication();
		$this->params = $app->getParams();

		// read database configuration from joobase table
		$this->joobase = $this->get('joobase');

		//get the data page
		$this->items = $this->get('data');
		$this->subitems = $this->get('subitems');
		
		$this->pagination = $this->get('pagination');
		
		$this->_prepareDocument();
		
		$this->params->set('search', $this->get('search'));
		$this->params->set('alphachar', $this->get('alphachar'));

		JHTML::_('behavior.modal');

		parent::display($tpl);
	}
	
	/**
	 * Prepares the document
	 */
	protected function _prepareDocument()
	{
		$document = JFactory::getDocument();
		$app = JFactory::getApplication();		
	
		if (!$this->params->get( 'page_title') )
			$this->params->set('page_title',	JText::_( $this->joobase->name ));
	
		if (!$this->params->get( 'page_heading' ) )
			$this->params->set('page_heading',JText::_( $this->joobase->name ));
	
	
		//set document title
		$document->setTitle( $this->params->get('page_title')." - ".$app->getCfg('sitename') );
		// add joodb style
		$document->addStyleSheet(JURI::root(true)."/components/com_joodb/assets/joodb.css");
	
		if ($this->params->get('menu-meta_description'))
		{
			$document->setDescription($this->params->get('menu-meta_description'));
		}
	
		if ($this->params->get('menu-meta_keywords'))
		{
			$document->setMetadata('keywords', $this->params->get('menu-meta_keywords'));
		}
	
	}	

	/**
	 * Parse Template part and replace with view specific elements
	 * @param array $parts - the split parts of the template
	 * @return string with html
	 */
	protected function _parseTemplate($parts)
	{
        $filter = new JFilterInput();
		$doOutput = true;
    	 $output = "";
		// replace item content with wildcards
    	foreach( $parts as $n => $part ) {
   		if ($doOutput) {
		  switch ($part->function) {		  	 
   			case ('pagenav'):
   				$output .= $this->pagination->getPagesLinks();
   				break;
   			case ('pagecount'):
   				$output .= $this->pagination->getPagesCounter();
   				$output .=  $this->pagination->getResultsCounter();
   				break;
   			case ('resultcount'):
   				$output .=  $this->pagination->getResultsCounter();
   				break;
   			case ('limitbox'):
   				$output .=  $this->pagination->getLimitBox();
   				break;
   			case ('searchbox'):
  				$output .=  JoodbHelper::getSearchbox($this->params->get('search'),$this->joobase,$part->parameter);
   				break;
			case ('groupselect'):
				$model = $this->getModel();
				$use_search = (isset($part->parameter[2])) ? JoodbHelper::parameterToBoolean($part->parameter[2]) : false;
				$values = $model->getColumnVals($part->parameter[0],$use_search);
				$output .= JoodbHelper::getGroupselect($this->joobase,$part->parameter,$values);
   				break;
   			case ('alphabox'):
   				$output .= JoodbHelper::getAlphabox($this->params->get('alphachar'),$this->joobase);
   				break;
			case ('orderlink'):
			case ('sortlink'):				
   				$output .= JoodbHelper::getOrderlink($part->parameter,$this->joobase);
   				break;
			case ('exportbutton'):
   				$output .= "<input class='button export' type='submit' value='".(isset($part->parameter[0]) ? $part->parameter[0] : JText::_('Export XLS'))."' onmousedown='submitSearch(\"xportxls\");void(0);' />";
   				break;
			case ('resetbutton'):
   				$output .= "<input class='button reset' type='submit' value='".(isset($part->parameter[0]) ? $part->parameter[0] : JText::_('Reset'))."' onmousedown='submitSearch(\"reset\");void(0);' />";
   				break;
			case ('searchbutton'):
   				$output .= "<input class='button search' type='submit' value='".(isset($part->parameter[0]) ? $part->parameter[0] : JText::_('Search'))."' onmousedown='submitSearch();void(0);' />";
   				break;
		  	case ('translate') :
                $output .= JText::_(addslashes($part->parameter[0]));
                break;
            }
		  }	
		  switch ($part->function) {
			case ('else'):
				$doOutput = !$doOutput;
			case ('endif'):
				$doOutput = true;
		  }
		  if ($doOutput) $output .= $part->text;
    	}
    	return ($doOutput) ? $output : "";
	}

}
?>
