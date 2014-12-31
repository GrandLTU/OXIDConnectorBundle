
USE `ongr_oxid_test`;
#
# Table structure for table `oxacceptedterms`
# for storing information user accepted terms version
# created 2010-06-10
#

DROP TABLE IF EXISTS `oxacceptedterms`;

CREATE TABLE `oxacceptedterms` (
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'User id (oxuser)',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXTERMVERSION` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Terms version',
  `OXACCEPTEDTIME` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Time, when terms were accepted',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY (`OXUSERID`, `OXSHOPID`)
) ENGINE=MyISAM COMMENT='Shows which users has accepted shop terms';

#
# Table structure for table `oxaccessoire2article`
#

DROP TABLE IF EXISTS `oxaccessoire2article`;

CREATE TABLE `oxaccessoire2article` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Accessory Article id (oxarticles)',
  `OXARTICLENID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXSORT` int(5) NOT NULL default '0' COMMENT 'Sorting',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXOBJECTID` (`OXOBJECTID`),
  KEY `OXARTICLENID` (`OXARTICLENID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between article and its accessory articles';

#
# Table structure for table `oxactions`
#

DROP TABLE IF EXISTS `oxactions`;

CREATE TABLE `oxactions` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Action id',
  `OXSHOPID` int(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)',
  `OXTYPE` tinyint( 1 ) NOT NULL COMMENT 'Action type: 0 or 1 - action, 2 - promotion, 3 - banner',
  `OXTITLE` char(128) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXTITLE_1` char(128) NOT NULL default '' COMMENT '',
  `OXTITLE_2` char(128) NOT NULL default '' COMMENT '',
  `OXTITLE_3` char(128) NOT NULL default '' COMMENT '',
  `OXLONGDESC` text NOT NULL COMMENT 'Long description, used for promotion (multilanguage)',
  `OXLONGDESC_1` text NOT NULL,
  `OXLONGDESC_2` text NOT NULL,
  `OXLONGDESC_3` text NOT NULL,
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Active',
  `OXACTIVEFROM` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active from specified date',
  `OXACTIVETO` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active to specified date',
  `OXPIC`   VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'Picture filename, used for banner (multilanguage)',
  `OXPIC_1` VARCHAR(128) NOT NULL DEFAULT '',
  `OXPIC_2` VARCHAR(128) NOT NULL DEFAULT '',
  `OXPIC_3` VARCHAR(128) NOT NULL DEFAULT '',
  `OXLINK`   VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'Link, used on banner (multilanguage)',
  `OXLINK_1` VARCHAR(128) NOT NULL DEFAULT '',
  `OXLINK_2` VARCHAR(128) NOT NULL DEFAULT '',
  `OXLINK_3` VARCHAR(128) NOT NULL DEFAULT '',
  `OXSORT` int( 5 ) NOT NULL DEFAULT '0' COMMENT 'Sorting',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  index(`oxsort`),
  index(`OXTYPE`, `OXACTIVE`, `OXACTIVETO`, `OXACTIVEFROM`)
) ENGINE=MyISAM COMMENT 'Stores information about actions, promotions and banners';

#
# Data for table `oxactions`
#
INSERT INTO `oxactions` (`OXID`, `OXSHOPID`, `OXTYPE`, `OXTITLE`, `OXTITLE_1`, `OXTITLE_2`, `OXTITLE_3`, `OXLONGDESC`, `OXLONGDESC_1`, `OXLONGDESC_2`, `OXLONGDESC_3`, `OXACTIVE`, `OXACTIVEFROM`, `OXACTIVETO`, `OXPIC`, `OXPIC_1`, `OXPIC_2`, `OXPIC_3`, `OXLINK`, `OXLINK_1`, `OXLINK_2`, `OXLINK_3`, `OXSORT`) VALUES
('oxstart',      0, 0, 'Startseite unten', 'Start page bottom', '', '', '', '', '', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', 0),
('oxtopstart',   0, 0, 'Topangebot Startseite', 'Top offer start page', '', '', '', '', '', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', 0),
('oxbargain',    0, 0, 'Angebot der Woche', 'Week''s Special', '', '', '', '', '', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', 0),
('oxtop5',       0, 0, 'Topseller', 'Top seller', '', '', '', '', '', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', 0),
('oxcatoffer',   0, 0, 'Kategorien-Topangebot', 'Top offer in categories', '', '', '', '', '', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', 0),
('oxnewest',     0, 0, 'Frisch eingetroffen', 'Just arrived', '', '', '', '', '', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', 0),
('oxnewsletter', 0, 0, 'Newsletter', 'Newsletter', '', '', '', '', '', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', 0);

#
# Table structure for table `oxactions2article`
#

DROP TABLE IF EXISTS `oxactions2article`;

CREATE TABLE `oxactions2article` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXACTIONID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Action id (oxactions)',
  `OXARTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXSORT` int(11) NOT NULL default '0' COMMENT 'Sorting',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXMAINIDX` (`OXSHOPID`,`OXACTIONID`,`OXSORT`),
  KEY `OXARTID` (`OXARTID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between actions and articles';

#
# Table structure for table `oxaddress`
#

DROP TABLE IF EXISTS `oxaddress`;

CREATE TABLE `oxaddress` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Address id',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXADDRESSUSERID` VARCHAR(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'User id (oxuser)',
  `OXCOMPANY` varchar(255) NOT NULL default '' COMMENT 'Company name',
  `OXFNAME` varchar(255) NOT NULL default '' COMMENT 'First name',
  `OXLNAME` varchar(255) NOT NULL default '' COMMENT 'Last name',
  `OXSTREET` varchar(255) NOT NULL default '' COMMENT 'Street',
  `OXSTREETNR` varchar(16) NOT NULL default '' COMMENT 'House number',
  `OXADDINFO` varchar(255) NOT NULL default '' COMMENT 'Additional info',
  `OXCITY` varchar(255) NOT NULL default '' COMMENT 'City',
  `OXCOUNTRY` varchar(255) NOT NULL default '' COMMENT 'Country name',
  `OXCOUNTRYID` VARCHAR( 32 ) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Country id (oxcountry)',
  `OXSTATEID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'State id (oxstate)',
  `OXZIP` varchar(50) NOT NULL default '' COMMENT 'Zip code',
  `OXFON` varchar(128) NOT NULL default '' COMMENT 'Phone number',
  `OXFAX` varchar(128) NOT NULL default '' COMMENT 'Fax number',
  `OXSAL` varchar(128) NOT NULL default '' COMMENT 'User title prefix (Mr/Mrs)',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXUSERID` (`OXUSERID`)
) ENGINE=MyISAM COMMENT 'Stores user shipping addresses';

#
# Table structure for table `oxadminlog`
#

DROP TABLE IF EXISTS `oxadminlog`;

CREATE TABLE `oxadminlog` (
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXSQL` text NOT NULL COMMENT 'Logged sql'
) ENGINE=MyISAM COMMENT 'Logs admin actions';

#
# Table structure for table `oxarticles`
#

DROP TABLE IF EXISTS `oxarticles`;

CREATE TABLE `oxarticles` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Article id',
  `OXSHOPID` int(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)',
  `OXPARENTID` char(32) character set latin1 collate latin1_general_ci NOT NULL  default '' COMMENT 'Parent article id',
  `OXACTIVE` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Active',
  `OXACTIVEFROM` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active from specified date',
  `OXACTIVETO` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT  'Active to specified date',
  `OXARTNUM` varchar(255) NOT NULL default '' COMMENT 'Article number',
  `OXEAN` varchar(13)  NOT NULL default '' COMMENT 'International Article Number (EAN)',
  `OXDISTEAN` varchar(13)  NOT NULL default '' COMMENT 'Manufacture International Article Number (Man. EAN)',
  `OXMPN` varchar(100) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Manufacture Part Number (MPN)',
  `OXTITLE` varchar(255) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXSHORTDESC` varchar(255) NOT NULL default '' COMMENT 'Short description (multilanguage)',
  `OXPRICE` double NOT NULL default '0' COMMENT 'Article Price',
  `OXBLFIXEDPRICE` tinyint(1) NOT NULL default '0' COMMENT 'No Promotions (Price Alert) ',
  `OXPRICEA` double NOT NULL default '0' COMMENT 'Price A',
  `OXPRICEB` double NOT NULL default '0' COMMENT 'Price B',
  `OXPRICEC` double NOT NULL default '0' COMMENT 'Price C',
  `OXBPRICE` double NOT NULL default '0' COMMENT 'Purchase Price',
  `OXTPRICE` double NOT NULL default '0' COMMENT 'Recommended Retail Price (RRP)',
  `OXUNITNAME` varchar(32) NOT NULL default '' COMMENT 'Unit name (kg,g,l,cm etc), used in setting price per quantity unit calculation',
  `OXUNITQUANTITY` double NOT NULL default '0' COMMENT 'Article quantity, used in setting price per quantity unit calculation',
  `OXEXTURL` varchar(255) NOT NULL default '' COMMENT 'External URL to other information about the article',
  `OXURLDESC` varchar(255) NOT NULL default '' COMMENT 'Text for external URL (multilanguage)',
  `OXURLIMG` varchar(128) NOT NULL default '' COMMENT 'External URL image',
  `OXVAT` float default NULL COMMENT 'Value added tax. If specified, used in all calculations instead of global vat',
  `OXTHUMB` varchar(128) NOT NULL default '' COMMENT 'Thumbnail filename',
  `OXICON` varchar(128) NOT NULL default '' COMMENT 'Icon filename',
  `OXPIC1` varchar(128) NOT NULL default '' COMMENT '1# Picture filename',
  `OXPIC2` varchar(128) NOT NULL default '' COMMENT '2# Picture filename',
  `OXPIC3` varchar(128) NOT NULL default '' COMMENT '3# Picture filename',
  `OXPIC4` varchar(128) NOT NULL default '' COMMENT '4# Picture filename',
  `OXPIC5` varchar(128) NOT NULL default '' COMMENT '5# Picture filename',
  `OXPIC6` varchar(128) NOT NULL default '' COMMENT '6# Picture filename',
  `OXPIC7` varchar(128) NOT NULL default '' COMMENT '7# Picture filename',
  `OXPIC8` varchar(128) NOT NULL default '' COMMENT '8# Picture filename',
  `OXPIC9` varchar(128) NOT NULL default '' COMMENT '9# Picture filename',
  `OXPIC10` varchar(128) NOT NULL default '' COMMENT '10# Picture filename',
  `OXPIC11` varchar(128) NOT NULL default '' COMMENT '11# Picture filename',
  `OXPIC12` varchar(128) NOT NULL default '' COMMENT '12# Picture filename',
  `OXWEIGHT` double NOT NULL default '0' COMMENT 'Weight (kg)',
  `OXSTOCK` double NOT NULL default '0' COMMENT 'Article quantity in stock',
  `OXSTOCKFLAG` tinyint(1) NOT NULL default '1' COMMENT 'Delivery Status: 1 - Standard, 2 - If out of Stock, offline, 3 - If out of Stock, not orderable, 4 - External Storehouse',
  `OXSTOCKTEXT` varchar(255) NOT NULL default '' COMMENT 'Message, which is shown if the article is in stock (multilanguage)',
  `OXNOSTOCKTEXT` varchar(255) NOT NULL default '' COMMENT 'Message, which is shown if the article is off stock (multilanguage)',
  `OXDELIVERY` date NOT NULL default '0000-00-00' COMMENT 'Date, when the product will be available again if it is sold out',
  `OXINSERT` date NOT NULL default '0000-00-00' COMMENT 'Creation time',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `OXLENGTH` double NOT NULL default '0' COMMENT 'Article dimensions: Length',
  `OXWIDTH` double NOT NULL default '0' COMMENT 'Article dimensions: Width',
  `OXHEIGHT` double NOT NULL default '0' COMMENT 'Article dimensions: Height',
  `OXFILE` varchar(128) NOT NULL default '' COMMENT 'File, shown in article media list',
  `OXSEARCHKEYS` varchar(255) NOT NULL default '' COMMENT 'Search terms (multilanguage)',
  `OXTEMPLATE` varchar(128) NOT NULL default '' COMMENT 'Alternative template filename (if empty, default is used)',
  `OXQUESTIONEMAIL` varchar(255) NOT NULL default '' COMMENT 'E-mail for question',
  `OXISSEARCH` tinyint(1) NOT NULL default '1' COMMENT 'Should article be shown in search',
  `OXISCONFIGURABLE` tinyint NOT NULL DEFAULT '0' COMMENT 'Can article be customized',
  `OXVARNAME` varchar(255) NOT NULL default '' COMMENT 'Name of variants selection lists (different lists are separated by | ) (multilanguage)',
  `OXVARSTOCK` int(5) NOT NULL default '0' COMMENT 'Sum of active article variants stock quantity',
  `OXVARCOUNT` int(1) NOT NULL default '0' COMMENT 'Total number of variants that article has (active and inactive)',
  `OXVARSELECT` varchar(255) NOT NULL default '' COMMENT 'Variant article selections (separated by | ) (multilanguage)',
  `OXVARMINPRICE` double NOT NULL default '0' COMMENT 'Lowest price in active article variants',
  `OXVARMAXPRICE` double NOT NULL default '0' COMMENT 'Highest price in active article variants',
  `OXVARNAME_1` varchar(255) NOT NULL default '',
  `OXVARSELECT_1` varchar(255) NOT NULL default '',
  `OXVARNAME_2` varchar(255) NOT NULL default '',
  `OXVARSELECT_2` varchar(255) NOT NULL default '',
  `OXVARNAME_3` varchar(255) NOT NULL default '',
  `OXVARSELECT_3` varchar(255) NOT NULL default '',
  `OXTITLE_1` varchar(255) NOT NULL default '',
  `OXSHORTDESC_1` varchar(255) NOT NULL default '',
  `OXURLDESC_1` varchar(255) NOT NULL default '',
  `OXSEARCHKEYS_1` varchar(255) NOT NULL default '',
  `OXTITLE_2` varchar(255) NOT NULL default '',
  `OXSHORTDESC_2` varchar(255) NOT NULL default '',
  `OXURLDESC_2` varchar(255) NOT NULL default '',
  `OXSEARCHKEYS_2` varchar(255) NOT NULL default '',
  `OXTITLE_3` varchar(255) NOT NULL default '',
  `OXSHORTDESC_3` varchar(255) NOT NULL default '',
  `OXURLDESC_3` varchar(255) NOT NULL default '',
  `OXSEARCHKEYS_3` varchar(255) NOT NULL default '',
  `OXBUNDLEID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Bundled article id',
  `OXFOLDER` varchar(32) NOT NULL default '' COMMENT 'Folder',
  `OXSUBCLASS` varchar(32) NOT NULL default '' COMMENT 'Subclass',
  `OXSTOCKTEXT_1` varchar(255) NOT NULL default '',
  `OXSTOCKTEXT_2` varchar(255) NOT NULL default '',
  `OXSTOCKTEXT_3` varchar(255) NOT NULL default '',
  `OXNOSTOCKTEXT_1` varchar(255) NOT NULL default '',
  `OXNOSTOCKTEXT_2` varchar(255) NOT NULL default '',
  `OXNOSTOCKTEXT_3` varchar(255) NOT NULL default '',
  `OXSORT` int(5) NOT NULL default '0' COMMENT 'Sorting',
  `OXSOLDAMOUNT` double NOT NULL default '0' COMMENT 'Amount of sold articles including variants (used only for parent articles)',
  `OXNONMATERIAL` int(1) NOT NULL default '0' COMMENT 'Intangible article, free shipping is used (variants inherits parent setting)',
  `OXFREESHIPPING` int(1) NOT NULL default '0' COMMENT 'Free shipping (variants inherits parent setting)',
  `OXREMINDACTIVE` int(1) NOT NULL default '0' COMMENT 'Enables sending of notification email when oxstock field value falls below oxremindamount value',
  `OXREMINDAMOUNT` double NOT NULL default '0' COMMENT 'Defines the amount, below which notification email will be sent if oxremindactive is set to 1',
  `OXAMITEMID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '',
  `OXAMTASKID` varchar(16) character set latin1 collate latin1_general_ci NOT NULL default '0',
  `OXVENDORID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Vendor id (oxvendor)',
  `OXMANUFACTURERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Manufacturer id (oxmanufacturers)',
  `OXSKIPDISCOUNTS` tinyint(1) NOT NULL default '0' COMMENT 'Skips all negative Discounts (Discounts, Vouchers, Delivery ...)',
  `OXRATING` double NOT NULL default '0' COMMENT 'Article rating',
  `OXRATINGCNT` int(11) NOT NULL default '0' COMMENT 'Rating votes count',
  `OXMINDELTIME` int(11) NOT NULL default '0' COMMENT 'Minimal delivery time (unit is set in oxdeltimeunit)',
  `OXMAXDELTIME` int(11) NOT NULL default '0' COMMENT 'Maximum delivery time (unit is set in oxdeltimeunit)',
  `OXDELTIMEUNIT` varchar(255) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Delivery time unit: DAY, WEEK, MONTH',
  `OXUPDATEPRICE` DOUBLE NOT NULL default '0' COMMENT 'If not 0, oxprice will be updated to this value on oxupdatepricetime date',
  `OXUPDATEPRICEA` DOUBLE NOT NULL default '0' COMMENT 'If not 0, oxpricea will be updated to this value on oxupdatepricetime date',
  `OXUPDATEPRICEB` DOUBLE NOT NULL default '0' COMMENT 'If not 0, oxpriceb will be updated to this value on oxupdatepricetime date',
  `OXUPDATEPRICEC` DOUBLE NOT NULL default '0' COMMENT 'If not 0, oxpricec will be updated to this value on oxupdatepricetime date',
  `OXUPDATEPRICETIME` TIMESTAMP NOT NULL COMMENT 'Date, when oxprice[a,b,c] should be updated to oxupdateprice[a,b,c] values',
  `OXISDOWNLOADABLE` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable download of files for this product',
  PRIMARY KEY  (`OXID`),
  KEY `OXCOUNT` (`OXPARENTID`,`OXSHOPID`),
  KEY `OXSORT` (`OXSORT`),
  KEY `OXSHOPID` (`OXSHOPID`),
  KEY `OXISSEARCH` (`OXISSEARCH`),
  KEY `OXARTNUM` (`OXARTNUM`),
  KEY `OXSTOCK` (`OXSTOCK`),
  KEY `OXSTOCKFLAG` (`OXSTOCKFLAG`),
  KEY `OXINSERT` (`OXINSERT`),
  KEY `OXVARNAME` (`OXVARNAME`),
  KEY `OXACTIVE` (`OXACTIVE`),
  KEY `OXACTIVEFROM` (`OXACTIVEFROM`),
  KEY `OXACTIVETO` (`OXACTIVETO`),
  KEY `OXVENDORID` (`OXVENDORID`),
  KEY `OXMANUFACTURERID` (`OXMANUFACTURERID`),
  KEY `OXSOLDAMOUNT` ( `OXSOLDAMOUNT` ),
  KEY `parentsort` ( `OXPARENTID` , `OXSORT` ),
  KEY `OXUPDATEPRICETIME` ( `OXUPDATEPRICETIME` ),
  KEY `OXISDOWNLOADABLE` ( `OXISDOWNLOADABLE` )
)ENGINE=InnoDB COMMENT 'Articles information';

#
# Table structure for table `oxartextends`
# created on 2008-05-23
#

DROP TABLE IF EXISTS `oxartextends`;

CREATE TABLE `oxartextends` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Article id (extends oxarticles article with this id)',
  `OXLONGDESC` text NOT NULL COMMENT 'Long description (multilanguage)',
  `OXLONGDESC_1` text NOT NULL,
  `OXLONGDESC_2` text NOT NULL,
  `OXLONGDESC_3` text NOT NULL,
  `OXTAGS` varchar(255) NOT NULL COMMENT 'Tags (multilanguage)',
  `OXTAGS_1` varchar(255) NOT NULL,
  `OXTAGS_2` varchar(255) NOT NULL,
  `OXTAGS_3` varchar(255) NOT NULL,
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  FULLTEXT KEY `OXTAGS`   (`OXTAGS`),
  FULLTEXT KEY `OXTAGS_1` (`OXTAGS_1`),
  FULLTEXT KEY `OXTAGS_2` (`OXTAGS_2`),
  FULLTEXT KEY `OXTAGS_3` (`OXTAGS_3`)
) ENGINE=MyISAM COMMENT 'Additional information for articles';

#
# Table structure for table `oxattribute`
#

DROP TABLE IF EXISTS `oxattribute`;

CREATE TABLE `oxattribute` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Attribute id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXTITLE` char(128) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXTITLE_1` char(128) NOT NULL default '',
  `OXTITLE_2` char(128) NOT NULL default '',
  `OXTITLE_3` char(128) NOT NULL default '',
  `OXPOS` int(11) NOT NULL default '9999' COMMENT 'Sorting',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `OXDISPLAYINBASKET` tinyint(1) NOT NULL default '0' COMMENT 'Display attribute`s value for articles in checkout',
  PRIMARY KEY  (`OXID`)
) ENGINE=MyISAM COMMENT 'Article attributes';

#
# Table structure for table `oxcaptcha`
#

DROP TABLE IF EXISTS `oxcaptcha`;

CREATE TABLE IF NOT EXISTS `oxcaptcha` (
  `OXID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Captcha id',
  `OXHASH` char(32) NOT NULL default '' COMMENT 'Hash',
  `OXTIME` int(11) NOT NULL COMMENT 'Validation time',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY (`OXID`),
  KEY `OXID` (`OXID`,`OXHASH`),
  KEY `OXTIME` (`OXTIME`)
) ENGINE=MEMORY AUTO_INCREMENT=1 COMMENT 'If session is not available, this is where captcha information is stored';

#
# Table structure for table `oxcategories`
#

DROP TABLE IF EXISTS `oxcategories`;

CREATE TABLE `oxcategories` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Category id',
  `OXPARENTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default 'oxrootid' COMMENT 'Parent category id',
  `OXLEFT` int(11) NOT NULL default '0' COMMENT 'Used for building category tree',
  `OXRIGHT` int(11) NOT NULL default '0' COMMENT 'Used for building category tree',
  `OXROOTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Root category id',
  `OXSORT` int(11) NOT NULL default '9999' COMMENT 'Sorting',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Active (multilanguage)',
  `OXHIDDEN` tinyint(1) NOT NULL default '0' COMMENT 'Hidden (Can be accessed by direct link, but is not visible in lists and menu)',
  `OXSHOPID` int(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)',
  `OXTITLE` varchar(254) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXDESC` varchar(255) NOT NULL default '' COMMENT 'Description (multilanguage)',
  `OXLONGDESC` text NOT NULL COMMENT 'Long description (multilanguage)',
  `OXTHUMB` varchar(128) NOT NULL default '' COMMENT 'Thumbnail filename (multilanguage)',
  `OXTHUMB_1` VARCHAR(128) NOT NULL DEFAULT '',
  `OXTHUMB_2` VARCHAR(128) NOT NULL DEFAULT '',
  `OXTHUMB_3` VARCHAR(128) NOT NULL DEFAULT '',
  `OXEXTLINK` varchar(255) NOT NULL default '' COMMENT 'External link, that if specified is opened instead of category content',
  `OXTEMPLATE` varchar(128) NOT NULL default '' COMMENT 'Alternative template filename (if empty, default is used)',
  `OXDEFSORT` varchar(64) NOT NULL default '' COMMENT 'Default field for sorting of articles in this category (most of oxarticles fields)',
  `OXDEFSORTMODE` tinyint(1) NOT NULL default '0' COMMENT 'Default mode of sorting of articles in this category (0 - asc, 1 - desc)',
  `OXPRICEFROM` double NOT NULL default '0' COMMENT 'If specified, all articles, with price higher than specified, will be shown in this category',
  `OXPRICETO` double NOT NULL default '0' COMMENT 'If specified, all articles, with price lower than specified, will be shown in this category',
  `OXACTIVE_1` tinyint(1) NOT NULL default '0',
  `OXTITLE_1` varchar(255) NOT NULL default '',
  `OXDESC_1` varchar(255) NOT NULL default '',
  `OXLONGDESC_1` text NOT NULL,
  `OXACTIVE_2` tinyint(1) NOT NULL default '0',
  `OXTITLE_2` varchar(255) NOT NULL default '',
  `OXDESC_2` varchar(255) NOT NULL default '',
  `OXLONGDESC_2` text NOT NULL,
  `OXACTIVE_3` tinyint(1) NOT NULL default '0',
  `OXTITLE_3` varchar(255) NOT NULL default '',
  `OXDESC_3` varchar(255) NOT NULL default '',
  `OXLONGDESC_3` text NOT NULL,
  `OXICON` varchar(128) NOT NULL default '' COMMENT 'Icon filename',
  `OXPROMOICON` varchar(128) NOT NULL default '' COMMENT 'Promotion icon filename',
  `OXVAT` FLOAT NULL DEFAULT NULL COMMENT 'VAT, used for articles in this category (only if oxarticles.oxvat is not set)',
  `OXSKIPDISCOUNTS` tinyint(1) NOT NULL default '0' COMMENT 'Skip all negative Discounts for articles in this category (Discounts, Vouchers, Delivery ...) ',
  `OXSHOWSUFFIX` tinyint(1) NOT NULL default '1' COMMENT 'Show SEO Suffix in Category',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
   PRIMARY KEY  (`OXID`),
   KEY `OXROOTID` (`OXROOTID`),
   KEY `OXPARENTID` (`OXPARENTID`),
   KEY `OXPRICEFROM` (`OXPRICEFROM`),
   KEY `OXPRICETO` (`OXPRICETO`),
   KEY `OXHIDDEN` (`OXHIDDEN`),
   KEY `OXSHOPID` (`OXSHOPID`),
   KEY `OXSORT` (`OXSORT`),
   KEY `OXVAT` (`OXVAT`)
) ENGINE=MyISAM COMMENT 'Article categories';

#
# Table structure for table `oxcategory2attribute`
#

DROP TABLE IF EXISTS `oxcategory2attribute`;

CREATE TABLE `oxcategory2attribute` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Category id (oxcategories)',
  `OXATTRID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Attribute id (oxattributes)',
  `OXSORT` INT( 11 ) NOT NULL DEFAULT '9999' COMMENT 'Sorting',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Creation time',
  PRIMARY KEY  (`OXID`),
  KEY `OXOBJECTID` (`OXOBJECTID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between categories and attributes';


#
# Table structure for table `oxconfig`
#

DROP TABLE IF EXISTS `oxconfig`;

CREATE TABLE `oxconfig` (
  `OXID`            char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Config id',
  `OXSHOPID`        char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXMODULE`        varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Module or theme specific config (theme:themename, module:modulename)',
  `OXVARNAME`       char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Variable name',
  `OXVARTYPE`       varchar(16) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Variable type',
  `OXVARVALUE`      blob NOT NULL COMMENT 'Variable value',
  `OXTIMESTAMP`     timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXVARNAME` (`OXVARNAME`),
  KEY `listall` (`OXSHOPID`, `OXMODULE`)
) ENGINE=MyISAM COMMENT 'Shop configuration values';

#
# Data for table `oxconfig`
#
INSERT INTO `oxconfig` (`OXID`, `OXSHOPID`, `OXMODULE`, `OXVARNAME`, `OXVARTYPE`, `OXVARVALUE`) VALUES
('8563fba1965a11df3.34244997', 0, '', 'blEnterNetPrice', 'bool', ''),
('8563fba1965a11df3.12345678', 0, '', 'blWrappingVatOnTop', 'bool', ''),
('8563fba1965a1cc34.52696792', 0, '', 'blCalculateDelCostIfNotLoggedIn', 'bool', ''),
('8563fba1965a1f266.82484369', 0, '', 'blAllowUnevenAmounts', 'bool', ''),
('8563fba1965a219c9.51133344', 0, '', 'blUseStock', 'bool', 0x07),
('8563fba1965a23786.00479842', 0, '', 'blStoreCreditCardInfo', 'bool', ''),
('8563fba1965a25500.87856483', 0, '', 'dDefaultVAT', 'num', 0x07a1),
('8563fba1965a27185.06428911', 0, '', 'sDefaultLang', 'str', 0xde),
('8563fba1965a2b330.65668120', 0, '', 'sMerchantID', 'str', ''),
('8563fba1965a2d181.97927980', 0, '', 'sHost', 'str', 0x00d0e1aeebd778fac282663570d1660f41dc61385dbcd5d5d6f6),
('7fc4007ffb2639208.44268873', 0, '', 'sGZSLogFile', 'str', ''),
('8563fba1965a2eee6.68137602', 0, '', 'sPaymentUser', 'str', ''),
('8563fba1965a30cf7.41846088', 0, '', 'sPaymentPwd', 'str', ''),
('mlae44cdad808d9b994c58540db39e7a', 0, '', 'aLanguages', 'aarr', 0x4dba832f744c5786a371d9df3377ea87f0e2773dbaf685493e0b949a1c149111959424345b628f640a0d92ea6047ec118252e992),
('39893a0ef6a6e11645d4beee4fd0cd51', 0, '', 'aLanguageParams', 'aarr', 0x4dba832f744c5786a371d9df33778f9525f408b6efbc82de7c3c5ae3396caa6f8afb6864afa833b43597cad1fb8f9b8970c8e9098d10aae1be4637faa40a012a04e45a8a1cdd1b2ac3da558638600e58acf70fe8c192b668995bb533dac95be7af7d343b3a9c9b8daeaf4d637f065895346773476d667de331fe40d18765d4b98faf7375e1090587d8dd4bf98ad5005eb30666410920),
('mlabefd7ebdb5946e8f3f7e7a953b323', 0, '', 'aLanguageSSLURLs', 'arr', 0x4dba832f74e74df4cdd5afca153f15e216aea908af01b8),
('mla50c74dd79703312ffb8cfd82c3741', 0, '', 'aLanguageURLs', 'arr', 0x4dba832f74e74df4cdd5afca153f15e216aea908af01b8),
('3c4f033dfb8fd4fe692715dda19ecd28', 0, '', 'aCurrencies', 'arr', 0x4dbace2972e14bf2cbd3a9a4e655024620eb2a8b1770b083941edcbf1c09b8fc7a380fb4fb661e5241a9210d3ffa59395ce3d820d2a79c058e9c3a17c6815dfd492d51e0c01ace28af380e907a09677cedf73adab55f42f0154d9fc9bee3386b61956857d73768557428bf4d2f57e672f2bc3aaea791227a0de72d60c14259edefcf1358c703cf1d639f6a59d1cc9334bf7275d37b679cc79f178db9ca504c0e43),
('8563fba1965a43873.40898997', 0, '', 'aLexwareVAT', 'aarr', 0x4dba682873e04a2acbd3a9a4113b832e198a7e75fb770da528d4e916d042856bcaa4b6795b839a7c836f43faae6ef75d3e6f91e3a0384990c0b7fae81c46aeca010521bb89b5),
('8563fba1baec4d3b7.61553539', 0, '', 'iNrofSimilarArticles', 'str', 0x5d),
('8563fba1baec4f6d3.38812651', 0, '', 'iNrofCustomerWhoArticles', 'str', 0x5d),
('8563fba1baec515d0.57265727', 0, '', 'iNrofCrossellArticles', 'str', 0x5d),
('8563fba1baec55dc8.04115259', 0, '', 'iUseGDVersion', 'str', 0xb6),
('8563fba1baec5b7d3.75515041', 0, '', 'sCSVSign', 'str', 0x86),
('8563fba1baec5d615.45874801', 0, '', 'iExportNrofLines', 'str', 0xb644b7),
('8563fba1baec678e2.44233324', 0, '', 'iExportTickerRefresh', 'str', 0x07),
('8563fba1baec6acc3.69139343', 0, '', 'iImportNrofLines', 'str', 0x07c4b1),
('8563fba1baec6cce8.28843189', 0, '', 'iImportTickerRefresh', 'str', 0x07),
('8563fba1baec6eaf2.01241384', 0, '', 'iCntofMails', 'str', 0xb6c7),
('8563fba1baec73b00.28734905', 0, '', 'aOrderfolder', 'aarr', 0x4dba852e754d56360c19978b3f1481d799910f7f100e9ee73438ded0565e1a5edadd7c2846da44546f068ea2903bf5953068bc0cde9838848b7b31b27787c304bab9fe83bde678242f3645cb050632af58ea55b47cb51d45d03e8bd7cb984b2c2cd0fce8b09f09a2d796f5d3faa7f0ddb6b45d4554b6a7521f75503cd75b0c),
('8563fba1c39367724.92308656', 0, '', 'blCheckTemplates', 'bool', 0x07),
('8563fba1c39370d88.58444180', 0, '', 'blLogChangesInAdmin', 'bool', ''),
('8563fba1c393750a0.46170041', 0, '', 'sUtilModule', 'str', ''),
('8563fba1c3937ee60.91079898', 0, '', 'iMallMode', 'str', 0x07),
('8563fba1c39381962.39392958', 0, '', 'aCacheViews', 'arr', 0x4dba852e75e64cf5ccd4ae48113baca2c2f96704c777824cbc13da72f905064aea430c1a75e7bb914d80360cf25cf5bd5ed9fcaf3d310ab4),
('8563fba1c39386cf4.18302736', 0, '', 'aSkipTags', 'arr', 0x4dba85c975d460d7927733e9525403bc01ae3616da4e6cdf0a9b83cf8359894abce65f2103ad7e83270c4eb019ecf2fc0a3dcde5325b2bb08143bb43ec2c868c29d48dc7bea7f3abf16f6ebd6b97c50114bb53f0f23f59568f0fe9da452cfab264b8aa17ba9e978e892fc6cdef47b7f495e487027dcd08f12ce35d7d997b031d80044d60ba090f1d82a01b62d201d77ef25ce01e68a94948b3d48c2f6c5d612c2dcd6e8af2f00dd435f5e4a4884431560fe092e46de90ebdea5199915de557220607bfc0f7c9c945192e7640e2fda7d7f36ff1215b22ea4b3569cb47763d13e81f0a2dcf9398a5ccdd093ffa578c3c505b13a91d85f0d839543b340a4407ff6ec7d0948b0e7794bc05b993636dd6ac010b7c315f671a5c9b734402efbe207473995291e3122d474f0a86d07d643df2910af62397b4dbfb27c2bc2485498d0ff6bd0eaadc6e63a0fbb596fb50f7dc04a26f6ea8fc1b36f3ea274de76375b6dc82b3924a048a7f8a6ea741e8325b280a8d8c8c33c9d044fae750ad46b80dccfd8ae0c8471bf20c4236ecc4f3220011f7318b51e8c4276141f29a88c248a7563e89decc6561ac568f444fc75b5721947e980a280cde376532a0c7af16d6ad3a7decf89a8c3f1fd923fb11f8dd3bdea9319c71ba0be02c7f1fa10c276240727b56aafa61cc48f5b4f4852d184b3cf12e879a7d96b3b3134de64d0a9f8582632d1d18e1e7c007e2fc5dc95fd460e9d02db3fd2958ca5600d1b66f0853a6cd1488133f0299e1f20f),
('8563fba1c3938c994.40718405', 0, '', 'aModules', 'aarr', 0x4dba322c774f5444a5777125d61918a96e9e65e1b84a26e3fc11a1f3995f28a5f21f4ae67609854e73db7cf2cb37b5bb25),
('d319165cbf49e360b4f84c684c315245', 0, '', 'aModulePaths', 'aarr', 0x4dba322c774f54348d1e90d5718afbb1fd8d8f507175ab3dd621c589c5b19a03a1afa6bb6943d74959d245f3eb),
('8563fba1c3938ebe7.95075058', 0, '', 'aLogSkipTags', 'arr', 0x4dbaeb2d768d),
('79c3fbc9897c0d159.27469500', 0, '', 'blLoadVariants', 'bool', 0x07),
('b2b400dd011bf6273.08965005', 0, '', 'blVariantsSelection', 'bool', ''),
('43040112c71dfb0f2.40367454', 0, '', 'sDefaultImageQuality', 'str', 0x7741),
('51240739e4bc61362.43751239', 0, '', 'iMaxGBEntriesPerDay', 'str', 0xb0),
('4994145b9e87481c5.69580772', 0, '', 'aSortCols', 'arr', 0x4dba832f74e74df4cdd5af631238e7040fc97a18cf6cb28fd522f05ae28cf374f04ceeb7bd886eb10ac36ba86043beb02e),
('4994145b9e8736eb6.03785000', 0, '', 'iTop5Mode', 'str', 0x07),
('4994145b9e8678993.26056670', 0, '', 'blShowSorting', 'bool', 0x07),
('a104164f96fa51c41.58873414', 0, '', 'aSearchCols', 'arr', 0x4dba682873e04af3cad2a864153fe00308ce7d1fc86bb588d225f75de58b4371f549ebf5f054a8aa5d72ff4f9b5bb590240b14921d5f21962f67c7bd29417e61149f025b96cdf815d975cc85278913ee4b505bdfea13af328807c5ddd68d655b20d74de1e812236ebd97ee),
('d144175015dcd2a39.15131643', 0, '', 'aHomeCountry', 'arr', 0x4dba322c77e44ef7ced6aca1f357003cad231d1d78fe80070841979cd58fd7eca88459d4cb9ce3b72a2804d5),
('ce143201f7e03e110.09792514', 0, '', 'aMustFillFields', 'arr', 0x4dba322775d460d7927733e9e5fb6bf2ef688abcc84baef2405f16b906eec019f3a63b927c45a833864604543fe611a86d4a9f4027235e1a3f8572bfe00be3f1f0efee2efcc915c759d77d9270c9fef10bc707cdf5bc1a299c3795b96e0b85d032c55ff31364daf0e7a37ec5362cfdfb60e2de223e8160c91b08887f22196bfa2abae5f5d862fb1d0a7e35b2ceaf862088ab34b7029b1d598e61c436d21111682cf3442e4f9f16b936b1cdc085ed0dbda4b996a2a573c0aa47d3fb73ab13d4193b4d32c87bf9994e175f864102872ef2535d5d3df359ca2b25d26640038bbe74de0c8e2ef4b4c4e887afc4d889da38c63bf1c13c57a5c8d3f66a0615e155e4c3ec6dc279693b96e5b04004171fca59cb133027c34a309d9393736914ba027d21fa8ef1b9c79ec170ffa1a2bbf4746175c0e04b9cff68ae4f2875973518b9b1abc64f8e940d42183ed4ec6e1d285b2503869374d82727fae6f33ef4dd71c52de6bf9e460837768460a9fe62570ba2f75e83fd21be7e0c8fb78106e713d0e2e79fd19f04304989166dda296361a897ad15cc9f11db0566c70e968282da76ebb76fef0409f0),
('79e417a3916b910c8.31517473', 0, '', 'bl_perfLoadAktion', 'bool', 0x07),
('79e417a4201010a12.85717286', 0, '', 'bl_perfLoadReviews', 'bool', 0x07),
('79e417a420101f3e6.18536996', 0, '', 'bl_perfLoadCrossselling', 'bool', 0x07),
('79e417a4201028c21.24163259', 0, '', 'bl_perfLoadAccessoires', 'bool', 0x07),
('79e417a420103a598.95673089', 0, '', 'bl_perfLoadCustomerWhoBoughtThis', 'bool', 0x07),
('79e417a4201044603.06076651', 0, '', 'bl_perfLoadSimilar', 'bool', 0x07),
('79e417a420104dbd8.25267555', 0, '', 'bl_perfLoadSelectLists', 'bool', 0x07),
('79e417a4201062a60.33852458', 0, '', 'bl_perfLoadDiscounts', 'bool', 0x07),
('79e417a420106baa7.25594072', 0, '', 'bl_perfLoadDelivery', 'bool', 0x07),
('79e417a420107ab46.59697382', 0, '', 'bl_perfLoadPrice', 'bool', 0x07),
('79e417a442934fcb9.11733184', 0, '', 'bl_perfLoadCatTree', 'bool', 0x07),
('79e417a45558d97f6.76133435', 0, '', 'bl_perfLoadCurrency', 'bool', 0x07),
('79e417a45558e7851.36128674', 0, '', 'bl_perfLoadLanguages', 'bool', 0x07),
('79e417a45558f1b86.05956285', 0, '', 'bl_perfLoadNews', 'bool', 0x07),
('79e417a466086f390.29565974', 0, '', 'bl_perfLoadNewsOnlyStart', 'bool', 0x07),
('c20424bf2f8e71271.42955545', 0, '', 'bl_perfLoadTreeForSearch', 'bool', 0x07),
('36d42513de8cab671.54909813', 0, '', 'bl_perfShowActionCatArticleCnt', 'bool', 0x07),
('7044252b61dcb8ac9.31672388', 0, '', 'bl_perfLoadPriceForAddList', 'bool', 0x07),
('7044252b61dd44324.24181665', 0, '', 'bl_perfParseLongDescinSmarty', 'bool', 0x07),
('77c425a29db68f0d9.00182375', 0, '', 'bl_perfLoadManufacturerTree', 'bool', 0x07),
('79e417a4eaad1a593.54850808', 0, '', 'blStoreIPs', 'bool', ''),
('79e417a4eaad9dfa6.77588633', 0, '', 'aDeniedDynGroups', 'arr', 0x4dba322c77e44ef7ced6acac1f35ea091294b94a7572f88ffe92),
('33341949f476b65e8.17282442', 0, '', 'iAttributesPercent', 'str', 0x77c2),
('43141b9b252874600.34636487', 0, '', 'sDecimalSeparator', 'str', 0xc9),
('bf041bd98dacd9021.61732877', 0, '', 'aInterfaceProfiles', 'aarr', 0x4dbace29724a51b6af7d09aac117301142e91c3c5b7eed9a850f85c1e3d58739aa9ea92523f05320a95060d60d57fbb027bad88efdaa0b928ebcd6aacf58084d31dd6ed5e718b833f1079b3805d28203f284492955c82cea3405879ea7588ec610ccde56acede495),
('e8e41bda6fa7631d8.13775806', 0, '', 'iSessionTimeout', 'str', 0x17c3),
('6ec4235c5182c3620.11050422', 0, '', 'iNrofNewcomerArticles', 'str', 0xfb),
('6ec4235c2aaa8eec5.99966057', 0, '', 'sMidlleCustPrice', 'str', 0xfbc1),
('6ec4235c2aaa97585.69723730', 0, '', 'sLargeCustPrice', 'str', 0x07c4b1),
('6ec4235c2aa997942.70260123', 0, '', 'blWarnOnSameArtNums', 'bool', 0x07),
('a7a425c02819f7253.64374401', 0, '', 'blAutoIcons', 'bool', 0x07),
('7e9426025ff199d75.57820200', 0, '', 'sStockWarningLimit', 'str', 0x07c4),
('9a8426df9d36443e7.48701626', 0, '', 'blSearchUseAND', 'bool', ''),
('a99427345bf85a602.27736147', 0, '', 'blDontShowEmptyCategories', 'bool', ''),
('a99427345bf8fcff2.83464949', 0, '', 'bl_perfUseSelectlistPrice', 'bool', ''),
('a99427345bf9a27a1.04791092', 0, '', 'bl_perfCalcVatOnlyForBasketOrder', 'bool', ''),
('2ca4277aa49a5bd27.44511187', 0, '', 'blStockOnDefaultMessage', 'bool', 0x07),
('2ca4277aa49a634f8.76432326', 0, '', 'blStockOffDefaultMessage', 'bool', 0x07),
('6da42abf915b5f290.70877375', 0, '', 'sCntOfNewsLoaded', 'str', 0x07),
('89e42b02704ce5589.91950338', 0, '', 'iNewestArticlesMode', 'str', 0x07),
('e1142ca231becd5c4.00590616', 0, '', 'blConfirmAGB', 'bool', ''),
('2e4452b5763e03c74.88240349', 0, '', 'blDisableDublArtOnCopy', 'bool', 0x07),
('fde4559837789b3c7.26965372', 0, '', 'aCMSfolder', 'aarr', 0x4dbace29724a5131411d93d207fd82ee70b3e465e8c18e1b60a35eb597a1f3bad1e50ee52570c9ca486b4755b08cea9d0a17892b1e7628a152af0ab842c7c310547016f7c53a9ad0d62060ca7fc75f2bf6892a6f9987d014c0418d2b1e7a6defd8e0d2f5b189c89b886c5d130a72f1dcb7b55c4455b720ce73743f3ed559cda8621a523aa1021ed09f9a1f0177fc9e7ab5920621aa55a368bfeb28ae782c3456362aee),
('6f8453f77d174e0a0.31854175', 0, '', 'blOtherCountryOrder', 'bool', 0x07),
('0a5455450f97fdec9.37454802', 0, '', 'blAllowNegativeStock', 'bool', ''),
('b0b4d221756c80afdad8904c0b91b877', 0, '', 'iRssItemsCount', 'str', 0xb6c7),
('8b831f739c5d16cf4571b14a76006568', 0, '', 'aSEOReservedWords', 'arr', 0x4dba422a71e248f1c8d0aa4c153fcde9eec56a0fcc7c8947b718d1dff30f2db6d7a60c59398fb5e1aa5999cfde45071ab225fba4d72b3ba9c23a4b0adb75314b1e7a2de97adee42d81197c0b48d4621740313f9df1ad63f693b7c47aa031ed88093c0e12eb85a75de769ede4f57823a56c6576106fb7),
('2b72d8716ab1c8a67e1f8eae931ce56f', 0, '', 'bl_rssSearch', 'bool', 0x07),
('2b7aa4c6e33301b5855cc538fea4bccd', 0, '', 'bl_rssTopShop', 'bool', 0x07),
('2b7f0b7ba625f0fe61993c66f21b13f3', 0, '', 'bl_rssNewest', 'bool', 0x07),
('2b7eccdd7027feb7367a6edc668164c5', 0, '', 'bl_rssCategories', 'bool', 0x07),
('fd770460540c32422b415a65fefb8f90', 0, '', 'blLoadDynContents', 'bool', ''),
('fd7a064bbb64466f8e6ba847902b2005', 0, '', 'sShopCountry', 'str', ''),
('44bcd90bd1d059.053753111', 0, '', 'sTagList', 'str', 0x071d33336bce8dbe0606),
('603a1a28ff2a421b64c631ffaf97f324', 0, '', 'sGiCsvFieldEncloser', 'str', 0x95),
('591e3b6358fc5c87a6cb81c3f79787bc', 0, '', 'sTagSeparator', 'str', 0xc9),
('9135a582a6971656110b9a98ca5be6d2', 0, '', 'blShippingCountryVat', 'bool', ''),
('7a59f9000f39e5d9549a5d1e29c076a0', 0, '', 'blUseMultidimensionVariants', 'bool', 0x07),
('7a59f9000f39e5d9549a5d1e29c076a2', 0, '', 'blOrderOptInEmail', 'bool', 0x07),
('bd3e73e699331eb92c557113bac02fc4', 0, '', 'dPointsForInvitation', 'str', 0x07c4),
('bd320d322fa2f638086787c512329eec', 0, '', 'dPointsForRegistration', 'str', 0x07c4),
('99065ff58e9d2c1b2e362e54c0bb54f3', 0, '', 'blNewArtByInsert', 'bool', 0x07),
('rgk2a8c9cf8c9d23b3a7c8e9c090baf1', 0, '', 'sTheme', 'str', 0x4db70f6d1a),
('8563fba1c39367724.92308656123456', 0, '', 'blShowTags', 'bool', 0x07),
('8563fba1c39367724.92308656123457', 0, '', 'blFacebookConfirmEnabled', 'bool', 0x07),
('8563fba1c39367724.92308656123111', 0, '', 'sDownloadsDir', 'str', 0x603ee70d5409aee3c7d241d291),
('5i1c49faf83b3fe3d6bdbfa301e2704d', 0, '', 'iLinkExpirationTime', 'str', 0x070de9),
('5i1d215fe1d6f0e1061ba1134e0ee4f2', 0, '', 'iDownloadExpirationTime', 'str', 0xb6e2),
('l8g3e140a4bc7993d7d715df951dfe25', 0, '', 'iMaxDownloadsCountUnregistered', 'str', 0x07),
('l8g957be9e7b13412960c7670f71ba3b', 0, '', 'iMaxDownloadsCount', 'str', 0xde),
('mhjf24905a5b49c8d60aa31087b9797f', 0, '', 'blShowRememberMe', 'bool', 0x07),
('omc4555952125c3c2.98253113', 0, '', 'blDisableNavBars', 'bool', 0x07),
('mhjf24905a5b49c8d60aa31087b97971', 0, '', 'blEnableSeoCache', 'bool', 0x07),
('l8g957be9e7b13412960c7670f71ba31', 0, '', 'sAdditionalServVATCalcMethod', 'str', 0x55ca40ff0d0a72f5b908f2),
('fecfcd8dbd01a491a94557448425acc8', 0, '', 'blShowTSInternationalFeesMessage', 'bool', 0x07),
('1eada690d18be312ef5e49b8451440e7', 0, '', 'blShowTSCODMessage', 'bool', 0x07);

-- default unconfigurable values to fallback if theme does not provide alternatives
INSERT INTO `oxconfig` (`OXID`, `OXSHOPID`, `OXMODULE`, `OXVARNAME`, `OXVARTYPE`, `OXVARVALUE`) VALUES
('8563fba1baec57c19.08644217', 0, '', 'sThumbnailsize', 'str', 0x07c4b144c7b838),
('8563fba1baec599d5.89404456', 0, '', 'sCatThumbnailsize', 'str', 0x5d43334072bf3f),
('6ec4235c2aaa45d77.87437919', 0, '', 'sIconsize', 'str', 0x5d09ae6470),
('62642dfaa1d88b1b2.94593071', 0, '', 'sZoomImageSize', 'str', 0xfb42b1443b3e38),
('62642dfaa1d87d064.50653921', 0, '', 'aDetailImageSizes', 'aarr', 0x4dba326a73d2cdcb471b9533d7800b4b898873f7ae9dc29edf3ce8fab64f8609e31d318807f46516ea31aa94cb0b4edaaf32e7cb502403b480dd7cb1451f56975c3fd6159579cd2cab97104f17ae6a99af864bc1acb550c7e78b82f4618aeb8ba7fbec5409f277e0a2b84e66c24f96ba3fa76665f6a9294d8bf365bf7d3d0d56faf2355df799bc2892994db56203b0f5967ddbe8d403cead91988dfc82772557950eb1ba0d9468f3d8ca7170cde789d6c1282016056e51005091e7440fa453b1235c40010a71ff46f681c74515b4fda6da204abf3178561e271f8202652eabe106a93f9f4d1ed363f2f33c1e29716b95be88112373c48373148b134f2e0312bcfa2f2ba96f5cb15338dee7265d0efc66fe6526a6047b0e2bc4896143076e8dbc7dd8a7448ba2a5233814dd6abc39cb811a4d295c95cdaffde7cb8a5a3fddfe14f9a580973e9660a622f0d774bdb9);

-- data for azure theme
INSERT INTO `oxconfig` (`OXID`, `OXSHOPID`, `OXMODULE`, `OXVARNAME`, `OXVARTYPE`, `OXVARVALUE`) VALUES
('1ec4235c2aee774aa45d772875437919', 0, 'theme:azure', 'sIconsize', 'str', 0x8064a213b1),
('1563fba1bee774aec57c192086494217', 0, 'theme:azure', 'sThumbnailsize', 'str', 0x079a3a49ca3630),
('12642dfaa1dee77487d0644506753921', 0, 'theme:azure', 'aDetailImageSizes', 'aarr', 0x4dba326a73d2cdcb471b9533d7800b4b898873f7ae9dc29ed9e0e4f6bc678f00ea1438810efd6c1fe338a39dc20247d3a63beec4852106b7a1dd7cb1451f56975c3fd6159579cd2cab97104f17ae6c45a38a41e9a5bc59ceee828bfd6883e282aef2e55d00fb7ee9abb79b63c74cb7ba3fa76665f6a9294d8bf365bf7d3d0d56faf2355df145b02498b144bc6b0ab9fc9f74d2e1dd0ac7a4989184f58b7e2c58400bb4b92c9468f3d8ca7170cde789d6c1282016056e51005091e19803a859992a5549080378f64fff88ce4c1cbdf4afd32943b63877831b221ca302652eabe106a93f9f4d1ed363f2f33c1e29716b95b8541d2f79ec8a7a1d821a46270a1bb5f32622a06655b85a31d7ee2f52dbf963fd4426a6047b0e2bc4896143076e8dbc7dd8a7448ba2a5233ec8d166b611c288134420559cc4a6f4eec2835336d4f71df0ac899e314365a321d1d774bdb9),
('12642dfaa1dee77488b1b22948593071', 0, 'theme:azure', 'sZoomImageSize', 'str', 0x170a3340d372be),
('1ec42a395d0595ee7741091898848798', 0, 'theme:azure', 'sCatIconsize', 'str', 0x070de94ac9b636),
('1563fba1bee774aec599d56894094456', 0, 'theme:azure', 'sCatThumbnailsize', 'str', 0x77e7ed4ecd3137),
('1ec42a395d0595ee7741091898848987', 0, 'theme:azure', 'sCatPromotionsize', 'str', 0xb06fb441c2bd94),
('1ec42a395d0595ee7741091898848789', 0, 'theme:azure', 'sManufacturerIconsize', 'str', 0x07c4b144c7b838),
('18a9473894d473f6ed28f04e80d929fc', 0, 'theme:azure', 'bl_showCompareList', 'bool', 0x07),
('18acb2f595da54b5f865e54aa5cdb967', 0, 'theme:azure', 'bl_showListmania', 'bool', 0x07),
('18a12329124850cd8f63cda6e8e7b4e1', 0, 'theme:azure', 'bl_showWishlist', 'bool', 0x07),
('18a23429124850cd8f63cda6e8e7b4e1', 0, 'theme:azure', 'bl_showVouchers', 'bool', 0x07),
('18a34529124850cd8f63cda6e8e7b4e1', 0, 'theme:azure', 'bl_showGiftWrapping', 'bool', 0x07),
('15342e4cab0ee774acb3905838384984', 0, 'theme:azure', 'blShowBirthdayFields', 'bool', 0x07),
('11296159b7641d31b93423972af6150b', 0, 'theme:azure', 'iTopNaviCatCount', 'str', 0xfb),
('1ec42a395d0595ee7741091898848989', 0, 'theme:azure', 'sDefaultListDisplayType', 'select', 0x83cd10b7f09064ed),
('1ec42a395d0595ee7741091898848992', 0, 'theme:azure', 'sStartPageListDisplayType', 'select', 0x83cd10b7f09064ed),
('1ec42a395d0595ee7741091898848990', 0, 'theme:azure', 'blShowListDisplayType', 'bool', 0x07),
('1ec42a395d0595ee7741091898848474', 0, 'theme:azure', 'iNewBasketItemMessage', 'select', 0x07),
('1545423fe8ce213a0435345552230295', 0, 'theme:azure', 'aNrofCatArticles', 'arr', 0x4dbace2972e14bf2cbd3a9a4113b83ad1c8f7b704f710ba39fd1ecd29b438b41809712e316c6f4fdc92741f7876cc6fca127d78994e604dcc99519),
('1ec42a395d0595ee7741091898848991', 0, 'theme:azure', 'aNrofCatArticlesInGrid', 'arr', 0x4dbace2972e14bf2cbd3a9a4113b83c51e8d79724d7309a19dd3ee6153448c46879015e411c1f3fa250245f38368c2f8a523d58c91546b92cdf6);

#
# Table structure for table `oxconfigdisplay`
# Created on 2010-11-11
#

DROP TABLE IF EXISTS `oxconfigdisplay`;

CREATE TABLE `oxconfigdisplay` (
  `OXID`            char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Config id (extends oxconfig record with this id)',
  `OXCFGMODULE`     varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Module or theme specific config (theme:themename, module:modulename)',
  `OXCFGVARNAME`    char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Variable name',
  `OXGROUPING`      varchar(255) NOT NULL default '' COMMENT 'Grouping (groups config fields to array with specified value as key)',
  `OXVARCONSTRAINT` varchar(255) NOT NULL default '' COMMENT 'Serialized constraints',
  `OXPOS`           int NOT NULL default 0 COMMENT 'Sorting',
  `OXTIMESTAMP`     timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `list` (`OXCFGMODULE`, `OXCFGVARNAME`)
) ENGINE=MyISAM COMMENT 'Additional configuraion fields';

INSERT INTO `oxconfigdisplay` (`OXID`, `OXCFGMODULE`, `OXCFGVARNAME`, `OXGROUPING`, `OXVARCONSTRAINT`, `OXPOS`) VALUES
('1ec4235c2aee774aa45d772875437919', 'theme:azure', 'sIconsize', 'images', '', 1),
('1563fba1bee774aec57c192086494217', 'theme:azure', 'sThumbnailsize', 'images', '', 2),
('1563fba1bee774aec599d56894094456', 'theme:azure', 'sCatThumbnailsize', 'images', '', 3),
('12642dfaa1dee77488b1b22948593071', 'theme:azure', 'sZoomImageSize', 'images', '', 4),
('12642dfaa1dee77487d0644506753921', 'theme:azure', 'aDetailImageSizes', 'images', '', 5),
('18a9473894d473f6ed28f04e80d929fc', 'theme:azure', 'bl_showCompareList', 'features', '', 6),
('18acb2f595da54b5f865e54aa5cdb967', 'theme:azure', 'bl_showListmania', 'features', '', 7),
('18a12329124850cd8f63cda6e8e7b4e1', 'theme:azure', 'bl_showWishlist', 'features', '', 8),
('18a23429124850cd8f63cda6e8e7b4e1', 'theme:azure', 'bl_showVouchers', 'features', '', 9),
('18a34529124850cd8f63cda6e8e7b4e1', 'theme:azure', 'bl_showGiftWrapping', 'features', '', 10),
('15342e4cab0ee774acb3905838384984', 'theme:azure', 'blShowBirthdayFields', 'display', '', 14),
('11296159b7641d31b93423972af6150b', 'theme:azure', 'iTopNaviCatCount', 'display', '', 15),
('6ec4235c2aee774aa45d772875437789', 'theme:azure', 'sManufacturerIconsize', 'images', '', 6),
('8563fba1bee774aec57c192086494897', 'theme:azure', 'sCatIconsize', 'images', '', 7),
('8563fba1bee774aec599d56894094987', 'theme:azure', 'sCatPromotionsize', 'images', '', 8),
('1ec42a395d0595ee7741091898848989', 'theme:azure', 'sDefaultListDisplayType', 'display', 'infogrid|line|grid', 21),
('1ec42a395d0595ee7741091898848992', 'theme:azure', 'sStartPageListDisplayType', 'display', 'infogrid|line|grid', 22),
('1ec42a395d0595ee7741091898848990', 'theme:azure', 'blShowListDisplayType', 'display', '', 20),
('1ec42a395d0595ee7741091898848474', 'theme:azure', 'iNewBasketItemMessage', 'display', '0|1|2|3', 17),
('1545423fe8ce213a06.20230295', 'theme:azure', 'aNrofCatArticles', 'display', '', 23),
('1ec42a395d0595ee7741091898848991', 'theme:azure', 'aNrofCatArticlesInGrid', 'display', '', 24);
# --------------------------------------------------------


#
# Table structure for table `oxcontents`
#

DROP TABLE IF EXISTS `oxcontents`;

CREATE TABLE `oxcontents` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Content id',
  `OXLOADID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Id, specified by admin and can be used instead of oxid',
  `OXSHOPID` int(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)',
  `OXSNIPPET` tinyint(1) NOT NULL default '1' COMMENT 'Snippet (can be included to other oxcontents records)',
  `OXTYPE` tinyint(1) NOT NULL default '0' COMMENT 'Type: 0 - Snippet, 1 - Upper Menu, 2 - Category, 3 - Manual',
  `OXACTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Active (multilanguage)',
  `OXACTIVE_1` tinyint(1) NOT NULL default '0' COMMENT '',
  `OXPOSITION` varchar(32) NOT NULL default '' COMMENT 'Position',
  `OXTITLE` varchar(255) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXCONTENT` text NOT NULL COMMENT 'Content (multilanguage)',
  `OXTITLE_1` varchar(255) NOT NULL default '' COMMENT '',
  `OXCONTENT_1` text NOT NULL ,
  `OXACTIVE_2` tinyint(1) NOT NULL default '0' ,
  `OXTITLE_2` varchar(255) NOT NULL default '' ,
  `OXCONTENT_2` text NOT NULL ,
  `OXACTIVE_3` tinyint(1) NOT NULL default '0' ,
  `OXTITLE_3` varchar(255) NOT NULL default '' ,
  `OXCONTENT_3` text NOT NULL,
  `OXCATID` varchar(32) character set latin1 collate latin1_general_ci default NULL COMMENT 'Category id (oxcategories), used only when type = 2',
  `OXFOLDER` varchar(32) NOT NULL default '' COMMENT 'Content Folder (available options at oxconfig.OXVARNAME = aCMSfolder)',
  `OXTERMVERSION` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Term and Conditions version (used only when OXLOADID = oxagb)',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  UNIQUE KEY `OXLOADID` (`OXLOADID`),
  INDEX `cat_search` ( `OXTYPE` , `OXSHOPID` , `OXSNIPPET` , `OXCATID` )
) ENGINE=MyISAM COMMENT 'Content pages (Snippets, Menu, Categories, Manual)';


#
# Table structure for table `oxcounters`
#

DROP TABLE IF EXISTS `oxcounters`;

CREATE TABLE  `oxcounters` (
  `OXIDENT` CHAR( 32 ) NOT NULL COMMENT 'Counter id',
  `OXCOUNT` INT NOT NULL COMMENT 'Counted number',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY (  `OXIDENT` )
) ENGINE = InnoDB COMMENT 'Shop counters';

# --------------------------------------------------------

#
# Table structure for table `oxcountry`
#

DROP TABLE IF EXISTS `oxcountry`;

CREATE TABLE `oxcountry` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Country id',
  `OXACTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Active',
  `OXTITLE` char(128) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXISOALPHA2` char(2) NOT NULL default '' COMMENT 'ISO 3166-1 alpha-2',
  `OXISOALPHA3` char(3) NOT NULL default '' COMMENT 'ISO 3166-1 alpha-3',
  `OXUNNUM3` char(3) NOT NULL default '' COMMENT 'ISO 3166-1 numeric',
  `OXORDER` int(11) NOT NULL default '9999' COMMENT 'Sorting',
  `OXSHORTDESC` char(128) NOT NULL default '' COMMENT 'Short description (multilanguage)',
  `OXLONGDESC` char(255) NOT NULL default '' COMMENT 'Long description (multilanguage)',
  `OXTITLE_1` char(128) NOT NULL default '',
  `OXTITLE_2` char(128) NOT NULL default '',
  `OXTITLE_3` char(128) NOT NULL default '',
  `OXSHORTDESC_1` char(128) NOT NULL default '',
  `OXSHORTDESC_2` char(128) NOT NULL default '',
  `OXSHORTDESC_3` char(128) NOT NULL default '',
  `OXLONGDESC_1` char(255) NOT NULL,
  `OXLONGDESC_2` char(255) NOT NULL,
  `OXLONGDESC_3` char(255) NOT NULL,
  `OXVATSTATUS` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Vat status: 0 - Do not bill VAT, 1 - Do not bill VAT only if provided valid VAT ID',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY (`OXACTIVE`)
) ENGINE=MyISAM COMMENT 'Countries list';

#
# Data for table `oxcountry`
#

INSERT INTO `oxcountry` (`OXID`, `OXACTIVE`, `OXTITLE`, `OXISOALPHA2`, `OXISOALPHA3`, `OXUNNUM3`, `OXORDER`, `OXSHORTDESC`, `OXLONGDESC`, `OXTITLE_1`, `OXTITLE_2`, `OXTITLE_3`, `OXSHORTDESC_1`, `OXSHORTDESC_2`, `OXSHORTDESC_3`, `OXLONGDESC_1`, `OXLONGDESC_2`, `OXLONGDESC_3`, `OXVATSTATUS`) VALUES
('2db455824e4a19cc7.14731328', 0, 'Anderes Land', '', '', '', 10000, '', 'Select this if you can not find your country.', 'Other country', '', '', '', '', '', 'Select this if you can not find your country.', '', '', 0),
('a7c40f631fc920687.20179984', 1, 'Deutschland', 'DE', 'DEU', '276', 9999, 'EU1', '', 'Germany', '', '', 'EU1', '', '', '', '', '', 1),
('a7c40f6320aeb2ec2.72885259', 1, '�sterreich', 'AT', 'AUT', '40', 9999, 'EU1', '', 'Austria', '', '', 'EU1', '', '', '', '', '', 1),
('a7c40f6321c6f6109.43859248', 1, 'Schweiz', 'CH', 'CHE', '756', 9999, 'EU1', '', 'Switzerland', '', '', 'EU1', '', '', '', '', '', 0),
('a7c40f6322d842ae3.83331920', 0, 'Liechtenstein', 'LI', 'LIE', '438', 9999, 'EU1', '', 'Liechtenstein', '', '', 'EU1', '', '', '', '', '', 0),
('a7c40f6323c4bfb36.59919433', 0, 'Italien', 'IT', 'ITA', '380', 9999, 'EU1', '', 'Italy', '', '', 'EU1', '', '', '', '', '', 1),
('a7c40f63264309e05.58576680', 0, 'Luxemburg', 'LU', 'LUX', '442', 9999, 'EU1', '', 'Luxembourg', '', '', 'EU1', '', '', '', '', '', 1),
('a7c40f63272a57296.32117580', 0, 'Frankreich', 'FR', 'FRA', '250', 9999, 'EU1', '', 'France', '', '', 'EU1', '', '', '', '', '', 1),
('a7c40f632848c5217.53322339', 0, 'Schweden', 'SE', 'SWE', '752', 9999, 'EU2', '', 'Sweden', '', '', 'EU2', '', '', '', '', '', 1),
('a7c40f63293c19d65.37472814', 0, 'Finnland', 'FI', 'FIN', '246', 9999, 'EU2', '', 'Finland', '', '', 'EU2', '', '', '', '', '', 1),
('a7c40f632a0804ab5.18804076', 1, 'Vereinigtes K�nigreich', 'GB', 'GBR', '826', 9999, 'EU2', '', 'United Kingdom', '', '', 'EU2', '', '', '', '', '', 1),
('a7c40f632be4237c2.48517912', 0, 'Irland', 'IE', 'IRL', '372', 9999, 'EU2', '', 'Ireland', '', '', 'EU2', '', '', '', '', '', 1),
('a7c40f632cdd63c52.64272623', 0, 'Niederlande', 'NL', 'NLD', '528', 9999, 'EU2', '', 'Netherlands', '', '', 'EU2', '', '', '', '', '', 1),
('a7c40f632e04633c9.47194042', 0, 'Belgien', 'BE', 'BEL', '56', 9999, 'Rest Europ�ische Union', '', 'Belgium', '', '', 'Rest of EU', '', '', '', '', '', 1),
('a7c40f632f65bd8e2.84963272', 0, 'Portugal', 'PT', 'PRT', '620', 9999, 'Rest Europ�ische Union', '', 'Portugal', '', '', 'Rest of EU', '', '', '', '', '', 1),
('a7c40f633038cd578.22975442', 0, 'Spanien', 'ES', 'ESP', '724', 9999, 'Rest Europ�ische Union', '', 'Spain', '', '', 'Rest of EU', '', '', '', '', '', 1),
('a7c40f633114e8fc6.25257477', 0, 'Griechenland', 'GR', 'GRC', '300', 9999, 'Rest Europ�ische Union', '', 'Greece', '', '', 'Rest of EU', '', '', '', '', '', 1),
('8f241f11095306451.36998225', 0, 'Afghanistan', 'AF', 'AFG', '4', 9999, 'Rest Welt', '', 'Afghanistan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110953265a5.25286134', 0, 'Albanien', 'AL', 'ALB', '8', 9999, 'Rest Europa', '', 'Albania', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f1109533b943.50287900', 0, 'Algerien', 'DZ', 'DZA', '12', 9999, 'Rest Welt', '', 'Algeria', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109534f8c7.80349931', 0, 'Amerikanisch Samoa', 'AS', 'ASM', '16', 9999, 'Rest Welt', '', 'American Samoa', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095363464.89657222', 0, 'Andorra', 'AD', 'AND', '20', 9999, 'Europa', '', 'Andorra', '', '', 'Europe', '', '', '', '', '', 0),
('8f241f11095377d33.28678901', 0, 'Angola', 'AO', 'AGO', '24', 9999, 'Rest Welt', '', 'Angola', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095392e41.74397491', 0, 'Anguilla', 'AI', 'AIA', '660', 9999, 'Rest Welt', '', 'Anguilla', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110953a8d10.29474848', 0, 'Antarktis', 'AQ', 'ATA', '10', 9999, 'Rest Welt', '', 'Antarctica', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110953be8f2.56248134', 0, 'Antigua und Barbuda', 'AG', 'ATG', '28', 9999, 'Rest Welt', '', 'Antigua and Barbuda', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110953d2fb0.54260547', 0, 'Argentinien', 'AR', 'ARG', '32', 9999, 'Rest Welt', '', 'Argentina', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110953e7993.88180360', 0, 'Armenien', 'AM', 'ARM', '51', 9999, 'Rest Europa', '', 'Armenia', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f110953facc6.31621036', 0, 'Aruba', 'AW', 'ABW', '533', 9999, 'Rest Welt', '', 'Aruba', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095410f38.37165361', 0, 'Australien', 'AU', 'AUS', '36', 9999, 'Rest Welt', '', 'Australia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109543cf47.17877015', 0, 'Aserbaidschan', 'AZ', 'AZE', '31', 9999, 'Rest Welt', '', 'Azerbaijan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095451379.72078871', 0, 'Bahamas', 'BS', 'BHS', '44', 9999, 'Rest Welt', '', 'Bahamas', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110954662e3.27051654', 0, 'Bahrain', 'BH', 'BHR', '48', 9999, 'Welt', '', 'Bahrain', '', '', 'World', '', '', '', '', '', 0),
('8f241f1109547ae49.60154431', 0, 'Bangladesch', 'BD', 'BGD', '50', 9999, 'Rest Welt', '', 'Bangladesh', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095497083.21181725', 0, 'Barbados', 'BB', 'BRB', '52', 9999, 'Rest Welt', '', 'Barbados', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110954ac5b9.63105203', 0, 'Wei�russland', 'BY', 'BLR', '112', 9999, 'Rest Europa', '', 'Belarus', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f110954d3621.45362515', 0, 'Belize', 'BZ', 'BLZ', '84', 9999, 'Rest Welt', '', 'Belize', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110954ea065.41455848', 0, 'Benin', 'BJ', 'BEN', '204', 9999, 'Rest Welt', '', 'Benin', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110954fee13.50011948', 0, 'Bermuda', 'BM', 'BMU', '60', 9999, 'Rest Welt', '', 'Bermuda', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095513ca0.75349731', 0, 'Bhutan', 'BT', 'BTN', '64', 9999, 'Rest Welt', '', 'Bhutan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109552aee2.91004965', 0, 'Bolivien', 'BO', 'BOL', '68', 9999, 'Rest Welt', '', 'Bolivia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109553f902.06960438', 0, 'Bosnien und Herzegowina', 'BA', 'BIH', '70', 9999, 'Rest Europa', '', 'Bosnia and Herzegovina', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f11095554834.54199483', 0, 'Botsuana', 'BW', 'BWA', '72', 9999, 'Rest Welt', '', 'Botswana', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109556dd57.84292282', 0, 'Bouvetinsel', 'BV', 'BVT', '74', 9999, 'Rest Welt', '', 'Bouvet Island', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095592407.89986143', 0, 'Brasilien', 'BR', 'BRA', '76', 9999, 'Rest Welt', '', 'Brazil', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110955a7644.68859180', 0, 'Britisches Territorium im Indischen Ozean', 'IO', 'IOT', '86', 9999, 'Rest Welt', '', 'British Indian Ocean Territory', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110955bde61.63256042', 0, 'Brunei Darussalam', 'BN', 'BRN', '96', 9999, 'Rest Welt', '', 'Brunei Darussalam', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110955d3260.55487539', 0, 'Bulgarien', 'BG', 'BGR', '100', 9999, 'Rest Europa', '', 'Bulgaria', '', '', 'Rest Europe', '', '', '', '', '', 1),
('8f241f110955ea7c8.36762654', 0, 'Burkina Faso', 'BF', 'BFA', '854', 9999, 'Rest Welt', '', 'Burkina Faso', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110956004d5.11534182', 0, 'Burundi', 'BI', 'BDI', '108', 9999, 'Rest Welt', '', 'Burundi', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110956175f9.81682035', 0, 'Kambodscha', 'KH', 'KHM', '116', 9999, 'Rest Welt', '', 'Cambodia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095632828.20263574', 0, 'Kamerun', 'CM', 'CMR', '120', 9999, 'Rest Welt', '', 'Cameroon', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095649d18.02676059', 0, 'Kanada', 'CA', 'CAN', '124', 9999, 'Welt', '', 'Canada', '', '', 'World', '', '', '', '', '', 0),
('8f241f1109565e671.48876354', 0, 'Kap Verde', 'CV', 'CPV', '132', 9999, 'Rest Welt', '', 'Cape Verde', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095673248.50405852', 0, 'Kaimaninseln', 'KY', 'CYM', '136', 9999, 'Rest Welt', '', 'Cayman Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109568a509.03566030', 0, 'Zentralafrikanische Republik', 'CF', 'CAF', '140', 9999, 'Rest Welt', '', 'Central African Republic', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109569d4c2.42800039', 0, 'Tschad', 'TD', 'TCD', '148', 9999, 'Rest Welt', '', 'Chad', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110956b3ea7.11168270', 0, 'Chile', 'CL', 'CHL', '152', 9999, 'Rest Welt', '', 'Chile', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110956c8860.37981845', 0, 'China', 'CN', 'CHN', '156', 9999, 'Rest Welt', '', 'China', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110956df6b2.52283428', 0, 'Weihnachtsinsel', 'CX', 'CXR', '162', 9999, 'Rest Welt', '', 'Christmas Island', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110956f54b4.26327849', 0, 'Kokosinseln (Keelinginseln)', 'CC', 'CCK', '166', 9999, 'Rest Welt', '', 'Cocos (Keeling) Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109570a1e3.69772638', 0, 'Kolumbien', 'CO', 'COL', '170', 9999, 'Rest Welt', '', 'Colombia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109571f018.46251535', 0, 'Komoren', 'KM', 'COM', '174', 9999, 'Rest Welt', '', 'Comoros', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095732184.72771986', 0, 'Kongo', 'CG', 'COG', '178', 9999, 'Rest Welt', '', 'Congo', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095746a92.94878441', 0, 'Cookinseln', 'CK', 'COK', '184', 9999, 'Rest Welt', '', 'Cook Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109575d708.20084150', 0, 'Costa Rica', 'CR', 'CRI', '188', 9999, 'Rest Welt', '', 'Costa Rica', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095771f76.87904122', 0, 'Cote d�Ivoire', 'CI', 'CIV', '384', 9999, 'Rest Welt', '', 'Cote d''Ivoire', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095789a04.65154246', 0, 'Kroatien', 'HR', 'HRV', '191', 9999, 'Rest Europ�ische Union', '', 'Croatia', '', '', 'Rest of EU', '', '', '', '', '', 1),
('8f241f1109579ef49.91803242', 0, 'Kuba', 'CU', 'CUB', '192', 9999, 'Rest Welt', '', 'Cuba', '', '', 'World', '', '', '', '', '', 0),
('8f241f110957b6896.52725150', 0, 'Zypern', 'CY', 'CYP', '196', 9999, 'Rest Europa', '', 'Cyprus', '', '', 'Rest Europe', '', '', '', '', '', 1),
('8f241f110957cb457.97820918', 0, 'Tschechische Republik', 'CZ', 'CZE', '203', 9999, 'Europa', '', 'Czech Republic', '', '', 'Europe', '', '', '', '', '', 1),
('8f241f110957e6ef8.56458418', 0, 'D�nemark', 'DK', 'DNK', '208', 9999, 'Europa', '', 'Denmark', '', '', 'Europe', '', '', '', '', '', 1),
('8f241f110957fd356.02918645', 0, 'Dschibuti', 'DJ', 'DJI', '262', 9999, 'Rest Welt', '', 'Djibouti', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095811ea5.84717844', 0, 'Dominica', 'DM', 'DMA', '212', 9999, 'Rest Welt', '', 'Dominica', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095825bf2.61063355', 0, 'Dominikanische Republik', 'DO', 'DOM', '214', 9999, 'Rest Welt', '', 'Dominican Republic', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095839323.86755169', 0, 'Timor-Leste', 'TL', 'TLS', '626', 9999, 'Rest Welt', '', 'Timor-Leste', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109584d512.06663789', 0, 'Ecuador', 'EC', 'ECU', '218', 9999, 'Rest Welt', '', 'Ecuador', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095861fb7.55278256', 0, '�gypten', 'EG', 'EGY', '818', 9999, 'Welt', '', 'Egypt', '', '', 'World', '', '', '', '', '', 0),
('8f241f110958736a9.06061237', 0, 'El Salvador', 'SV', 'SLV', '222', 9999, 'Rest Welt', '', 'El Salvador', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109588d077.74284490', 0, '�quatorialguinea', 'GQ', 'GNQ', '226', 9999, 'Rest Welt', '', 'Equatorial Guinea', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110958a2216.38324531', 0, 'Eritrea', 'ER', 'ERI', '232', 9999, 'Rest Welt', '', 'Eritrea', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110958b69e4.93886171', 0, 'Estland', 'EE', 'EST', '233', 9999, 'Rest Europ�ische Union', '', 'Estonia', '', '', 'Rest of EU', '', '', '', '', '', 1),
('8f241f110958caf67.08982313', 0, '�thiopien', 'ET', 'ETH', '210', 9999, 'Rest Welt', '', 'Ethiopia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110958e2cc3.90770249', 0, 'Falklandinseln (Malwinen)', 'FK', 'FLK', '238', 9999, 'Rest Welt', '', 'Falkland Islands (Malvinas)', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110958f7ba4.96908065', 0, 'F�r�er', 'FO', 'FRO', '234', 9999, 'Rest Welt', '', 'Faroe Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109590d226.07938729', 0, 'Fidschi', 'FJ', 'FJI', '242', 9999, 'Rest Welt', '', 'Fiji', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109594fcb1.79441780', 0, 'Franz�sisch Guiana', 'GF', 'GUF', '254', 9999, 'Rest Welt', '', 'French Guiana', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110959636f5.71476354', 0, 'Franz�sisch-Polynesien', 'PF', 'PYF', '258', 9999, 'Rest Welt', '', 'French Polynesia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110959784a3.34264829', 0, 'Franz�sische S�dgebiete', 'TF', 'ATF', '260', 9999, 'Rest Welt', '', 'French Southern Territories', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095994cb6.59353392', 0, 'Gabun', 'GA', 'GAB', '266', 9999, 'Rest Welt', '', 'Gabon', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110959ace77.17379319', 0, 'Gambia', 'GM', 'GMB', '270', 9999, 'Rest Welt', '', 'Gambia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110959c2341.01830199', 0, 'Georgien', 'GE', 'GEO', '268', 9999, 'Rest Europa', '', 'Georgia', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f110959e96b3.05752152', 0, 'Ghana', 'GH', 'GHA', '288', 9999, 'Rest Welt', '', 'Ghana', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110959fdde0.68919405', 0, 'Gibraltar', 'GI', 'GIB', '292', 9999, 'Rest Welt', '', 'Gibraltar', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095a29f47.04102343', 0, 'Gr�nland', 'GL', 'GRL', '304', 9999, 'Europa', '', 'Greenland', '', '', 'Europe', '', '', '', '', '', 0),
('8f241f11095a3f195.88886789', 0, 'Grenada', 'GD', 'GRD', '308', 9999, 'Rest Welt', '', 'Grenada', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095a52578.45413493', 0, 'Guadeloupe', 'GP', 'GLP', '312', 9999, 'Rest Welt', '', 'Guadeloupe', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095a717b3.68126681', 0, 'Guam', 'GU', 'GUM', '316', 9999, 'Rest Welt', '', 'Guam', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095a870a5.42235635', 0, 'Guatemala', 'GT', 'GTM', '320', 9999, 'Rest Welt', '', 'Guatemala', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095a9bf82.19989557', 0, 'Guinea', 'GN', 'GIN', '324', 9999, 'Rest Welt', '', 'Guinea', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095ab2b56.83049280', 0, 'Guinea-Bissau', 'GW', 'GNB', '624', 9999, 'Rest Welt', '', 'Guinea-Bissau', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095ac9d30.56640429', 0, 'Guyana', 'GY', 'GUY', '328', 9999, 'Rest Welt', '', 'Guyana', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095aebb06.34405179', 0, 'Haiti', 'HT', 'HTI', '332', 9999, 'Rest Welt', '', 'Haiti', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095aff2c3.98054755', 0, 'Heard Insel und McDonald Inseln', 'HM', 'HMD', '334', 9999, 'Rest Welt', '', 'Heard Island And Mcdonald Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095b13f57.56022305', 0, 'Honduras', 'HN', 'HND', '340', 9999, 'Rest Welt', '', 'Honduras', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095b29021.49657118', 0, 'Hong Kong', 'HK', 'HKG', '344', 9999, 'Rest Welt', '', 'Hong Kong', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095b3e016.98213173', 0, 'Ungarn', 'HU', 'HUN', '348', 9999, 'Rest Europa', '', 'Hungary', '', '', 'Rest Europe', '', '', '', '', '', 1),
('8f241f11095b55846.26192602', 0, 'Island', 'IS', 'ISL', '352', 9999, 'Rest Europa', '', 'Iceland', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f11095b6bb86.01364904', 0, 'Indien', 'IN', 'IND', '356', 9999, 'Rest Welt', '', 'India', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095b80526.59927631', 0, 'Indonesien', 'ID', 'IDN', '360', 9999, 'Rest Welt', '', 'Indonesia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095b94476.05195832', 0, 'Iran', 'IR', 'IRN', '364', 9999, 'Welt', '', 'Iran', '', '', 'World', '', '', '', '', '', 0),
('8f241f11095bad5b2.42645724', 0, 'Irak', 'IQ', 'IRQ', '368', 9999, 'Welt', '', 'Iraq', '', '', 'World', '', '', '', '', '', 0),
('8f241f11095bd65e1.59459683', 0, 'Israel', 'IL', 'ISR', '376', 9999, 'Rest Europa', '', 'Israel', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f11095bfe834.63390185', 0, 'Jamaika', 'JM', 'JAM', '388', 9999, 'Rest Welt', '', 'Jamaica', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095c11d43.73419747', 0, 'Japan', 'JP', 'JPN', '392', 9999, 'Rest Welt', '', 'Japan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095c2b304.75906962', 0, 'Jordanien', 'JO', 'JOR', '400', 9999, 'Rest Welt', '', 'Jordan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095c3e2d1.36714463', 0, 'Kasachstan', 'KZ', 'KAZ', '398', 9999, 'Rest Europa', '', 'Kazakhstan', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f11095c5b8e8.66333679', 0, 'Kenia', 'KE', 'KEN', '404', 9999, 'Rest Welt', '', 'Kenya', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095c6e184.21450618', 0, 'Kiribati', 'KI', 'KIR', '296', 9999, 'Rest Welt', '', 'Kiribati', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095c87284.37982544', 0, 'Nordkorea', 'KP', 'PRK', '408', 9999, 'Rest Welt', '', 'North Korea', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095c9de64.01275726', 0, 'S�dkorea', 'KR', 'KOR', '410', 9999, 'Rest Welt', '', 'South Korea', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095cb1546.46652174', 0, 'Kuwait', 'KW', 'KWT', '414', 9999, 'Welt', '', 'Kuwait', '', '', 'World', '', '', '', '', '', 0),
('8f241f11095cc7ef5.28043767', 0, 'Kirgisistan', 'KG', 'KGZ', '417', 9999, 'Rest Welt', '', 'Kyrgyzstan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095cdccd5.96388808', 0, 'Laos', 'LA', 'LAO', '418', 9999, 'Rest Welt', '', 'Laos', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095cf2ea6.73925511', 0, 'Lettland', 'LV', 'LVA', '428', 9999, 'Rest Europ�ische Union', '', 'Latvia', '', '', 'Rest of EU', '', '', '', '', '', 1),
('8f241f11095d07d87.58986129', 0, 'Libanon', 'LB', 'LBN', '422', 9999, 'Welt', '', 'Lebanon', '', '', 'World', '', '', '', '', '', 0),
('8f241f11095d1c9b2.21548132', 0, 'Lesotho', 'LS', 'LSO', '426', 9999, 'Rest Welt', '', 'Lesotho', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095d2fd28.91858908', 0, 'Liberia', 'LR', 'LBR', '430', 9999, 'Welt', '', 'Liberia', '', '', 'World', '', '', '', '', '', 0),
('8f241f11095d46188.64679605', 0, 'Libyen', 'LY', 'LBY', '434', 9999, 'Rest Welt', '', 'Libya', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095d6ffa8.86593236', 0, 'Litauen', 'LT', 'LTU', '440', 9999, 'Rest Europ�ische Union', '', 'Lithuania', '', '', 'Rest of EU', '', '', '', '', '', 1),
('8f241f11095d9c1b2.13577033', 0, 'Macao', 'MO', 'MAC', '446', 9999, 'Rest Welt', '', 'Macao', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095db2291.58912887', 0, 'Mazedonien', 'MK', 'MKD', '807', 9999, 'Rest Europa', '', 'Macedonia', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f11095dccf17.06266806', 0, 'Madagaskar', 'MG', 'MDG', '450', 9999, 'Rest Welt', '', 'Madagascar', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095de2119.60795833', 0, 'Malawi', 'MW', 'MWI', '454', 9999, 'Rest Welt', '', 'Malawi', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095df78a8.44559506', 0, 'Malaysia', 'MY', 'MYS', '458', 9999, 'Rest Welt', '', 'Malaysia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095e0c6c9.43746477', 0, 'Malediven', 'MV', 'MDV', '462', 9999, 'Rest Welt', '', 'Maldives', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095e24006.17141715', 0, 'Mali', 'ML', 'MLI', '466', 9999, 'Rest Welt', '', 'Mali', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095e36eb3.69050509', 0, 'Malta', 'MT', 'MLT', '470', 9999, 'Rest Welt', '', 'Malta', '', '', 'Rest World', '', '', '', '', '', 1),
('8f241f11095e4e338.26817244', 0, 'Marshallinseln', 'MH', 'MHL', '584', 9999, 'Rest Welt', '', 'Marshall Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095e631e1.29476484', 0, 'Martinique', 'MQ', 'MTQ', '474', 9999, 'Rest Welt', '', 'Martinique', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095e7bff9.09518271', 0, 'Mauretanien', 'MR', 'MRT', '478', 9999, 'Rest Welt', '', 'Mauritania', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095e90a81.01156393', 0, 'Mauritius', 'MU', 'MUS', '480', 9999, 'Rest Welt', '', 'Mauritius', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095ea6249.81474246', 0, 'Mayotte', 'YT', 'MYT', '175', 9999, 'Rest Welt', '', 'Mayotte', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095ebf3a6.86388577', 0, 'Mexiko', 'MX', 'MEX', '484', 9999, 'Rest Welt', '', 'Mexico', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095ed4902.49276197', 0, 'Mikronesien, F�derierte Staaten von', 'FM', 'FSM', '583', 9999, 'Rest Welt', '', 'Micronesia, Federated States Of', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095ee9923.85175653', 0, 'Moldau', 'MD', 'MDA', '498', 9999, 'Rest Europa', '', 'Moldova', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f11095f00d65.30318330', 0, 'Monaco', 'MC', 'MCO', '492', 9999, 'Europa', '', 'Monaco', '', '', 'Europe', '', '', '', '', '', 0),
('8f241f11095f160c9.41059441', 0, 'Mongolei', 'MN', 'MNG', '496', 9999, 'Rest Welt', '', 'Mongolia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11095f314f5.05830324', 0, 'Montserrat', 'MS', 'MSR', '500', 9999, 'Rest Welt', '', 'Montserrat', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096006828.49285591', 0, 'Marokko', 'MA', 'MAR', '504', 9999, 'Welt', '', 'Morocco', '', '', 'World', '', '', '', '', '', 0),
('8f241f1109601b419.55269691', 0, 'Mosambik', 'MZ', 'MOZ', '508', 9999, 'Rest Welt', '', 'Mozambique', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096030af5.65449043', 0, 'Myanmar', 'MM', 'MMR', '104', 9999, 'Rest Welt', '', 'Myanmar', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096046575.31382060', 0, 'Namibia', 'NA', 'NAM', '516', 9999, 'Rest Welt', '', 'Namibia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109605b1f4.20574895', 0, 'Nauru', 'NR', 'NRU', '520', 9999, 'Rest Welt', '', 'Nauru', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109607a9e7.03486450', 0, 'Nepal', 'NP', 'NPL', '524', 9999, 'Rest Welt', '', 'Nepal', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110960aeb64.09757010', 0, 'Niederl�ndische Antillen', 'AN', 'ANT', '530', 9999, 'Rest Welt', '', 'Netherlands Antilles', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110960c3e97.21901471', 0, 'Neukaledonien', 'NC', 'NCL', '540', 9999, 'Rest Welt', '', 'New Caledonia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110960d8e58.96466103', 0, 'Neuseeland', 'NZ', 'NZL', '554', 9999, 'Rest Welt', '', 'New Zealand', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110960ec345.71805056', 0, 'Nicaragua', 'NI', 'NIC', '558', 9999, 'Rest Welt', '', 'Nicaragua', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096101a79.70513227', 0, 'Niger', 'NE', 'NER', '562', 9999, 'Rest Welt', '', 'Niger', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096116744.92008092', 0, 'Nigeria', 'NG', 'NGA', '566', 9999, 'Rest Welt', '', 'Nigeria', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109612dc68.63806992', 0, 'Niue', 'NU', 'NIU', '570', 9999, 'Rest Welt', '', 'Niue', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110961442c2.82573898', 0, 'Norfolkinsel', 'NF', 'NFK', '574', 9999, 'Rest Welt', '', 'Norfolk Island', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096162678.71164081', 0, 'N�rdliche Marianen', 'MP', 'MNP', '580', 9999, 'Rest Welt', '', 'Northern Mariana Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096176795.61257067', 0, 'Norwegen', 'NO', 'NOR', '578', 9999, 'Rest Europa', '', 'Norway', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f1109618d825.87661926', 0, 'Oman', 'OM', 'OMN', '512', 9999, 'Rest Welt', '', 'Oman', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110961a2401.59039740', 0, 'Pakistan', 'PK', 'PAK', '586', 9999, 'Rest Welt', '', 'Pakistan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110961b7729.14290490', 0, 'Palau', 'PW', 'PLW', '585', 9999, 'Rest Welt', '', 'Palau', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110961cc384.18166560', 0, 'Panama', 'PA', 'PAN', '591', 9999, 'Rest Welt', '', 'Panama', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110961e3538.78435307', 0, 'Papua-Neuguinea', 'PG', 'PNG', '598', 9999, 'Rest Welt', '', 'Papua New Guinea', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110961f9d61.52794273', 0, 'Paraguay', 'PY', 'PRY', '600', 9999, 'Rest Welt', '', 'Paraguay', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109620b245.16261506', 0, 'Peru', 'PE', 'PER', '604', 9999, 'Rest Welt', '', 'Peru', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109621faf8.40135556', 0, 'Philippinen', 'PH', 'PHL', '608', 9999, 'Rest Welt', '', 'Philippines', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096234d62.44125992', 0, 'Pitcairn', 'PN', 'PCN', '612', 9999, 'Rest Welt', '', 'Pitcairn', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109624d3f8.50953605', 0, 'Polen', 'PL', 'POL', '616', 9999, 'Europa', '', 'Poland', '', '', 'Europe', '', '', '', '', '', 1),
('8f241f11096279a22.50582479', 0, 'Puerto Rico', 'PR', 'PRI', '630', 9999, 'Rest Welt', '', 'Puerto Rico', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109628f903.51478291', 0, 'Katar', 'QA', 'QAT', '634', 9999, 'Rest Welt', '', 'Qatar', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110962a3ec5.65857240', 0, 'R�union', 'RE', 'REU', '638', 9999, 'Rest Welt', '', 'R�union', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110962c3007.60363573', 0, 'Rum�nien', 'RO', 'ROU', '642', 9999, 'Rest Europa', '', 'Romania', '', '', 'Rest Europe', '', '', '', '', '', 1),
('8f241f110962e40e6.75062153', 0, 'Russische F�deration', 'RU', 'RUS', '643', 9999, 'Rest Europa', '', 'Russian Federation', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f110962f8615.93666560', 0, 'Ruanda', 'RW', 'RWA', '646', 9999, 'Rest Welt', '', 'Rwanda', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110963177a7.49289900', 0, 'St. Kitts und Nevis', 'KN', 'KNA', '659', 9999, 'Rest Welt', '', 'Saint Kitts and Nevis', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109632fab4.68646740', 0, 'St. Lucia', 'LC', 'LCA', '662', 9999, 'Rest Welt', '', 'Saint Lucia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110963443c3.29598809', 0, 'St. Vincent und die Grenadinen', 'VC', 'VCT', '670', 9999, 'Rest Welt', '', 'Saint Vincent and The Grenadines', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096359986.06476221', 0, 'Samoa', 'WS', 'WSM', '882', 9999, 'Rest Welt', '', 'Samoa', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096375757.44126946', 0, 'San Marino', 'SM', 'SMR', '674', 9999, 'Europa', '', 'San Marino', '', '', 'Europe', '', '', '', '', '', 0),
('8f241f1109639b8c4.57484984', 0, 'Sao Tome und Principe', 'ST', 'STP', '678', 9999, 'Rest Welt', '', 'Sao Tome and Principe', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110963b9b20.41500709', 0, 'Saudi-Arabien', 'SA', 'SAU', '682', 9999, 'Welt', '', 'Saudi Arabia', '', '', 'World', '', '', '', '', '', 0),
('8f241f110963d9962.36307144', 0, 'Senegal', 'SN', 'SEN', '686', 9999, 'Rest Welt', '', 'Senegal', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110963f98d8.68428379', 0, 'Serbien', 'RS', 'SRB', '688', 9999, 'Rest Europa', '', 'Serbia', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f11096418496.77253079', 0, 'Seychellen', 'SC', 'SYC', '690', 9999, 'Rest Welt', '', 'Seychelles', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096436968.69551351', 0, 'Sierra Leone', 'SL', 'SLE', '694', 9999, 'Rest Welt', '', 'Sierra Leone', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096456a48.79608805', 0, 'Singapur', 'SG', 'SGP', '702', 9999, 'Rest Welt', '', 'Singapore', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109647a265.29938154', 0, 'Slowakei', 'SK', 'SVK', '703', 9999, 'Europa', '', 'Slovakia', '', '', 'Europe', '', '', '', '', '', 1),
('8f241f11096497149.85116254', 0, 'Slowenien', 'SI', 'SVN', '705', 9999, 'Rest Europa', '', 'Slovenia', '', '', 'Rest Europe', '', '', '', '', '', 1),
('8f241f110964b7bf9.49501835', 0, 'Salomonen', 'SB', 'SLB', '90', 9999, 'Rest Welt', '', 'Solomon Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110964d5f29.11398308', 0, 'Somalia', 'SO', 'SOM', '706', 9999, 'Rest Welt', '', 'Somalia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110964f2623.74976876', 0, 'S�dafrika', 'ZA', 'ZAF', '710', 9999, 'Rest Welt', '', 'South Africa', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096531330.03198083', 0, 'Sri Lanka', 'LK', 'LKA', '144', 9999, 'Rest Welt', '', 'Sri Lanka', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109654dca4.99466434', 0, 'Saint Helena', 'SH', 'SHN', '654', 9999, 'Rest Welt', '', 'Saint Helena', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109656cde9.10816078', 0, 'Saint Pierre und Miquelon', 'PM', 'SPM', '666', 9999, 'Rest Welt', '', 'Saint Pierre and Miquelon', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109658cbe5.08293991', 0, 'Sudan', 'SD', 'SDN', '736', 9999, 'Rest Welt', '', 'Sudan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110965c7347.75108681', 0, 'Suriname', 'SR', 'SUR', '740', 9999, 'Rest Welt', '', 'Suriname', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110965eb7b7.26149742', 0, 'Svalbard und Jan Mayen', 'SJ', 'SJM', '744', 9999, 'Rest Welt', '', 'Svalbard and Jan Mayen', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109660c113.62780718', 0, 'Swasiland', 'SZ', 'SWZ', '748', 9999, 'Rest Welt', '', 'Swaziland', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109666b7f3.81435898', 0, 'Syrien', 'SY', 'SYR', '760', 9999, 'Rest Welt', '', 'Syria', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096687ec7.58824735', 0, 'Republik China (Taiwan)', 'TW', 'TWN', '158', 9999, 'Rest Welt', '', 'Taiwan, Province of China', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110966a54d1.43798997', 0, 'Tadschikistan', 'TJ', 'TJK', '762', 9999, 'Rest Welt', '', 'Tajikistan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110966c3a75.68297960', 0, 'Tansania', 'TZ', 'TZA', '834', 9999, 'Rest Welt', '', 'Tanzania', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096707e08.60512709', 0, 'Thailand', 'TH', 'THA', '764', 9999, 'Rest Welt', '', 'Thailand', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110967241e1.34925220', 0, 'Togo', 'TG', 'TGO', '768', 9999, 'Rest Welt', '', 'Togo', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096742565.72138875', 0, 'Tokelau', 'TK', 'TKL', '772', 9999, 'Rest Welt', '', 'Tokelau', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096762b31.03069244', 0, 'Tonga', 'TO', 'TON', '776', 9999, 'Rest Welt', '', 'Tonga', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109677ed23.84886671', 0, 'Trinidad und Tobago', 'TT', 'TTO', '780', 9999, 'Rest Welt', '', 'Trinidad and Tobago', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109679d988.46004322', 0, 'Tunesien', 'TN', 'TUN', '788', 9999, 'Welt', '', 'Tunisia', '', '', 'World', '', '', '', '', '', 0),
('8f241f110967bba40.88233204', 0, 'T�rkei', 'TR', 'TUR', '792', 9999, 'Rest Europa', '', 'Turkey', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f110967d8f65.52699796', 0, 'Turkmenistan', 'TM', 'TKM', '795', 9999, 'Rest Welt', '', 'Turkmenistan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110967f73f8.13141492', 0, 'Turks- und Caicosinseln', 'TC', 'TCA', '796', 9999, 'Rest Welt', '', 'Turks and Caicos Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109680ec30.97426963', 0, 'Tuvalu', 'TV', 'TUV', '798', 9999, 'Rest Welt', '', 'Tuvalu', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096823019.47846368', 0, 'Uganda', 'UG', 'UGA', '800', 9999, 'Rest Welt', '', 'Uganda', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110968391d2.37199812', 0, 'Ukraine', 'UA', 'UKR', '804', 9999, 'Rest Europa', '', 'Ukraine', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f1109684bf15.63071279', 0, 'Vereinigte Arabische Emirate', 'AE', 'ARE', '784', 9999, 'Rest Welt', '', 'United Arab Emirates', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096877ac0.98748826', 1, 'Vereinigte Staaten von Amerika', 'US', 'USA', '840', 9999, 'Welt', '', 'United States', '', '', 'World', '', '', '', '', '', 0),
('8f241f11096894977.41239553', 0, 'United States Minor Outlying Islands', 'UM', 'UMI', '581', 9999, 'Rest Welt', '', 'United States Minor Outlying Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110968a7cc9.56710143', 0, 'Uruguay', 'UY', 'URY', '858', 9999, 'Rest Welt', '', 'Uruguay', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110968bec45.44161857', 0, 'Usbekistan', 'UZ', 'UZB', '860', 9999, 'Rest Welt', '', 'Uzbekistan', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110968d3f03.13630334', 0, 'Vanuatu', 'VU', 'VUT', '548', 9999, 'Rest Welt', '', 'Vanuatu', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110968ebc30.63792746', 0, 'Heiliger Stuhl (Vatikanstadt)', 'VA', 'VAT', '336', 9999, 'Europa', '', 'Holy See (Vatican City State)', '', '', 'Europe', '', '', '', '', '', 0),
('8f241f11096902d92.14742486', 0, 'Venezuela', 'VE', 'VEN', '862', 9999, 'Rest Welt', '', 'Venezuela', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096919d00.92534927', 0, 'Vietnam', 'VN', 'VNM', '704', 9999, 'Rest Welt', '', 'Viet Nam', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109692fc04.15216034', 0, 'Britische Jungferninseln', 'VG', 'VGB', '92', 9999, 'Rest Welt', '', 'Virgin Islands, British', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096944468.61956573', 0, 'Amerikanische Jungferninseln', 'VI', 'VIR', '850', 9999, 'Rest Welt', '', 'Virgin Islands, U.S.', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110969598c8.76966113', 0, 'Wallis und Futuna', 'WF', 'WLF', '876', 9999, 'Rest Welt', '', 'Wallis and Futuna', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109696e4e9.33006292', 0, 'Westsahara', 'EH', 'ESH', '732', 9999, 'Rest Welt', '', 'Western Sahara', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096982354.73448958', 0, 'Jemen', 'YE', 'YEM', '887', 9999, 'Rest Welt', '', 'Yemen', '', '', 'Rest World', '', '', '', '', '', 0),
('a7c40f632a0804ab5.18804099', 0, '�land Inseln', 'AX', 'ALA', '248', 9999, 'Rest Welt', '', '�land Islands', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110969c34a2.42564730', 0, 'Sambia', 'ZM', 'ZMB', '894', 9999, 'Rest Welt', '', 'Zambia', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110969da699.04185888', 0, 'Simbabwe', 'ZW', 'ZWE', '716', 9999, 'Rest Welt', '', 'Zimbabwe', '', '', 'Rest World', '', '', '', '', '', 0),
('56d308a822c18e106.3ba59048', 0, 'Montenegro', 'ME', 'MNE', '499', 9999, 'Rest Europa', '', 'Montenegro', '', '', 'Rest Europe', '', '', '', '', '', 0),
('8f241f1109575d708.20084199', 0, 'Kongo, Dem. Rep.', 'CD', 'COD', '180', 9999, 'Rest Welt', '', 'Congo, The Democratic Republic Of The', '', '', 'Rest World', '', '', '', '', '', 0),
('56d308a822c18e106.3ba59099', 0, 'Guernsey', 'GG', 'GGY', '831', 9999, 'Rest Welt', '', 'Guernsey', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096982354.73448999', 0, 'Isle of Man', 'IM', 'IMN', '833', 9999, 'Rest Welt', '', 'Isle Of Man', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f11096944468.61956599', 0, 'Jersey', 'JE', 'JEY', '832', 9999, 'Rest Welt', '', 'Jersey', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110968ebc30.63792799', 0, 'Pal�stinische Gebiete', 'PS', 'PSE', '275', 9999, 'Rest Welt', '', 'Palestinian Territory, Occupied', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f110968a7cc9.56710199', 0, 'Saint-Barth�lemy', 'BL', 'BLM', '652', 9999, 'Rest Welt', '', 'Saint Barth�lemy', '', '', 'Rest World', '', '', '', '', '', 0),
('a7c40f632f65bd8e2.84963299', 0, 'Saint-Martin', 'MF', 'MAF', '663', 9999, 'Rest Welt', '', 'Saint Martin', '', '', 'Rest World', '', '', '', '', '', 0),
('8f241f1109533b943.50287999', 0, 'S�dgeorgien und die S�dlichen Sandwichinseln', 'GS', 'SGS', '239', 9999, 'Rest Welt', '', 'South Georgia and The South Sandwich Islands', '', '', 'Rest World', '', '', '', '', '', 0);

#
# Table structure for table `oxdel2delset`
#

DROP TABLE IF EXISTS `oxdel2delset`;

CREATE TABLE `oxdel2delset` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXDELID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shipping cost rule id (oxdelivery)',
  `OXDELSETID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Delivery method id (oxdeliveryset)',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXDELID` (`OXDELID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between Shipping cost rules (oxdelivery) and delivery methods (oxdeliveryset)';

#
# Table structure for table `oxdelivery`
#

DROP TABLE IF EXISTS `oxdelivery`;

CREATE TABLE `oxdelivery` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Delivery shipping cost rule id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXACTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Active',
  `OXACTIVEFROM` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active from specified date',
  `OXACTIVETO` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active to specified date',
  `OXTITLE` varchar(255) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXTITLE_1` varchar(255) NOT NULL default '',
  `OXTITLE_2` varchar(255) NOT NULL default '',
  `OXTITLE_3` varchar(255) NOT NULL default '',
  `OXADDSUMTYPE` enum('%','abs') NOT NULL default 'abs' COMMENT 'Price Surcharge/Reduction type (abs|%)',
  `OXADDSUM` double NOT NULL default '0' COMMENT 'Price Surcharge/Reduction amount',
  `OXDELTYPE` enum('a','s','w','p') NOT NULL default 'a' COMMENT 'Condition type: a - Amount, s - Size, w - Weight, p - Price',
  `OXPARAM` double NOT NULL default '0' COMMENT 'Condition param from (e.g. amount from 1)',
  `OXPARAMEND` double NOT NULL default '0' COMMENT 'Condition param to (e.g. amount to 10)',
  `OXFIXED` tinyint(1) NOT NULL default '0' COMMENT 'Calculation Rules: 0 - Once per Cart, 1 - Once for each different product, 2 - For each product',
  `OXSORT` int(11) NOT NULL default '9999' COMMENT 'Order of Rules Processing',
  `OXFINALIZE` tinyint(1) NOT NULL default '0' COMMENT 'Do not run further rules if this rule is valid and is being run',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXSHOPID` (`OXSHOPID`)
)  ENGINE=MyISAM COMMENT 'Delivery shipping cost rules';

#
# Table structure for table `oxdeliveryset`
#

DROP TABLE IF EXISTS `oxdeliveryset`;

CREATE TABLE `oxdeliveryset` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Delivery method id',
  `OXSHOPID` int(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)',
  `OXACTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Active',
  `OXACTIVEFROM` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active from specified date',
  `OXACTIVETO` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active to specified date',
  `OXTITLE` varchar(255) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXTITLE_1` varchar(255) NOT NULL default '',
  `OXTITLE_2` varchar(255) NOT NULL default '',
  `OXTITLE_3` varchar(255) NOT NULL default '',
  `OXPOS` int(11) NOT NULL default '0' COMMENT 'Sorting',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Creation time',
  PRIMARY KEY  (`OXID`),
  KEY `OXSHOPID` (`OXSHOPID`)
) ENGINE=MyISAM COMMENT 'Delivery (shipping) methods';

#
# Data for table `oxdeliveryset`
#
INSERT INTO `oxdeliveryset` (`OXID`, `OXSHOPID`, `OXACTIVE`, `OXACTIVEFROM`, `OXACTIVETO`, `OXTITLE`, `OXTITLE_1`, `OXTITLE_2`, `OXTITLE_3`, `OXPOS`) VALUES
('oxidstandard', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'Standard', 'Standard', '', '', 10);

#
# Table structure for table `oxdiscount`
#

DROP TABLE IF EXISTS `oxdiscount`;

CREATE TABLE `oxdiscount` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Discount id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXACTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Active',
  `OXACTIVEFROM` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active from specified date',
  `OXACTIVETO` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active to specified date',
  `OXTITLE` varchar(128) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXTITLE_1` varchar( 128 ) NOT NULL,
  `OXTITLE_2` varchar( 128 ) NOT NULL,
  `OXTITLE_3` varchar( 128 ) NOT NULL,
  `OXAMOUNT` double NOT NULL default '0' COMMENT 'Valid from specified amount of articles',
  `OXAMOUNTTO` double NOT NULL default '999999' COMMENT 'Valid to specified amount of articles',
  `OXPRICETO` double NOT NULL default '999999' COMMENT 'Valid to specified purchase price',
  `OXPRICE` double NOT NULL default '0' COMMENT 'Valid from specified purchase price',
  `OXADDSUMTYPE` enum('%','abs','itm') NOT NULL default '%' COMMENT 'Discount type (%,abs,itm)',
  `OXADDSUM` double NOT NULL default '0' COMMENT 'Magnitude of the discount',
  `OXITMARTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Free article id, that will be added as a discount',
  `OXITMAMOUNT` double NOT NULL default '1' COMMENT 'The quantity of free article that will be added to basket with discounted article',
  `OXITMMULTIPLE` int(1) NOT NULL default '0' COMMENT 'Should free article amount be multiplied by discounted item quantity in basket',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXSHOPID` (`OXSHOPID`),
  KEY `OXACTIVE` (`OXACTIVE`),
  KEY `OXACTIVEFROM` (`OXACTIVEFROM`),
  KEY `OXACTIVETO` (`OXACTIVETO`)
) ENGINE=MyISAM COMMENT 'Article discounts';

#
# Table structure for table `oxfiles`
#

DROP TABLE IF EXISTS `oxfiles`;

CREATE TABLE IF NOT EXISTS `oxfiles` (
  `OXID` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'File id',
  `OXARTID` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Article id (oxarticles)',
  `OXFILENAME` varchar(128) NOT NULL COMMENT 'Filename',
  `OXSTOREHASH` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Hashed filename, used for file directory path creation',
  `OXPURCHASEDONLY` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Download is available only after purchase',
  `OXMAXDOWNLOADS` int(11) NOT NULL default '-1' COMMENT 'Maximum count of downloads after order',
  `OXMAXUNREGDOWNLOADS` int(11) NOT NULL default '-1' COMMENT 'Maximum count of downloads for not registered users after order',
  `OXLINKEXPTIME` int(11) NOT NULL default '-1' COMMENT 'Expiration time of download link in hours',
  `OXDOWNLOADEXPTIME` int(11) NOT NULL default '-1' COMMENT 'Expiration time of download link after the first download in hours',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Creation time',
  PRIMARY KEY (`OXID`),
  KEY `OXARTID` (`OXARTID`)
) ENGINE=MyISAM COMMENT 'Files available for users to download';

#
# Table structure for table `oxgbentries`
#

DROP TABLE IF EXISTS `oxgbentries`;

CREATE TABLE `oxgbentries` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Entry id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXCONTENT` text NOT NULL COMMENT 'Content',
  `OXCREATE` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Creation time',
  `OXACTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Is active',
  `OXVIEWED` tinyint(1) NOT NULL default '0' COMMENT 'Whether the entry was checked by admin',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY (`OXUSERID`)
) ENGINE=MyISAM COMMENT='Guestbook`s entries';

#
# Table structure for table `oxgroups`
#

DROP TABLE IF EXISTS `oxgroups`;

CREATE TABLE `oxgroups` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Group id',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Active',
  `OXTITLE` varchar(128) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXTITLE_1` varchar(128) NOT NULL default '',
  `OXTITLE_2` varchar(128) NOT NULL default '',
  `OXTITLE_3` varchar(128) NOT NULL default '',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXACTIVE` (`OXACTIVE`)
) ENGINE=MyISAM COMMENT 'User groups';

#
# Data for table `oxgroups`
#
INSERT INTO `oxgroups` (`OXID`, `OXACTIVE`, `OXTITLE`, `OXTITLE_1`, `OXTITLE_2`, `OXTITLE_3`) VALUES
('oxidblacklist', 1, 'Blacklist', 'Blacklist', '', ''),
('oxidsmallcust', 1, 'Geringer Umsatz', 'Less Turnover', '', ''),
('oxidmiddlecust', 1, 'Mittlerer Umsatz', 'Medium Turnover', '', ''),
('oxidgoodcust', 1, 'Grosser Umsatz', 'Huge Turnover', '', ''),
('oxidforeigncustomer', 1, 'Auslandskunde', 'Foreign Customer', '', ''),
('oxidnewcustomer', 1, 'Inlandskunde', 'Domestic Customer', '', ''),
('oxidpowershopper', 1, 'Powershopper', 'Powershopper', '', ''),
('oxiddealer', 1, 'H�ndler', 'Retailer', '', ''),
('oxidnewsletter', 1, 'Newsletter-Abonnenten', 'Newsletter Recipients', '', ''),
('oxidadmin', 1, 'Shop-Admin', 'Store Administrator', '', ''),
('oxidpriceb', 1, 'Preis B', 'Price B', '', ''),
('oxidpricea', 1, 'Preis A', 'Price A', '', ''),
('oxidpricec', 1, 'Preis C', 'Price C', '', ''),
('oxidblocked', 1, 'BLOCKED', 'BLOCKED', '', ''),
('oxidcustomer', 1, 'Kunde', 'Customer', '', ''),
('oxidnotyetordered', 1, 'Noch nicht gekauft', 'Not Yet Purchased', '', '');

#
# Table structure for table `oxinvitations`
# for storing information about invited users
# created 2010-01-06
#

DROP TABLE IF EXISTS `oxinvitations`;

CREATE TABLE IF NOT EXISTS `oxinvitations` (
   `OXUSERID` char(32) collate latin1_general_ci NOT NULL COMMENT 'User id (oxuser), who sent invitation',
   `OXDATE` date NOT NULL COMMENT 'Creation time',
   `OXEMAIL` varchar(255) collate latin1_general_ci NOT NULL COMMENT 'Recipient email',
   `OXPENDING` mediumint(9) NOT NULL COMMENT 'Has recipient user registered',
   `OXACCEPTED` mediumint(9) NOT NULL COMMENT 'Is recipient user accepted',
   `OXTYPE` tinyint(4) NOT NULL default '1' COMMENT 'Invitation type',
   `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
    KEY `OXUSERID` (`OXUSERID`),
    KEY `OXDATE` (`OXDATE`)
) ENGINE=MYISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT 'User sent invitations';

#
# Table structure for table `oxlinks`
#

DROP TABLE IF EXISTS `oxlinks`;

CREATE TABLE `oxlinks` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Link id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXACTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Active',
  `OXURL` varchar(255) NOT NULL default '' COMMENT 'Link url',
  `OXURLDESC` text NOT NULL COMMENT 'Description (multilanguage)',
  `OXURLDESC_1` text NOT NULL,
  `OXURLDESC_2` text NOT NULL,
  `OXURLDESC_3` text NOT NULL,
  `OXINSERT` datetime default NULL COMMENT 'Creation time (set by user)',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXSHOPID` (`OXSHOPID`),
  KEY `OXINSERT` (`OXINSERT`),
  KEY `OXACTIVE` (`OXACTIVE`)
) ENGINE=MyISAM COMMENT 'Links';

#
# Table structure for table `oxlogs`
#

DROP TABLE IF EXISTS `oxlogs`;

CREATE TABLE `oxlogs` (
  `OXTIME` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Creation time',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXSESSID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Session id',
  `OXCLASS` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Logged class name',
  `OXFNC` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Logged function name',
  `OXCNID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Active category id (oxcategories)',
  `OXANID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Active article id (oxarticles)',
  `OXPARAMETER` varchar(64) NOT NULL default '' COMMENT 'Template name or search param',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp'
) ENGINE=InnoDB COMMENT 'Stores logs from actions processing';

#
# Table structure for table `oxmanufacturers`
#

DROP TABLE IF EXISTS `oxmanufacturers`;

CREATE TABLE `oxmanufacturers` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Manufacturer id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Is active',
  `OXICON` char(128) NOT NULL default '' COMMENT 'Icon filename',
  `OXTITLE` char(255) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXSHORTDESC` char(255) NOT NULL default '' COMMENT 'Short description (multilanguage)',
  `OXTITLE_1` char(255) NOT NULL default '',
  `OXSHORTDESC_1` char(255) NOT NULL default '',
  `OXTITLE_2` char(255) NOT NULL default '',
  `OXSHORTDESC_2` char(255) NOT NULL default '',
  `OXTITLE_3` char(255) NOT NULL default '',
  `OXSHORTDESC_3` char(255) NOT NULL default '',
  `OXSHOWSUFFIX` tinyint(1) NOT NULL default '1' COMMENT 'Show SEO Suffix in Category',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`)
) ENGINE=MyISAM COMMENT 'Shop manufacturers';

