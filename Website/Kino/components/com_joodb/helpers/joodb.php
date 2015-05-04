<?php
/**
* @package		JooDatabase - http://joodb.feenders.de
* @copyright	Copyright (C) Computer - Daten - Netze : Feenders. All rights reserved.
* @license		GNU/GPL, see LICENSE.php
* @author		Dirk Hoeschen (hoeschen@feenders.de)
*/

// no direct access
defined('_JEXEC') or die('Restricted access');

// Component Helper
jimport('joomla.application.component.helper');

/**
 * JooDB Component Helper
 */
class JoodbHelper
{

	/**
 	* Parse template for wildcards and return text
 	*
 	* @access public
 	* @param JooDB-Objext with fieldnames, Array with template parts, Object with Item-Data
 	* @return The parsed output$parmas
 	*
 	*/
	static function parseTemplate(&$joobase, & $parts, &$item) {
		$output = "";
		// generate link to the item
	   	$itemlink = JRoute::_('index.php?option=com_joodb&view=article&joobase='.$joobase->id.'&id='.$item->{$joobase->fid}.':'.JFilterOutput::stringURLSafe($item->{$joobase->ftitle}),false);
		$doOutput = true;
		$level = 0;
		$imgpart = "/images/joodb/db".$joobase->id."/img".$item->{$joobase->fid};
        $filter = new JFilterInput();

        // replace item content with wildcards
    	foreach( $parts as $n => &$part ) {
            if ($doOutput) {
				// replace field command with 1st parameter
                if (empty($part->function)) {
                } else if ($part->function=="field") {
    				$part->function = $part->parameter[0]; array_shift($part->parameter);
					$output .= self::replaceField($joobase, $part, $item->{$part->function}, $itemlink,$item->{$joobase->fid});
	   			} else if ($part->function=="readon") { // replace readon field
					$output .= self::getReadmore($itemlink); 
	   			} else if ($part->function=="path2item") {  // get url to current item
					$output .= $itemlink; 
	   			} else if ($part->function=="path2editform") { // get url to edit view of current item
					$output .= JRoute::_('index.php?option=com_joodb&view=edit&joobase='.$joobase->id.'&id='.$item->{$joobase->fid},false); 
	   			} else if ($part->function=="nextbutton") { // get next item link
   					$output .= self::getNavigationButton("next",$joobase);
	   			} else if ($part->function=="prevbutton") { // get previous item link
					$output .= self::getNavigationButton("prev",$joobase);
    			} else if ($part->function=="loopclass") { // replace item loop class field
					$output .= $item->loopclass;
	   			} else if ($part->function=="printbutton") { // insert print button
					$output .= self::getPrintPopup($item,$joobase);
                } else if ($part->function=="editbutton") { // insert print button
                    $output .= self::getEditButton($item,$joobase,$part);
	   			} else if ($part->function=="backbutton") { // insert backlink
					$output .= self::getBackbutton();
                } else if ($part->function=="translate") { // Translate using joomla Language system
                    $output .= JText::_(addslashes($part->parameter[0]));
	   			} else if ($part->function=="image") { // get image
					$image = JURI::root(true).(file_exists(JPATH_ROOT.$imgpart.".jpg") ? $imgpart.".jpg" : "/components/com_joodb/assets/images/nopic.png");
					$output .= '<img src="'.$image.'" alt="image" class="database-image';
					if (!file_exists(JPATH_ROOT.$imgpart.".jpg")) $output .= " nopic";
					$output .='" />';
	   			} else if ($part->function=="thumb") { // get small image
					$thumb = JURI::root(true).(file_exists(JPATH_ROOT.$imgpart."-thumb.jpg") ? $imgpart."-thumb.jpg" : "/components/com_joodb/assets/images/nopic.png");
					$image = JURI::root(true).(file_exists(JPATH_ROOT.$imgpart.".jpg") ? $imgpart.".jpg" : "/components/com_joodb/assets/images/nopic.png");
					$output .= '<a href="'.$image.'" class="modal"><img src="'.$thumb.'" alt="thumb" class="database-thumb';
					if (!file_exists(JPATH_ROOT.$imgpart.".jpg")) $output .= " nopic";
					$output .= '" /></a>';
	   			} else if ($part->function=="path2image") { // get image
					$output .= JURI::root(true).(file_exists(JPATH_ROOT.$imgpart.".jpg") ? $imgpart.".jpg" : "/components/com_joodb/assets/images/nopic.png");
	   			} else if ($part->function=="path2thumb") { // get small image
					$output .= JURI::root(true).(file_exists(JPATH_ROOT.$imgpart."-thumb.jpg") ? $imgpart."-thumb.jpg" : "/components/com_joodb/assets/images/nopic.png");
	   			} else if ($part->function=="checkbox") { // print checkbox
	   				$ids = JRequest::getVar('cid', array(), '', 'array');
	   				$checked = (in_array($item->{$joobase->fid},$ids)) ? 'checked="checked"' : '';
					$output .= '<input class="inputbox check" type="checkbox" id="cb'.$item->{$joobase->fid}.'" name="cid[]" value="'.$item->{$joobase->fid}.'" '.$checked.' />';
	   			} else if (isset($joobase->fields[$part->function])) {
                    /** only replace exisiting fields
    				 *  @deprecated */
				  	$output .= self::replaceField($joobase, $part, $item->{$part->function}, $itemlink,$item->{$joobase->fid});
	   			}
			}
			self::GetOutputState($item, $part,$doOutput,$level);
			if ($doOutput) $output .= $part->text;
  	 	}
  	 	return $output;
	}

