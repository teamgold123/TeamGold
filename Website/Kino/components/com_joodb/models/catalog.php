<?php
/**
* @package		JooDatabase - http://joodb.feenders.de
* @copyright	Copyright (C) Computer - Daten - Netze : Feenders. All rights reserved.
* @license		GNU/GPL, see LICENSE.php
* @author		Dirk Hoeschen (hoeschen@feenders.de)
*/

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die( 'Restricted access' );

jimport('joomla.application.component.model');

/**
 * JooDatabase Component Catalog Model
 */
class JoodbModelCatalog extends JModelLegacy
{
	/**
	 * Frontpage data array
	 *
	 * @var array
	 */
	var $_data = null;

	/**
	 * Frontpage total
	 *
	 * @var integer
	 */
	var $_total = null;

	/**
	 * Database Object
	 *
	 * @var object
	 */
	var $_joobase = null;

	/**
	 * Where Statemant
	 *
	 * @var string
	 */
	var $_where = null;	

	/**	 
	 * Postion of current element
	 * 
	 * @var integer
	 */
	var $_postion = null;
	
	
	/**
	 * Constructor
	 */
	public function __construct()
	{
		parent::__construct();
		$app = JFactory::getApplication();
		$params	= $app->getParams();
		$joodbId = $params->get("joobase",0);
		// Load the Database parameters
		if ($joodbId==0) $joodbId = JRequest::getInt('joobase', 1);
		$this->_joobase =  JTable::getInstance( 'joodb', 'Table' );
		if (!$this->_joobase->load( $joodbId)) JError::raiseError( 500, $this->_joobase->getErrror());
		if ($this->_joobase->published==0) JError::raiseError( 404, JText::sprintf( 'Database is unpublished or not availiable'));

		$option = "com_joodb".$joodbId;

		// access allowed... redirect to login if not
		JoodbHelper::checkAuthorization($this->_joobase,"accessd");
		$this->_db = $this->_joobase->getTableDBO();

		// get the table field list
		$db = JFactory::getDbo();
		$this->_joobase->fields = $this->_db->getTableColumns($this->_joobase->table);
		$orderby = $app->getUserStateFromRequest($option.'.orderby', 'orderby',null, 'cmd');		
		$ordering = $app->getUserStateFromRequest($option.'.ordering', 'ordering',null, 'cmd');		
		if (empty($orderby)) $orderby = $params->get('orderby','fid');
		if (empty($ordering)) $ordering = $params->get('ordering','DESC');

		// Get the pagination request variables
		$this->setState('limit', $app->getUserStateFromRequest($option.'.limit', 'limit', $params->get('limit','10'), 'int'));
		$this->setState('limitstart', JRequest::getInt('limitstart', 0));
		$this->setState('orderby', $orderby);
		$this->setState('ordering', $ordering);
		
		// Get search pramaters
		$search = $app->getUserStateFromRequest($option.'.search', 'search',JRequest::getVar('search'), 'string');
		if ($search==JText::_('search...')) $search = "";
		$this->setState('search',addslashes($search));
				
		$this->setState('alphachar', JRequest::getCmd('letter'));
		$where = array();
		$prefilter= $params->get("where_statement");
		if (!empty($prefilter)) {
			 $where[] = ' ('.$prefilter.')';
		}

		//build search string
		if ($this->getState('alphachar')!="") {
			if (JRequest::getVar('letter')) {
				$this->setState('search','');
			}
			$where[] .= " ( a.`".$this->_joobase->ftitle."` LIKE '".substr($this->getState('alphachar'),0,1)."%' )";
		} else if ($this->getState('search')!="") {
			if (strlen($this->getState('search'))>=2) {
				$search = $this->_db->escape(substr($this->getState('search'),0,40));
				// extended search
				if ($sfield = JRequest::getVar('searchfield')) {
						$where[] .= " ( a.`".addslashes($sfield)."` LIKE '%".$search."%' ) ";
				} else {
					if ($params->get('search_all',1)==1) {
						$wa = array();
						foreach ($this->_joobase->fields AS $var => $field) {
							switch ($field) {
								case 'varchar' : case 'char' : case 'tinytext' : case 'text' : case 'mediumtext' : case 'longtext' :
									$wa[] = "a.`".$var."` LIKE '%".$search."%'";
									break;
								case 'int' : case 'smallint' : case 'mediumint' : case 'bigint' : case 'tinyint' :
									$wa[] = "a.`".$var."` = '".(int) $search."'";
									break;
								case 'date' : case 'datetime' : case 'timestamp' :
									$wa[] = "a.`".$var."` LIKE '".$search."%'";
									break;
								default :
									$wa[] = "a.`".$var."` LIKE '".$search."'";
							}
						}
						$where[] .= " ( ".join(" OR ", $wa)." ) ";
					} else {	
						$where[] .= " (a.`".$this->_joobase->ftitle."` LIKE '%".$search."%' ".
				    	        " OR a.`".$this->_joobase->fcontent."` LIKE '%".$search."%' ) ";
					}
				}
			}
		}
		if ($this->_joobase->fstate) $where[] = "a.`".$this->_joobase->fstate."`='1'";

		if (JRequest::getCmd('reset')=="true") {
			$app->setUserState($option.'.cid',array());
			$app->setUserState($option.'.gs',array());
		}		
		
		// reduce result to selected items
		$ids = $app->getUserStateFromRequest($option.'.cid', 'cid',array(), 'array');
		if (is_array($ids) && count($ids)>=1) {
			foreach ($ids as $n => $fid)
				$ids[$n] = "a.`".$this->_joobase->fid."`= '".$fid."'";
			$where[] = " (".join(" OR ", $ids).") ";
		} else {
			$app->setUserState($option.'.cid',array());
		}

		// limit to user id
		if ($params->get('limit_to_user','0')==1 && $this->_joobase->getSubdata('fuser')) {
			$where[]  = "`".$this->_joobase->getSubdata('fuser')."`='".JFactory::getUser()->id."'";
		}

		// add filter from parametric search selects
		$gs =  $app->getUserStateFromRequest($option.'.gs', 'gs',array(), 'array');

		if (is_array($gs) && count($gs)>=1)
		 foreach ($gs as $column => $sv) {
			if (isset($this->_joobase->fields[$column])) {
				foreach ($sv as $n => $value)
					if (empty($value)) unset($sv[$n]);
					else $sv[$n] = "`".$column."` LIKE ".$this->_db->Quote($value);
				if (count($sv)>=1) $where[] = " (".join(" OR ", $sv).") ";
			}
		} else {
			$app->setUserState($option.'.gs',array());
		}
		
		// notepad view select marked articles
		if (JRequest::getCmd("layout")=="notepad") {
			$where = array();
	  		$session =& JFactory::getSession();
			$articles = preg_split("/:/",$session->get('articles'));
			if (count($articles)>=1) {
		    	foreach ($articles as $n => $article) $articles[$n] = " a.`".$this->_joobase->fid."`='".$article."' ";
			} else $articles = array(" a.`".$this->_joobase->fid."`='0'");
			$where[] = " (".join(" OR ", $articles).") ";
		}
		if (count($where)>=1) $this->_where = " WHERE ".join(" AND ", $where);
	}