#
# Table structure for table `oxmediaurls`
# For storing extended file urls
# Created 2008-06-25
#

DROP TABLE IF EXISTS `oxmediaurls`;

CREATE TABLE `oxmediaurls` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Media id',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Article id (oxarticles)',
  `OXURL` varchar(255) NOT NULL COMMENT 'Media url or filename',
  `OXDESC` varchar(255) NOT NULL COMMENT 'Description (multilanguage)',
  `OXDESC_1` varchar(255) NOT NULL,
  `OXDESC_2` varchar(255) NOT NULL,
  `OXDESC_3` varchar(255) NOT NULL,
  `OXISUPLOADED` int(1) NOT NULL default '0' COMMENT 'Is oxurl field used for filename or url',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
 PRIMARY KEY ( `OXID` ) ,
 INDEX ( `OXOBJECTID` )
) ENGINE = MYISAM COMMENT 'Stores objects media';

#
# Table structure for table `oxnews`
#

DROP TABLE IF EXISTS `oxnews`;

CREATE TABLE `oxnews` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'News id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Is active',
  `OXACTIVEFROM` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active from specified date',
  `OXACTIVETO` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Active to specified date',
  `OXDATE` date NOT NULL default '0000-00-00' COMMENT 'Creation date (entered by user)',
  `OXSHORTDESC` varchar(255) NOT NULL default '' COMMENT 'Short description (multilanguage)',
  `OXLONGDESC` text NOT NULL COMMENT 'Long description (multilanguage)',
  `OXACTIVE_1` tinyint(1) NOT NULL default '0',
  `OXSHORTDESC_1` varchar(255) NOT NULL default '',
  `OXLONGDESC_1` text NOT NULL,
  `OXACTIVE_2` tinyint(1) NOT NULL default '0',
  `OXSHORTDESC_2` varchar(255) NOT NULL default '',
  `OXLONGDESC_2` text NOT NULL,
  `OXACTIVE_3` tinyint(1) NOT NULL default '0',
  `OXSHORTDESC_3` varchar(255) NOT NULL default '',
  `OXLONGDESC_3` text NOT NULL,
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXSHOPID` (`OXSHOPID`),
  KEY `OXACTIVE` (`OXACTIVE`),
  KEY `OXACTIVEFROM` (`OXACTIVEFROM`),
  KEY `OXACTIVETO` (`OXACTIVETO`)
) ENGINE=MyISAM COMMENT 'Shop news';

#
# Table structure for table `oxnewsletter`
#

DROP TABLE IF EXISTS `oxnewsletter`;

CREATE TABLE `oxnewsletter` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Newsletter id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXTITLE` varchar(255) NOT NULL default '' COMMENT 'Title',
  `OXTEMPLATE` mediumtext NOT NULL COMMENT 'HTML template',
  `OXPLAINTEMPLATE` mediumtext NOT NULL COMMENT 'Plain template',
  `OXSUBJECT` varchar(255) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Subject',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`)
) ENGINE=MyISAM COMMENT 'Templates for sending newsletters';