	/**
 	* Replaces a joodb fieldname with field contennt
 	*
 	* @access public
 	* @param JooDB-Object with fieldnames, Part-object from the template, Text with field content
 	* @return The parsed output
 	*
 	*/
	static function replaceField(&$joobase, &$part, $field, $itemlink,$id) {
		$app = JFactory::getApplication();
		$params	= $app->getParams();

		$fieldname = $part->function;
		if (($fieldname==$joobase->ftitle) && ($params->get('link_titles',0))) {
			$field= "<a href='".$itemlink."' title='".Jtext::_('Read more...')."' class='joodb_titletink'>".$field."</a>";
		}
		// convert some of the fieldtypes
		switch(strtolower($joobase->fields[$part->function])) {
			case "date":
				$field= JHtml::_('date', $field, JText::_('DATE_FORMAT_LC3'));
			break;
			case "datetime":
				$field= JHtml::_('date', $field, JText::_('DATE_FORMAT_LC2'));
			break;
			case "timestamp":
				$field= JHtml::_('date', $field, JText::_('DATE_FORMAT_LC2'));
			break;
			case "varchar":
			case "tinytext":
				if ($params->get('link_urls','0')) {
					// try to detect and link urls ans emails
					if (preg_match('/^[^@]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$/', $field)) {
						$field= JHtml::_('email.cloak', $field);
					} else if (strtolower(substr($field,0,4))=="www.") {
						$field= '<a href="http://'.$field.'" target"_blank">'.$field.'</a>';
                    } else if (preg_match('#^http(s)?://#',$field)) {
                        $field= '<a href="'.$field.'" target"_blank">'.preg_replace( "#^[^:/.]*[:/]+#i", "", $field).'</a>';
                    }
				}				
			break;
			case "tinyblob" :
			case "mediumblob" :
			case "blob" :
			case "longblob" :
				// @todo extend the field mode settings for downloads and so on to define filenames and scaling
				$field = (!empty($field)) ? JURI::root().'index.php?option=com_joodb&task=getFileFromBlob&joobase='.$joobase->id.'&id='.$id.'&field='.$fieldname : "";  
			break;	
		}
		// shorten a text for abscracts
		if ((isset($part->parameter[0])) && ($part->parameter[0]>1)) {
			$field = self::wrapText($field,$part->parameter[0]);
		}
		return $field;
	}

