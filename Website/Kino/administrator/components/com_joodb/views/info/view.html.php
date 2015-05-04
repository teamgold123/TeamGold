<?php
/**
* @package		JooDatabase - http://joodb.feenders.de
* @copyright	Copyright (C) Computer - Daten - Netze : Feenders. All rights reserved.
* @license		GNU/GPL, see LICENSE.php
* @author		Dirk Hoeschen (hoeschen@feenders.de)
*/

// no direct access
defined('_JEXEC') or die();

jimport( 'joomla.application.component.view' );

class JoodbViewInfo extends JViewLegacy {
	function display($tpl = null) {
		JToolBarHelper::title(   JText::_( "JooDatabase" ).': <small><small>['.JText::_( 'Information' ).']</small></small>','joodb.png' );
		$bar =  JToolBar::getInstance('toolbar');
        $bar->appendButton('Help', 'http://joodb.feenders.de/support.html', false, 'http://joodb.feenders.de/support.html', null);
        JoodbAdminHelper::addSubmenu('info');

		$db	= JFactory::getDBO();
		$db->setQuery("SELECT value FROM `#__joodb_settings` WHERE `name` = 'version' AND `jb_id` IS NULL",0,1);
		$this->version = $db->loadResult();		
		
?>
<div class="container-fluid">
<div class="width-60 fltlft span7">
	<fieldset class="adminform">
		<legend><?php echo JText::_( 'Help' );?></legend>
		<table class="adminlist">
			<tr>
				<td>
					<h3>What is JooDatabase for?</h3>
					<p>JooDatabase is simple and fast way to include and display external tables (collections, databases) into Joomla.
					It automatically generates pages containing the table data using editable templates for catalog and single entry views.</p>
					<p>Special elements like print-icons and pagination-links are displayed at the desired position in the templates.
					JooDatabase handles the linking, routing between the pages automatically. The search plug-in provides search in your
					databases using the Joomla sitesearch component.</p>
					<p style="text-align:center; color: #d40000; font-weight: bold;">With JooDatabase you can include your data collections to Joomla within minutes!</p>
					<h3>Installation</h3>
					<ol>
						<li><b>Install Component</b> - Extensions &raquo; Install/Uninstall</li>
						<li><b>Download</b> and <b>Install searchplugin</b> - Extensions &raquo; Install/Uninstall</li>
						<li><b>Enable Searchplugin</b> - Extensions &raquo; Plug-ins</li>
					</ol>
					<h3>Usage</h3>
					<blockquote>
					<h4>Two possible situations</h4>
					<ol>
						<li>The table(s) are already in your joomla database or you use tools like phpmyadmin or myodbc to import the data &raquo; continue.</li>
						<li>Use the "import"-function if you have an .xml or xls spreadsheet, to create a new table.</li>
					</ol>
					<h4>Set up your first Database</h4>
					<ol>
						<li><b>Open Joodb</b> - Select Components&raquo;JooDatabase in the admin menu to open database configuration.</li>
						<li><b>Create new DB</b> - Click on "new"-button at the toolbar to open Wizzard-Popup.
						<ol>
						  <li><b>Step 1</b> - Enter a name and choose your main database-table.</li>
						  <li><b>Step 2</b> - Select some important fields like the "Title","Unique-ID" and "Main content text".
						  <br/><span style="color: #d40000;">Every Database must have these fields defined</span></li>
						  <li><b>Step 3</b> - There is no step 3. Close the popup.</li>
						</ol>
						</li>
						<li><b>Add Menuentry</b> - Add a JooDB-Catalog-view to your menus.</li>
						<li><b>Thats it</b> - You are ready! Test your database in frontend.</li>
					</ol>
					<h4>Customize Templates</h4>
					<p>Edit the predefined templates by clicking on the database title. Like template-engines (for example Smarty) JooDatabase uses wildcards to
					replace informations in templates. That makes the output highly customizable. JooDatabsae uses only some simple wildcards.</p>
					<ul>
						<li><b>Data wildcards</b> - {joodb field|FILEDNAME} is replaced by the field content. You can limit the output to a maximum char length by adding |XXX to the fieldname. (For example {joodb longtext|120})</li>
						<li><b>Control wildcards</b> - Control wildcards are replaced by page-control elements. Most of them are only valid in a certain context.
						<ul>
							<li><b>{joodb pagenav}</b> - Pagination links in catalog-view</li>
							<li><b>{joodb pagecount}</b> - Pagination page informations in catalog-view</li>
							<li><b>{joodb resultcount}</b> - Total ammount of datasets in in catalog-view</li>
							<li><b>{joodb nodata}</b> - Error-message if no data was found in catalog-view</li>
							<li><b>{joodb limitbox}</b> - Form for changing the amount of entries per page in catalog-view</li>
							<li><b>{joodb searchbox}</b> -Search field for internal search at the database in catalog-view</li>
							<li><b>{joodb alphabox}</b> - [A-Z] Link-form for selecting the entries by letters in catalog-view</li>
							<li><b>{joodb ifis|FIELDNAME|[value]|[condition]}</b> -Show the following output till <b>{joodb endif}</b> or <b>{joodb else}</b> if the condition matches.</li>
							<li><b>{joodb alphabox}</b> - [A-Z] Link-form for selecting the entries by letters in catalog-view</li>
							<li><b>{joodb readon}</b> - A &raquo;Read more...&laquo; link to the current entry</li>
							<li><b>{joodb backbutton}</b> - A link back to previous page</li>
							<li><b>{joodb printbutton}</b> - Print page button/link in single-entry view</li>
							<li><b>{joodb notepadbutton}</b> - Prints add or remove to notepad button/link</li>
							<li><b>{joodb form|FIELDNAME}</b> - Inserts a formfield to the form-view.
								The formelement-types are dependent on the datafield-type.
								Form validation is done automatically. If a datafield can not be Null it is required.
								<ul>
									<li>Varchar is displayed as a input-element</li>
									<li>Text is displayed as a textbox. Possible Parameters are "password" and "email". (For example {joodb form|usermail|email}) </li>
									<li>Enum and set fields are displayed as a select-element</li>
									<li>Enum and set fields with less then 3 elements are displayed as radio-element (enum) or checkbox (set)</li>
								</ul>
							</li>
							<li><b>{joodb captcha}</b> - Captcha box in form-view</li>
							<li><b>{joodb imageupload}</b> - File select box to upload image with the data in form-view</li>
							<li><b>{joodb submitbutton}</b> - Submit button in form-view</li>
							<li><b>{joodb image}</b> - A complete image-tag with the image image related to the entry</li>
							<li><b>{joodb thumb}</b> - A complete image-tag with the thumbnail and a modal link to the gig image. <i>Example &lt;img src="{joodb path2thumb}" width="100" alt="*" /&gt;</i></li>
							<li><b>{joodb path2image}</b> - Filename and path to the image related to the entry in /images/joodb. (empty image if none)</li>
							<li><b>{joodb path2thumb}</b> - Filename and path to the thumbnail image related to the entry. <i>Example &lt;img src="{joodb path2thumb}" width="100" alt="*" /&gt;</i></li>
							<li><b>{joodb subtemplate|TEMPLATENAME}</b> - Will be replaced by the suptemplate with the given templatename.</li>
						</ul>
						</li>
						<li><b>Loop wildcards</b> - The catalog-view expects two <b>{joodb loop}</b> declarations in the template. The part between these wildcards defines item-row.</li>
					</ul>
					</blockquote>
					<h3>Limitations</h3>
					<ul>
						<li>JooDatabase is only for simple Data-Collections and demands. Future versions will be able to handle multiple, linked tables.</li>
						<li>JooDatabase is for advanced users with basic knowledges about Joomla, MYSQL and Template-engines.</li>
					</ul>
				</td>
			</tr>
		</table>
	</fieldset>
</div>
<div class="width-40 fltlft span5">
	<fieldset class="adminform">
		<legend><?php echo JText::_( 'About' );?></legend>
		<table class="adminlist">
			<tr>
				<td>
					<a href="http://www.feenders.de" target="_blank" title="www.feenders.de"><img alt="Feenders.de" src="<?php echo 'components/com_joodb/assets/images/feenders-logo.jpg'; ?>" style="width:230px; margin: 10px 10px 10px 20px; float: right; border: 1px solid black; "/></a>
					<h2>JooDatabase was made by</h2>
					<h3>Computer &sdot; Daten &sdot; Netze &bull; feenders</h3>
					<ul>
						<li>Autor: Dirk Hoeschen (<a href="mailto:hoeschen@feenders.de">hoeschen@feenders.de</a>)</li>
						<li>Project Support: Joest Feenders (<a href="mailto:post@feenders.de">post@feenders.de</a>)</li>
					</ul>
					<p>Feenders does not offer free support for this version. However: If you need professional support or want individual modifications, ask for conditions.</p>
					<p>For more informations (user forum,help,FAQs and examples), look at <a href="http://joodb.feenders.de" target="_blank" title="joodb.feenders.de">joodb.feenders.de</a>.<br/>German support can be found at <a href="http://joodb.feenders.de/help/hilfe-ger.html" target="_blank" title="Deutsche Hilfeseite">joodb.feenders.de/help/hilfe-ger.html</a></p>
					<p>JooDatabase is released under GPL v3 - See &raquo;<a href="#license">License</a>&laquo;.</p>
					<hr/>
					<p align="right"><i>Version <?php echo $this->version; ?> FREE</i></p>
				</td>
			</tr>
		</table>
	</fieldset>
	<fieldset class="adminform">
		<legend><?php echo JText::_( 'Changelist' );?></legend>
		<table class="adminlist">
			<tr>
				<td>
					<h4>Changes in 2.0</h4>
					<ul>
						<li>Linked tables with subforms</li>
						<li>Import of excel spreadsheets</li>
						<li>Automatic update via update channel</li>
						<li>Basic notepad functions</li>
						<li>Groupable select boxes for parametic searches</li>
					</ul>
				</td>
			</tr>
		</table>
	</fieldset>
	<fieldset class="adminform">
		<legend><?php echo JText::_( 'Todo' );?></legend>
		<table class="adminlist">
			<tr>
				<td>
					<ul>
						<li>Edit existing data in frontend</li>
						<li>Flexible XML-Support</li>
					</ul>
				</td>
			</tr>
		</table>
	</fieldset>
	<fieldset class="adminform">
		<legend><a name="license">&nbsp;</a><?php echo JText::_( 'License' );?></legend>
		<table class="adminlist">
			<tr>
				<td>
				<p>Copyright <?php echo date('Y'); ?> &copy; Computer &sdot; Daten &sdot; Netze &bull; Feenders. All rights reserved.</p>
				<p>JooDatabase is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or (at your option) any later version.</p><p>
    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.</p><p>
    You should have received a copy of the GNU General Public License along with this program.<br/>If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
					</p>
				</td>
			</tr>
		</table>
	</fieldset>
</div>
</div>
    <?php
	}
}