#
# Table structure for table `oxnewssubscribed`
#

DROP TABLE IF EXISTS `oxnewssubscribed`;

CREATE TABLE `oxnewssubscribed` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Subscription id',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXSAL` char(64) NOT NULL default '' COMMENT 'User title prefix (Mr/Mrs)',
  `OXFNAME` char(128) NOT NULL default '' COMMENT 'First name',
  `OXLNAME` char(128) NOT NULL default '' COMMENT 'Last name',
  `OXEMAIL` char(128) NOT NULL default '' COMMENT 'Email',
  `OXDBOPTIN` tinyint(1) NOT NULL default '0' COMMENT 'Subscription status: 0 - not subscribed, 1 - subscribed, 2 - not confirmed',
  `OXEMAILFAILED` tinyint(1) NOT NULL default '0' COMMENT 'Subscription email sending status',
  `OXSUBSCRIBED` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Subscription date',
  `OXUNSUBSCRIBED` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Unsubscription date',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  UNIQUE KEY `OXEMAIL` (`OXEMAIL`),
  KEY `OXUSERID` (`OXUSERID`)
) ENGINE=MyISAM COMMENT 'User subscriptions';

#
# Data for table `oxnewssubscribed`
#
INSERT INTO `oxnewssubscribed` (`OXID`, `OXSHOPID`, `OXUSERID`, `OXSAL`, `OXFNAME`, `OXLNAME`, `OXEMAIL`, `OXDBOPTIN`, `OXEMAILFAILED`, `OXSUBSCRIBED`, `OXUNSUBSCRIBED`) VALUES
('0b742e66fd94c88b8.61001136', 0, 'oxdefaultadmin', 'MR', 'John', 'Doe', 'admin', 1, 0, '2005-07-26 19:16:09', '0000-00-00 00:00:00');