	/**
	 * Analyses the field-parameter and returns a formfield ...
	 * @param object $joobase
	 * @param string $params ... fieldname e.g.
	 * @param misc $value
	 */
	static function getFormField(&$joobase,$params,$value=null) {
		$fieldname = $params[0];
        $fid = "jform_".preg_replace("/[^A-Z0-9]/i","",$fieldname);
		foreach ($joobase->fields as $field) {
			if ($fieldname==$field->Field) {
				$typearr = preg_split("/\(/",$field->Type);
				$typevals = array();
				$required = ($field->Null=="NO") ? "required" :"";
				if (isset($typearr[1])) { $typevals =  preg_split("/','/",trim($typearr[1],"')"));	}
				if (empty($value)) $value = JRequest::getVar($fieldname);
				if (empty($value)) $value = $field->Default;
				$formfield = "";
			switch ($typearr[0]) {					
				case 'varchar' :
				case 'char' :
				case 'tinytext' :
					if (count($params)>=2 && $params[1]=="email") $required.= " validate-email";
					$formfield = '<input class="inputbox '.$required.'" type="'.((count($params)>=2 && $params[1]=="password") ? "password" : "text").'" name="'.$fieldname.'" id="'.$fid.'" value="'.htmlspecialchars($value, ENT_COMPAT, 'UTF-8').'" maxlength="'.$typevals[0].'" size="50" />';
				break;
				case 'int' :
				case 'smallint' :
				case 'mediumint' :
				case 'bigint' :
					$formfield =  '<input class="inputbox '.$required.'" type="text" name="'.$fieldname.'"  id="'.$fid.'" value="'.(preg_replace("/[^0-9]/","",$value)).'" maxlength="40" size="20" style="width: 200px" />';
				break;
				case 'decimal' :
				case 'float' :
				case 'double' :
				case 'real' :
					$formfield =  '<input class="inputbox '.$required.'" type="text" name="'.$fieldname.'"  id="'.$fid.'" value="'.(preg_replace("/[^0-9.]/","",$value)).'" maxlength="40" size="20" style="width: 200px" />';
				break;
				case 'tinyint' :
					if (!empty($joobase->fstate) && $joobase->fstate==$fieldname) {
						$formfield =  '<select class="inputbox"  style="width: auto;" name="'.$fieldname.'"  id="'.$fid.'"><option value="0">'.JText::_('JNo').'</option><option value="1" ';
						if (!empty($value)) $formfield .= 'selected="selected"'; 
						$formfield .= '>'.JText::_('JYes').'</option></select>';
					} else 
						$formfield = '<input class="inputbox '.$required.'" type="text" name="'.$fieldname.'"  id="'.$fid.'" value="'.(int) $value.'" maxlength="4" size="4" style="width: 50px" />';
				break;
				case 'datetime' :
				case 'timestamp' :
					$formfield =  JHtml::_('calendar', preg_replace("/[^0-9\: \-]/","",$value) , $fieldname, $fid, '%Y-%m-%d %H:%M:%S', array('class'=>'inputbox '.$required, 'size'=>'25', 'style'=>'width: 150px;',  'maxlength'=>'19'));
					break;
				case 'date' :
					$formfield = JHtml::_('calendar', preg_replace("/[^0-9\: \-]/","",$value) , $fieldname, $fid,'%Y-%m-%d', array('class'=>'inputbox '.$required, 'size'=>'10', 'style'=>'width: 100px;', 'maxlength'=>'10'));
				break;
				case 'year' :
					$formfield =  '<input class="inputbox '.$required.'" name="'.$fieldname.'" id="'.$fid.'"  value="'.(int) $value.'" maxlength="4" size="4" />';
				break;
				case 'text' :
				case 'mediumtext' :
				case 'longtext' :
//                    $editor =& JFactory::getEditor();
//                    $formfield = $editor->display($fieldname, stripslashes($value), '450', '250', '40', '5',false);
					$formfield = '<textarea class="inputbox '.$required.'" cols="60" rows="5"  name="'.$fieldname.'" id="'.$fid.'">'.stripslashes($value).'</textarea>';
				break;
				// special handling for enum and set
				case 'enum' :
					$formfield = '<select class="inputbox '.$required.'" type="text"  name="'.$fieldname.'" id="'.$fid.'" >';
					$formfield .= '<option value="" >...</option>';
					foreach ($typevals as $n => $val) {
						$formfield .= '<option value="'.$val.'" '.(($val==$value) ? 'selected' : '' ).'>'.$val.'</option>';
					}
					$formfield .= '</select>';
				break;
				case 'set' :
					if (!is_array($value)) $value = preg_split("/,/",$value);
					$required = (count($typevals)==1) ? "required" :"";
					if (count($typevals)<=5) {
						foreach ($typevals as $n => $val) {					
							$formfield .=  '<label for="'.$fid.$n.'"><input type="checkbox" class="'.$required.'"  name="'.$fieldname.'[]" id="'.$fid.$n.'" value="'.$val.'" '.((array_search($val,$value)!==false) ? 'checked' : '' ).' >&nbsp;'.$val.'</label></input> ';
						}
					} else {
						$formfield = '<select class="inputbox multiselect" type="text"  name="'.$fieldname.'[]" id="'.$fid.'" multiple>';
						$optgroup = "";
						foreach ($typevals as $n => $val) {
							$p = preg_split("/\./", $val,2);
							if (count($p)>1) {
								if ($optgroup!=$p[0]) {
									$optgroup = $p[0];
									if (!empty($optgroup)) $formfield .= '</optgroup>';
									$formfield .= '<optgroup label="'.$optgroup.'">';
								}
								$formfield .= '<option value="'.$val.'" '.((array_search($val,$value)!==false) ? 'selected' : '' ).' >'.$p[1].'</option>';
							} else {
								$formfield .= '<option value="'.$val.'" '.((array_search($val,$value)!==false) ? 'selected' : '' ).' >'.$val.'</option>';
							}	
						}
						if (!empty($optgroup)) $formfield .= '</optgroup>';
						$formfield .= '</select>';
					}	
				break;
				case 'tinyblob' :
				case 'mediumblob' :
				case 'blob' :
				case 'longblob' :
					$formfield .= '<input class="inputbox '.$required.'" type="file" name="'.$fieldname.'" id="'.$fid.'" size="10" />';
				break;				
				default:
					$formfield = '<input class="inputbox '.$required.'" type="text" name="'.$fieldname.'" id="'.$fid.'" value="'.htmlspecialchars($value, ENT_COMPAT, 'UTF-8').'" maxlength="254" size="50" />';
				}
				return $formfield;
				break;
			}
		}
		return $joobase->fields[$fieldname];
	}
		