	/**
	 * Get Object from JooDB table
	 *
	 * @access public
	 * @return single object
	 */
	function getJoobase()
	{
		return	$this->_joobase;
	}

	/**
	 * Method to get Data from table in Database
	 *
	 * @access public
	 * @param boolean $export - ignore pagination limit and page
	 * @return array
	 */
	public function getData($export=false)
	{
		// Lets load the content if it doesn't already exist
		if (empty($this->_data))
		{
			$query = $this->_buildQuery();
			$app = JFactory::getApplication();
			JFactory::getDbo()->getErrors();
			$pagination = $this->getPagination();
			if ($export===true) {
				$params	= $app->getParams();
				$pagination->limitstart = 0;
				$pagination->limit = $params->get('eportlimit',"100");
			}
			$this->_data = $this->_getList($query,$pagination->limitstart,$pagination->limit);
			if ($this->_data===null) {
				$app->enqueueMessage(JText::_( 'Error' )." : ".$this->_db->getErrorMsg(),"Warning");
			}			
		}
		return $this->_data;
	}
	

	/**
	 * Return Export items ...
	 */
	public function getExport() {
		return $this->getData(true);
	}

	/**
	 * Method to get the total number of items in the Database
	 *
	 * @access public
	 * @return integer
	 */
	function getTotal()
	{
		// Get total if not exits
		if (empty($this->_total))
		{
			$query = 'SELECT `'.$this->_joobase->fid.'` AS numlinks FROM `'.$this->_joobase->table."` AS a ".$this->_where;
			$this->_total = $this->_getListCount($query);
		}

		return $this->_total;
	}