#
# Table structure for table `oxobject2action`
#

DROP TABLE IF EXISTS `oxobject2action`;

CREATE TABLE IF NOT EXISTS `oxobject2action` (
  `OXID` char(32) collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXACTIONID` char(32) collate latin1_general_ci NOT NULL default '' COMMENT 'Action id (oxactions)',
  `OXOBJECTID` char(32) collate latin1_general_ci NOT NULL default '' COMMENT 'Object id (table set by oxclass)',
  `OXCLASS` char(32) collate latin1_general_ci NOT NULL default '' COMMENT 'Object table name',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXOBJECTID` (`OXOBJECTID`),
  KEY `OXACTIONID` (`OXACTIONID`,`OXCLASS`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT 'Shows many-to-many relationship between actions (oxactions) and objects (table set by oxclass)';

#
# Table structure for table `oxobject2article`
#

DROP TABLE IF EXISTS `oxobject2article`;

CREATE TABLE `oxobject2article` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Cross-selling Article id (oxarticles)',
  `OXARTICLENID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Main Article id (oxarticles)',
  `OXSORT` int(5) NOT NULL default '0' COMMENT 'Sorting',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXARTICLENID` (`OXARTICLENID`),
  KEY `OXOBJECTID` (`OXOBJECTID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between cross-selling articles';

#
# Table structure for table `oxobject2attribute`
#

DROP TABLE IF EXISTS `oxobject2attribute`;

CREATE TABLE `oxobject2attribute` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXATTRID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Attribute id (oxattributes)',
  `OXVALUE` char(255) NOT NULL default '' COMMENT 'Attribute value (multilanguage)',
  `OXPOS` int(11) NOT NULL default '9999' COMMENT 'Sorting',
  `OXVALUE_1` char(255) NOT NULL default '',
  `OXVALUE_2` char(255) NOT NULL default '',
  `OXVALUE_3` char(255) NOT NULL default '',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXOBJECTID` (`OXOBJECTID`),
  KEY `OXATTRID` (`OXATTRID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between articles and attributes';

#
# Table structure for table `oxobject2category`
#

DROP TABLE IF EXISTS `oxobject2category`;

CREATE TABLE `oxobject2category` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXCATNID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Category id (oxcategory)',
  `OXPOS` int(11) NOT NULL default '0' COMMENT 'Sorting',
  `OXTIME` INT( 11 ) DEFAULT 0 NOT NULL COMMENT 'Creation time',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY ( `OXOBJECTID` ),
  KEY (`OXPOS`),
  KEY `OXMAINIDX` (`OXCATNID`,`OXOBJECTID`),
  KEY `OXTIME` (`OXTIME`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between articles and categories';

#
# Table structure for table `oxobject2delivery`
#

DROP TABLE IF EXISTS `oxobject2delivery`;

CREATE TABLE `oxobject2delivery` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXDELIVERYID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Delivery id (oxdelivery)',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Object id (table determined by oxtype)',
  `OXTYPE` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Record type',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXOBJECTID` (`OXOBJECTID`),
  KEY `OXDELIVERYID` ( `OXDELIVERYID` , `OXTYPE` )
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between delivery cost rules and objects (table determined by oxtype)';

#
# Table structure for table `oxobject2discount`
#

DROP TABLE IF EXISTS `oxobject2discount`;

CREATE TABLE `oxobject2discount` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXDISCOUNTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Discount id (oxdiscount)',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Object id (table determined by oxtype)',
  `OXTYPE` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Record type',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `oxobjectid` (`OXOBJECTID`),
  KEY `oxdiscidx` (`OXDISCOUNTID`,`OXTYPE`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between discounts and objects (table determined by oxtype)';

#
# Table structure for table `oxobject2group`
#

DROP TABLE IF EXISTS `oxobject2group`;

CREATE TABLE `oxobject2group` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id',
  `OXGROUPSID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Group id',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXOBJECTID` (`OXOBJECTID`),
  KEY `OXGROUPSID` (`OXGROUPSID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between users and groups';

INSERT INTO `oxobject2group` (`OXID`, `OXSHOPID`, `OXOBJECTID`, `OXGROUPSID`) VALUES
('e913fdd8443ed43e1.51222316', 0, 'oxdefaultadmin', 'oxidadmin');

#
# Table structure for table `oxobject2list`
#

DROP TABLE IF EXISTS `oxobject2list`;

CREATE TABLE `oxobject2list` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXLISTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Listmania id (oxrecommlists)',
  `OXDESC` text NOT NULL default '' COMMENT 'Description',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXOBJECTID` (`OXOBJECTID`),
  KEY `OXLISTID` (`OXLISTID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between articles and listmania lists';

#
# Table structure for table `oxobject2payment`
#

DROP TABLE IF EXISTS `oxobject2payment`;

CREATE TABLE `oxobject2payment` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXPAYMENTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Payment id (oxpayments)',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Object id (table determined by oxtype)',
  `OXTYPE` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Record type',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY ( `OXOBJECTID` ),
  KEY ( `OXPAYMENTID` )
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between payments and objects (table determined by oxtype)';

#
# Table structure for table `oxobject2selectlist`
#

DROP TABLE IF EXISTS `oxobject2selectlist`;

CREATE TABLE `oxobject2selectlist` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXSELNID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Selection list id (oxselectlist)',
  `OXSORT` int(5) NOT NULL default '0' COMMENT 'Sorting',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXOBJECTID` (`OXOBJECTID`),
  KEY `OXSELNID` (`OXSELNID`)
) ENGINE=MyISAM COMMENT 'Shows many-to-many relationship between articles and selection lists';

#
# Table structure for table `oxobject2seodata`
# For storing SEO meta data
# Created 2010-05-11
#

DROP TABLE IF EXISTS `oxobject2seodata`;

CREATE TABLE `oxobject2seodata` (
  `OXOBJECTID` CHAR( 32 ) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Objects id',
  `OXSHOPID` CHAR( 32 ) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXLANG` INT( 2 ) NOT NULL default '0' COMMENT 'Language id',
  `OXKEYWORDS` TEXT NOT NULL COMMENT 'Keywords',
  `OXDESCRIPTION` TEXT NOT NULL COMMENT 'Description',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY ( `OXOBJECTID` , `OXSHOPID` , `OXLANG` )
) ENGINE = MYISAM  COMMENT 'Seo entries';

#
# Table structure for table `oxorder`
#

DROP TABLE IF EXISTS `oxorder`;

CREATE TABLE `oxorder` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Order id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXORDERDATE` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Order date',
  `OXORDERNR` int(11) UNSIGNED NOT NULL default '0' COMMENT 'Order number',
  `OXBILLCOMPANY` varchar(255) NOT NULL default '' COMMENT 'Billing info: Company name',
  `OXBILLEMAIL` varchar(255) NOT NULL default '' COMMENT 'Billing info: Email',
  `OXBILLFNAME` varchar(255) NOT NULL default '' COMMENT 'Billing info: First name',
  `OXBILLLNAME` varchar(255) NOT NULL default '' COMMENT 'Billing info: Last name',
  `OXBILLSTREET` varchar(255) NOT NULL default '' COMMENT 'Billing info: Street name',
  `OXBILLSTREETNR` varchar(16) NOT NULL default '' COMMENT 'Billing info: House number',
  `OXBILLADDINFO` varchar(255) NOT NULL default '' COMMENT 'Billing info: Additional info',
  `OXBILLUSTID` varchar(255) NOT NULL default '' COMMENT 'Billing info: VAT ID No.',
  `OXBILLCITY` varchar(255) NOT NULL default '' COMMENT 'Billing info: City',
  `OXBILLCOUNTRYID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Billing info: Country id (oxcountry)',
  `OXBILLSTATEID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Billing info: US State id (oxstates)',
  `OXBILLZIP` varchar(16) NOT NULL default '' COMMENT 'Billing info: Zip code',
  `OXBILLFON` varchar(128) NOT NULL default '' COMMENT 'Billing info: Phone number',
  `OXBILLFAX` varchar(128) NOT NULL default '' COMMENT 'Billing info: Fax number',
  `OXBILLSAL` varchar(128) NOT NULL default '' COMMENT 'Billing info: User title prefix (Mr/Mrs)',
  `OXDELCOMPANY` varchar(255) NOT NULL default '' COMMENT 'Shipping info: Company name',
  `OXDELFNAME` varchar(255) NOT NULL default '' COMMENT 'Shipping info: First name',
  `OXDELLNAME` varchar(255) NOT NULL default '' COMMENT 'Shipping info: Last name',
  `OXDELSTREET` varchar(255) NOT NULL default '' COMMENT 'Shipping info: Street name',
  `OXDELSTREETNR` varchar(16) NOT NULL default '' COMMENT 'Shipping info: House number',
  `OXDELADDINFO` varchar(255) NOT NULL default '' COMMENT 'Shipping info: Additional info',
  `OXDELCITY` varchar(255) NOT NULL default '' COMMENT 'Shipping info: City',
  `OXDELCOUNTRYID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shipping info: Country id (oxcountry)',
  `OXDELSTATEID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shipping info: US State id (oxstates)',
  `OXDELZIP` varchar(16) NOT NULL default '' COMMENT 'Shipping info: Zip code',
  `OXDELFON` varchar(128) NOT NULL default '' COMMENT 'Shipping info: Phone number',
  `OXDELFAX` varchar(128) NOT NULL default '' COMMENT 'Shipping info: Fax number',
  `OXDELSAL` varchar(128) NOT NULL default '' COMMENT 'Shipping info: User title prefix (Mr/Mrs)',
  `OXPAYMENTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User payment id (oxuserpayments)',
  `OXPAYMENTTYPE` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Payment id (oxpayments)',
  `OXTOTALNETSUM` double NOT NULL default '0' COMMENT 'Total net sum',
  `OXTOTALBRUTSUM` double NOT NULL default '0' COMMENT 'Total brut sum',
  `OXTOTALORDERSUM` double NOT NULL default '0' COMMENT 'Total order sum',
  `OXARTVAT1` double NOT NULL default '0' COMMENT 'First VAT',
  `OXARTVATPRICE1` double NOT NULL default '0' COMMENT 'First calculated VAT price',
  `OXARTVAT2` double NOT NULL default '0' COMMENT 'Second VAT',
  `OXARTVATPRICE2` double NOT NULL default '0' COMMENT 'Second calculated VAT price',
  `OXDELCOST` double NOT NULL default '0' COMMENT 'Delivery price',
  `OXDELVAT` double NOT NULL default '0' COMMENT 'Delivery VAT',
  `OXPAYCOST` double NOT NULL default '0' COMMENT 'Payment cost',
  `OXPAYVAT` double NOT NULL default '0' COMMENT 'Payment VAT',
  `OXWRAPCOST` double NOT NULL default '0' COMMENT 'Wrapping cost',
  `OXWRAPVAT` double NOT NULL default '0' COMMENT 'Wrapping VAT',
  `OXGIFTCARDCOST` double NOT NULL default '0' COMMENT 'Giftcard cost',
  `OXGIFTCARDVAT` double NOT NULL default '0' COMMENT 'Giftcard VAT',
  `OXCARDID` varchar( 32 ) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Gift card id (oxwrapping)',
  `OXCARDTEXT` text NOT NULL COMMENT 'Gift card text',
  `OXDISCOUNT` double NOT NULL default '0' COMMENT 'Additional discount for order (abs)',
  `OXEXPORT` tinyint(4) NOT NULL default '0' COMMENT 'Is exported',
  `OXBILLNR` varchar(128) NOT NULL default '' COMMENT 'Invoice No.',
  `OXBILLDATE` date NOT NULL default '0000-00-00' COMMENT 'Invoice sent date',
  `OXTRACKCODE` varchar(128) NOT NULL default '' COMMENT 'Tracking code',
  `OXSENDDATE` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Order shipping date',
  `OXREMARK` text NOT NULL COMMENT 'User remarks',
  `OXVOUCHERDISCOUNT` double NOT NULL default '0' COMMENT 'Coupon (voucher) discount price',
  `OXCURRENCY` varchar(32) NOT NULL default '' COMMENT 'Currency',
  `OXCURRATE` double NOT NULL default '0' COMMENT 'Currency rate',
  `OXFOLDER` varchar(32) NOT NULL default '' COMMENT 'Folder: ORDERFOLDER_FINISHED, ORDERFOLDER_NEW, ORDERFOLDER_PROBLEMS',
  `OXTRANSID` varchar(64) NOT NULL default '' COMMENT 'Paypal: Transaction id',
  `OXPAYID` varchar(64) character set latin1 collate latin1_general_ci NOT NULL default '',
  `OXXID` varchar(64) NOT NULL default '',
  `OXPAID` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Time, when order was paid',
  `OXSTORNO` tinyint(1) NOT NULL default '0' COMMENT 'Order cancelled',
  `OXIP` varchar(39) NOT NULL default '' COMMENT 'User ip address',
  `OXTRANSSTATUS` varchar(30) NOT NULL default '' COMMENT 'Order status: NOT_FINISHED, OK, ERROR',
  `OXLANG` int(2) NOT NULL default '0' COMMENT 'Language id',
  `OXINVOICENR` int(11) NOT NULL default '0' COMMENT 'Invoice number',
  `OXDELTYPE` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Delivery id (oxdeliveryset)',
  `OXTSPROTECTID` char(64) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Trusted shop protection id',
  `OXTSPROTECTCOSTS` double NOT NULL default '0' COMMENT 'Trusted shop protection cost',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `OXISNETTOMODE` tinyint(1) UNSIGNED NOT NULL DEFAULT  '0' COMMENT 'Order created in netto mode',
  PRIMARY KEY  (`OXID`),
  KEY `MAINIDX` (`OXSHOPID`,`OXSTORNO`,`OXORDERDATE`)
) ENGINE=InnoDB COMMENT 'Shop orders information';

#
# Table structure for table `oxorderarticles`
#

DROP TABLE IF EXISTS `oxorderarticles`;

CREATE TABLE `oxorderarticles` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Order article id',
  `OXORDERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Order id (oxorder)',
  `OXAMOUNT` double NOT NULL default '0' COMMENT 'Amount',
  `OXARTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXARTNUM` varchar(255) NOT NULL default '' COMMENT 'Article number',
  `OXTITLE` varchar(255) NOT NULL default '' COMMENT 'Title',
  `OXSHORTDESC` varchar(255) NOT NULL default '' COMMENT 'Short description',
  `OXSELVARIANT` varchar(255) NOT NULL default '' COMMENT 'Selected variant',
  `OXNETPRICE` double NOT NULL default '0' COMMENT 'Full netto price (oxnprice * oxamount)',
  `OXBRUTPRICE` double NOT NULL default '0' COMMENT 'Full brutto price (oxbprice * oxamount)',
  `OXVATPRICE` double NOT NULL default '0' COMMENT 'Calculated VAT price',
  `OXVAT` double NOT NULL default '0' COMMENT 'VAT',
  `OXPERSPARAM` text NOT NULL COMMENT 'Serialized persistent parameters',
  `OXPRICE` double NOT NULL default '0' COMMENT 'Base price',
  `OXBPRICE` double NOT NULL default '0' COMMENT 'Brutto price for one item',
  `OXNPRICE` double NOT NULL default '0' COMMENT 'Netto price for one item',
  `OXWRAPID` varchar( 32 ) NOT NULL default '' COMMENT 'Wrapping id (oxwrapping)',
  `OXEXTURL` varchar(255) NOT NULL default '' COMMENT 'External URL to other information about the article',
  `OXURLDESC` varchar(255) NOT NULL default '' COMMENT 'Text for external URL',
  `OXURLIMG` varchar(128) NOT NULL default '' COMMENT 'External URL image',
  `OXTHUMB` varchar(128) NOT NULL default '' COMMENT 'Thumbnail filename',
  `OXPIC1` varchar(128) NOT NULL default '' COMMENT '1# Picture filename',
  `OXPIC2` varchar(128) NOT NULL default '' COMMENT '2# Picture filename',
  `OXPIC3` varchar(128) NOT NULL default '' COMMENT '3# Picture filename',
  `OXPIC4` varchar(128) NOT NULL default '' COMMENT '4# Picture filename',
  `OXPIC5` varchar(128) NOT NULL default '' COMMENT '5# Picture filename',
  `OXWEIGHT` double NOT NULL default '0' COMMENT 'Weight (kg)',
  `OXSTOCK` double NOT NULL default '-1' COMMENT 'Articles quantity in stock',
  `OXDELIVERY` date NOT NULL default '0000-00-00' COMMENT 'Date, when the product will be available again if it is sold out',
  `OXINSERT` date NOT NULL default '0000-00-00' COMMENT 'Creation time',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `OXLENGTH` double NOT NULL default '0' COMMENT 'Article dimensions: Length',
  `OXWIDTH` double NOT NULL default '0' COMMENT 'Article dimensions: Width',
  `OXHEIGHT` double NOT NULL default '0' COMMENT 'Article dimensions: Height',
  `OXFILE` varchar(128) NOT NULL default '' COMMENT 'File, shown in article media list',
  `OXSEARCHKEYS` varchar(255) NOT NULL default '' COMMENT 'Search terms',
  `OXTEMPLATE` varchar(128) NOT NULL default '' COMMENT 'Alternative template filename (use default, if empty)',
  `OXQUESTIONEMAIL` varchar(255) NOT NULL default '' COMMENT 'E-mail for question',
  `OXISSEARCH` tinyint(1) NOT NULL default '1' COMMENT 'Is article shown in search',
  `OXFOLDER` char(32) NOT NULL default '' COMMENT 'Folder: ORDERFOLDER_FINISHED, ORDERFOLDER_NEW, ORDERFOLDER_PROBLEMS',
  `OXSUBCLASS` char(32) NOT NULL default '' COMMENT 'Subclass',
  `OXSTORNO` tinyint(1) NOT NULL default '0' COMMENT 'Order cancelled',
  `OXORDERSHOPID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops), in which order was done',
  `OXISBUNDLE` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Bundled article',
  PRIMARY KEY  (`OXID`),
  KEY `OXORDERID` (`OXORDERID`),
  KEY `OXARTID` (`OXARTID`),
  KEY `OXARTNUM` (`OXARTNUM`)
) ENGINE=InnoDB COMMENT 'Ordered articles information';

#
# Table structure for table `oxorderfiles`
#

DROP TABLE IF EXISTS `oxorderfiles`;

CREATE TABLE IF NOT EXISTS `oxorderfiles` (
  `OXID` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Order file id',
  `OXORDERID` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Order id (oxorder)',
  `OXFILENAME` varchar(128) NOT NULL COMMENT 'Filename',
  `OXFILEID` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'File id (oxfiles)',
  `OXSHOPID` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Shop id (oxshops)',
  `OXORDERARTICLEID` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Ordered article id (oxorderarticles)',
  `OXFIRSTDOWNLOAD` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'First time downloaded time',
  `OXLASTDOWNLOAD` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Last time downloaded time',
  `OXDOWNLOADCOUNT` int(10) unsigned NOT NULL COMMENT 'Downloads count',
  `OXMAXDOWNLOADCOUNT` int(10) unsigned NOT NULL COMMENT 'Maximum count of downloads',
  `OXDOWNLOADEXPIRATIONTIME` int(10) unsigned NOT NULL COMMENT 'Download expiration time in hours',
  `OXLINKEXPIRATIONTIME` int(10) unsigned NOT NULL COMMENT 'Link expiration time in hours',
  `OXRESETCOUNT` int(10) unsigned NOT NULL COMMENT 'Count of resets',
  `OXVALIDUNTIL` datetime NOT NULL COMMENT 'Download is valid until time specified',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY (`OXID`),
  KEY `OXORDERID` (`OXORDERID`),
  KEY `OXFILEID` (`OXFILEID`),
  KEY `OXORDERARTICLEID` (`OXORDERARTICLEID`)
) ENGINE=InnoDB COMMENT 'Files, given to users to download after order';

#
# Table structure for table `oxpayments`
#

DROP TABLE IF EXISTS `oxpayments`;

CREATE TABLE `oxpayments` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Payment id',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Active',
  `OXDESC` varchar(128) NOT NULL default '' COMMENT 'Description (multilanguage)',
  `OXADDSUM` double NOT NULL default '0' COMMENT 'Price Surcharge/Reduction amount',
  `OXADDSUMTYPE` enum('abs','%') NOT NULL default 'abs' COMMENT 'Price Surcharge/Reduction type (abs|%)',
  `OXADDSUMRULES` int(11) NOT NULL default '0' COMMENT 'Base of price surcharge/reduction: 1 - Value of all goods in cart, 2 - Discounts, 4 - Vouchers, 8 - Shipping costs, 16 - Gift Wrapping/Greeting Card',
  `OXFROMBONI` int(11) NOT NULL default '0' COMMENT 'Minimal Credit Rating ',
  `OXFROMAMOUNT` double NOT NULL default '0' COMMENT 'Purchase Price: From',
  `OXTOAMOUNT` double NOT NULL default '0' COMMENT 'Purchase Price: To',
  `OXVALDESC` text NOT NULL COMMENT 'Payment additional fields, separated by "field1__@@field2" (multilanguage)',
  `OXCHECKED` tinyint(1) NOT NULL default '0' COMMENT 'Selected as the default method',
  `OXDESC_1` varchar(128) NOT NULL default '',
  `OXVALDESC_1` text NOT NULL,
  `OXDESC_2` varchar(128) NOT NULL default '',
  `OXVALDESC_2` text NOT NULL,
  `OXDESC_3` varchar(128) NOT NULL default '',
  `OXVALDESC_3` text NOT NULL,
  `OXLONGDESC` text NOT NULL default '' COMMENT 'Long description (multilanguage)',
  `OXLONGDESC_1` text NOT NULL default '',
  `OXLONGDESC_2` text NOT NULL default '',
  `OXLONGDESC_3` text NOT NULL default '',
  `OXSORT` int(5) NOT NULL default 0 COMMENT 'Sorting',
  `OXTSPAYMENTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Trusted shop payment id',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXACTIVE` (`OXACTIVE`)
) ENGINE=MyISAM COMMENT 'Payment methods';

#
# Data for table `oxpayments`
#
INSERT INTO `oxpayments` (`OXID`, `OXACTIVE`, `OXDESC`, `OXADDSUM`, `OXADDSUMTYPE`, `OXADDSUMRULES`, `OXFROMBONI`, `OXFROMAMOUNT`, `OXTOAMOUNT`, `OXVALDESC`, `OXCHECKED`, `OXDESC_1`, `OXVALDESC_1`, `OXDESC_2`, `OXVALDESC_2`, `OXDESC_3`, `OXVALDESC_3`, `OXLONGDESC`, `OXLONGDESC_1`, `OXLONGDESC_2`, `OXLONGDESC_3`, `OXSORT`, `OXTSPAYMENTID`) VALUES
('oxidcashondel', 1, 'Nachnahme', 7.5, 'abs', 0, 0, 0, 1000000, '', 1, 'COD (Cash on Delivery)', '', '', '', '', '', '', '', '', '', 0, ''),
('oxidcreditcard', 1, 'Kreditkarte', 20.9, 'abs', 0, 500, 0, 1000000, 'kktype__@@kknumber__@@kkmonth__@@kkyear__@@kkname__@@kkpruef__@@', 1, 'Credit Card', 'kktype__@@kknumber__@@kkmonth__@@kkyear__@@kkname__@@kkpruef__@@', '', '', '', '', 'Die Belastung Ihrer Kreditkarte erfolgt mit dem Abschluss der Bestellung.', 'Your Credit Card will be charged when you submit the order.', '', '', 0, ''),
('oxiddebitnote', 1, 'Bankeinzug/Lastschrift', 0, 'abs', 0, 0, 0, 1000000, 'lsbankname__@@lsblz__@@lsktonr__@@lsktoinhaber__@@', 0, 'Direct Debit', 'lsbankname__@@lsblz__@@lsktonr__@@lsktoinhaber__@@', '', '', '', '', 'Die Belastung Ihres Kontos erfolgt mit dem Versand der Ware.', 'Your bank account will be charged when the order is shipped.', '', '', 0, ''),
('oxidpayadvance', 1, 'Vorauskasse', 0, 'abs', 0, 0, 0, 1000000, '', 1, 'Cash in advance', '', '', '', '', '', '', '', '', '', 0, ''),
('oxidinvoice', 1, 'Rechnung', 0, 'abs', 0, 800, 0, 1000000, '', 0, 'Invoice', '', '', '', '', '', '', '', '', '', 0, ''),
('oxempty', 1, 'Empty', 0, 'abs', 0, 0, 0, 0, '', 0, 'Empty', '', '', '', '', '', 'for other countries', 'An example. Maybe for use with other countries', '', '', 0, '');

#
# Table structure for table `oxprice2article`
#

DROP TABLE IF EXISTS `oxprice2article`;

CREATE TABLE `oxprice2article` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXARTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXADDABS` double NOT NULL default '0' COMMENT 'Price, that will be used for specified article if basket amount is between oxamount and oxamountto',
  `OXADDPERC` double NOT NULL default '0' COMMENT 'Discount, that will be used for specified article if basket amount is between oxamount and oxamountto',
  `OXAMOUNT` double NOT NULL default '0' COMMENT 'Quantity: From',
  `OXAMOUNTTO` double NOT NULL default '0' COMMENT 'Quantity: To',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXSHOPID` (`OXSHOPID`),
 KEY `OXARTID` (`OXARTID`)
) ENGINE=MyISAM COMMENT 'Article scale prices';

#
# Table structure for table `oxpricealarm`
#

DROP TABLE IF EXISTS `oxpricealarm`;

CREATE TABLE `oxpricealarm` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Price alarm id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXEMAIL` varchar(128) NOT NULL default '' COMMENT 'Recipient email',
  `OXARTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXPRICE` double NOT NULL default '0' COMMENT 'Expected (user) price, when notification email should be sent',
  `OXCURRENCY` varchar(32) NOT NULL default '' COMMENT 'Currency',
  `OXLANG` INT(2) NOT NULL default 0 COMMENT 'Language id',
  `OXINSERT` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Creation time',
  `OXSENDED` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Time, when notification was sent',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY (`OXID`)
) ENGINE=MyISAM COMMENT 'Price fall alarm requests';

#
# Table structure for table `oxratings`
#

DROP TABLE IF EXISTS `oxratings`;

CREATE TABLE `oxratings` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Rating id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXTYPE` enum('oxarticle','oxrecommlist') NOT NULL COMMENT 'Rating type (oxarticle, oxrecommlist)',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article or Listmania id (oxarticles or oxrecommlists)',
  `OXRATING` int(1) NOT NULL default '0' COMMENT 'Rating',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `oxobjectsearch` (`OXTYPE`,`OXOBJECTID`)
) ENGINE=MyISAM COMMENT 'Articles and Listmania ratings';
#
# Table structure for table `oxrecommlists`
#

DROP TABLE IF EXISTS `oxrecommlists`;

CREATE TABLE `oxrecommlists` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Listmania id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXAUTHOR` varchar(255) NOT NULL default '' COMMENT 'Author first and last name',
  `OXTITLE` varchar(255) NOT NULL default '' COMMENT 'Title',
  `OXDESC` text NOT NULL COMMENT 'Description',
  `OXRATINGCNT` int(11) NOT NULL default '0' COMMENT 'Rating votes count',
  `OXRATING` double NOT NULL default '0' COMMENT 'Rating',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`)
) ENGINE=MyISAM COMMENT 'Listmania';

#
# Table structure for table `oxremark`
#

DROP TABLE IF EXISTS `oxremark`;

CREATE TABLE `oxremark` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXPARENTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXTYPE` enum('o','r','n','c') NOT NULL default 'r' COMMENT 'Record type: o - order, r - remark, n - nesletter, c - registration',
  `OXHEADER` varchar(255) NOT NULL default '' COMMENT 'Header (default: Creation time)',
  `OXTEXT` text NOT NULL COMMENT 'Remark text',
  `OXCREATE` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Creation time',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXPARENTID` (`OXPARENTID`),
  KEY `OXTYPE` (`OXTYPE`)
) ENGINE=MyISAM COMMENT 'User History';

#
# Table structure for table `oxreviews`
#

DROP TABLE IF EXISTS `oxreviews`;

CREATE TABLE `oxreviews` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Review id',
  `OXACTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Active',
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Article or Listmania id (oxarticles or oxrecommlist)',
  `OXTYPE` enum('oxarticle','oxrecommlist') NOT NULL COMMENT 'Review type (oxarticle, oxrecommlist)',
  `OXTEXT` text NOT NULL COMMENT 'Review text',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXCREATE` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Creation time',
  `OXLANG` tinyint( 3 ) NOT NULL DEFAULT '0' COMMENT 'Language id',
  `OXRATING` int(1) NOT NULL default '0' COMMENT 'Rating',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `oxobjectsearch` (`OXTYPE`,`OXOBJECTID`)
) ENGINE=MyISAM COMMENT 'Articles and Listmania reviews';