	/**
 	* Split a template into parts return a array of of objects
 	*
 	* @access public
 	* @param String with template text
 	*/
	static function splitTemplate($template) {
		$psplit = preg_split('/\{joodb /U', $template);
		$parts=array();
		// insert text only for the first part
		if (substr($template,0,6)!="{joodb") {
			$e = new joodbPart();
			$e->text = array_shift($psplit);
			$parts[] =$e;
		}
		foreach ($psplit as $part) {
			$part = $part;
			$e = new joodbPart();
			$p=strpos($part,"}");
			if ($p===false) {
				$e->text=$part;
			} else {
				$e->text=substr($part,$p+1);
				$e->parameter = preg_split("/\|/",trim(substr($part,0,$p)));
				$e->function = array_shift($e->parameter);
			}
			$parts[] =$e;
		}
		return $parts;
	}
	
	/**
	 * Calculates the outputsituation from condition arguments
	 * 
 	 * @access public
	 * @param misc $item
	 * @param misc $part
	 * @param bool $state
	 */	
	static function getOutputState(&$item, &$part,&$state,&$level) {
		if ($part->function=="ifis") { // check if field condition is true
			$level++;
			if (isset($part->parameter[1]) && $state) {
				$cond = (isset($part->parameter[2])) ? strtolower($part->parameter[2]) : "eq";
				switch ($cond) {
					case "lt":
						$state = ($item->{$part->parameter[0]}<=$part->parameter[1]) ? true : false;
					break;	
					case "le":
						$state = ($item->{$part->parameter[0]}<$part->parameter[1]) ? true : false;
					break;	
					case "gt":
						$state = ($item->{$part->parameter[0]}>$part->parameter[1]) ? true : false;
					break;	
					case "ge":
						$state = ($item->{$part->parameter[0]}>=$part->parameter[1]) ? true : false;
					break;	
					case "ne":
						$state = ($item->{$part->parameter[0]}!=$part->parameter[1]) ? true : false;
					break;	
					default:
						$state = ($item->{$part->parameter[0]}==$part->parameter[1]) ? true : false;
					break;	
				}
			} else {
				if ($state) $state = (!empty($item->{$part->parameter[0]})) ? true : false;
			}
		} else if ($part->function=="ifnot") { // check if field condition is false
			$level++;
			if (isset($part->parameter[1])) {
				$state = ($item->{$part->parameter[0]}!=$part->parameter[1]) ? true : false;
			} else {
				$state = (empty($item->{$part->parameter[0]})) ? true : false;
			}
		} else if ($part->function=="else") {	if($level==1) $state = !$state; 
		} else if ($part->function=="endif") {	if($level==1) $state = true; $level--; }		
	}	


