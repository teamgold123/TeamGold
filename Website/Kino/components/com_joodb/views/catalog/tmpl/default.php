<?php // no direct acces
defined('_JEXEC') or die('Restricted access');

?>
<div class="database-list<?php echo $this->params->get('pageclass_sfx')?>">
<?php if ($this->params->get('show_page_heading') || $this->params->get( 'show_description')) : ?>
<div class="page-header">
<?php if ($this->params->get('show_page_heading')) : ?>
	<h1>
	<?php echo $this->escape($this->params->get('page_heading')); ?>
	</h1>
<?php endif; ?>
<?php if ( $this->params->get( 'show_description') && $this->pagination->limitstart==0 ) : ?>
    <p>
	<?php if ($this->params->get('image')!="-1") : ?>
		<img src="<?php echo $this->baseurl . '/images/'. $this->params->get('image');?>" align="<?php echo $this->params->get('image_align');?>" hspace="6" alt="<?php echo $this->params->get('image');?>" />
	<?php endif; ?>
	<?php echo nl2br($this->params->get('description')); ?>
    </p>
    <div style="clear: both"></div>
<?php endif; ?>
</div>
<?php endif; ?>
<form name="searchForm" id="searchForm"  method="get" class="form-inline" action="<?php echo JURI::current(); ?>"  >
<input type="hidden" name="option" value="com_joodb"/>
<input type="hidden" name="view" value="catalog"/>
<input type="hidden" name="format" value="html"/>
<input type="hidden" name="reset" value="false"/>
<input type="hidden" name="ordering" value="<?php echo JRequest::getVar("ordering"); ?>"/>
<input type="hidden" name="orderby" value="<?php echo JRequest::getVar("orderby"); ?>"/>
<input type="hidden" name="Itemid" value="<?php echo JRequest::getInt("Itemid"); ?>"/>
<input type="hidden" name="task" value=""/>
<?php
	// replace nodata wildcard if data is empty
	if (empty($this->items)) {
		$this->joobase->tpl_list = str_replace("{joodb nodata}" , '<div class="error nodata">'.JText::_('No data found')."</div>" ,$this->joobase->tpl_list);
	}

	$pageparts = preg_split("!{joodb loop}!", $this->joobase->tpl_list);	
	if (count($pageparts)<3)
		JError::raiseError(500, "Error in catalog template. Remember 2 loop declarations must be found inside catalog template!");

	// get header text
	 $parts = JoodbHelper::splitTemplate($pageparts[0]);
	 $page = new JObject();
	 $page->text = $this->_parseTemplate($parts);

	 // do the loop
	 if ($this->items) {
	  	// get the parts
	  	$parts = JoodbHelper::splitTemplate($pageparts[1]);
	 	foreach ( $this->items as $n=>$item ) {
			$item->loopclass = ($n%2==0) ? "odd" : "even";
			$page->text .= JoodbHelper::parseTemplate($this->joobase,$parts,$item,$this->params);
		}
	 }
	 
	 // get footer text
	 $parts = JoodbHelper::splitTemplate($pageparts[2]);
	 $page->text .= $this->_parseTemplate($parts);
 	 // render output text
	 JoodbHelper::printOutput($page,$this->params,"catalog");

?>
</form>
    <div style="clear: both;"></div>
</div>
<script type="text/javascript" >

	// Special function for multiple groupselect
	function resetSelect(element) {
		var found = false;
		// start with element and reset all selects below
		$$('#searchForm select.groupselect').each(
			function(el){
				if (el.get('name')=="gs["+element+"][]") found = true;
				if (found)  Array.each(el.options, function(item){item.selected=false;});				
			});
		return true;
	}


	// Submit search form
	function submitSearch(task) {
		form = document.searchForm;
		form.format.value="html";
		if (task=="reset") {
			if (form.search) form.search.value="";
			form.ordering.value="";
			form.orderby.value="";
			$$("#searchForm select.groupselect").each(function(el) {
				for (var i=0; i<el.options.length; i++) el.options[i].selected = false;
				el.selectedIndex = -1; el.value = null;
			});
			$$("#searchForm input.check").each(function(el){el.checked=false; });
			form.reset.value = true
		} else if (task=="xportxls") {
			form.format.value="xls";
		} else if (task=="uncheck") {
			$$("#searchForm input.check").each(function(el){el.checked=false; });
		} else if (task=="setlimit") {
		}
		if (form.search && form.search.value=="<?php echo JText::_('search...'); ?>")
			form.search.value="";
		form.submit();
	}

	// initialize some form elements
	window.addEvent('domready', function() {
		$$("#searchForm select.groupselect").each(function(el){
			if (el.multiple==true) {
				// todo: functional multiple select
				el.addEvent('click',function(e){
                    if (e.event.ctrlKey!=true) {
                        submitSearch('parametric');
                    }
                });
			} else {
				el.addEvent('change',function(){ submitSearch(); });
			}
		});
		if ($('limit')) {
			$('limit').onchange = function(){ submitSearch('setlimit'); };
		}
	});

</script>