#
# Table structure for table `oxselectlist`
#

DROP TABLE IF EXISTS `oxselectlist`;

CREATE TABLE `oxselectlist` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Selection list id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXTITLE` varchar(254) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXIDENT` varchar(255) NOT NULL default '' COMMENT 'Working Title',
  `OXVALDESC` text NOT NULL COMMENT 'List fields, separated by "[field_name]!P![price]__@@[field_name]__@@" (multilanguage)',
  `OXTITLE_1` varchar(255) NOT NULL default '',
  `OXVALDESC_1` text NOT NULL,
  `OXTITLE_2` varchar(255) NOT NULL default '',
  `OXVALDESC_2` text NOT NULL,
  `OXTITLE_3` varchar(255) NOT NULL default '',
  `OXVALDESC_3` text NOT NULL,
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`)
) ENGINE=MyISAM COMMENT 'Selection lists';

#
# Table structure for table `oxseo`
# Created 2008.04.16
#

DROP TABLE IF EXISTS `oxseo`;

CREATE TABLE `oxseo` (
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Object id',
  `OXIDENT`    char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Hashed seo url (md5)',
  `OXSHOPID`   char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (multilanguage)',
  `OXLANG`     int(2) NOT NULL default 0 COMMENT 'Language id',
  `OXSTDURL`   varchar(2048) NOT NULL COMMENT 'Primary url, not seo encoded',
  `OXSEOURL`   varchar(2048) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL COMMENT 'Old seo url',
  `OXTYPE`     enum('static', 'oxarticle', 'oxcategory', 'oxvendor', 'oxcontent', 'dynamic', 'oxmanufacturer') NOT NULL COMMENT 'Record type',
  `OXFIXED`    TINYINT(1) NOT NULL default 0 COMMENT 'Fixed',
  `OXEXPIRED` tinyint(1) NOT NULL default '0' COMMENT 'Expired',
  `OXPARAMS` char(32) NOT NULL default '' COMMENT 'Params',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
   PRIMARY KEY (`OXIDENT`, `OXSHOPID`, `OXLANG`),
   UNIQUE KEY search (`OXTYPE`, `OXOBJECTID`, `OXSHOPID`, `OXLANG`,`OXPARAMS`),
   KEY `OXOBJECTID` (`OXLANG`,`OXOBJECTID`,`OXSHOPID`),
   KEY `SEARCHSTD` (OXSTDURL(100),`OXSHOPID`),
   KEY `SEARCHSEO` (OXSEOURL(100))
) ENGINE=InnoDB COMMENT 'Seo urls information';

#
# Table structure for table `oxseohistory`
# For tracking old SEO urls
# Created 2008-05-21
#

DROP TABLE IF EXISTS `oxseohistory`;

CREATE TABLE `oxseohistory` (
  `OXOBJECTID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Object id',
  `OXIDENT` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Hashed url (md5)',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id oxshops',
  `OXLANG` int(2) NOT NULL default '0' COMMENT 'Language id',
  `OXHITS` bigint(20) NOT NULL default '0' COMMENT 'Hits',
  `OXINSERT` timestamp NULL default NULL COMMENT 'Creation time',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXIDENT`,`OXSHOPID`,`OXLANG`),
  KEY `search` (`OXOBJECTID`,`OXSHOPID`,`OXLANG`)
) ENGINE=InnoDB COMMENT 'Seo urls history. If url does not exists in oxseo, then checks here and redirects';

#
# Table structure for table `oxseologs`
# For tracking untranslatable to SEO format non SEO urls
# Created 2008-10-21
#

DROP TABLE IF EXISTS `oxseologs`;

CREATE TABLE IF NOT EXISTS `oxseologs` (
  `OXSTDURL` text NOT NULL COMMENT 'Primary url, not seo encoded',
  `OXIDENT` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Hashed seo url',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXLANG` int(11) NOT NULL COMMENT 'Language id',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXIDENT`,`OXSHOPID`,`OXLANG`)
) ENGINE=InnoDB COMMENT 'Seo logging. Logs bad requests';

#
# Table structure for table `oxshops`
#

DROP TABLE IF EXISTS `oxshops`;

CREATE TABLE `oxshops` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Shop id',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Active',
  `OXPRODUCTIVE` tinyint(1) NOT NULL default '0' COMMENT 'Productive Mode (if 0, debug info displayed)',
  `OXDEFCURRENCY` char(32) NOT NULL default '' COMMENT 'Default currency',
  `OXDEFLANGUAGE` int(11) NOT NULL default '0' COMMENT 'Default language id',
  `OXNAME` varchar(255) NOT NULL default '' COMMENT 'Shop name',
  `OXTITLEPREFIX` varchar(255) NOT NULL default '' COMMENT 'Seo title prefix (multilanguage)',
  `OXTITLEPREFIX_1` varchar(255) NOT NULL default '',
  `OXTITLEPREFIX_2` varchar(255) NOT NULL default '',
  `OXTITLEPREFIX_3` varchar(255) NOT NULL default '',
  `OXTITLESUFFIX` varchar(255) NOT NULL default '' COMMENT 'Seo title suffix (multilanguage)',
  `OXTITLESUFFIX_1` varchar(255) NOT NULL default '',
  `OXTITLESUFFIX_2` varchar(255) NOT NULL default '',
  `OXTITLESUFFIX_3` varchar(255) NOT NULL default '',
  `OXSTARTTITLE` varchar(255) NOT NULL default '' COMMENT 'Start page title (multilanguage)',
  `OXSTARTTITLE_1` varchar(255) NOT NULL default '',
  `OXSTARTTITLE_2` varchar(255) NOT NULL default '',
  `OXSTARTTITLE_3` varchar(255) NOT NULL default '',
  `OXINFOEMAIL` varchar(255) NOT NULL default '' COMMENT 'Informational email address',
  `OXORDEREMAIL` varchar(255) NOT NULL default '' COMMENT 'Order email address',
  `OXOWNEREMAIL` varchar(255) NOT NULL default '' COMMENT 'Owner email address',
  `OXORDERSUBJECT` varchar(255) NOT NULL default '' COMMENT 'Order email subject (multilanguage)',
  `OXREGISTERSUBJECT` varchar(255) NOT NULL default '' COMMENT 'Registration email subject (multilanguage)',
  `OXFORGOTPWDSUBJECT` varchar(255) NOT NULL default '' COMMENT 'Forgot password email subject (multilanguage)',
  `OXSENDEDNOWSUBJECT` varchar(255) NOT NULL default '' COMMENT 'Order sent email subject (multilanguage)',
  `OXORDERSUBJECT_1` varchar(255) NOT NULL default '',
  `OXREGISTERSUBJECT_1` varchar(255) NOT NULL default '',
  `OXFORGOTPWDSUBJECT_1` varchar(255) NOT NULL default '',
  `OXSENDEDNOWSUBJECT_1` varchar(255) NOT NULL default '',
  `OXORDERSUBJECT_2` varchar(255) NOT NULL default '',
  `OXREGISTERSUBJECT_2` varchar(255) NOT NULL default '',
  `OXFORGOTPWDSUBJECT_2` varchar(255) NOT NULL default '',
  `OXSENDEDNOWSUBJECT_2` varchar(255) NOT NULL default '',
  `OXORDERSUBJECT_3` varchar(255) NOT NULL default '',
  `OXREGISTERSUBJECT_3` varchar(255) NOT NULL default '',
  `OXFORGOTPWDSUBJECT_3` varchar(255) NOT NULL default '',
  `OXSENDEDNOWSUBJECT_3` varchar(255) NOT NULL default '',
  `OXSMTP` varchar(255) NOT NULL default '' COMMENT 'SMTP server',
  `OXSMTPUSER` varchar(128) NOT NULL default '' COMMENT 'SMTP user',
  `OXSMTPPWD` varchar(128) NOT NULL default '' COMMENT 'SMTP password',
  `OXCOMPANY` varchar(128) NOT NULL default '' COMMENT 'Your company',
  `OXSTREET` varchar(255) NOT NULL default '' COMMENT 'Street',
  `OXZIP` varchar(255) NOT NULL default '' COMMENT 'ZIP code',
  `OXCITY` varchar(255) NOT NULL default '' COMMENT 'City',
  `OXCOUNTRY` varchar(255) NOT NULL default '' COMMENT 'Country',
  `OXBANKNAME` varchar(255) NOT NULL default '' COMMENT 'Bank name',
  `OXBANKNUMBER` varchar(255) NOT NULL default '' COMMENT 'Account Number',
  `OXBANKCODE` varchar(255) NOT NULL default '' COMMENT 'Routing Number',
  `OXVATNUMBER` varchar(255) NOT NULL default '' COMMENT 'Sales Tax ID',
  `OXBICCODE` varchar(255) NOT NULL default '' COMMENT 'Bank BIC',
  `OXIBANNUMBER` varchar(255) NOT NULL default '' COMMENT 'Bank IBAN',
  `OXFNAME` varchar(255) NOT NULL default '' COMMENT 'First name',
  `OXLNAME` varchar(255) NOT NULL default '' COMMENT 'Last name',
  `OXTELEFON` varchar(255) NOT NULL default '' COMMENT 'Phone number',
  `OXTELEFAX` varchar(255) NOT NULL default '' COMMENT 'Fax number',
  `OXURL` varchar(255) NOT NULL default '' COMMENT 'Shop url',
  `OXDEFCAT` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Default category id',
  `OXHRBNR` varchar(64) NOT NULL default '' COMMENT 'CBR',
  `OXCOURT` varchar(128) NOT NULL default '' COMMENT 'District Court',
  `OXADBUTLERID` varchar(64) NOT NULL default '' COMMENT 'Adbutler code (belboon.de) - deprecated',
  `OXAFFILINETID` varchar(64) NOT NULL default '' COMMENT 'Affilinet code (webmasterplan.com) - deprecated',
  `OXSUPERCLICKSID` varchar(64) NOT NULL default '' COMMENT 'Superclix code (superclix.de) - deprecated',
  `OXAFFILIWELTID` varchar(64) NOT NULL default '' COMMENT 'Affiliwelt code (affiliwelt.net) - deprecated',
  `OXAFFILI24ID` varchar(64) NOT NULL default '' COMMENT 'Affili24 code (affili24.com) - deprecated',
  `OXEDITION` CHAR( 2 ) NOT NULL COMMENT 'Shop Edition (CE,PE,EE)',
  `OXVERSION` CHAR( 16 ) NOT NULL COMMENT 'Shop Version',
  `OXSEOACTIVE` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Seo active (multilanguage)',
  `OXSEOACTIVE_1` tinyint(1) NOT NULL DEFAULT '1',
  `OXSEOACTIVE_2` tinyint(1) NOT NULL DEFAULT '1',
  `OXSEOACTIVE_3` tinyint(1) NOT NULL DEFAULT '1',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXACTIVE` (`OXACTIVE`)
) ENGINE=MyISAM COMMENT 'Shop config';