	/**
 	* Returns popup link for printview as Icon or Text
 	*
 	* @access public
 	* @param Item, Params
 	*/
	static function getPrintPopup(&$item, &$joobase, $attribs = array())
	{
		$app = JFactory::getApplication();
		$params	= $app->getParams();

		$url  = 'index.php?option=com_joodb&view=article&joobase='.$joobase->id.'&id='.$item->{$joobase->fid}.'&layout=print&tmpl=component&print=1';

		$status = 'status=no,toolbar=no,scrollbars=yes,titlebar=no,menubar=no,resizable=yes,width=720,height=560,directories=no,location=no';

		// checks template image directory for image, if non found default are loaded
		if ( $params->get( 'show_icons', '1' ) ) {
			$text = JHtml::image('components/com_joodb/assets/images/print.png', JText::_( 'Print' ) );
		} else {
			$text = JText::_( 'ICON_SEP' ) .'&nbsp;'. JText::_( 'Print' ) .'&nbsp;'. JText::_( 'ICON_SEP' );
		}

		$attribs['title']	= JText::_( 'Print' );
		$attribs['onclick'] = "window.open(this.href,'win2','".$status."'); return false;";
		$attribs['rel']     = 'nofollow';

		return JHtml::link(JRoute::_($url), $text, $attribs);
	}



    /**
     * Returns an icon or text link to edit item in frontend
     *
     * @access public
     * @param object Item
     * @param object joobase
     * @return string
     */
    static function getEditButton(&$item, &$joobase,&$part)
    {
        if (JRequest::getCmd('tmpl')!='component') {
            $app = JFactory::getApplication();
            $params	= $app->getParams();

            $view = ((isset($part->parameter[0])) && (self::parameterToBoolean($part->parameter[0]))) ? "form" : "edit";
            $url  = JRoute::_("index.php?option=com_joodb&view=".$view."&joobase=".$joobase->id."&id=".$item->{$joobase->fid});

            $jparams = new JRegistry($joobase->params);
            $user = JFactory::getUser();
            $levels	= $user->getAuthorisedViewLevels();
            $levels = array_flip($levels);
            $show=false;
            if ($view=="form" && $fuser=$joobase->getSubdata('fuser')) {
                if (array_key_exists($jparams->get("accessf","2"),$levels)) {
                   // only assinged users have access to the form
                   if ($item->{$fuser}==$user->id) $show = true;
                }
            } else if ($jparams->get("accesse","1")==1) {
                if (array_key_exists(3, $levels)) $show = true;
            }

            if (!$show) return;

            // checks template image directory for image, if non found default are loaded
            if ( $params->get( 'show_icons', '1' ) ) {
                $icon = "edit.png";
                $text = JHtml::image('components/com_joodb/assets/images/'.$icon,JText::_("EDIT_DATABASE_ENTRY"));
            } else {
                $text = JText::_( 'ICON_SEP' ) .'&nbsp;'. JText::_("EDIT_DATABASE_ENTRY") .'&nbsp;'. JText::_( 'ICON_SEP' );
            }
            $attribs= array('title'=> JText::_("EDIT_DATABASE_ENTRY"));
            return JHtml::link(JRoute::_($url), $text,$attribs);
        }
    }


	/**
 	* Returns a back to prev page link
 	*
 	* @access public
 	*/
	static function getBackbutton() {
		if ( JFactory::getApplication()->getParams()->get( 'show_icons', '1' ) ) {
			$text = JHtml::image('components/com_joodb/assets/images/back.png', JText::_('BACK') );
		} else {
			$text = JText::_('BACK');
		}
		return JHtml::link('javascript:history.back();', $text,array('title'=>  JText::_('BACK'),'class'=>'backbutton'));
	}

	/**
	 * Returns a back to prev page link
	 *
	 * @access public
	 * @param string link
	 */
	static function getReadmore($url) {
		if ( JFactory::getApplication()->getParams()->get( 'show_icons', '1' ) ) {
			$text = JHtml::image('components/com_joodb/assets/images/next.png',JText::_('READ MORE...'));
		} else {
			$text = JText::_('READ MORE...');
		}
		return  JHtml::link($url , $text,array('title'=>  JText::_('READ MORE...'),'class'=>'readonbutton'));
	}