	/**
	 * Get the possible values from a column regarding the current selection
	 *
	 * @access public
	 * @return values
	 */
	public function getColumnVals($column,$use_search=true)
	{
		// Get total if not exits
		if ($use_search && !empty($this->_data)) {
			$cw = $this->_where;
		} else {
			$app = JFactory::getApplication();
			$params	= $app->getParams();
            $cw = $params->get("where_statement");
            if (!empty($cw)) $cw = "WHERE ".$cw;
		}
        $fields = $this->_joobase->getTableFieldList();
        $type = preg_split("/\(/",$fields[$column]);
        $split = ($type[0]=="enum" || $type[0]=="set") ? true : false;
	    $query = "SELECT count(distinct(`".$this->_joobase->fid."`)) AS count,a.`".$column."` AS value, '' AS delimeter FROM `"
            .$this->_joobase->table."` AS a ".$cw." GROUP BY a.`".$column."` ORDER BY a.`".$column."` ASC";
        $values = $this->_getList($query);
        if (!empty($values)) {
			foreach ($values as $value) {
				if (substr_count($value->value,",")>=1) { // its a value list - rebuild values
					$query = "SELECT a.`".$column."` AS value FROM `".$this->_joobase->table."` AS a ".$cw." ORDER BY a.`".$column."` ASC";
					$values = $this->_getList($query);
					$v= array();
					foreach ($values as $value) {
						if ($split) {
							$parts = preg_split("/,/",$value->value);
							foreach ($parts as $p) $v[] = trim($p);
						} else $v[] = $value->value; 	
					}
					sort($v);
					$c = array_count_values($v);
					$values = array();
					foreach ($c as $value => $count) {
						$values[] = (object) array ("value" => $value, 'count' => $count, "delimeter" => '%');
					}
                    break;
				}
			}
		}
		return $values;
	}


	/**
	 * Method to get a pagination object
	 *
	 * @access public
	 * @return integer
	 */
	public function getPagination()
	{
		if (empty($this->_pagination))
		{
			jimport('joomla.html.pagination');
			$this->_pagination = new JPagination( $this->getTotal(), $this->getState('limitstart'), $this->getState('limit') );
		}
		return $this->_pagination;
	}

	/**
	 * Method to get a search value
	 *
	 * @access public
	 * @return string
	 */
	public function getSearch()
	{
		return $this->getState('search');
	}

	/**
	 * Method to get a search value
	 *
	 * @access public
	 * @return string
	 */
	public function getAlphachar()
	{
		return $this->getState('alphachar');
	}
	

	/**
	 * Try to get the id of the next or Previous entry in katalog
	 *
	 * @param string $dir (next or prev)
	 * @return $item with position AND total
	 */
	public function getSideElementUrl($dir="next",$position=0) {
		if (empty($this->_position) && empty($this->_total)) {
			$this->_position = JRequest::getInt('position');
			$this->_total = JRequest::getInt('total');
		}
				
		if ( $this->getState('orderby') == "random") $this->setState('orderby','fid');
		$orderby = $this->getState('orderby');
		if (!isset($this->_joobase->fields[$orderby]) && isset($this->_joobase->{$orderby})) $orderby = $this->_joobase->{$orderby};
		$orderby = " ORDER BY a.`".$orderby."` ".$this->getState('ordering');
		// get position only once to prevent heavy mysql load
		if (empty($this->_position)) {
			$id = JRequest::getInt('id', 1);
			$query = "SELECT p.`jb_pos` FROM "
				."(SELECT a.`".$this->_joobase->fid."`, @rownum := @rownum +1 AS jb_pos FROM "
				."`".$this->_joobase->table."` a JOIN (SELECT @rownum :=0) r "
				.$this->_where." GROUP BY a.`".$this->_joobase->fid."`"
				.$orderby.") p WHERE p.`".$this->_joobase->fid."` = ".$id;
			$this->_db->setQuery($query,0,1);
			$this->_position = $this->_db->loadResult();
		}
		// get start postion in result 
		$start_pos = ($dir=="next") ? $this->_position+1 : $this->_position-1;
		if ($start_pos <= 0) $start_pos = $this->_total;
		if ($start_pos > $this->getTotal()) $start_pos = 1;
		
		$this->_db->setQuery($this->_buildQuery(),($start_pos-1),1);
		if ($item = $this->_db->loadObject()) { 
			$item->jb_total = $this->getTotal();
			$item->jb_pos = $start_pos;
		}	
		
		return $item;
	}	

	/**
	 * Build query string
	 *
	 * @access non-public
	 * @return string
	 */
	protected function _buildQuery()
	{
		/* Query table and return the relevant fields. */
		$query = "SELECT a.* "
			. " FROM `".$this->_joobase->table."` AS a"
			. $this->_where
			. " GROUP BY a.`".$this->_joobase->fid."`";

			// build ordering
			$orderby = $this->getState('orderby');
			if ($this->getState('orderby')== "random") {
				$query .= " ORDER BY RAND() ";
			} else {
				if (!isset($this->_joobase->fields[$orderby]) && isset($this->_joobase->{$orderby})) $orderby = $this->_joobase->{$orderby};
				$query .= " ORDER BY a.`".$orderby."` ".$this->getState('ordering');
			}
			return $query;
	}

}
?>