#
# Data for table `oxshops`
#
INSERT INTO `oxshops` (`OXID`, `OXACTIVE`, `OXPRODUCTIVE`, `OXDEFCURRENCY`, `OXDEFLANGUAGE`, `OXNAME`, `OXTITLEPREFIX`, `OXTITLEPREFIX_1`, `OXTITLEPREFIX_2`, `OXTITLEPREFIX_3`, `OXTITLESUFFIX`, `OXTITLESUFFIX_1`, `OXTITLESUFFIX_2`, `OXTITLESUFFIX_3`, `OXSTARTTITLE`, `OXSTARTTITLE_1`, `OXSTARTTITLE_2`, `OXSTARTTITLE_3`, `OXINFOEMAIL`, `OXORDEREMAIL`, `OXOWNEREMAIL`, `OXORDERSUBJECT`, `OXREGISTERSUBJECT`, `OXFORGOTPWDSUBJECT`, `OXSENDEDNOWSUBJECT`, `OXORDERSUBJECT_1`, `OXREGISTERSUBJECT_1`, `OXFORGOTPWDSUBJECT_1`, `OXSENDEDNOWSUBJECT_1`, `OXORDERSUBJECT_2`, `OXREGISTERSUBJECT_2`, `OXFORGOTPWDSUBJECT_2`, `OXSENDEDNOWSUBJECT_2`, `OXORDERSUBJECT_3`, `OXREGISTERSUBJECT_3`, `OXFORGOTPWDSUBJECT_3`, `OXSENDEDNOWSUBJECT_3`, `OXSMTP`, `OXSMTPUSER`, `OXSMTPPWD`, `OXCOMPANY`, `OXSTREET`, `OXZIP`, `OXCITY`, `OXCOUNTRY`, `OXBANKNAME`, `OXBANKNUMBER`, `OXBANKCODE`, `OXVATNUMBER`, `OXBICCODE`, `OXIBANNUMBER`, `OXFNAME`, `OXLNAME`, `OXTELEFON`, `OXTELEFAX`, `OXURL`, `OXDEFCAT`, `OXHRBNR`, `OXCOURT`, `OXADBUTLERID`, `OXAFFILINETID`, `OXSUPERCLICKSID`, `OXAFFILIWELTID`, `OXAFFILI24ID`, `OXEDITION`, `OXVERSION`, `OXSEOACTIVE`, `OXSEOACTIVE_1`, `OXSEOACTIVE_2`, `OXSEOACTIVE_3`) VALUES
(0, 1, 0, '', 0, 'OXID eShop 4', 'OXID eShop 4', 'OXID eShop 4', '', '', 'online kaufen', 'purchase online', '', '', 'Der Onlineshop', 'Online Shop', '', '', 'info@myoxideshop.com', 'reply@myoxideshop.com', 'order@myoxideshop.com', 'Ihre Bestellung bei OXID eSales', 'Vielen Dank f�r Ihre Registrierung im OXID eShop', 'Ihr Passwort im OXID eShop', 'Ihre OXID eSales Bestellung wurde versandt', 'Your order at OXID eShop', 'Thank you for your registration at OXID eShop', 'Your OXID eShop password', 'Your OXID eSales Order has been shipped', '', '', '', '', '', '', '', '', '', '', '', 'Your Company Name', '2425 Maple Street', '9041', 'Any City, CA', 'United States', 'Bank of America', '1234567890', '900 1234567', '', '', '', 'John', 'Doe', '217-8918712', '217-8918713', 'www.myoxideshop.com', '', '', '', '', '', '', '', '', 'CE', '4.8.4', 1, 1, 0, 0);