	/**
	 * Returns a next or previous Item link
	 *
	 * @access public
	 * @param string next or prev
	 */
	static function getNavigationButton($side="next",&$joobase) {
		require_once JPATH_BASE.'/components/com_joodb/models/catalog.php';
		$model = new JoodbModelCatalog();
		if (!$item=$model->getSideElementUrl($side)) return;
		$url = JRoute::_('index.php?option=com_joodb&view=article&joobase='.$joobase->id.'&id='.$item->{$joobase->fid}.':'.JFilterOutput::stringURLSafe($item->{$joobase->ftitle})."&position=".$item->jb_pos."&total=".$item->jb_total,false);
		if ($side=="next") {
			$btext = JText::_('Next entry');
			$image = "next.png";
		} else {
			$btext = JText::_('Previous Entry');
			$image = "back.png";
		}		
		if ( JFactory::getApplication()->getParams()->get( 'show_icons', '1' ) ) {
			$text = JHtml::image('components/com_joodb/assets/images/'.$image, $btext );
		} else {
			$text = $btext;
		}
		return JHtml::link($url,$text,array('title'=>  $btext,'class'=>$side.'button'));
	}
		
	
	/**
 	* Returns Search box for catalog view
 	*
 	* @access public
 	* @param  current Searchstring, Joobase
 	*/
	static function getSearchbox($search="",&$joobase,$parameter)
	{
		$stext = JText::_('search...');
		$sval = ($search!="") ? $search : $stext;
		$searchform =  '<div class="searchbox"><input class="inputbox searchword" type="text"' 
				.' onfocus="if(this.value==\''.$stext.'\') this.value=\'\';" onblur="if(this.value==\'\') this.value=\''.$stext.'\';" '
				.' value="'.stripslashes($sval).'" size="20" alt="'.$stext.'" maxlength="40" name="search" />';
		if (!empty($parameter[0])) {
			$fields = @preg_split("/,/",$parameter[0]);
			$searchform .= "&nbsp;<select class='inputbox' name='searchfield'><option value=''>".JText::_('All fields')."</option>" ;
			$rf = JRequest::getVar("searchfield");
			foreach ($fields as $field) {
				$field=trim($field);
				$searchform .= "<option value='".$field."' " ;
				if ($rf==$field) $searchform .= "selected";
				$searchform .= ">".ucfirst(str_replace(array("-","_")," ",$field))."</option>" ;
			}
			$searchform .= "</select>" ;
		}
		$searchform .=  "&nbsp;<input class='button btn search' type='submit' value='".$stext."' />"
					   ."&nbsp;<input class='button btn reset' type='submit' value='".JText::_('Reset...')."' onmousedown='submitSearch(\"reset\");void(0);' /></div>";
		return $searchform;
	}

	/**
 	* Returns a select-box of possible row to search for
 	* @access public
 	* @param  current Joobase, parameters, values
 	*/
	static function getGroupselect(&$joobase,$parameter,$values)
	{
		$app = JFactory::getApplication();
		$gs =  $app->getUserStateFromRequest("com_joodb".$joobase->id.'.gs', 'gs',array(), 'array');
		$sv = (isset($gs[$parameter[0]])) ? $gs[$parameter[0]] : array();
		$size = (isset($parameter[1]) && $parameter[1]>1) ? 'size="'.$parameter[1].'" multiple ' : "";
		$searchform = '<select class="inputbox groupselect" id="gs_'.$parameter[0].'" name="gs['.$parameter[0].'][]" '.$size.' >' ;
		$searchform .= '<option value="">...</option>';
		if ($values)
		   foreach ($values as $value) {
			$selected = (array_search($value->delimeter.$value->value.$value->delimeter, $sv)!==false) ? 'selected="selected"' : '';
			if (!empty($value->value))
				$searchform .= '<option value="'.$value->delimeter.$value->value.$value->delimeter.'" '.$selected.'>'.$value->value.' ('.$value->count.')</option>';
		}
		$searchform .= "</select>";
		return $searchform;
	}


	/**
 	* Returns a roman alphabet to select the first letters ot the title
 	*
 	* @access public
 	* @param current Alphachar
 	*/
	static function getAlphabox($alphachar, &$joobase)
	{
		$alphabox = "<div class='pagination alphabox'><ul>";
		$alphabet= array ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
		foreach ($alphabet as $achar) {
			if ($achar==$alphachar) {
				$alphabox .= "<li class='active'><span>".ucfirst($achar)."</span></li>";
			} else {
				$alphabox .= "<li><a href='".self::_findItem($joobase,"&letter=".$achar)."'>".ucfirst($achar)."</a></li>";
			}
		}
		$alphabox .=  "<li><a href='".self::_findItem($joobase)."'>&raquo;".JText::_('All')."</a></li></ul></div>";
		return $alphabox;
	}

	/**
 	* Get complete link or only url to sort
 	*
 	* @access public
 	* @params fieldname fpr sort, [linktext]
 	*/
	static function getOrderlink(&$parameter,&$joobase)
	{
		$app = JFactory::getApplication();
		$params	= $app->getParams();
		$ordering = "ASC"; $orderclass = "";
		if ($app->getUserStateFromRequest('com_joodb.orderby', 'orderby', $params->get('orderby','fid'), 'string')==$parameter[0]) {
			$ordering = (strtolower(JRequest::getCMD('ordering')) == "asc") ? "DESC" : "ASC";
			$orderclass = strtolower(JRequest::getCMD('ordering'));
		}
		$url = self::_findItem($joobase,'&orderby='.$parameter[0].'&ordering='.$ordering);
		if (count($parameter)>1) {
			$url = '<a href="'.$url.'" class="order '.$orderclass.'">'.$parameter[1]."</a>";
		}
		return $url;
	}


	/**
 	* Returns a captcha box
 	*
 	* @access public
 	*
 	*/
	static function getCaptcha(){
		$captcha ="<div class='joocaptcha' style='margin: 5px 0;' >"
				."<img src='".Juri::root(false)."index.php?option=com_joodb&task=captcha' alt='captcha' style='width:200px; height:50px; margin: 5px 0; border: 1px solid black;'  />"
				."<br><input class='inputbox required' name='joocaptcha' id='joocaptcha' style='width:190px;' size='1' maxlength='5' /></div>";
		return $captcha;
	}

	/**
 	* Output of a captcha image
 	*
 	* @access public
 	*
 	*/
	static function printCaptcha(){

		header("Content-Type: image/png");

	    // Generate code for Captcha
    	$code = "";
    	$codelength = 5;
    	$pool = "qwertzupasdfghkyxcvbnm23456789";
    	srand ((double)microtime()*1000000);
    	for($n = 0; $n < $codelength; $n++) {
            	$code .= substr($pool,(rand()%(strlen ($pool))), 1);
     	}

		$includepath=JPATH_ROOT."/components/com_joodb/assets/images/";
    	$fontsize=20;
	    // Get the size
    	$bbox = imagettfbbox($fontsize, 0, $includepath."captcha.ttf", $code);

	    // calculate size of the image
    	$x= $bbox[2]+(2*$bbox[3]);
    	$y= (-$bbox[7])+(2*$bbox[3]);
    	$background = imagecreatefromjpeg($includepath."captcha.jpg");

	    //prepare the image
    	$im  =  ImageCreateTrueColor ( 200,  50 );
    	$fill = ImageColorAllocate ( $im ,  0,  0, 0 );
    	$color = ImageColorAllocate ( $im , 235  , 235, 235 );

	    imagecopy($im,$background,0,0,rand(0,600),rand(0,500),200,50);
	    $startx = rand(5,110); $starty = rand(25,40);

	    // rotate and shift each char randomly
    	for($i=0; $i<$codelength; $i++) {
    		$ch = $code{$i};
    		ImageTTFText ($im, $fontsize, rand(-10,10) , $startx + (15*$i) , $starty , $color, $includepath."captcha.ttf", $ch);
    	}

	    ImagePNG ( $im );
    	ImageDestroy ($im);

    	// store the code to the session
    	$session =& JFactory::getSession();
	  	$session->set('joocaptcha',$code);

	}

	/**
	 * Output text... trigger content event before ...
	 * @param object $text
	 * @param array $params
	 * @param sting view name of the view
	 */
	static function printOutput(& $page, & $params,$view="article") {
	    $dispatcher = JDispatcher::getInstance();
     	JPluginHelper::importPlugin('content');
   		$dispatcher->trigger('onContentPrepare', array ('com_joodb.'.$view, &$page, &$params,0));
   		$dispatcher->trigger('onContentBeforeDisplay', array ('com_joodb.'.$view, &$page, &$params,0));
     	echo $page->text;
   		$dispatcher->trigger('onContentBeforeDisplay', array ('com_joodb.'.$view, &$page, &$params,0));
	}