#
# Table structure for table `oxstates`
# for storing extended file urls
# created 2010-01-06
#

DROP TABLE IF EXISTS `oxstates`;

CREATE TABLE `oxstates` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'State id',
  `OXCOUNTRYID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Country id (oxcountry)',
  `OXTITLE` char(128) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXISOALPHA2` char(2) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'SEO short name',
  `OXTITLE_1` char(128) NOT NULL default '',
  `OXTITLE_2` char(128) NOT NULL default '',
  `OXTITLE_3` char(128) NOT NULL default '',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY(`OXCOUNTRYID`)
) ENGINE = MYISAM COMMENT 'US States list';

#
# Data for table `oxstates`
#
INSERT INTO `oxstates` (`OXID`, `OXCOUNTRYID`, `OXTITLE`, `OXISOALPHA2`, `OXTITLE_1`, `OXTITLE_2`, `OXTITLE_3`) VALUES
('AB', '8f241f11095649d18.02676059', 'Alberta', 'AB', 'Alberta', '', ''),
('BC', '8f241f11095649d18.02676059', 'Britisch-Kolumbien', 'BC', 'British Columbia', '', ''),
('MB', '8f241f11095649d18.02676059', 'Manitoba', 'MB', 'Manitoba', '', ''),
('NB', '8f241f11095649d18.02676059', 'Neubraunschweig', 'NB', 'New Brunswick', '', ''),
('NF', '8f241f11095649d18.02676059', 'Neufundland und Labrador', 'NF', 'Newfoundland and Labrador', '', ''),
('NT', '8f241f11095649d18.02676059', 'Nordwest-Territorien', 'NT', 'Northwest Territories', '', ''),
('NS', '8f241f11095649d18.02676059', 'Nova Scotia', 'NS', 'Nova Scotia', '', ''),
('NU', '8f241f11095649d18.02676059', 'Nunavut', 'NU', 'Nunavut', '', ''),
('ON', '8f241f11095649d18.02676059', 'Ontario', 'ON', 'Ontario', '', ''),
('PE', '8f241f11095649d18.02676059', 'Prince Edward Island', 'PE', 'Prince Edward Island', '', ''),
('QC', '8f241f11095649d18.02676059', 'Quebec', 'QC', 'Quebec', '', ''),
('SK', '8f241f11095649d18.02676059', 'Saskatchewan', 'SK', 'Saskatchewan', '', ''),
('YK', '8f241f11095649d18.02676059', 'Yukon', 'YK', 'Yukon', '', ''),
('AL', '8f241f11096877ac0.98748826', 'Alabama', 'AL', 'Alabama', '', ''),
('AK', '8f241f11096877ac0.98748826', 'Alaska', 'AK', 'Alaska', '', ''),
('AS', '8f241f11096877ac0.98748826', 'Amerikanisch-Samoa', 'AS', 'American Samoa', '', ''),
('AZ', '8f241f11096877ac0.98748826', 'Arizona', 'AZ', 'Arizona', '', ''),
('AR', '8f241f11096877ac0.98748826', 'Arkansas', 'AR', 'Arkansas', '', ''),
('CA', '8f241f11096877ac0.98748826', 'Kalifornien', 'CA', 'California', '', ''),
('CO', '8f241f11096877ac0.98748826', 'Colorado', 'CO', 'Colorado', '', ''),
('CT', '8f241f11096877ac0.98748826', 'Connecticut', 'CT', 'Connecticut', '', ''),
('DE', '8f241f11096877ac0.98748826', 'Delaware', 'DE', 'Delaware', '', ''),
('DC', '8f241f11096877ac0.98748826', 'District of Columbia', 'DC', 'District of Columbia', '', ''),
('FM', '8f241f11096877ac0.98748826', 'F�derierten Staaten von Mikronesien', 'FM', 'Federated States of Micronesia', '', ''),
('FL', '8f241f11096877ac0.98748826', 'Florida', 'FL', 'Florida', '', ''),
('GA', '8f241f11096877ac0.98748826', 'Georgia', 'GA', 'Georgia', '', ''),
('GU', '8f241f11096877ac0.98748826', 'Guam', 'GU', 'Guam', '', ''),
('HI', '8f241f11096877ac0.98748826', 'Hawaii', 'HI', 'Hawaii', '', ''),
('ID', '8f241f11096877ac0.98748826', 'Idaho', 'ID', 'Idaho', '', ''),
('IL', '8f241f11096877ac0.98748826', 'Illinois', 'IL', 'Illinois', '', ''),
('IN', '8f241f11096877ac0.98748826', 'Indiana', 'IN', 'Indiana', '', ''),
('IA', '8f241f11096877ac0.98748826', 'Iowa', 'IA', 'Iowa', '', ''),
('KS', '8f241f11096877ac0.98748826', 'Kansas', 'KS', 'Kansas', '', ''),
('KY', '8f241f11096877ac0.98748826', 'Kentucky', 'KY', 'Kentucky', '', ''),
('LA', '8f241f11096877ac0.98748826', 'Louisiana', 'LA', 'Louisiana', '', ''),
('ME', '8f241f11096877ac0.98748826', 'Maine', 'ME', 'Maine', '', ''),
('MH', '8f241f11096877ac0.98748826', 'Marshallinseln', 'MH', 'Marshall Islands', '', ''),
('MD', '8f241f11096877ac0.98748826', 'Maryland', 'MD', 'Maryland', '', ''),
('MA', '8f241f11096877ac0.98748826', 'Massachusetts', 'MA', 'Massachusetts', '', ''),
('MI', '8f241f11096877ac0.98748826', 'Michigan', 'MI', 'Michigan', '', ''),
('MN', '8f241f11096877ac0.98748826', 'Minnesota', 'MN', 'Minnesota', '', ''),
('MS', '8f241f11096877ac0.98748826', 'Mississippi', 'MS', 'Mississippi', '', ''),
('MO', '8f241f11096877ac0.98748826', 'Missouri', 'MO', 'Missouri', '', ''),
('MT', '8f241f11096877ac0.98748826', 'Montana', 'MT', 'Montana', '', ''),
('NE', '8f241f11096877ac0.98748826', 'Nebraska', 'NE', 'Nebraska', '', ''),
('NV', '8f241f11096877ac0.98748826', 'Nevada', 'NV', 'Nevada', '', ''),
('NH', '8f241f11096877ac0.98748826', 'New Hampshire', 'NH', 'New Hampshire', '', ''),
('NJ', '8f241f11096877ac0.98748826', 'New Jersey', 'NJ', 'New Jersey', '', ''),
('NM', '8f241f11096877ac0.98748826', 'Neumexiko', 'NM', 'New Mexico', '', ''),
('NY', '8f241f11096877ac0.98748826', 'New York', 'NY', 'New York', '', ''),
('NC', '8f241f11096877ac0.98748826', 'North Carolina', 'NC', 'North Carolina', '', ''),
('ND', '8f241f11096877ac0.98748826', 'North Dakota', 'ND', 'North Dakota', '', ''),
('MP', '8f241f11096877ac0.98748826', 'N�rdlichen Marianen', 'MP', 'Northern Mariana Islands', '', ''),
('OH', '8f241f11096877ac0.98748826', 'Ohio', 'OH', 'Ohio', '', ''),
('OK', '8f241f11096877ac0.98748826', 'Oklahoma', 'OK', 'Oklahoma', '', ''),
('OR', '8f241f11096877ac0.98748826', 'Oregon', 'OR', 'Oregon', '', ''),
('PW', '8f241f11096877ac0.98748826', 'Palau', 'PW', 'Palau', '', ''),
('PA', '8f241f11096877ac0.98748826', 'Pennsylvania', 'PA', 'Pennsylvania', '', ''),
('PR', '8f241f11096877ac0.98748826', 'Puerto Rico', 'PR', 'Puerto Rico', '', ''),
('RI', '8f241f11096877ac0.98748826', 'Rhode Island', 'RI', 'Rhode Island', '', ''),
('SC', '8f241f11096877ac0.98748826', 'S�dkarolina', 'SC', 'South Carolina', '', ''),
('SD', '8f241f11096877ac0.98748826', 'S�ddakota', 'SD', 'South Dakota', '', ''),
('TN', '8f241f11096877ac0.98748826', 'Tennessee', 'TN', 'Tennessee', '', ''),
('TX', '8f241f11096877ac0.98748826', 'Texas', 'TX', 'Texas', '', ''),
('UT', '8f241f11096877ac0.98748826', 'Utah', 'UT', 'Utah', '', ''),
('VT', '8f241f11096877ac0.98748826', 'Vermont', 'VT', 'Vermont', '', ''),
('VI', '8f241f11096877ac0.98748826', 'Jungferninseln', 'VI', 'Virgin Islands', '', ''),
('VA', '8f241f11096877ac0.98748826', 'Virginia', 'VA', 'Virginia', '', ''),
('WA', '8f241f11096877ac0.98748826', 'Washington', 'WA', 'Washington', '', ''),
('WV', '8f241f11096877ac0.98748826', 'West Virginia', 'WV', 'West Virginia', '', ''),
('WI', '8f241f11096877ac0.98748826', 'Wisconsin', 'WI', 'Wisconsin', '', ''),
('WY', '8f241f11096877ac0.98748826', 'Wyoming', 'WY', 'Wyoming', '', ''),
('AA', '8f241f11096877ac0.98748826', 'Armed Forces Americas', 'AA', 'Armed Forces Americas', '', ''),
('AE', '8f241f11096877ac0.98748826', 'Armed Forces', 'AE', 'Armed Forces', '', ''),
('AP', '8f241f11096877ac0.98748826', 'Armed Forces Pacific', 'AP', 'Armed Forces Pacific', '', '');

#
# Table structure for table `oxstatistics`
#

DROP TABLE IF EXISTS `oxstatistics`;

CREATE TABLE `oxstatistics` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Record id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXTITLE` char(32) NOT NULL default '' COMMENT 'Title',
  `OXVALUE` text NOT NULL COMMENT 'Serialized array of reports',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`)
) ENGINE=InnoDB COMMENT 'Statistics reports';

#
# Table structure for table `oxtplblocks`
# for storing blocks for template parts override
# created 2010-10-12
#

DROP TABLE IF EXISTS `oxtplblocks`;

CREATE TABLE `oxtplblocks` (
  `OXID`        char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Block id',
  `OXACTIVE`    tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is active',
  `OXSHOPID`    char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Shop id (oxshops)',
  `OXTEMPLATE`  char(255) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Template filename (with rel. path), where block is located',
  `OXBLOCKNAME` char(128) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Block name',
  `OXPOS`       int  NOT NULL COMMENT 'Sorting',
  `OXFILE`      char(255) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Module template filename, where block replacement is located',
  `OXMODULE`    char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Module, which uses this template',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY (`OXID`),
  INDEX `search` (`OXACTIVE`, `OXTEMPLATE`, `OXPOS`)
) ENGINE=MyISAM COMMENT 'Module template blocks';

#
# Table structure for table `oxuser`
#

DROP TABLE IF EXISTS `oxuser`;

CREATE TABLE `oxuser` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'User id',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Is active',
  `OXRIGHTS` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User rights: user, malladmin',
  `OXSHOPID` char( 32 ) NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXUSERNAME` varchar(255) NOT NULL default '' COMMENT 'Username',
  `OXPASSWORD` varchar(128) NOT NULL default '' COMMENT 'Hashed password',
  `OXPASSSALT` char(128) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Password salt',
  `OXCUSTNR` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Customer number',
  `OXUSTID` varchar(255) NOT NULL default '' COMMENT 'VAT ID No.',
  `OXCOMPANY` varchar(255) NOT NULL default '' COMMENT 'Company',
  `OXFNAME` varchar(255) NOT NULL default '' COMMENT 'First name',
  `OXLNAME` varchar(255) NOT NULL default '' COMMENT 'Last name',
  `OXSTREET` varchar(255) NOT NULL default '' COMMENT 'Street',
  `OXSTREETNR` varchar(16) NOT NULL default '' COMMENT 'House number',
  `OXADDINFO` varchar(255) NOT NULL default '' COMMENT 'Additional info',
  `OXCITY` varchar(255) NOT NULL default '' COMMENT 'City',
  `OXCOUNTRYID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Country id (oxcountry)',
  `OXSTATEID` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'State id (oxstates)',
  `OXZIP` varchar(16) NOT NULL default '' COMMENT 'ZIP code',
  `OXFON` varchar(128) NOT NULL default '' COMMENT 'Phone number',
  `OXFAX` varchar(128) NOT NULL default '' COMMENT 'Fax number',
  `OXSAL` varchar(128) NOT NULL default '' COMMENT 'User title (Mr/Mrs)',
  `OXBONI` int(11) NOT NULL default '0' COMMENT 'Credit points',
  `OXCREATE` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Creation time',
  `OXREGISTER` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'Registration time',
  `OXPRIVFON` varchar(64) NOT NULL default '' COMMENT 'Personal phone number',
  `OXMOBFON` varchar(64) NOT NULL default '' COMMENT 'Mobile phone number',
  `OXBIRTHDATE` date NOT NULL default '0000-00-00' COMMENT 'Birthday date',
  `OXURL` varchar(255) NOT NULL default '' COMMENT 'Url',
  `OXDISABLEAUTOGRP` tinyint(1) NOT NULL default '0' COMMENT 'Deactivate automatic User Group Assignment',
  `OXUPDATEKEY` char( 32 ) NOT NULL default '' COMMENT 'Update key',
  `OXUPDATEEXP` int(11) NOT NULL default '0' COMMENT 'Update key expiration time',
  `OXPOINTS` double NOT NULL default '0' COMMENT 'User points (for registration, invitation, etc)',
  `OXFBID` bigint unsigned NOT NULL default '0' COMMENT 'Facebook id (used for openid login)',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  UNIQUE `OXUSERNAME` (`OXUSERNAME`, `OXSHOPID`),
  KEY `OXPASSWORD` (`OXPASSWORD`),
  KEY `OXCUSTNR` (`OXCUSTNR`),
  KEY `OXACTIVE` (`OXACTIVE`),
  KEY `OXLNAME` (`OXLNAME`),
  KEY `OXUPDATEEXP` (`OXUPDATEEXP`)
) ENGINE=MyISAM COMMENT 'Shop administrators and users';

#
# Data for table `oxuser`
#
INSERT INTO `oxuser` (`OXID`, `OXACTIVE`, `OXRIGHTS`, `OXSHOPID`, `OXUSERNAME`, `OXPASSWORD`, `OXPASSSALT`, `OXCUSTNR`, `OXUSTID`, `OXCOMPANY`, `OXFNAME`, `OXLNAME`, `OXSTREET`, `OXSTREETNR`, `OXADDINFO`, `OXCITY`, `OXCOUNTRYID`, `OXSTATEID`, `OXZIP`, `OXFON`, `OXFAX`, `OXSAL`, `OXBONI`, `OXCREATE`, `OXREGISTER`, `OXPRIVFON`, `OXMOBFON`, `OXBIRTHDATE`, `OXURL`, `OXDISABLEAUTOGRP`, `OXUPDATEKEY`, `OXUPDATEEXP`, `OXPOINTS`, `OXFBID`) VALUES
('oxdefaultadmin', 1, 'malladmin', 0, 'admin', 'f6fdffe48c908deb0f4c3bd36c032e72', '61646D696E', 1, '', 'Your Company Name', 'John', 'Doe', 'Maple Street', '2425', '', 'Any City', 'a7c40f631fc920687.20179984', '', '9041', '217-8918712', '217-8918713', 'MR', 1000, '2003-01-01 00:00:00', '2003-01-01 00:00:00', '', '', '0000-00-00', '', 0, '', 0, 0, 0);
#
# Table structure for table `oxuserbaskets`
#

DROP TABLE IF EXISTS `oxuserbaskets`;