	/**
	 * Add new DS to joodb table
	 * @param misc $jb joddb object
	 * @param misc $item jobject
	 */
	static function saveData(&$jb,&$item) {		
		$table = $jb->table;
		$fid = $jb->fid;
		$db	= $jb->getTableDBO();
		// load the jooDb object with table fiel infos		
		$fields = $db->getTableColumns($table,false);
		foreach ($fields as $fname=>$fcell) {
            $fne = str_replace(" ","_",$fname);
			if (isset($_POST[$fne]) || isset($_FILES[$fne])) {
				$typearr = preg_split("/\(/",$fcell->Type);
				switch ($typearr[0]) {
					case 'text' :
					case 'tinytext' :
					case 'mediumtext' :
					case 'longtext' :
					$item->{$fname}= JRequest::getVar($fne, '', 'post', 'string', JREQUEST_ALLOWHTML);
					if (empty($item->{$fname}) && $fcell->Null=="YES") $item->{$fname}= NULL;
				break;
					case 'int' :
					case 'tinyint' :
					case 'smallint' :
					case 'mediumint' :
					case 'bigint' :
					case 'year' :
					$item->{$fname}= JRequest::getInt($fne);
				break;
					case 'date' :
					case 'datetime' :
					case 'timestamp' :
					$item->{$fname}= preg_replace("/[^0-9\: \-]/","",JRequest::getVar($fne, '', 'post', 'string'));
					if (empty($item->{$fname}) && $fcell->Null=="YES") $item->{$fname}= NULL;
				break;
					case 'set' :
					$values = JRequest::getVar($fne, '');
					$item->{$fname}= join(",",$values);
				break;
					case "tinyblob" :
					case "mediumblob" :
					case "blob" :
					case "longblob" :
						$newf = JRequest::getVar($fne, null, 'files', 'array');
						if(!empty($newf) && $newf['size'] > 0) {
							$fp = fopen($newf['tmp_name'], 'r');
							$item->{$fname} = fread($fp, filesize($newf['tmp_name']));
						}
				break;				
					default:
					$item->{$fname}= JRequest::getVar($fne, '', 'post','string');
					if (empty($item->{$fname}) && $fcell->Null=="YES") $item->{$fname}= NULL;
				}
			} else {
				if ($fcell->Null=="YES") $item->{$fname}= NULL;
			}
		}

		// Update or insert object if ID exists
		if (!empty($item->{$fid})) {
			$db->updateObject($table,$item,$fid,true);
		} else {
			if ($fuser=$jb->getSubdata('fuser')) $item->{$fuser} = JFactory::getUser()->id;
			$db->insertObject($table,$item,$fid);
		}
		$error =  $db->getErrorMsg();	
		if(!empty($error)){
			$msg = JText::_( 'Error' )." : ".$db->getErrorMsg();
		} else {
			$msg = JText::_( 'Item Saved' );
		}
		return $msg;
	}

	/**
 	* Try to find menuitem for the database
 	*
 	* @access private
 	* @param id of the referring database
 	*/
	static function _findItem(&$joobase,$params="")
	{
			return JRoute::_("index.php?option=com_joodb&view=catalog&joobase=".$joobase->id.$params,false);

	}

	/**
	 * Check the Authorization ...
	 * @param string $section
	 * @todo Joomla ACL compatibilty
	 *
	 */
	static function checkAuthorization(&$joobase, $section="accessd") {
		// get database parameters
		$jparams = new JRegistry($joobase->params);
        $user = JFactory::getUser();
        $levels	= $user->getAuthorisedViewLevels();
        $level_need = $jparams->get($section, 1);
        if (empty($level_need)) $level_need = 1;
        $has_access = false;
        $levels = array_flip($levels);
        if (array_key_exists($level_need, $levels)) $has_access = true;

		if (!$has_access) {
				$uri = JUri::getInstance();
                $return	= $uri->toString();
				$url  = JRoute::_('index.php?option=com_users&return=');
				$url .= base64_encode($return);
				$app = JFactory::getApplication();
				$app->redirect($url, JText::_('Please login') );
		}
        return true;
	}
	
	/**
 	* Shorten a text
 	*
 	* @access public
 	* @param String with text
 	* @param Integer with maximum length
 	* @return Truncated text
 	* 
 	*/
	static function wrapText($text,$maxlen=120) {
		$text = strip_tags($text);
		if (strlen($text)>$maxlen) {
			$len = strpos($text," ",$maxlen);
			if ($len) $text = substr($text,0,$len).' &hellip;';
		}
		return $text;
	}

	/**
	 * Returns the condition of a boolean string parameter
	 * @param string $value
	 * @return boolean
	 */
	static function parameterToBoolean($value) {
		if (empty($value)) return false;
		$def = array('true','on','1','yes');
		$value = trim(strtolower((string)$value));
		return (array_search($value,$def)===false) ? false : true;
	}
	
}

// a pure object class to keep parts
class joodbPart {
	//the joodb function
	var $function = false;
	//an array of parameters
	var $parameter = array();
	// the text to the next comand
	var $text = "";
}

?>