CREATE TABLE `oxuserbaskets` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Basket id',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxuser)',
  `OXTITLE` varchar(255) NOT NULL default '' COMMENT 'Basket title',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `OXPUBLIC` tinyint(1) DEFAULT '1' NOT NULL COMMENT 'Is public',
  `OXUPDATE` INT NOT NULL default 0 COMMENT 'Update timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXUPDATE` (`OXUPDATE`),
  KEY `OXTITLE` (`OXTITLE`),
  KEY `OXUSERID` (`OXUSERID`)
) ENGINE=InnoDB COMMENT 'Active User baskets';

#
# Table structure for table `oxuserbasketitems`
#

DROP TABLE IF EXISTS `oxuserbasketitems`;

CREATE TABLE `oxuserbasketitems` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Item id',
  `OXBASKETID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Basket id (oxuserbaskets)',
  `OXARTID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Article id (oxarticles)',
  `OXAMOUNT` char(32) NOT NULL default '' COMMENT 'Amount',
  `OXSELLIST` varchar(255) NOT NULL default '' COMMENT 'Selection list',
  `OXPERSPARAM` text NOT NULL COMMENT 'Serialized persistent parameters',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXBASKETID` (`OXBASKETID`),
  KEY `OXARTID` (`OXARTID`)
) ENGINE=InnoDB COMMENT 'User basket items';

#
# Table structure for table `oxuserpayments`
#

DROP TABLE IF EXISTS `oxuserpayments`;

CREATE TABLE `oxuserpayments` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Payment id',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'User id (oxusers)',
  `OXPAYMENTSID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Payment id (oxpayments)',
  `OXVALUE` blob NOT NULL COMMENT 'DYN payment values array as string',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXUSERID` (`OXUSERID`)
) ENGINE=InnoDB COMMENT 'User payments';

#
# Table structure for table `oxvendor`
#

DROP TABLE IF EXISTS `oxvendor`;

CREATE TABLE `oxvendor` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Vendor id',
  `OXSHOPID` char(32) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Shop id (oxshops)',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Active',
  `OXICON` char(128) NOT NULL default '' COMMENT 'Icon filename',
  `OXTITLE` char(255) NOT NULL default '' COMMENT 'Title (multilanguage)',
  `OXSHORTDESC` char(255) NOT NULL default '' COMMENT 'Short description (multilanguage)',
  `OXTITLE_1` char(255) NOT NULL default '',
  `OXSHORTDESC_1` char(255) NOT NULL default '',
  `OXTITLE_2` char(255) NOT NULL default '',
  `OXSHORTDESC_2` char(255) NOT NULL default '',
  `OXTITLE_3` char(255) NOT NULL default '',
  `OXSHORTDESC_3` char(255) NOT NULL default '',
  `OXSHOWSUFFIX` tinyint(1) NOT NULL default '1' COMMENT 'Show SEO Suffix in Category',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  KEY `OXACTIVE` (`OXACTIVE`)
) ENGINE=MyISAM COMMENT 'Distributors list';

#
# Table structure for table `oxvouchers`
#

DROP TABLE IF EXISTS `oxvouchers` ;

CREATE  TABLE IF NOT EXISTS `oxvouchers` (
  `OXDATEUSED` DATE NULL DEFAULT NULL COMMENT 'Date, when coupon was used (set on order complete)',
  `OXORDERID` char(32) character set latin1 collate latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Order id (oxorder)',
  `OXUSERID` char(32) character set latin1 collate latin1_general_ci NOT NULL DEFAULT '' COMMENT 'User id (oxuser)',
  `OXRESERVED` INT(11) NOT NULL DEFAULT 0 COMMENT 'Time, when coupon is added to basket',
  `OXVOUCHERNR` varchar(255) NOT NULL DEFAULT '' COMMENT 'Coupon number',
  `OXVOUCHERSERIEID` char(32) character set latin1 collate latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Coupon Series id (oxvoucherseries)',
  `OXDISCOUNT` FLOAT(9,2) NULL DEFAULT NULL COMMENT 'Discounted amount (if discount was used)',
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Coupon id',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  INDEX OXVOUCHERSERIEID (`OXVOUCHERSERIEID` ASC) ,
  INDEX OXORDERID (`OXORDERID` ASC) ,
  INDEX OXUSERID (`OXUSERID` ASC) ,
  INDEX OXVOUCHERNR (`OXVOUCHERNR` ASC)
) ENGINE = InnoDB COMMENT 'Generated coupons';

#
# Table structure for table `oxvoucherseries`
#

DROP TABLE IF EXISTS `oxvoucherseries` ;

CREATE  TABLE IF NOT EXISTS `oxvoucherseries` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Series id',
  `OXSHOPID` CHAR(32) NOT NULL DEFAULT '' COMMENT 'Shop id (oxshops)',
  `OXSERIENR` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Series name',
  `OXSERIEDESCRIPTION` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Description',
  `OXDISCOUNT` FLOAT(9,2) NOT NULL DEFAULT '0' COMMENT 'Discount amount',
  `OXDISCOUNTTYPE` ENUM('percent','absolute') NOT NULL DEFAULT 'absolute' COMMENT 'Discount type (percent, absolute)',
  `OXSTARTDATE` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Valid from',
  `OXRELEASEDATE` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Valid to',
  `OXBEGINDATE` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Valid from',
  `OXENDDATE` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Valid to',
  `OXALLOWSAMESERIES` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Coupons of this series can be used with single order',
  `OXALLOWOTHERSERIES` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Coupons of different series can be used with single order',
  `OXALLOWUSEANOTHER` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Coupons of this series can be used in multiple orders',
  `OXMINIMUMVALUE` FLOAT(9,2) NOT NULL DEFAULT '0.00' COMMENT 'Minimum Order Sum ',
  `OXCALCULATEONCE` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Calculate only once (valid only for product or category vouchers)',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`),
  INDEX OXSERIENR (`OXSERIENR` ASC) ,
  INDEX OXSHOPID (`OXSHOPID` ASC)
) ENGINE = InnoDB COMMENT 'Coupon series';

#
# Table structure for table `oxwrapping`
#

DROP TABLE IF EXISTS `oxwrapping`;

CREATE TABLE `oxwrapping` (
  `OXID` char(32) character set latin1 collate latin1_general_ci NOT NULL COMMENT 'Wrapping id',
  `OXSHOPID` int(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)',
  `OXACTIVE` tinyint(1) NOT NULL default '1' COMMENT 'Active (multilanguage)',
  `OXACTIVE_1` tinyint(1) NOT NULL default '1',
  `OXACTIVE_2` tinyint(1) NOT NULL default '1',
  `OXACTIVE_3` tinyint(1) NOT NULL default '1',
  `OXTYPE` varchar(4) NOT NULL default 'WRAP' COMMENT 'Wrapping type: WRAP,CARD',
  `OXNAME` varchar(128) NOT NULL default '' COMMENT 'Name (multilanguage)',
  `OXNAME_1` varchar(128) NOT NULL default '',
  `OXNAME_2` varchar(128) NOT NULL default '',
  `OXNAME_3` varchar(128) NOT NULL default '',
  `OXPIC` varchar(128) NOT NULL default '' COMMENT 'Image filename',
  `OXPRICE` double NOT NULL default '0' COMMENT 'Price',
  `OXTIMESTAMP` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY  (`OXID`)
) ENGINE=MyISAM COMMENT 'Wrappings';




CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxarticles AS SELECT oxarticles.* FROM oxarticles;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxarticles_de AS SELECT OXID,OXSHOPID,OXPARENTID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXARTNUM,OXEAN,OXDISTEAN,OXMPN,OXTITLE,OXSHORTDESC,OXPRICE,OXBLFIXEDPRICE,OXPRICEA,OXPRICEB,OXPRICEC,OXBPRICE,OXTPRICE,OXUNITNAME,OXUNITQUANTITY,OXEXTURL,OXURLDESC,OXURLIMG,OXVAT,OXTHUMB,OXICON,OXPIC1,OXPIC2,OXPIC3,OXPIC4,OXPIC5,OXPIC6,OXPIC7,OXPIC8,OXPIC9,OXPIC10,OXPIC11,OXPIC12,OXWEIGHT,OXSTOCK,OXSTOCKFLAG,OXSTOCKTEXT,OXNOSTOCKTEXT,OXDELIVERY,OXINSERT,OXTIMESTAMP,OXLENGTH,OXWIDTH,OXHEIGHT,OXFILE,OXSEARCHKEYS,OXTEMPLATE,OXQUESTIONEMAIL,OXISSEARCH,OXISCONFIGURABLE,OXVARNAME,OXVARSTOCK,OXVARCOUNT,OXVARSELECT,OXVARMINPRICE,OXVARMAXPRICE,OXBUNDLEID,OXFOLDER,OXSUBCLASS,OXSORT,OXSOLDAMOUNT,OXNONMATERIAL,OXFREESHIPPING,OXREMINDACTIVE,OXREMINDAMOUNT,OXAMITEMID,OXAMTASKID,OXVENDORID,OXMANUFACTURERID,OXSKIPDISCOUNTS,OXRATING,OXRATINGCNT,OXMINDELTIME,OXMAXDELTIME,OXDELTIMEUNIT,OXUPDATEPRICE, OXUPDATEPRICEA, OXUPDATEPRICEB, OXUPDATEPRICEC, OXUPDATEPRICETIME, OXISDOWNLOADABLE FROM oxarticles;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxarticles_en AS SELECT OXID,OXSHOPID,OXPARENTID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXARTNUM,OXEAN,OXDISTEAN,OXMPN,OXTITLE_1 AS OXTITLE,OXSHORTDESC_1 AS OXSHORTDESC,OXPRICE,OXBLFIXEDPRICE,OXPRICEA,OXPRICEB,OXPRICEC,OXBPRICE,OXTPRICE,OXUNITNAME,OXUNITQUANTITY,OXEXTURL,OXURLDESC_1 AS OXURLDESC,OXURLIMG,OXVAT,OXTHUMB,OXICON,OXPIC1,OXPIC2,OXPIC3,OXPIC4,OXPIC5,OXPIC6,OXPIC7,OXPIC8,OXPIC9,OXPIC10,OXPIC11,OXPIC12,OXWEIGHT,OXSTOCK,OXSTOCKFLAG,OXSTOCKTEXT_1 AS OXSTOCKTEXT,OXNOSTOCKTEXT_1 AS OXNOSTOCKTEXT,OXDELIVERY,OXINSERT,OXTIMESTAMP,OXLENGTH,OXWIDTH,OXHEIGHT,OXFILE,OXSEARCHKEYS_1 AS OXSEARCHKEYS,OXTEMPLATE,OXQUESTIONEMAIL,OXISSEARCH,OXISCONFIGURABLE,OXVARNAME_1 AS OXVARNAME,OXVARSTOCK,OXVARCOUNT,OXVARSELECT_1 AS OXVARSELECT,OXVARMINPRICE,OXVARMAXPRICE,OXBUNDLEID,OXFOLDER,OXSUBCLASS,OXSORT,OXSOLDAMOUNT,OXNONMATERIAL,OXFREESHIPPING,OXREMINDACTIVE,OXREMINDAMOUNT,OXAMITEMID,OXAMTASKID,OXVENDORID,OXMANUFACTURERID,OXSKIPDISCOUNTS,OXRATING,OXRATINGCNT,OXMINDELTIME,OXMAXDELTIME,OXDELTIMEUNIT,OXUPDATEPRICE, OXUPDATEPRICEA, OXUPDATEPRICEB, OXUPDATEPRICEC, OXUPDATEPRICETIME, OXISDOWNLOADABLE FROM oxarticles;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxartextends AS SELECT oxartextends.* FROM oxartextends;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxartextends_de AS SELECT OXID,OXLONGDESC,OXTAGS,OXTIMESTAMP FROM oxartextends;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxartextends_en AS SELECT OXID,OXLONGDESC_1 AS OXLONGDESC,OXTAGS_1 AS OXTAGS,OXTIMESTAMP FROM oxartextends;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxattribute AS SELECT oxattribute.* FROM oxattribute;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxattribute_de AS SELECT OXID,OXSHOPID,OXTITLE,OXPOS,OXTIMESTAMP, OXDISPLAYINBASKET FROM oxattribute;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxattribute_en AS SELECT OXID,OXSHOPID,OXTITLE_1 AS OXTITLE,OXPOS,OXTIMESTAMP, OXDISPLAYINBASKET FROM oxattribute;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcategories AS SELECT oxcategories.* FROM oxcategories;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcategories_de AS SELECT OXID,OXPARENTID,OXLEFT,OXRIGHT,OXROOTID,OXSORT,OXACTIVE,OXHIDDEN,OXSHOPID,OXTITLE,OXDESC,OXLONGDESC,OXTHUMB,OXEXTLINK,OXTEMPLATE,OXDEFSORT,OXDEFSORTMODE,OXPRICEFROM,OXPRICETO,OXICON,OXPROMOICON,OXVAT,OXSKIPDISCOUNTS,OXSHOWSUFFIX,OXTIMESTAMP FROM oxcategories;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcategories_en AS SELECT OXID,OXPARENTID,OXLEFT,OXRIGHT,OXROOTID,OXSORT,OXACTIVE_1 AS OXACTIVE,OXHIDDEN,OXSHOPID,OXTITLE_1 AS OXTITLE,OXDESC_1 AS OXDESC,OXLONGDESC_1 AS OXLONGDESC,OXTHUMB_1 AS OXTHUMB,OXEXTLINK,OXTEMPLATE,OXDEFSORT,OXDEFSORTMODE,OXPRICEFROM,OXPRICETO,OXICON,OXPROMOICON,OXVAT,OXSKIPDISCOUNTS,OXSHOWSUFFIX,OXTIMESTAMP FROM oxcategories;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcontents AS SELECT oxcontents.* FROM oxcontents;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcontents_de AS SELECT OXID,OXLOADID,OXSHOPID,OXSNIPPET,OXTYPE,OXACTIVE,OXPOSITION,OXTITLE,OXCONTENT,OXCATID,OXFOLDER,OXTERMVERSION,OXTIMESTAMP FROM oxcontents;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcontents_en AS SELECT OXID,OXLOADID,OXSHOPID,OXSNIPPET,OXTYPE,OXACTIVE_1 AS OXACTIVE,OXPOSITION,OXTITLE_1 AS OXTITLE,OXCONTENT_1 AS OXCONTENT,OXCATID,OXFOLDER,OXTERMVERSION,OXTIMESTAMP FROM oxcontents;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcountry AS SELECT oxcountry.* FROM oxcountry;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcountry_de AS SELECT OXID,OXACTIVE,OXTITLE,OXISOALPHA2,OXISOALPHA3,OXUNNUM3,OXORDER,OXSHORTDESC,OXLONGDESC,OXVATSTATUS,OXTIMESTAMP FROM oxcountry;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxcountry_en AS SELECT OXID,OXACTIVE,OXTITLE_1 AS OXTITLE,OXISOALPHA2,OXISOALPHA3,OXUNNUM3,OXORDER,OXSHORTDESC_1 AS OXSHORTDESC,OXLONGDESC_1 AS OXLONGDESC,OXVATSTATUS,OXTIMESTAMP FROM oxcountry;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdelivery AS SELECT oxdelivery.* FROM oxdelivery;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdelivery_de AS SELECT OXID,OXSHOPID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXTITLE,OXADDSUMTYPE,OXADDSUM,OXDELTYPE,OXPARAM,OXPARAMEND,OXFIXED,OXSORT,OXFINALIZE,OXTIMESTAMP FROM oxdelivery;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdelivery_en AS SELECT OXID,OXSHOPID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXTITLE_1 AS OXTITLE,OXADDSUMTYPE,OXADDSUM,OXDELTYPE,OXPARAM,OXPARAMEND,OXFIXED,OXSORT,OXFINALIZE,OXTIMESTAMP FROM oxdelivery;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdiscount AS SELECT oxdiscount.* FROM oxdiscount;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdiscount_de AS SELECT OXID,OXSHOPID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXTITLE,OXAMOUNT,OXAMOUNTTO,OXPRICETO,OXPRICE,OXADDSUMTYPE,OXADDSUM,OXITMARTID,OXITMAMOUNT,OXITMMULTIPLE,OXTIMESTAMP FROM oxdiscount;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdiscount_en AS SELECT OXID,OXSHOPID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXTITLE_1 AS OXTITLE,OXAMOUNT,OXAMOUNTTO,OXPRICETO,OXPRICE,OXADDSUMTYPE,OXADDSUM,OXITMARTID,OXITMAMOUNT,OXITMMULTIPLE,OXTIMESTAMP FROM oxdiscount;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxgroups AS SELECT oxgroups.* FROM oxgroups;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxgroups_de AS SELECT OXID,OXACTIVE,OXTITLE,OXTIMESTAMP FROM oxgroups;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxgroups_en AS SELECT OXID,OXACTIVE,OXTITLE_1 AS OXTITLE,OXTIMESTAMP FROM oxgroups;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxlinks AS SELECT oxlinks.* FROM oxlinks;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxlinks_de AS SELECT OXID,OXSHOPID,OXACTIVE,OXURL,OXURLDESC,OXINSERT,OXTIMESTAMP FROM oxlinks;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxlinks_en AS SELECT OXID,OXSHOPID,OXACTIVE,OXURL,OXURLDESC_1 AS OXURLDESC,OXINSERT,OXTIMESTAMP FROM oxlinks;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxnews AS SELECT oxnews.* FROM oxnews;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxnews_de AS SELECT OXID,OXSHOPID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXDATE,OXSHORTDESC,OXLONGDESC,OXTIMESTAMP FROM oxnews;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxnews_en AS SELECT OXID,OXSHOPID,OXACTIVE_1 AS OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXDATE,OXSHORTDESC_1 AS OXSHORTDESC,OXLONGDESC_1 AS OXLONGDESC,OXTIMESTAMP FROM oxnews;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxobject2attribute AS SELECT oxobject2attribute.* FROM oxobject2attribute;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxobject2attribute_de AS SELECT OXID,OXOBJECTID,OXATTRID,OXVALUE,OXPOS,OXTIMESTAMP FROM oxobject2attribute;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxobject2attribute_en AS SELECT OXID,OXOBJECTID,OXATTRID,OXVALUE_1 AS OXVALUE,OXPOS,OXTIMESTAMP FROM oxobject2attribute;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxpayments AS SELECT oxpayments.* FROM oxpayments;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxpayments_de AS SELECT OXID,OXACTIVE,OXDESC,OXADDSUM,OXADDSUMTYPE,OXADDSUMRULES,OXFROMBONI,OXFROMAMOUNT,OXTOAMOUNT,OXVALDESC,OXCHECKED,OXLONGDESC,OXSORT,OXTSPAYMENTID,OXTIMESTAMP FROM oxpayments;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxpayments_en AS SELECT OXID,OXACTIVE,OXDESC_1 AS OXDESC,OXADDSUM,OXADDSUMTYPE,OXADDSUMRULES,OXFROMBONI,OXFROMAMOUNT,OXTOAMOUNT,OXVALDESC_1 AS OXVALDESC,OXCHECKED,OXLONGDESC_1 AS OXLONGDESC,OXSORT,OXTSPAYMENTID,OXTIMESTAMP FROM oxpayments;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxselectlist AS SELECT oxselectlist.* FROM oxselectlist;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxselectlist_de AS SELECT OXID,OXSHOPID,OXTITLE,OXIDENT,OXVALDESC,OXTIMESTAMP FROM oxselectlist;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxselectlist_en AS SELECT OXID,OXSHOPID,OXTITLE_1 AS OXTITLE,OXIDENT,OXVALDESC_1 AS OXVALDESC,OXTIMESTAMP FROM oxselectlist;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxshops AS SELECT oxshops.* FROM oxshops;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxshops_de AS SELECT OXID,OXACTIVE,OXPRODUCTIVE,OXDEFCURRENCY,OXDEFLANGUAGE,OXNAME,OXTITLEPREFIX,OXTITLESUFFIX,OXSTARTTITLE,OXINFOEMAIL,OXORDEREMAIL,OXOWNEREMAIL,OXORDERSUBJECT,OXREGISTERSUBJECT,OXFORGOTPWDSUBJECT,OXSENDEDNOWSUBJECT,OXSMTP,OXSMTPUSER,OXSMTPPWD,OXCOMPANY,OXSTREET,OXZIP,OXCITY,OXCOUNTRY,OXBANKNAME,OXBANKNUMBER,OXBANKCODE,OXVATNUMBER,OXBICCODE,OXIBANNUMBER,OXFNAME,OXLNAME,OXTELEFON,OXTELEFAX,OXURL,OXDEFCAT,OXHRBNR,OXCOURT,OXADBUTLERID,OXAFFILINETID,OXSUPERCLICKSID,OXAFFILIWELTID,OXAFFILI24ID,OXEDITION,OXVERSION,OXSEOACTIVE,OXTIMESTAMP FROM oxshops;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxshops_en AS SELECT OXID,OXACTIVE,OXPRODUCTIVE,OXDEFCURRENCY,OXDEFLANGUAGE,OXNAME,OXTITLEPREFIX_1 AS OXTITLEPREFIX,OXTITLESUFFIX_1 AS OXTITLESUFFIX,OXSTARTTITLE_1 AS OXSTARTTITLE,OXINFOEMAIL,OXORDEREMAIL,OXOWNEREMAIL,OXORDERSUBJECT_1 AS OXORDERSUBJECT,OXREGISTERSUBJECT_1 AS OXREGISTERSUBJECT,OXFORGOTPWDSUBJECT_1 AS OXFORGOTPWDSUBJECT,OXSENDEDNOWSUBJECT_1 AS OXSENDEDNOWSUBJECT,OXSMTP,OXSMTPUSER,OXSMTPPWD,OXCOMPANY,OXSTREET,OXZIP,OXCITY,OXCOUNTRY,OXBANKNAME,OXBANKNUMBER,OXBANKCODE,OXVATNUMBER,OXBICCODE,OXIBANNUMBER,OXFNAME,OXLNAME,OXTELEFON,OXTELEFAX,OXURL,OXDEFCAT,OXHRBNR,OXCOURT,OXADBUTLERID,OXAFFILINETID,OXSUPERCLICKSID,OXAFFILIWELTID,OXAFFILI24ID,OXEDITION,OXVERSION,OXSEOACTIVE_1 AS OXSEOACTIVE,OXTIMESTAMP FROM oxshops;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxactions AS SELECT oxactions.* FROM oxactions;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxactions_de AS SELECT OXID,OXSHOPID,OXTYPE,OXTITLE,OXLONGDESC,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXPIC,OXLINK,OXSORT,OXTIMESTAMP FROM oxactions;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxactions_en AS SELECT OXID,OXSHOPID,OXTYPE,OXTITLE_1 AS OXTITLE,OXLONGDESC_1 AS OXLONGDESC,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXPIC_1 AS OXPIC,OXLINK_1 AS OXLINK,OXSORT,OXTIMESTAMP FROM oxactions;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxwrapping AS SELECT oxwrapping.* FROM oxwrapping;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxwrapping_de AS SELECT OXID,OXSHOPID,OXACTIVE,OXTYPE,OXNAME,OXPIC,OXPRICE,OXTIMESTAMP FROM oxwrapping;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxwrapping_en AS SELECT OXID,OXSHOPID,OXACTIVE_1 AS OXACTIVE,OXTYPE,OXNAME_1 AS OXNAME,OXPIC,OXPRICE,OXTIMESTAMP FROM oxwrapping;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdeliveryset AS SELECT oxdeliveryset.* FROM oxdeliveryset;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdeliveryset_de AS SELECT OXID,OXSHOPID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXTITLE,OXPOS,OXTIMESTAMP FROM oxdeliveryset;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxdeliveryset_en AS SELECT OXID,OXSHOPID,OXACTIVE,OXACTIVEFROM,OXACTIVETO,OXTITLE_1 AS OXTITLE,OXPOS,OXTIMESTAMP FROM oxdeliveryset;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxvendor AS SELECT oxvendor.* FROM oxvendor;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxvendor_de AS SELECT OXID,OXSHOPID,OXACTIVE,OXICON,OXTITLE,OXSHORTDESC,OXSHOWSUFFIX,OXTIMESTAMP FROM oxvendor;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxvendor_en AS SELECT OXID,OXSHOPID,OXACTIVE,OXICON,OXTITLE_1 AS OXTITLE,OXSHORTDESC_1 AS OXSHORTDESC,OXSHOWSUFFIX,OXTIMESTAMP FROM oxvendor;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxmanufacturers AS SELECT oxmanufacturers.* FROM oxmanufacturers;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxmanufacturers_de AS SELECT OXID,OXSHOPID,OXACTIVE,OXICON,OXTITLE,OXSHORTDESC,OXSHOWSUFFIX,OXTIMESTAMP FROM oxmanufacturers;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxmanufacturers_en AS SELECT OXID,OXSHOPID,OXACTIVE,OXICON,OXTITLE_1 AS OXTITLE,OXSHORTDESC_1 AS OXSHORTDESC,OXSHOWSUFFIX,OXTIMESTAMP FROM oxmanufacturers;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxmediaurls AS SELECT oxmediaurls.* FROM oxmediaurls;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxmediaurls_de AS SELECT OXID,OXOBJECTID,OXURL,OXDESC,OXISUPLOADED,OXTIMESTAMP FROM oxmediaurls;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxmediaurls_en AS SELECT OXID,OXOBJECTID,OXURL,OXDESC_1 AS OXDESC,OXISUPLOADED,OXTIMESTAMP FROM oxmediaurls;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxstates AS SELECT oxstates.* FROM oxstates;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxstates_de AS SELECT OXID,OXCOUNTRYID,OXTITLE,OXISOALPHA2,OXTIMESTAMP FROM oxstates;
CREATE OR REPLACE SQL SECURITY INVOKER VIEW oxv_oxstates_en AS SELECT OXID,OXCOUNTRYID,OXTITLE_1 AS OXTITLE,OXISOALPHA2,OXTIMESTAMP FROM oxstates;
