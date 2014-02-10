-- Demo module database dump
-- Version 1.1
-- http://drupal.org/project/demo
--
-- Database: demobleen1
-- Date: Mon, 03/12/2012 - 17:07
-- Server version: 5.1.53-log
-- PHP version: 5.3.5
-- Drupal version: 7.12

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET FOREIGN_KEY_CHECKS = 0;

SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION;
SET NAMES utf8;

--
-- Table structure for table 'actions'
--

CREATE TABLE IF NOT EXISTS `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores action information.';

--
-- Dumping data for table 'actions'
--

/*!40000 ALTER TABLE actions DISABLE KEYS */;
INSERT INTO `actions` VALUES
('comment_publish_action', 'comment', 'comment_publish_action', '', 'Publish comment'),
('comment_save_action', 'comment', 'comment_save_action', '', 'Save comment'),
('comment_unpublish_action', 'comment', 'comment_unpublish_action', '', 'Unpublish comment'),
('node_make_sticky_action', 'node', 'node_make_sticky_action', '', 'Make content sticky'),
('node_make_unsticky_action', 'node', 'node_make_unsticky_action', '', 'Make content unsticky'),
('node_promote_action', 'node', 'node_promote_action', '', 'Promote content to front page'),
('node_publish_action', 'node', 'node_publish_action', '', 'Publish content'),
('node_save_action', 'node', 'node_save_action', '', 'Save content'),
('node_unpromote_action', 'node', 'node_unpromote_action', '', 'Remove content from front page'),
('node_unpublish_action', 'node', 'node_unpublish_action', '', 'Unpublish content'),
('system_block_ip_action', 'user', 'system_block_ip_action', '', 'Ban IP address of current user'),
('user_block_user_action', 'user', 'user_block_user_action', '', 'Block current user');
/*!40000 ALTER TABLE actions ENABLE KEYS */;

--
-- Table structure for table 'authmap'
--

CREATE TABLE IF NOT EXISTS `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores distributed authentication mapping.';

--
-- Dumping data for table 'authmap'
--

/*!40000 ALTER TABLE authmap DISABLE KEYS */;
/*!40000 ALTER TABLE authmap ENABLE KEYS */;

--
-- Table structure for table 'batch'
--

CREATE TABLE IF NOT EXISTS `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores details about batches (processes that run in...';

--
-- Dumping data for table 'batch'
--

/*!40000 ALTER TABLE batch DISABLE KEYS */;
/*!40000 ALTER TABLE batch ENABLE KEYS */;

--
-- Table structure for table 'block'
--

CREATE TABLE IF NOT EXISTS `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the `Pages` block; contains either a list of paths on which to include/exclude the block or PHP code, depending on `visibility` setting.',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores block settings, such as region and visibility...';

--
-- Dumping data for table 'block'
--

/*!40000 ALTER TABLE block DISABLE KEYS */;
INSERT INTO `block` VALUES
('1', 'system', 'main', 'bartik', '1', '0', 'content', '0', '0', '', '', '-1'),
('2', 'search', 'form', 'bartik', '1', '-8', 'sidebar_first', '0', '0', '', '', '-1'),
('3', 'node', 'recent', 'seven', '1', '10', 'dashboard_main', '0', '0', '', '', '-1'),
('4', 'user', 'login', 'bartik', '1', '-6', 'sidebar_first', '0', '0', '', '', '-1'),
('5', 'system', 'navigation', 'bartik', '1', '-7', 'sidebar_first', '0', '0', '', '', '-1'),
('6', 'system', 'powered-by', 'bartik', '1', '-8', 'footer', '0', '0', '', '', '-1'),
('7', 'system', 'help', 'bartik', '1', '0', 'help', '0', '0', '', '', '-1'),
('8', 'system', 'main', 'seven', '1', '0', 'content', '0', '0', '', '', '-1'),
('9', 'system', 'help', 'seven', '1', '0', 'help', '0', '0', '', '', '-1'),
('10', 'user', 'login', 'seven', '1', '10', 'content', '0', '0', '', '', '-1'),
('11', 'user', 'new', 'seven', '1', '0', 'dashboard_sidebar', '0', '1', '<front>', '', '-1'),
('12', 'search', 'form', 'seven', '1', '-10', 'dashboard_sidebar', '0', '0', '', '', '-1'),
('13', 'comment', 'recent', 'bartik', '0', '-6', '-1', '0', '0', '', '', '1'),
('14', 'node', 'syndicate', 'bartik', '0', '-3', '-1', '0', '0', '', '', '-1'),
('15', 'node', 'recent', 'bartik', '0', '-5', '-1', '0', '0', '', '', '1'),
('16', 'shortcut', 'shortcuts', 'bartik', '0', '-4', '-1', '0', '0', '', '', '-1'),
('17', 'system', 'management', 'bartik', '0', '-7', '-1', '0', '0', '', '', '-1'),
('18', 'system', 'user-menu', 'bartik', '1', '-9', 'footer', '0', '0', '', '<none>', '-1'),
('19', 'system', 'main-menu', 'bartik', '0', '-8', '-1', '0', '0', '', '', '-1'),
('20', 'user', 'new', 'bartik', '1', '-4', 'sidebar_first', '0', '1', '<front>', '', '1'),
('21', 'user', 'online', 'bartik', '1', '-5', 'sidebar_first', '0', '1', '<front>', '', '-1'),
('22', 'comment', 'recent', 'seven', '1', '0', 'dashboard_inactive', '0', '0', '', '', '1'),
('23', 'node', 'syndicate', 'seven', '0', '0', '-1', '0', '0', '', '', '-1'),
('24', 'shortcut', 'shortcuts', 'seven', '0', '0', '-1', '0', '0', '', '', '-1'),
('25', 'system', 'powered-by', 'seven', '0', '10', '-1', '0', '0', '', '', '-1'),
('26', 'system', 'navigation', 'seven', '0', '0', '-1', '0', '0', '', '', '-1'),
('27', 'system', 'management', 'seven', '0', '0', '-1', '0', '0', '', '', '-1'),
('28', 'system', 'user-menu', 'seven', '0', '0', '-1', '0', '0', '', '<none>', '-1'),
('29', 'system', 'main-menu', 'seven', '0', '0', '-1', '0', '0', '', '', '-1'),
('30', 'user', 'online', 'seven', '1', '0', 'dashboard_inactive', '0', '1', '<front>', '', '-1'),
('31', 'demo_reset', 'reset', 'bartik', '0', '-9', '-1', '0', '0', '', '', '-1'),
('32', 'demo_reset', 'reset', 'seven', '0', '0', '-1', '0', '0', '', '', '-1'),
('33', 'poll', 'recent', 'bartik', '1', '0', 'sidebar_second', '0', '1', '<front>', '', '1'),
('34', 'poll', 'recent', 'seven', '1', '0', 'dashboard_inactive', '0', '1', '<front>', '', '1'),
('35', 'menu', 'devel', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1'),
('36', 'devel', 'execute_php', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1'),
('37', 'devel', 'switch_user', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1'),
('38', 'menu', 'devel', 'seven', '0', '0', '-1', '0', '0', '', '', '-1'),
('39', 'devel', 'execute_php', 'seven', '0', '0', '-1', '0', '0', '', '', '-1'),
('40', 'devel', 'switch_user', 'seven', '0', '0', '-1', '0', '0', '', '', '-1');
/*!40000 ALTER TABLE block ENABLE KEYS */;

--
-- Table structure for table 'block_custom'
--

CREATE TABLE IF NOT EXISTS `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores contents of custom-made blocks.';

--
-- Dumping data for table 'block_custom'
--

/*!40000 ALTER TABLE block_custom DISABLE KEYS */;
/*!40000 ALTER TABLE block_custom ENABLE KEYS */;

--
-- Table structure for table 'block_node_type'
--

CREATE TABLE IF NOT EXISTS `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Sets up display criteria for blocks based on content types';

--
-- Dumping data for table 'block_node_type'
--

/*!40000 ALTER TABLE block_node_type DISABLE KEYS */;
/*!40000 ALTER TABLE block_node_type ENABLE KEYS */;

--
-- Table structure for table 'block_role'
--

CREATE TABLE IF NOT EXISTS `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Sets up access permissions for blocks based on user roles';

--
-- Dumping data for table 'block_role'
--

/*!40000 ALTER TABLE block_role DISABLE KEYS */;
INSERT INTO `block_role` VALUES
('poll', 'recent', '2'),
('user', 'new', '2'),
('user', 'online', '2'),
('poll', 'recent', '3'),
('user', 'new', '3'),
('user', 'online', '3');
/*!40000 ALTER TABLE block_role ENABLE KEYS */;

--
-- Table structure for table 'blocked_ips'
--

CREATE TABLE IF NOT EXISTS `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores blocked IP addresses.';

--
-- Dumping data for table 'blocked_ips'
--

/*!40000 ALTER TABLE blocked_ips DISABLE KEYS */;
/*!40000 ALTER TABLE blocked_ips ENABLE KEYS */;

--
-- Table structure for table 'cache'
--

CREATE TABLE IF NOT EXISTS `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Generic cache table for caching things not separated out...';

--
-- Table structure for table 'cache_block'
--

CREATE TABLE IF NOT EXISTS `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Cache table for the Block module to store already built...';

--
-- Table structure for table 'cache_bootstrap'
--

CREATE TABLE IF NOT EXISTS `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Cache table for data required to bootstrap Drupal, may be...';

--
-- Table structure for table 'cache_field'
--

CREATE TABLE IF NOT EXISTS `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Generic cache table for caching things not separated out...';

--
-- Table structure for table 'cache_filter'
--

CREATE TABLE IF NOT EXISTS `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Cache table for the Filter module to store already...';

--
-- Table structure for table 'cache_form'
--

CREATE TABLE IF NOT EXISTS `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Cache table for the form system to store recently built...';

--
-- Table structure for table 'cache_image'
--

CREATE TABLE IF NOT EXISTS `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Cache table used to store information about image...';

--
-- Dumping data for table 'cache_image'
--

/*!40000 ALTER TABLE cache_image DISABLE KEYS */;
/*!40000 ALTER TABLE cache_image ENABLE KEYS */;

--
-- Table structure for table 'cache_menu'
--

CREATE TABLE IF NOT EXISTS `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Cache table for the menu system to store router...';

--
-- Table structure for table 'cache_page'
--

CREATE TABLE IF NOT EXISTS `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Cache table used to store compressed pages for anonymous...';

--
-- Table structure for table 'cache_path'
--

CREATE TABLE IF NOT EXISTS `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Cache table for path alias lookup.';

--
-- Table structure for table 'comment'
--

CREATE TABLE IF NOT EXISTS `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores comments and associated data.';

--
-- Dumping data for table 'comment'
--

/*!40000 ALTER TABLE comment DISABLE KEYS */;
/*!40000 ALTER TABLE comment ENABLE KEYS */;

--
-- Table structure for table 'date_format_locale'
--

CREATE TABLE IF NOT EXISTS `date_format_locale` (
  `format` varchar(100) NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores configured date formats for each locale.';

--
-- Dumping data for table 'date_format_locale'
--

/*!40000 ALTER TABLE date_format_locale DISABLE KEYS */;
/*!40000 ALTER TABLE date_format_locale ENABLE KEYS */;

--
-- Table structure for table 'date_format_type'
--

CREATE TABLE IF NOT EXISTS `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores configured date format types.';

--
-- Dumping data for table 'date_format_type'
--

/*!40000 ALTER TABLE date_format_type DISABLE KEYS */;
INSERT INTO `date_format_type` VALUES
('long', 'Long', '1'),
('medium', 'Medium', '1'),
('short', 'Short', '1');
/*!40000 ALTER TABLE date_format_type ENABLE KEYS */;

--
-- Table structure for table 'date_formats'
--

CREATE TABLE IF NOT EXISTS `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores configured date formats.';

--
-- Dumping data for table 'date_formats'
--

/*!40000 ALTER TABLE date_formats DISABLE KEYS */;
INSERT INTO `date_formats` VALUES
('1', 'Y-m-d H:i', 'short', '1'),
('2', 'm/d/Y - H:i', 'short', '1'),
('3', 'd/m/Y - H:i', 'short', '1'),
('4', 'Y/m/d - H:i', 'short', '1'),
('5', 'd.m.Y - H:i', 'short', '1'),
('6', 'm/d/Y - g:ia', 'short', '1'),
('7', 'd/m/Y - g:ia', 'short', '1'),
('8', 'Y/m/d - g:ia', 'short', '1'),
('9', 'M j Y - H:i', 'short', '1'),
('10', 'j M Y - H:i', 'short', '1'),
('11', 'Y M j - H:i', 'short', '1'),
('12', 'M j Y - g:ia', 'short', '1'),
('13', 'j M Y - g:ia', 'short', '1'),
('14', 'Y M j - g:ia', 'short', '1'),
('15', 'D, Y-m-d H:i', 'medium', '1'),
('16', 'D, m/d/Y - H:i', 'medium', '1'),
('17', 'D, d/m/Y - H:i', 'medium', '1'),
('18', 'D, Y/m/d - H:i', 'medium', '1'),
('19', 'F j, Y - H:i', 'medium', '1'),
('20', 'j F, Y - H:i', 'medium', '1'),
('21', 'Y, F j - H:i', 'medium', '1'),
('22', 'D, m/d/Y - g:ia', 'medium', '1'),
('23', 'D, d/m/Y - g:ia', 'medium', '1'),
('24', 'D, Y/m/d - g:ia', 'medium', '1'),
('25', 'F j, Y - g:ia', 'medium', '1'),
('26', 'j F Y - g:ia', 'medium', '1'),
('27', 'Y, F j - g:ia', 'medium', '1'),
('28', 'j. F Y - G:i', 'medium', '1'),
('29', 'l, F j, Y - H:i', 'long', '1'),
('30', 'l, j F, Y - H:i', 'long', '1'),
('31', 'l, Y,  F j - H:i', 'long', '1'),
('32', 'l, F j, Y - g:ia', 'long', '1'),
('33', 'l, j F Y - g:ia', 'long', '1'),
('34', 'l, Y,  F j - g:ia', 'long', '1'),
('35', 'l, j. F Y - G:i', 'long', '1');
/*!40000 ALTER TABLE date_formats ENABLE KEYS */;

--
-- Table structure for table 'field_config'
--

CREATE TABLE IF NOT EXISTS `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table 'field_config'
--

/*!40000 ALTER TABLE field_config DISABLE KEYS */;
INSERT INTO `field_config` VALUES
('1', 'comment_body', 'text_long', 'text', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 'a:6:{s:12:"entity_types";a:1:{i:0;s:7:"comment";}s:12:"translatable";b:0;s:8:"settings";a:0:{}s:7:"storage";a:4:{s:4:"type";s:17:"field_sql_storage";s:8:"settings";a:0:{}s:6:"module";s:17:"field_sql_storage";s:6:"active";i:1;}s:12:"foreign keys";a:1:{s:6:"format";a:2:{s:5:"table";s:13:"filter_format";s:7:"columns";a:1:{s:6:"format";s:6:"format";}}}s:7:"indexes";a:1:{s:6:"format";a:1:{i:0;s:6:"format";}}}', '1', '0', '0'),
('2', 'body', 'text_with_summary', 'text', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 'a:6:{s:12:"entity_types";a:1:{i:0;s:4:"node";}s:12:"translatable";b:0;s:8:"settings";a:0:{}s:7:"storage";a:4:{s:4:"type";s:17:"field_sql_storage";s:8:"settings";a:0:{}s:6:"module";s:17:"field_sql_storage";s:6:"active";i:1;}s:12:"foreign keys";a:1:{s:6:"format";a:2:{s:5:"table";s:13:"filter_format";s:7:"columns";a:1:{s:6:"format";s:6:"format";}}}s:7:"indexes";a:1:{s:6:"format";a:1:{i:0;s:6:"format";}}}', '1', '0', '0'),
('3', 'field_tags', 'taxonomy_term_reference', 'taxonomy', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 'a:6:{s:8:"settings";a:1:{s:14:"allowed_values";a:1:{i:0;a:2:{s:10:"vocabulary";s:4:"tags";s:6:"parent";i:0;}}}s:12:"entity_types";a:0:{}s:12:"translatable";b:0;s:7:"storage";a:4:{s:4:"type";s:17:"field_sql_storage";s:8:"settings";a:0:{}s:6:"module";s:17:"field_sql_storage";s:6:"active";i:1;}s:12:"foreign keys";a:1:{s:3:"tid";a:2:{s:5:"table";s:18:"taxonomy_term_data";s:7:"columns";a:1:{s:3:"tid";s:3:"tid";}}}s:7:"indexes";a:1:{s:3:"tid";a:1:{i:0;s:3:"tid";}}}', '-1', '0', '0'),
('4', 'field_image', 'image', 'image', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 'a:6:{s:7:"indexes";a:1:{s:3:"fid";a:1:{i:0;s:3:"fid";}}s:8:"settings";a:2:{s:10:"uri_scheme";s:6:"public";s:13:"default_image";b:0;}s:7:"storage";a:4:{s:4:"type";s:17:"field_sql_storage";s:8:"settings";a:0:{}s:6:"module";s:17:"field_sql_storage";s:6:"active";i:1;}s:12:"entity_types";a:0:{}s:12:"translatable";b:0;s:12:"foreign keys";a:1:{s:3:"fid";a:2:{s:5:"table";s:12:"file_managed";s:7:"columns";a:1:{s:3:"fid";s:3:"fid";}}}}', '1', '0', '0'),
('5', 'field_sections', 'taxonomy_term_reference', 'taxonomy', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 'a:7:{s:12:"translatable";s:1:"0";s:12:"entity_types";a:0:{}s:8:"settings";a:1:{s:14:"allowed_values";a:1:{i:0;a:2:{s:10:"vocabulary";s:12:"news_section";s:6:"parent";s:1:"0";}}}s:7:"storage";a:5:{s:4:"type";s:17:"field_sql_storage";s:8:"settings";a:0:{}s:6:"module";s:17:"field_sql_storage";s:6:"active";s:1:"1";s:7:"details";a:1:{s:3:"sql";a:2:{s:18:"FIELD_LOAD_CURRENT";a:1:{s:25:"field_data_field_sections";a:1:{s:3:"tid";s:18:"field_sections_tid";}}s:19:"FIELD_LOAD_REVISION";a:1:{s:29:"field_revision_field_sections";a:1:{s:3:"tid";s:18:"field_sections_tid";}}}}}s:12:"foreign keys";a:1:{s:3:"tid";a:2:{s:5:"table";s:18:"taxonomy_term_data";s:7:"columns";a:1:{s:3:"tid";s:3:"tid";}}}s:7:"indexes";a:1:{s:3:"tid";a:1:{i:0;s:3:"tid";}}s:2:"id";s:1:"5";}', '1', '0', '0'),
('6', 'field_school_year', 'taxonomy_term_reference', 'taxonomy', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 'a:7:{s:12:"translatable";s:1:"0";s:12:"entity_types";a:0:{}s:8:"settings";a:1:{s:14:"allowed_values";a:1:{i:0;a:2:{s:10:"vocabulary";s:11:"school_year";s:6:"parent";s:1:"0";}}}s:7:"storage";a:5:{s:4:"type";s:17:"field_sql_storage";s:8:"settings";a:0:{}s:6:"module";s:17:"field_sql_storage";s:6:"active";s:1:"1";s:7:"details";a:1:{s:3:"sql";a:2:{s:18:"FIELD_LOAD_CURRENT";a:1:{s:28:"field_data_field_school_year";a:1:{s:3:"tid";s:21:"field_school_year_tid";}}s:19:"FIELD_LOAD_REVISION";a:1:{s:32:"field_revision_field_school_year";a:1:{s:3:"tid";s:21:"field_school_year_tid";}}}}}s:12:"foreign keys";a:1:{s:3:"tid";a:2:{s:5:"table";s:18:"taxonomy_term_data";s:7:"columns";a:1:{s:3:"tid";s:3:"tid";}}}s:7:"indexes";a:1:{s:3:"tid";a:1:{i:0;s:3:"tid";}}s:2:"id";s:1:"6";}', '1', '0', '0');
/*!40000 ALTER TABLE field_config ENABLE KEYS */;

--
-- Table structure for table 'field_config_instance'
--

CREATE TABLE IF NOT EXISTS `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table 'field_config_instance'
--

/*!40000 ALTER TABLE field_config_instance DISABLE KEYS */;
INSERT INTO `field_config_instance` VALUES
('1', '1', 'comment_body', 'comment', 'comment_node_page', 'a:6:{s:5:"label";s:7:"Comment";s:8:"settings";a:2:{s:15:"text_processing";i:1;s:18:"user_register_form";b:0;}s:8:"required";b:1;s:7:"display";a:1:{s:7:"default";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:12:"text_default";s:6:"weight";i:0;s:8:"settings";a:0:{}s:6:"module";s:4:"text";}}s:6:"widget";a:4:{s:4:"type";s:13:"text_textarea";s:8:"settings";a:1:{s:4:"rows";i:5;}s:6:"weight";i:0;s:6:"module";s:4:"text";}s:11:"description";s:0:"";}', '0'),
('2', '2', 'body', 'node', 'page', 'a:6:{s:5:"label";s:4:"Body";s:6:"widget";a:4:{s:4:"type";s:26:"text_textarea_with_summary";s:8:"settings";a:2:{s:4:"rows";i:20;s:12:"summary_rows";i:5;}s:6:"weight";i:-4;s:6:"module";s:4:"text";}s:8:"settings";a:3:{s:15:"display_summary";b:1;s:15:"text_processing";i:1;s:18:"user_register_form";b:0;}s:7:"display";a:2:{s:7:"default";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:12:"text_default";s:8:"settings";a:0:{}s:6:"module";s:4:"text";s:6:"weight";i:0;}s:6:"teaser";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:23:"text_summary_or_trimmed";s:8:"settings";a:1:{s:11:"trim_length";i:600;}s:6:"module";s:4:"text";s:6:"weight";i:0;}}s:8:"required";b:0;s:11:"description";s:0:"";}', '0'),
('3', '1', 'comment_body', 'comment', 'comment_node_article', 'a:6:{s:5:"label";s:7:"Comment";s:8:"settings";a:2:{s:15:"text_processing";i:1;s:18:"user_register_form";b:0;}s:8:"required";b:1;s:7:"display";a:1:{s:7:"default";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:12:"text_default";s:6:"weight";i:0;s:8:"settings";a:0:{}s:6:"module";s:4:"text";}}s:6:"widget";a:4:{s:4:"type";s:13:"text_textarea";s:8:"settings";a:1:{s:4:"rows";i:5;}s:6:"weight";i:0;s:6:"module";s:4:"text";}s:11:"description";s:0:"";}', '0'),
('4', '2', 'body', 'node', 'article', 'a:6:{s:5:"label";s:4:"Body";s:6:"widget";a:4:{s:4:"type";s:26:"text_textarea_with_summary";s:8:"settings";a:2:{s:4:"rows";i:20;s:12:"summary_rows";i:5;}s:6:"weight";s:1:"4";s:6:"module";s:4:"text";}s:8:"settings";a:3:{s:15:"display_summary";b:1;s:15:"text_processing";i:1;s:18:"user_register_form";b:0;}s:7:"display";a:2:{s:7:"default";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:12:"text_default";s:8:"settings";a:0:{}s:6:"module";s:4:"text";s:6:"weight";i:0;}s:6:"teaser";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:23:"text_summary_or_trimmed";s:8:"settings";a:1:{s:11:"trim_length";i:600;}s:6:"module";s:4:"text";s:6:"weight";i:0;}}s:8:"required";b:0;s:11:"description";s:0:"";}', '0'),
('5', '3', 'field_tags', 'node', 'article', 'a:6:{s:5:"label";s:4:"Tags";s:11:"description";s:63:"Enter a comma-separated list of words to describe your content.";s:6:"widget";a:4:{s:4:"type";s:21:"taxonomy_autocomplete";s:6:"weight";s:1:"2";s:8:"settings";a:2:{s:4:"size";i:60;s:17:"autocomplete_path";s:21:"taxonomy/autocomplete";}s:6:"module";s:8:"taxonomy";}s:7:"display";a:2:{s:7:"default";a:5:{s:4:"type";s:28:"taxonomy_term_reference_link";s:6:"weight";i:10;s:5:"label";s:5:"above";s:8:"settings";a:0:{}s:6:"module";s:8:"taxonomy";}s:6:"teaser";a:5:{s:4:"type";s:28:"taxonomy_term_reference_link";s:6:"weight";i:10;s:5:"label";s:5:"above";s:8:"settings";a:0:{}s:6:"module";s:8:"taxonomy";}}s:8:"settings";a:1:{s:18:"user_register_form";b:0;}s:8:"required";b:0;}', '0'),
('6', '4', 'field_image', 'node', 'article', 'a:6:{s:5:"label";s:5:"Image";s:11:"description";s:40:"Upload an image to go with this article.";s:8:"required";b:0;s:8:"settings";a:8:{s:14:"file_directory";s:11:"field/image";s:15:"file_extensions";s:16:"png gif jpg jpeg";s:12:"max_filesize";s:0:"";s:14:"max_resolution";s:0:"";s:14:"min_resolution";s:0:"";s:9:"alt_field";b:1;s:11:"title_field";s:0:"";s:18:"user_register_form";b:0;}s:6:"widget";a:4:{s:4:"type";s:11:"image_image";s:8:"settings";a:2:{s:18:"progress_indicator";s:8:"throbber";s:19:"preview_image_style";s:9:"thumbnail";}s:6:"weight";s:1:"5";s:6:"module";s:5:"image";}s:7:"display";a:2:{s:7:"default";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:5:"image";s:8:"settings";a:2:{s:11:"image_style";s:5:"large";s:10:"image_link";s:0:"";}s:6:"weight";i:-1;s:6:"module";s:5:"image";}s:6:"teaser";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:5:"image";s:8:"settings";a:2:{s:11:"image_style";s:6:"medium";s:10:"image_link";s:7:"content";}s:6:"weight";i:-1;s:6:"module";s:5:"image";}}}', '0'),
('7', '1', 'comment_body', 'comment', 'comment_node_poll', 'a:6:{s:5:"label";s:7:"Comment";s:8:"settings";a:2:{s:15:"text_processing";i:1;s:18:"user_register_form";b:0;}s:8:"required";b:1;s:7:"display";a:1:{s:7:"default";a:5:{s:5:"label";s:6:"hidden";s:4:"type";s:12:"text_default";s:6:"weight";i:0;s:8:"settings";a:0:{}s:6:"module";s:4:"text";}}s:6:"widget";a:4:{s:4:"type";s:13:"text_textarea";s:8:"settings";a:1:{s:4:"rows";i:5;}s:6:"weight";i:0;s:6:"module";s:4:"text";}s:11:"description";s:0:"";}', '0'),
('8', '5', 'field_sections', 'node', 'article', 'a:7:{s:5:"label";s:8:"Sections";s:6:"widget";a:5:{s:6:"weight";s:1:"1";s:4:"type";s:14:"options_select";s:6:"module";s:7:"options";s:6:"active";i:1;s:8:"settings";a:0:{}}s:8:"settings";a:1:{s:18:"user_register_form";b:0;}s:7:"display";a:1:{s:7:"default";a:5:{s:5:"label";s:5:"above";s:4:"type";s:28:"taxonomy_term_reference_link";s:8:"settings";a:0:{}s:6:"module";s:8:"taxonomy";s:6:"weight";i:11;}}s:8:"required";i:0;s:11:"description";s:0:"";s:13:"default_value";N;}', '0'),
('9', '6', 'field_school_year', 'node', 'article', 'a:7:{s:5:"label";s:11:"School Year";s:6:"widget";a:5:{s:6:"weight";s:1:"3";s:4:"type";s:14:"options_select";s:6:"module";s:7:"options";s:6:"active";i:1;s:8:"settings";a:0:{}}s:8:"settings";a:1:{s:18:"user_register_form";b:0;}s:7:"display";a:1:{s:7:"default";a:5:{s:5:"label";s:5:"above";s:4:"type";s:28:"taxonomy_term_reference_link";s:8:"settings";a:0:{}s:6:"module";s:8:"taxonomy";s:6:"weight";i:12;}}s:8:"required";i:1;s:11:"description";s:0:"";s:13:"default_value";a:1:{i:0;a:1:{s:3:"tid";s:1:"8";}}}', '0');
/*!40000 ALTER TABLE field_config_instance ENABLE KEYS */;

--
-- Table structure for table 'field_data_body'
--

CREATE TABLE IF NOT EXISTS `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Data storage for field 2 (body)';

--
-- Dumping data for table 'field_data_body'
--

/*!40000 ALTER TABLE field_data_body DISABLE KEYS */;
INSERT INTO `field_data_body` VALUES
('node', 'article', '0', '1', '1', 'und', '0', 'Principal Dries has commissioned this exciting new Web site.\r\nThis Web site is based on Drupal - the powerful CMS with outstanding support for building a community-based Web site.\r\nCheck back often as this Web site will take off fast!\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi commodo, ipsum sed pharetra gravida, orci magna rhoncus neque, id pulvinar odio lorem non turpis. Nullam sit amet enim. Suspendisse id velit vitae ligula volutpat condimentum. Aliquam erat volutpat. Sed quis velit. Nulla facilisi. Nulla libero. Vivamus pharetra posuere sapien. Nam consectetuer. Sed aliquam, nunc eget euismod ullamcorper, lectus nunc ullamcorper orci, fermentum bibendum enim nibh eget ipsum. Donec porttitor ligula eu dolor. Maecenas vitae nulla consequat libero cursus venenatis. Nam magna enim, accumsan eu, blandit sed, blandit a, eros.\r\n\r\nQuisque facilisis erat a dui. Nam malesuada ornare dolor. Cras gravida, diam sit amet rhoncus ornare, erat elit consectetuer erat, id egestas pede nibh eget odio. Proin tincidunt, velit vel porta elementum, magna diam molestie sapien, non aliquet massa pede eu diam. Aliquam iaculis. Fusce et ipsum et nulla tristique facilisis. Donec eget sem sit amet ligula viverra gravida. Etiam vehicula urna vel turpis. Suspendisse sagittis ante a urna. Morbi a est quis orci consequat rutrum. Nullam egestas feugiat felis. Integer adipiscing semper ligula. Nunc molestie, nisl sit amet cursus convallis, sapien lectus pretium metus, vitae pretium enim wisi id lectus. Donec vestibulum. Etiam vel nibh. Nulla facilisi. Mauris pharetra. Donec augue.\r\n', 'This is a quick summary of our story.\r\nFusce et ipsum et nulla tristique facilisis. Donec eget sem sit amet ligula viverra gravida. Etiam vehicula urna vel turpis. Suspendisse sagittis ante a urna. Morbi a est quis orci consequat rutrum.\r\n', 'filtered_html'),
('node', 'article', '0', '2', '2', 'und', '0', '<p><strong>Principal Dries</strong> here!</p> <p>Welcome to a new school year at Drupal U! We hope you are looking forward to the new year just as we are. Check back soon for more news and information. We''ll have information for students, teachers, and parents.</p> <p> - <em>D.B</em></p>', '', 'filtered_html'),
('node', 'page', '0', '3', '3', 'und', '0', 'Placeholder for an about us page.', '', 'filtered_html'),
('node', 'page', '0', '5', '5', 'und', '0', ' <ul><li><a href="www.Drupal .org">Drupal Home Page</a></li><li><a href="http://groups.Drupal .org">Drupal Groups</a></li></ul>', '', 'filtered_html'),
('node', 'page', '0', '6', '6', 'und', '0', '<ul><li>Dries</li><li>Webchick</li><li>chx</li><li>merlinofchaos</li></ul>', '', 'filtered_html'),
('node', 'article', '0', '27', '27', 'und', '0', 'Causa cogo defui feugiat hendrerit praemitto quis roto valetudo vulpes. Ea exputo illum nisl nostrud os voco zelus. Abluo acsi comis facilisi iriure laoreet nulla nutus scisco. Dignissim duis gravis hos jumentum loquor secundum turpis. Gilvus obruo patria. Camur ea eros iriure metuo praemitto utinam vereor.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '28', '28', 'und', '0', 'Abbas abigo aptent fere molior olim pala premo vel vulpes. Decet esca facilisis hos huic quibus sed suscipit vereor. Aliquam damnum distineo facilisi gemino interdico jugis quidne.\n\nAd conventio cui genitus iriure paulatim te usitas ut. Mauris melior wisi. Augue loquor pala pneum singularis uxor vulpes. Abdo huic melior mos quae sudo tation verto vicis.\n\n', NULL, 'full_html'),
('node', 'article', '0', '29', '29', 'und', '0', 'Abico amet antehabeo aptent camur dignissim hendrerit suscipere turpis valetudo. Damnum nimis probo quidem. Feugiat gemino imputo iustum modo obruo pagus proprius turpis zelus. Dignissim eu ibidem letalis molior tamen tego typicus wisi. Conventio hendrerit huic iustum occuro pala roto sit utrum. Comis ea letalis saluto. Brevitas ludus mos ratis tum. Abbas interdico loquor oppeto velit. At mauris os pagus praesent ulciscor.\n\nDuis exputo hendrerit immitto magna nobis odio quis suscipit. Blandit comis commoveo conventio feugiat olim quadrum vel vicis. Blandit consectetuer dolore elit et praemitto sagaciter.\n\nAbdo bene blandit cogo decet duis enim luctus mauris torqueo. In nutus odio vulpes. Autem blandit causa cogo fere haero quibus saluto. Aliquip capto luptatum nutus paulatim valetudo.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '30', '30', 'und', '0', 'Abluo brevitas defui et hos veniam. Dignissim dolor esca nibh te ut. At blandit metuo modo similis typicus ullamcorper volutpat ymo. Amet cogo erat. Hendrerit ideo pertineo pneum si tego torqueo uxor. Ea feugiat mos utinam. Abbas ad eligo lenis mos pagus ullamcorper usitas verto. Ad antehabeo dignissim gemino lobortis torqueo. Dignissim ex iustum modo sino valde.\n\nAbbas duis ea et eu fere hendrerit magna validus voco. Euismod fere gravis iustum luptatum paulatim praesent utrum valde voco. Abbas adipiscing aliquam lenis. Facilisis os si te. Ibidem nunc pneum saluto typicus. Accumsan commodo facilisis plaga praesent ulciscor ymo. Cogo dolor ea quibus vereor vicis. Eligo ibidem illum torqueo. Aptent humo illum molior secundum sit torqueo vero.\n\nAntehabeo dolus fere feugiat hos iustum nobis. Augue incassum quis secundum si turpis ut. Defui enim exputo melior. Neo paratus tego utinam venio. Ludus minim refero. Camur conventio haero ratis sed vel.\n\nIdeo sed similis tamen. Eu praemitto refoveo wisi. Caecus humo paratus quidem tamen usitas. Amet autem eum modo ulciscor.\n\nAccumsan modo nibh premo secundum tamen tum vel. Dolore gilvus humo meus natu neque populus ut. At consectetuer erat huic luctus saluto valde. Cui suscipit tation verto vicis. Bene inhibeo metuo molior obruo quidem venio. Fere jumentum praesent tego vulpes. Acsi capto erat eros nibh pala proprius sudo wisi. Abigo aliquam dolus molior neque suscipit tego veniam.\n\nAd diam ex occuro os pertineo pneum scisco. Facilisi humo importunus praemitto. Et pneum qui. Amet at commodo consequat illum olim suscipere. Appellatio capto magna modo ut.\n\nFeugiat quibus tum. Abico appellatio distineo dolore iaceo imputo luptatum tincidunt veniam vicis. Ea facilisi iustum quidem. Antehabeo diam valetudo. Ex iriure jugis nimis nutus pertineo saepius torqueo.\n\nAccumsan eligo feugiat gravis humo meus secundum sino typicus validus. Importunus singularis tamen uxor. Aliquip esca esse iaceo. Blandit et ideo letalis nimis rusticus secundum tincidunt ullamcorper. Haero immitto occuro tamen. Acsi consectetuer melior sagaciter. Augue capto consectetuer jus magna mauris molior refoveo te wisi.\n\nLuctus nunc os te. Hendrerit illum premo virtus. Gilvus gravis loquor ludus te vel. Cogo comis gravis minim olim proprius tation typicus ut volutpat.\n\nFacilisis incassum mos. Luptatum nulla obruo singularis tum utinam velit verto volutpat zelus. Augue eligo ibidem nibh saluto secundum ullamcorper vero. Elit erat eu fere huic ibidem minim praesent ratis singularis. Aptent blandit gravis ibidem metuo vel vicis. Abico blandit eligo esca inhibeo neque nunc saepius ullamcorper valde. Abico commodo dignissim duis et gilvus nutus si ullamcorper.\n\nAbluo eros lenis macto natu populus. Distineo ideo si. Accumsan causa dolus enim eum gemino nutus suscipere. Abigo acsi brevitas distineo esca nostrud tego tincidunt veniam. Caecus elit facilisis jumentum nibh nisl qui saluto tation utinam. Acsi capto elit loquor obruo tamen tation. Consectetuer gravis macto obruo scisco torqueo ullamcorper ymo. Humo pala rusticus usitas.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '31', '31', 'und', '0', 'Accumsan consectetuer dolor molior nisl rusticus tego utinam. Bene laoreet macto neque tation tincidunt vindico wisi. Aptent at illum laoreet lucidus neque plaga quidem veniam. Abdo esse hendrerit importunus luptatum ut valde. Abico enim in ludus roto secundum valde vereor. Dolore gemino molior obruo paratus premo quae roto zelus.\n\nIdeo jus neque nibh praesent vindico vulpes. Abbas augue dignissim huic si tego ullamcorper velit.\n\nAdipiscing camur conventio ideo laoreet magna mauris quidem saluto suscipit. Augue blandit gravis immitto neo nunc persto utinam vulpes. Aliquip amet aptent et fere in interdico neo probo te. Genitus probo veniam venio vero volutpat. Aptent metuo odio persto. Feugiat melior nutus occuro quidem roto sed vereor vicis. Defui laoreet ullamcorper vicis. Eligo facilisis iusto odio. Dolore et fere gravis metuo olim quia.\n\nEligo elit meus obruo paulatim vindico. Erat feugiat in qui refero utrum. Interdico nulla sagaciter. Antehabeo hendrerit iriure neo pneum typicus vindico.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '32', '32', 'und', '0', 'Decet eum facilisi ibidem interdico macto magna meus paulatim vero. Aptent dignissim interdico ludus premo rusticus zelus. Consequat ludus pala sit ullamcorper wisi. Facilisi in interdico nibh pertineo proprius quibus roto ymo zelus.\n\nIn iriure jus odio quis ullamcorper valetudo. Aliquam cui enim et iustum nisl si. Consectetuer ille nibh. Conventio dolor duis eum quidem sed veniam voco. Fere refoveo similis te. Hos interdico ludus. Dignissim dolus eum vulputate. Damnum genitus illum importunus jus molior populus si singularis. Cogo eligo erat huic iaceo lenis luctus paulatim tation.\n\nAugue hos importunus lenis pecus praemitto vereor zelus. Cogo euismod ex gemino natu nutus saluto. Enim erat eum humo illum minim nostrud refoveo saluto volutpat. Abico ad inhibeo lucidus nibh obruo verto vulputate.\n\nDolus lobortis metuo mos natu os si. Amet os tego. Damnum erat haero interdico minim quidne secundum similis vicis. Antehabeo gravis humo iriure pertineo sudo. Abigo abluo conventio decet virtus wisi. Brevitas hos imputo iusto luptatum mos os praemitto.\n\nAntehabeo gilvus quia tum utrum ymo. Aptent ex gemino gilvus nostrud quidne similis torqueo. Dolore esca ex hos illum inhibeo si tamen verto. Augue minim populus tego. Adipiscing eum ex lucidus oppeto scisco. Appellatio genitus jugis mauris metuo. Ille illum neque paulatim similis sit veniam volutpat.\n\nAcsi aliquip molior neo tego. Enim nimis os. Gemino mauris paratus sagaciter usitas. Amet causa comis eros eu lenis luptatum quae qui velit.\n\nEum nunc quia. Aptent importunus letalis magna melior paratus probo uxor.\n\nMetuo quidne sagaciter. Camur hendrerit paratus verto. Commoveo cui feugiat nunc. Commodo consequat iriure iusto. Adipiscing distineo melior nulla probo ullamcorper velit.\n\nConventio macto oppeto pecus premo tincidunt. Dolus esca exerci. Et mauris plaga pneum saepius sagaciter scisco singularis wisi. Autem euismod facilisis interdico iriure iustum paulatim sudo volutpat. Defui luctus melior pagus.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '33', '33', 'und', '0', 'Qui sagaciter singularis venio. Blandit commodo esca in lobortis ludus metuo os utinam. Mauris pecus te validus. Abdo autem molior pecus. Aliquip duis esca iaceo immitto neque plaga ratis similis singularis.\n\nAd aliquam ea elit nimis quadrum singularis. At incassum refero tamen. Ex nobis refoveo vicis vulpes. Abbas bene fere lobortis quidem. Abico adipiscing camur causa cui gemino ibidem populus te. Acsi aliquam capto distineo gravis lobortis lucidus nutus saluto.\n\nEligo lucidus paratus tamen. Incassum ludus paulatim ulciscor. Camur ille nunc. Elit eu illum immitto molior premo quae qui sudo utinam. Gemino ille iusto macto paratus quadrum refero. Meus nimis premo tego.\n\nCogo haero iriure nutus ymo. Adipiscing euismod huic illum jugis jus modo nisl. Capto eu loquor luptatum meus nunc populus saluto sudo tego.\n\nAmet dignissim erat eros minim occuro. Gemino paulatim refero secundum singularis suscipit. Abigo blandit euismod luctus quadrum quidem tation tincidunt. Autem ludus proprius valetudo. Abico augue comis distineo. Abigo cogo genitus imputo iriure paulatim sagaciter utinam.\n\nAd amet diam luctus occuro scisco te tego valde. Premo rusticus suscipit tincidunt utinam. Abigo appellatio conventio genitus iriure nimis odio quidem torqueo.\n\nDolor fere gemino iusto lucidus natu obruo vulputate. Abluo ad jugis loquor luptatum natu quidne saepius. Bene gemino iriure neo pagus refoveo sino venio zelus. Commoveo eros eum humo molior mos nibh oppeto tamen veniam. Accumsan comis diam dolore et hos pala.\n\nEuismod exputo huic. Abbas esse gemino nostrud praemitto tamen turpis ut vereor voco. Gravis iusto loquor ludus. Illum iustum lobortis sino voco vulpes. Abbas ibidem jumentum. Comis eu magna sudo ut valde. Inhibeo laoreet mos occuro secundum tamen vereor. Adipiscing at lobortis nibh patria quis.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '34', '34', 'und', '0', 'Aliquip facilisis macto qui sudo turpis. Enim eum facilisis iusto laoreet zelus. Adipiscing gilvus iusto pertineo suscipit tation typicus vereor vulputate. Augue jugis nimis tincidunt. Dolore duis euismod nisl nunc usitas vulputate. Consectetuer conventio praemitto secundum. Defui incassum pneum. Appellatio camur inhibeo lobortis. Erat huic modo valde. Caecus dolor pala ratis vindico. Ea elit nutus.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '35', '35', 'und', '0', 'Dolor incassum jugis jumentum praesent sagaciter sudo tego vel vero. Abico exerci nobis paratus probo ratis sed suscipere. Causa consectetuer et jus olim validus veniam. Abigo amet gemino magna meus occuro oppeto sagaciter sino vel. Autem dignissim dolor jumentum scisco. Ad commodo cui hos patria.\n\nAbico enim iriure jumentum occuro roto sudo tamen utinam voco. Caecus imputo in iustum jus lobortis minim natu vulpes. Humo neque nulla saluto tamen zelus. Jumentum nulla persto quis.\n\nDolor eros premo. Augue capto exputo imputo pecus refero. Abdo abluo amet antehabeo ludus odio quae veniam. Antehabeo appellatio commodo consectetuer neque sagaciter si torqueo. Abbas abluo aptent commodo ea iriure jumentum letalis quibus usitas. Abigo aliquam hendrerit minim natu rusticus veniam. Abdo pertineo premo validus vindico.\n\nCommoveo ea eu gilvus tincidunt virtus. Ad appellatio facilisis mauris saluto scisco. Hos paratus turpis. Camur commoveo probo quibus. Distineo elit enim occuro utrum wisi. Exputo ideo ille jumentum suscipere. Comis distineo genitus nimis nutus obruo sudo turpis utrum vindico. Genitus huic magna nutus. Abluo eu ibidem pagus paratus pneum quae suscipere vulputate.\n\nIbidem nimis obruo quia secundum ut vero. Ad cogo dolore eu imputo os populus sed. Accumsan blandit nimis saluto ut utinam. Exerci imputo laoreet neo obruo qui valde. Aliquam distineo mos tamen.\n\nAcsi meus qui. Aptent meus nutus paratus tego. Antehabeo camur esca facilisis jus ratis singularis voco volutpat.\n\nHuic sit utrum. Commoveo letalis macto nibh odio pagus suscipit torqueo valde voco. At commoveo ea ex fere haero ludus ratis. Commoveo fere loquor luptatum nostrud os proprius quidne sudo ulciscor.\n\nAbbas defui distineo haero neque valde zelus. Consequat hos interdico loquor luptatum quadrum quibus tation wisi. Nisl probo secundum. Imputo jumentum pagus sudo. Ille in nutus scisco. Adipiscing jumentum melior os ulciscor. Dolore feugiat haero hos letalis quidne. Adipiscing bene hos ideo importunus roto suscipere te vicis. Abdo at genitus populus veniam. Acsi ea esse interdico macto patria quadrum ratis utrum vel.\n\nAntehabeo caecus esca eu ex importunus incassum neo. Aliquip blandit facilisi quidne. Amet bene blandit decet iusto metuo neque os sino. Abluo antehabeo ille lucidus nobis quis scisco singularis valetudo. Dolore enim eu euismod illum nobis olim usitas. Amet lucidus praemitto premo quae si tum valde.\n\nGravis olim saepius si singularis. Acsi dolus luctus refoveo ut. Pneum quis vulputate. Abigo ad amet antehabeo autem minim patria refero rusticus vero. Abigo dignissim distineo euismod gemino mauris modo natu nunc validus.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '36', '36', 'und', '0', 'Abluo cui decet et refoveo suscipere tincidunt vereor. Adipiscing caecus elit in meus populus refero. Dolus et iriure iusto luctus mos quidem volutpat. Dolus hos immitto mauris quis refero tum typicus utrum. Mos pertineo quibus scisco vulputate ymo. Commoveo iriure nobis velit. Et gravis haero oppeto wisi. Antehabeo consectetuer magna rusticus sagaciter valetudo volutpat. Aliquip bene dolus eligo ibidem imputo mauris pecus suscipere vel.\n\nAdipiscing conventio haero refoveo. Aliquam causa duis elit facilisi iustum pala patria premo saluto. Abico commoveo et pala vulpes. Camur eros jugis magna olim. Antehabeo at cogo dolor facilisis paratus quia roto ut. Exerci tation uxor. Causa et imputo pertineo praesent roto sudo tum usitas vero. Abluo augue cogo comis jus macto natu quibus. Molior patria praemitto venio.\n\nDistineo ea sagaciter sit utinam. Ad ibidem interdico laoreet melior obruo ulciscor. Ibidem importunus melior saepius. Causa humo in iustum melior pneum secundum. Aliquam mos pecus. Acsi autem ea erat euismod ibidem mauris mos probo.\n\nAbigo cogo consectetuer eum letalis lobortis pala probo quadrum validus. Aliquam hos huic nisl oppeto persto quadrum tum valde. Dolore ibidem lenis lucidus neque olim probo quae singularis vereor. Et haero illum metuo quidem usitas.\n\nAbluo damnum dignissim duis eu hendrerit metuo nunc. Eu haero melior minim obruo pertineo quae quidne refero. Aptent distineo eligo inhibeo lucidus nulla occuro quibus sagaciter ymo.\n\nEa modo nisl olim. Autem facilisis gemino modo nisl pneum ratis. Comis luctus plaga scisco tamen turpis. Camur lenis metuo olim sit. Aptent commoveo laoreet loquor neo pneum. Dolor eu exerci importunus magna modo molior olim refoveo vulpes. Abdo dolore hos inhibeo nunc occuro quae suscipit validus ymo. Ideo lenis scisco.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '37', '37', 'und', '0', 'Antehabeo distineo facilisis nutus paratus paulatim pertineo qui sudo vel. Caecus dolus natu nibh olim utinam veniam vindico ymo. Abluo distineo esca fere incassum jumentum melior nunc valde. Abdo abico distineo gilvus lucidus luptatum mos occuro proprius quidem.\n\nBene eum praemitto saluto utinam. Commodo duis et macto neo odio si. Illum mos obruo paratus persto populus quae qui suscipere. Abbas feugiat os tum ullamcorper usitas. Appellatio aptent esca importunus incassum praesent. Autem brevitas capto cogo eligo quia ut validus vel vicis. Commodo distineo ille luptatum nobis nulla typicus ulciscor virtus.\n\nAbdo euismod natu neque nulla nunc vero virtus. Abluo adipiscing consectetuer dolus gilvus lobortis nobis pneum validus. Antehabeo dignissim inhibeo ludus suscipit. Blandit dolus euismod gravis lobortis oppeto paulatim turpis ut vulpes. Cui distineo paulatim sino sit torqueo. Hendrerit lucidus nulla oppeto zelus.\n\nDamnum elit feugiat iaceo inhibeo nostrud veniam. Bene macto patria quadrum quae uxor. Exerci in incassum ludus pertineo tamen. Accumsan elit ideo os quidne validus. Conventio enim incassum nobis rusticus sino te ullamcorper. Adipiscing aliquam imputo lobortis persto sit veniam.\n\nAd feugiat ille laoreet paratus praesent ratis ullamcorper vero. Ad augue duis luctus obruo quia rusticus verto vicis vulputate. Abigo decet elit ibidem macto os patria populus vicis ymo. Ad esse saluto ymo. Gilvus gravis praesent quae ratis refoveo singularis voco.\n\nCogo iriure molior quibus rusticus. Enim macto praesent zelus. Aliquam dolore inhibeo populus tum. Caecus cui eu plaga scisco. Adipiscing euismod eum gilvus iaceo oppeto paratus secundum. Aptent jumentum melior nimis pagus pecus praemitto. Abico abluo saluto singularis ut.\n\nNostrud proprius similis ymo. Abigo diam eros neque nibh scisco suscipit veniam. Mauris nunc ut. Abdo autem euismod iaceo nibh paulatim quia saluto usitas utrum. Augue letalis probo vulputate. Abigo ad damnum eligo iusto molior quadrum similis tation vulpes. Damnum iustum meus neo. Commoveo conventio modo plaga. Abico abluo aliquip macto modo tum.\n\nCommodo consequat erat molior nutus plaga. Damnum ex tamen usitas. Comis elit laoreet obruo utinam. Ideo lenis modo nimis persto sed suscipit tincidunt usitas vereor.\n\nAdipiscing mos plaga. At illum inhibeo singularis valde wisi. Exerci gilvus illum quia. Caecus decet eum in nutus paratus ratis validus volutpat vulpes. Accumsan eu eum imputo laoreet melior metuo quae sit ymo. Abigo aliquam bene gilvus haero jus loquor ludus quadrum velit. Aptent consequat ex facilisi iriure molior nisl voco. Autem iustum nunc praesent quae virtus voco.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '38', '38', 'und', '0', 'Autem conventio hos praemitto sagaciter. Ad antehabeo decet et ideo importunus vel verto virtus. Autem consequat dignissim elit eros ideo nimis quibus ratis. Abigo brevitas damnum dignissim dolor eu hendrerit humo odio scisco.\n\nAbigo bene esca eum gilvus ille importunus odio utrum vero. Blandit letalis lucidus rusticus usitas.\n\nAbbas facilisis fere gravis haero lobortis nulla persto utinam. Aptent feugiat loquor lucidus olim probo ullamcorper. Camur comis huic. Et ex metuo secundum te. Feugiat incassum plaga refoveo tation utrum. Abluo autem consectetuer inhibeo pagus populus. Aliquip autem ex premo secundum sed usitas. Comis eligo ideo luptatum pneum rusticus ulciscor vel vero.\n\nCogo minim probo proprius quibus utinam vulputate. At oppeto ulciscor. Consectetuer esca mauris metuo nisl quibus utinam.\n\nAcsi damnum dolore dolus nulla singularis sino ulciscor usitas utinam. Blandit consequat et ex gemino lucidus ratis refoveo vero.\n\nNeo nulla quadrum. Commodo consequat duis nibh paratus sagaciter secundum similis te virtus. Brevitas commoveo cui damnum. Iaceo illum ut utrum. Huic quadrum typicus. Brevitas loquor nobis nutus refoveo tum verto voco.\n\nDignissim elit meus neque plaga pneum sit. Acsi aliquip brevitas commoveo interdico melior te. Ad aliquam laoreet lenis loquor te typicus veniam vereor.\n\nCausa dignissim incassum lenis neque ymo. Adipiscing facilisis huic lenis quibus refoveo vulpes. Augue minim suscipit torqueo. Augue brevitas dolore laoreet minim mos nutus sagaciter sed uxor. Bene eligo nulla praesent refero vereor. Defui erat in letalis occuro tego ulciscor zelus. Eum fere immitto jugis meus. Eligo qui quidne ratis. Appellatio capto consectetuer gravis humo incassum jumentum lenis patria valde.\n\nBlandit esse gemino lenis os pecus quidem volutpat. Conventio gravis imputo jugis neque saepius tum. Gilvus nostrud plaga uxor. Ibidem lobortis nimis tamen volutpat. Acsi feugiat gemino letalis nisl populus si vulpes. Aliquam appellatio conventio gemino haero nibh qui suscipere. Dignissim imputo obruo os singularis. Ex iaceo meus rusticus saluto secundum tation veniam zelus.\n\nAbdo caecus camur decet luptatum pneum refero te vel vindico. Dignissim eligo eu hos pneum populus quibus tamen ut. Exputo inhibeo mos roto rusticus sudo venio. Bene jus laoreet pneum typicus utinam validus. Accumsan aliquam et imputo occuro. Abico decet dolus exerci illum occuro pala qui singularis valde. Elit pneum similis. Appellatio loquor magna secundum utrum. Accumsan decet quibus refoveo tation vel volutpat.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '39', '39', 'und', '0', 'Enim eros odio quidem similis. Commodo consequat iaceo lenis. Camur cogo facilisis ideo iusto jugis neque tamen velit. Consectetuer decet esse melior nunc populus. Feugiat nibh quis rusticus sagaciter ut zelus.\n\nCausa enim exerci ibidem nisl probo quibus turpis. Accumsan blandit ille natu quis. Cogo consectetuer eros verto. Jumentum magna proprius. Dolore ille incassum lobortis ludus quis. Inhibeo iustum paratus paulatim quis turpis vindico vulpes. Caecus exputo nisl saepius ut vulputate.\n\nAbigo adipiscing ex ibidem iustum melior neo nostrud vel virtus. Bene defui esse ille modo odio quis suscipere ut. Antehabeo illum immitto patria pneum qui sit utinam valetudo vicis. Augue camur genitus illum inhibeo iriure odio quadrum. Aliquam feugiat jumentum. Acsi distineo vulpes. Fere quadrum refero saluto tego zelus. Accumsan acsi consequat fere ibidem loquor luctus quis vulputate wisi.\n\nCamur interdico volutpat. Brevitas consequat damnum defui humo lenis lobortis plaga venio vicis. Amet imputo ludus nostrud obruo odio pagus validus vulpes ymo. Elit erat hendrerit in. Antehabeo caecus distineo loquor luptatum macto magna pala. Abico ad aliquip aptent blandit exerci exputo neque nunc ut.\n\nAbbas amet damnum distineo meus premo roto singularis volutpat. Blandit conventio et eum facilisis macto pagus pertineo zelus. Causa euismod interdico nutus populus quis rusticus sagaciter. Eum in laoreet melior obruo suscipit virtus ymo. Diam euismod neque praesent. Abico haero incassum iusto magna pertineo utinam utrum. Letalis similis sit. Appellatio incassum modo obruo quidem tego ullamcorper velit veniam vicis.\n\nConsectetuer dolus et letalis suscipere usitas. Facilisi obruo praemitto. Consectetuer ex ludus natu. Abluo aliquip autem nimis si sudo valetudo zelus.\n\nDecet lobortis pecus pertineo suscipit venio. Abico augue autem lobortis os secundum volutpat. Cogo distineo facilisis luctus melior. Camur lobortis probo utinam. Antehabeo consequat iaceo neo neque patria vero.\n\nCaecus ea et. Abdo camur eligo letalis nibh proprius quia usitas vereor virtus. Commodo consectetuer diam euismod exputo premo te tum veniam verto.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '40', '40', 'und', '0', 'Amet appellatio natu pecus scisco te utrum valde. Amet commodo dolor elit iriure sagaciter saluto sudo te ut. Appellatio ea genitus lenis lobortis quia te usitas vel. Duis eligo lucidus proprius quae qui quis sagaciter tamen.\n\nBene cogo macto nibh occuro quidem sino ullamcorper validus wisi. Aliquip causa diam dolus ea occuro wisi. Dolore genitus meus olim quis singularis vindico. Brevitas commodo gravis importunus laoreet sudo venio wisi. Elit gemino hendrerit meus occuro saepius tamen venio vero. Aliquam aliquip commoveo elit eu iustum singularis vereor vulpes. Cogo distineo facilisi jus luptatum sagaciter similis.\n\nHos luctus mos nulla pala pertineo praemitto premo tincidunt. Commodo consequat molior populus typicus ullamcorper. Luptatum magna natu tincidunt voco. Appellatio incassum lenis nulla suscipit tincidunt torqueo typicus verto. Hos inhibeo lucidus olim sit utrum. Abico eum iaceo pertineo ratis vero.\n\nIn jumentum ratis volutpat. Aptent at duis in jus lenis odio refoveo rusticus. Haero iaceo nisl nobis. Abbas aptent exputo laoreet neque oppeto paulatim tamen valde. Aliquip exputo feugiat huic iusto jumentum neque pala vicis zelus.\n\nCapto fere gemino ibidem quia ullamcorper validus wisi. Abdo premo sino turpis. Abdo paratus pertineo. Distineo facilisis letalis utrum vereor. Dolore feugiat hendrerit in laoreet oppeto pala. Abico at exputo gemino paulatim praemitto ullamcorper utrum vulputate. Capto hos melior veniam vulputate wisi. Appellatio bene eum facilisis mos nulla oppeto quae quis saluto.\n\nEum hos letalis loquor. Elit luctus obruo persto probo suscipit tation ut. Eu immitto os si utinam vindico.\n\nAutem iaceo probo sed sit. Comis singularis valetudo wisi. Aliquip diam esse gravis iusto occuro.\n\nDolus suscipere tincidunt uxor wisi. Euismod laoreet lenis ludus modo neque nobis. Abdo ad damnum eu importunus lucidus nimis olim pagus ulciscor. Gravis pertineo premo. Cogo esse hos incassum nisl patria persto si. Aliquam iriure occuro persto singularis tum.\n\nHos loquor praesent suscipere tego. Diam dignissim facilisis nulla vel. Bene damnum exerci immitto nisl pertineo quis. Illum melior praesent tincidunt valetudo. Abbas capto erat haero hendrerit incassum nisl os pagus. Genitus hendrerit letalis mauris scisco torqueo tum ullamcorper. Eros exerci humo molior refero secundum sudo tego vel.\n\nBene cui exerci immitto patria suscipit venio. Eligo tation usitas vindico. Dignissim eros ideo imputo mos saepius vero. Decet importunus laoreet nunc occuro refero saluto te vulputate.\n\nAcsi autem inhibeo nobis paratus tego. Distineo jugis quadrum sagaciter vel vero voco. Adipiscing cogo euismod exerci odio. Antehabeo appellatio damnum ratis ymo. Brevitas caecus odio sagaciter turpis usitas vero. Blandit brevitas dolus euismod gravis nostrud nulla suscipit virtus. Comis dolor ille pecus quadrum scisco torqueo.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '41', '41', 'und', '0', 'Ad eligo iriure patria. Euismod ex pneum uxor. Autem nutus ut. Erat exputo facilisis patria quadrum singularis sit tum.\n\nAcsi humo jus loquor scisco turpis. Abdo abico modo neque uxor vicis. Antehabeo damnum hendrerit iusto nisl os si usitas utinam veniam. Ad eum lenis metuo obruo pertineo probo ratis uxor.\n\nDolore eligo gemino metuo similis volutpat. Aliquip aptent incassum interdico olim pala utrum. Comis cui euismod genitus jus letalis nimis scisco similis utinam. Euismod paratus valde wisi. Damnum luptatum minim. Euismod ideo neo. Acsi in tation velit zelus. Appellatio diam esca illum nibh nisl praesent.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '42', '42', 'und', '0', 'Hendrerit pala veniam. Enim iriure scisco. Accumsan huic iaceo lenis roto sino voco zelus. Aliquam illum inhibeo loquor luptatum magna praesent utrum uxor vindico. Abdo blandit elit ibidem iusto zelus. Commodo erat fere immitto jumentum nostrud nutus pagus.\n\nEsca iusto magna nutus os pala qui ut valde. Commoveo eu feugiat plaga populus qui ratis. Facilisi gravis mauris nibh oppeto os refero tincidunt torqueo. Eum inhibeo vel. Obruo os valetudo. Bene damnum genitus hendrerit nunc quia tincidunt virtus. Defui nobis os paratus quidne validus. Abigo dolore exputo nisl plaga quidne sagaciter te ullamcorper uxor. Blandit brevitas cui ex nulla quidem singularis usitas.\n\nAccumsan amet autem hendrerit jus meus rusticus tego ut. Gemino utrum vindico. Abigo autem iustum sagaciter. Comis hos obruo. Appellatio cui dignissim humo interdico odio praemitto praesent ut. Aliquam causa iustum jumentum olim pecus vel virtus. Aliquam autem dolor occuro pertineo vindico. Camur euismod in neo os persto plaga vulpes zelus. Gravis hos importunus luctus nibh quibus venio wisi.\n\nAppellatio eu euismod gilvus lucidus mauris modo nisl proprius. Adipiscing enim iaceo iusto mauris melior nibh pagus si usitas.\n\nEsse hos molior os. Abluo nobis premo sed. Adipiscing comis lobortis quia quidne refero roto sit vereor. Commoveo hos illum in laoreet nulla quibus ratis si suscipere.\n\nAcsi aliquam appellatio consequat esca importunus incassum loquor ulciscor velit. Abluo amet comis eu illum melior paratus plaga roto wisi. Autem brevitas et pala vel. Abluo hos melior nisl paulatim praesent qui singularis. Bene commoveo enim illum paulatim refoveo torqueo zelus. Abbas commodo hos quidem tum.\n\nAliquam nimis quidne ratis vicis. Appellatio huic lucidus. Iriure praesent tamen. Abbas cui eros humo praesent probo quia saepius vereor zelus. Antehabeo dolore ea jumentum magna nimis pneum quibus saepius torqueo. Cui dolor facilisi zelus. Huic meus neque nisl persto quadrum quia torqueo. At damnum erat eum natu refoveo secundum te usitas ymo. At facilisis interdico neo nutus populus quadrum rusticus ulciscor.\n\nAd causa minim quae quidne sit. Distineo facilisi nutus. Abdo aliquam erat melior praemitto quadrum singularis. Amet damnum diam haero. Euismod nibh quia sed. Amet esca euismod natu pala ymo. Causa commodo gravis jumentum neo tincidunt. Commoveo facilisis hendrerit typicus ulciscor. Damnum duis genitus letalis. Abico abigo bene consectetuer dignissim genitus virtus. Accumsan huic luptatum mauris natu tego.\n\nExerci gravis laoreet neque persto quidem sino tum ulciscor. Abdo autem gilvus in laoreet refero verto. Aliquam luptatum vereor vulputate. At duis eligo haero hendrerit nutus saepius similis sudo valetudo. Decet fere metuo molior vulputate. Elit haero iusto letalis molior quae tincidunt vereor.\n\nAbluo aptent consectetuer diam ludus neo quia secundum vulpes vulputate. Abigo comis incassum verto. Commodo consequat erat genitus ibidem modo nimis paulatim vulpes.\n\nAccumsan adipiscing aliquam amet capto eligo enim quadrum venio verto. Ad ex exputo quae voco ymo. Laoreet probo similis valde. Caecus commoveo eligo laoreet suscipere. Ea enim et illum jumentum modo singularis valde vel vereor. Ad decet dignissim letalis lobortis lucidus pertineo quidem roto singularis. Blandit eum interdico molior nobis nulla pneum valde. Dolor nisl olim.\n\n', NULL, 'full_html'),
('node', 'article', '0', '43', '43', 'und', '0', 'Duis similis vindico. Antehabeo euismod haero sudo suscipit. Abbas commodo consequat eligo jugis melior metuo olim praemitto utrum. Appellatio causa diam luptatum neo rusticus velit.\n\nAbbas facilisis quis utinam vicis. Abico adipiscing rusticus. Ea lenis paulatim. Aliquip comis gemino. At cui iusto lobortis. Aptent caecus exerci gemino humo inhibeo loquor populus valetudo. Commoveo hendrerit imputo iriure lenis paulatim premo sagaciter. Ea elit enim molior paulatim premo verto. Accumsan amet antehabeo brevitas comis et iaceo qui.\n\nAbigo importunus os quibus saluto similis tum velit. Blandit dolor eligo erat nimis suscipit. Cogo dolus feugiat jumentum molior velit venio vereor. Ideo jumentum nimis.\n\nAmet eum os pneum praesent velit voco zelus. Amet iustum lobortis voco. Augue consectetuer consequat enim iusto obruo os quae uxor.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '44', '44', 'und', '0', 'Haero tation voco. Adipiscing luctus praemitto typicus. Conventio dignissim dolore euismod ex luctus natu nibh quibus torqueo. Loquor mauris nunc odio os praesent utinam vulputate. Aliquam saluto suscipit wisi. Dignissim dolus natu saluto. Metuo persto utrum.\n\nEu utinam voco. Dignissim inhibeo jumentum laoreet quae wisi. Commodo haero illum iusto verto virtus.\n\nHaero natu plaga sino tincidunt ullamcorper. Appellatio augue melior patria paulatim vel. Interdico jumentum utinam venio vereor. Aliquam camur cui elit interdico probo quis scisco uxor.\n\nAbdo ludus nimis pertineo premo vulputate. Ad camur exputo hos iaceo metuo quibus si ulciscor voco. Patria pecus quae vicis. Aliquip bene eum luptatum nunc persto quia uxor. Causa os tamen tego wisi. Abdo esse gravis hendrerit humo jugis probo quis sudo vindico. Dolore genitus incassum. Acsi eum praemitto sagaciter. Iustum nunc olim scisco sino.\n\nAugue eros lucidus paulatim sagaciter. Appellatio blandit euismod iusto letalis pagus rusticus saluto valetudo. Augue eu eum importunus magna obruo utinam. Odio quia sagaciter volutpat. Dignissim eu letalis neque praemitto scisco venio virtus.\n\n', NULL, 'full_html'),
('node', 'article', '0', '45', '45', 'und', '0', 'At dolor illum magna odio zelus. Augue iustum suscipere verto. Consectetuer dolore lucidus luptatum nobis singularis ullamcorper utrum ymo. Commoveo esse eum laoreet roto turpis ullamcorper velit vulputate. Damnum eros genitus gilvus nunc premo tum. Acsi torqueo valetudo. Amet nibh rusticus veniam. Cogo consequat illum magna pneum tum zelus.\n\nMagna paratus proprius ullamcorper. Antehabeo brevitas immitto pecus usitas. Eligo luptatum macto vulputate. Damnum eros minim nisl si. Abluo cogo comis nobis nostrud obruo occuro sed similis vindico.\n\nPecus quia ullamcorper venio volutpat vulpes. Erat esca ex iaceo interdico oppeto quibus scisco tamen vulputate. Damnum ex iustum nisl saepius ullamcorper vindico volutpat. Accumsan amet decet elit macto metuo mos sagaciter sino suscipit.\n\nAbico gemino haero mos neo odio quis singularis tation virtus. Ad caecus cui mauris nimis os premo si tego valde.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '46', '46', 'und', '0', 'Ad aliquip causa damnum elit in ludus roto secundum tego. Similis torqueo ut. Aliquam esse lucidus plaga sagaciter virtus vulputate. Camur sino ullamcorper. Capto facilisi occuro patria. Feugiat natu si sudo tum. Imputo interdico sudo zelus. Antehabeo augue interdico lobortis saepius singularis ullamcorper utinam. Facilisis secundum sed si zelus.\n\nEu hos olim. Ad antehabeo autem commoveo sit. Dignissim lenis nibh occuro praemitto refero vulputate. Conventio neque vindico. Abbas abico ad conventio erat et importunus modo oppeto secundum. Genitus os quidne suscipere. Humo iusto obruo persto quadrum quae tum vel. Abigo exerci lobortis veniam vicis. At cui elit esse gravis minim persto.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '47', '47', 'und', '0', 'Abigo euismod haero interdico nimis secundum. Accumsan ille sed tation. Amet plaga sed. Abbas decet elit eros incassum luctus persto. Aliquam ratis refoveo verto. Aliquam at iaceo ludus magna quae tincidunt torqueo voco. Dolor dolore dolus huic ibidem ille suscipit vicis ymo. Adipiscing bene cui nobis praemitto probo quidem tincidunt vel. Camur consequat esca hos iusto probo typicus.\n\nIlle iusto premo quis veniam vulpes. Amet at ille jus obruo oppeto pala suscipit tum venio. Abbas quae turpis. Cogo commodo euismod exerci verto. Roto valde vero. Camur consequat defui facilisis hendrerit lobortis tum. Ad et importunus molior obruo. Haero inhibeo premo veniam. Conventio duis importunus iustum luptatum nibh praemitto ratis ut. Abluo aptent laoreet macto sed. Brevitas haero ludus olim utinam.\n\nAmet dolus eros os paulatim. Aliquip antehabeo brevitas commoveo hos inhibeo nibh populus praemitto ulciscor. Damnum nisl qui. Cogo haero laoreet mauris neque paulatim te. Et ex gilvus huic ille mos nimis pagus vulpes vulputate. Ad blandit ea magna os pala pecus premo. Abigo letalis neo oppeto tego typicus validus veniam.\n\nBene et exerci feugiat laoreet melior pneum suscipit voco. Aliquam capto duis facilisis jumentum lenis luctus nostrud ulciscor. Capto damnum ludus melior os paratus scisco si.\n\nHuic jugis quadrum refoveo. Facilisis importunus nunc olim si sino tego. Feugiat nibh quia utrum zelus. Commoveo esca luctus persto. Cogo fere feugiat olim pneum saepius vindico.\n\n', NULL, 'full_html'),
('node', 'article', '0', '48', '48', 'und', '0', 'Enim et ex ibidem ille pneum si te valetudo. Damnum eros facilisis quia rusticus validus wisi. Antehabeo eu huic ibidem incassum nimis paulatim rusticus utinam validus. Defui ex veniam. Acsi nisl scisco vereor. Blandit damnum odio uxor. Elit feugiat mauris meus praesent utinam. Cui dolore gilvus haero mos torqueo. Consectetuer importunus tamen wisi.\n\nAccumsan camur eros lucidus praemitto quidne virtus. Melior natu occuro plaga typicus. Antehabeo camur distineo gilvus nostrud populus. Damnum decet defui facilisi nimis paulatim quidne rusticus vel vindico.\n\nBlandit camur et gemino nimis persto. Interdico luptatum odio pala saepius. Abico elit hendrerit macto mauris metuo molior obruo occuro refoveo. Facilisis jumentum singularis tum. Consectetuer duis gemino ille nostrud os refoveo sit virtus ymo.\n\nConsectetuer gilvus interdico venio. Luctus nisl pertineo. Acsi antehabeo eros euismod huic macto nimis si. Eros eu haero praesent si. Causa consequat dignissim eum hos nulla pala quidem refoveo vicis. Augue jus nobis ulciscor. Duis euismod quae ullamcorper.\n\nErat euismod exerci jugis meus saepius sed si usitas vulpes. Diam immitto jumentum minim natu plaga.\n\nErat ibidem loquor mauris meus. Jus melior odio patria vel. Autem caecus melior quae qui.\n\nAppellatio causa cogo cui damnum melior persto sudo tation ullamcorper. Duis ea facilisis gravis suscipit. Abigo dolus esca ideo velit zelus.\n\nConsequat dolore facilisis huic loquor sed. Adipiscing causa humo lucidus vicis. Abluo laoreet nostrud pecus usitas. Abdo elit eum ideo imputo mos tum utrum.\n\nAppellatio augue cui melior populus roto si sudo vindico. Blandit causa esca exerci iaceo.\n\nAd euismod ex gemino laoreet macto neque patria scisco venio. Adipiscing caecus damnum decet immitto probo tation wisi. Abico consequat damnum loquor pagus quidne sudo suscipit ut.\n\nAccumsan comis feugiat iusto luptatum sudo torqueo. Inhibeo laoreet ratis similis usitas. Causa gravis haero iaceo melior nobis praesent si usitas voco. Abbas hos immitto interdico iusto macto vicis. At letalis loquor usitas. Ad caecus dolor hos illum iriure letalis nulla paulatim. Appellatio esse odio. Bene euismod gravis quidem similis uxor. Camur commoveo defui nobis obruo praemitto premo tego valde.\n\nAugue consectetuer cui exputo gilvus immitto neo verto vindico. Huic humo magna similis. Augue cui feugiat gemino iaceo lobortis valde veniam. Diam erat praesent tego. Causa premo volutpat. Acsi brevitas commoveo cui dolor proprius vindico. Accumsan dignissim esse jumentum os ulciscor voco. Cogo cui feugiat ludus macto natu refero tation ut utinam.\n\n', NULL, 'full_html'),
('node', 'article', '0', '49', '49', 'und', '0', 'Distineo ille ludus. Dolor ex nunc veniam. Melior quis singularis valde. At inhibeo jugis ludus mos nisl quadrum ratis si vel. Abbas abigo consequat genitus neo refero sino sit te vereor. Ad bene caecus letalis pala paratus suscipit valetudo verto. Bene dolor eligo humo modo. Elit iustum luptatum macto molior paratus typicus vereor.\n\nIlle in valetudo. Humo ille praemitto. Esse jugis melior neo praemitto refero virtus. Blandit huic natu neque odio wisi. Amet conventio elit odio rusticus. Exputo genitus qui quibus sit te utrum. Abigo autem esse haero huic neque persto praesent secundum vicis. Autem ex gilvus pagus quia quibus rusticus saluto tincidunt utinam.\n\nAbigo aliquip commodo consequat decet humo refero vel vindico. Jugis natu nimis pagus patria suscipit vicis.\n\nFacilisi importunus lenis neo qui saepius torqueo velit. At eu feugiat imputo incassum letalis sed singularis turpis venio. Commoveo gilvus inhibeo jus mos. Premo quidem utinam. Gilvus ludus luptatum suscipit uxor. Autem cogo facilisis letalis melior plaga sino tation. Abdo accumsan decet distineo genitus in luptatum ut voco.\n\nCui dolus molior pagus paratus similis. At praesent quis rusticus saepius scisco tego verto.\n\nBlandit luctus premo quadrum quae si. Appellatio capto lucidus pertineo tum utrum venio zelus. Abluo bene nisl paulatim plaga quadrum. Abico probo ymo. Abdo distineo hendrerit ibidem jumentum melior si valde venio. Abbas huic iustum os praemitto. Aliquam eligo exputo gravis metuo nutus occuro probo secundum. Capto cui eligo exputo.\n\nPlaga saluto utinam validus. Gemino humo meus natu valde. Letalis patria quadrum si. Abluo caecus feugiat gilvus immitto olim pertineo tamen ulciscor.\n\nCommoveo eligo meus. Aptent damnum immitto lobortis mauris occuro oppeto os quidne tum.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '50', '50', 'und', '0', 'Cogo damnum defui loquor virtus zelus. Abbas ad adipiscing consectetuer feugiat iriure persto quibus saepius virtus. Hendrerit ibidem oppeto quae sit venio. Abigo autem decet diam pagus pecus suscipere. Aliquip amet capto gravis nibh nisl rusticus ullamcorper ut validus.\n\nAt autem bene loquor melior quidem vereor. Aptent commoveo iusto loquor melior nibh nulla praemitto quae virtus. Accumsan gemino saluto. Ea et ibidem. Consectetuer elit neo praesent proprius secundum venio. Ad facilisi fere feugiat gravis importunus suscipere tincidunt. Abigo ad camur feugiat ludus nobis nulla ut voco. Immitto incassum nimis quis. Appellatio brevitas probo qui veniam vulpes. Cogo luctus nostrud quadrum roto ullamcorper velit veniam voco.\n\nAdipiscing aliquam eum facilisi molior nunc roto similis sit veniam. Aliquam causa feugiat interdico magna neque pecus. Et lenis modo nulla pertineo tincidunt utinam vicis. At consectetuer conventio minim natu ulciscor veniam. Abluo jumentum natu obruo ullamcorper vicis.\n\nEx iaceo incassum usitas veniam. Facilisis genitus ratis volutpat ymo. Defui distineo letalis. Abdo ex illum occuro. Eros paratus suscipere. Abigo adipiscing capto iusto iustum nibh singularis tego valetudo. Commodo luptatum secundum vulpes. Dignissim dolus wisi. Dignissim gravis magna nibh quia. Abigo duis facilisi genitus mauris minim sagaciter turpis.\n\nCaecus erat humo occuro. Amet et exerci ratis tego tincidunt. Brevitas gilvus populus vero verto volutpat. Consequat illum incassum turpis. Abdo ideo incassum. Humo jus quae. Acsi et iustum ludus modo occuro paratus quia.\n\nBrevitas dignissim incassum. Camur luctus voco. Comis lobortis obruo saluto valde. Aliquip bene ille jugis singularis turpis. Abbas dolor melior modo te torqueo ut. Acsi at diam erat exerci pneum quae saluto tum.\n\n', NULL, 'full_html'),
('node', 'article', '0', '51', '51', 'und', '0', 'Elit hendrerit incassum nisl occuro quidem validus vulpes. Acsi autem blandit distineo sed suscipere. At erat huic iustum natu proprius tation ulciscor. Acsi capto eum gemino luctus meus neo secundum ulciscor virtus. Decet humo nisl os pala validus wisi. Eum jus luctus magna.\n\nAd aliquip duis imputo obruo quidem turpis validus. Conventio et feugiat immitto lenis letalis. Commoveo eu importunus imputo jugis nobis persto roto similis utrum. Enim incassum si. Cogo eros gravis refero ullamcorper. Abico diam eu feugiat haero olim quis refoveo tum uxor. Blandit dolor importunus iustum mos pala probo tation te validus. Abbas eu exputo gemino lucidus si vulpes.\n\nAdipiscing blandit caecus dolor inhibeo neque pneum sudo. Cogo macto pecus vereor. Abdo et exerci ibidem tation. At imputo quia velit. Consequat exerci haero obruo quadrum ullamcorper. Aliquam dolor dolus importunus interdico modo nunc probo proprius refero. Commoveo distineo dolore erat exputo importunus in paratus tego valde.\n\nEa erat eu imputo quis. Genitus praesent proprius quibus secundum. Eu jus olim. Consequat conventio jus refoveo similis sit usitas. Aliquip duis et haero immitto melior ullamcorper uxor vel. Abluo antehabeo caecus cogo elit gravis luctus neo quadrum valde.\n\nAppellatio nimis saluto sit wisi. Autem in luctus vel veniam virtus. Gravis iaceo interdico populus praemitto refero utrum velit. At consectetuer diam jus lobortis lucidus nutus. Jumentum letalis scisco singularis sit tego.\n\nDolus exputo nobis sed te velit. Augue ideo melior minim nisl praemitto quadrum ratis tego. Eros iustum mos veniam vicis. Appellatio commodo commoveo iusto saluto. Abdo accumsan aliquam esca letalis patria pertineo quadrum saepius sed.\n\n', NULL, 'full_html');
/*!40000 ALTER TABLE field_data_body ENABLE KEYS */;

--
-- Table structure for table 'field_data_comment_body'
--

CREATE TABLE IF NOT EXISTS `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Data storage for field 1 (comment_body)';

--
-- Dumping data for table 'field_data_comment_body'
--

/*!40000 ALTER TABLE field_data_comment_body DISABLE KEYS */;
/*!40000 ALTER TABLE field_data_comment_body ENABLE KEYS */;

--
-- Table structure for table 'field_data_field_image'
--

CREATE TABLE IF NOT EXISTS `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Data storage for field 4 (field_image)';

--
-- Dumping data for table 'field_data_field_image'
--

/*!40000 ALTER TABLE field_data_field_image DISABLE KEYS */;
INSERT INTO `field_data_field_image` VALUES
('node', 'article', '0', '27', '27', 'und', '0', '13', 'Causa eu ex lenis letalis odio typicus usitas virtus.', 'Antehabeo in inhibeo praemitto praesent ratis sino ymo.', '496', '339'),
('node', 'article', '0', '28', '28', 'und', '0', '14', 'Abluo scisco turpis vulputate.', 'Consectetuer ideo illum modo pala proprius valde wisi.', '144', '341'),
('node', 'article', '0', '29', '29', 'und', '0', '15', 'Aliquam blandit obruo. Camur elit humo ille iriure luctus oppeto pala si virtus.', 'Abdo amet appellatio defui lucidus meus ullamcorper.', '310', '114'),
('node', 'article', '0', '30', '30', 'und', '0', '16', 'Illum neque olim ratis similis ullamcorper ut.', 'Adipiscing caecus gemino letalis minim pecus turpis ymo.', '373', '347'),
('node', 'article', '0', '31', '31', 'und', '0', '17', 'Feugiat letalis nutus sudo.', 'Camur jus meus plaga suscipere.', '464', '183'),
('node', 'article', '0', '32', '32', 'und', '0', '18', 'Damnum facilisi iaceo. Commoveo nimis praesent velit.', 'Brevitas damnum exerci inhibeo jugis macto nisl plaga praemitto.', '261', '396'),
('node', 'article', '0', '33', '33', 'und', '0', '19', 'Abdo imputo incassum interdico proprius ut wisi.', 'Ibidem lobortis macto sed si te tego.', '149', '493'),
('node', 'article', '0', '34', '34', 'und', '0', '20', 'Abbas cui defui elit eu gilvus gravis saluto vulputate.', 'Diam humo vulpes wisi.', '152', '273'),
('node', 'article', '0', '35', '35', 'und', '0', '21', 'Ad laoreet meus quis sit tum utinam.', 'Eum illum incassum nutus paulatim pertineo roto vulpes ymo.', '383', '277'),
('node', 'article', '0', '36', '36', 'und', '0', '22', 'Augue consectetuer facilisis olim pertineo quidem singularis validus.', 'Euismod patria proprius similis tamen te.', '448', '258'),
('node', 'article', '0', '37', '37', 'und', '0', '23', 'Appellatio comis nulla obruo quadrum refoveo te ullamcorper vereor.', 'Appellatio dolore duis haero laoreet melior pala paratus pneum premo.', '502', '426'),
('node', 'article', '0', '38', '38', 'und', '0', '15', 'Amet dolor duis incassum neo probo quibus sino ulciscor vero.', 'Causa decet eros obruo sit tum venio vulpes.', '310', '114'),
('node', 'article', '0', '39', '39', 'und', '0', '14', 'Obruo veniam vulpes. Caecus consectetuer elit ex laoreet mauris veniam.', 'Appellatio et inhibeo luctus magna paulatim proprius singularis.', '144', '341'),
('node', 'article', '0', '40', '40', 'und', '0', '21', 'Autem cui imputo magna minim nostrud suscipere validus.', 'Camur ex tamen torqueo.', '383', '277'),
('node', 'article', '0', '41', '41', 'und', '0', '19', 'Dolore eu gravis mos nostrud patria praesent quibus rusticus.', 'Antehabeo esse haero melior validus wisi ymo.', '149', '493'),
('node', 'article', '0', '42', '42', 'und', '0', '24', 'Genitus iaceo neo tation.', 'Ea nunc secundum. Et gemino hendrerit saluto te valetudo vero volutpat.', '367', '406'),
('node', 'article', '0', '43', '43', 'und', '0', '15', 'Acsi blandit dignissim distineo facilisi pneum refoveo.', 'Abigo adipiscing eros exerci inhibeo interdico olim singularis ymo.', '310', '114'),
('node', 'article', '0', '44', '44', 'und', '0', '18', 'Commodo duis illum neque pneum premo sit.', 'Abluo amet dolor exputo iustum qui sit virtus.', '261', '396'),
('node', 'article', '0', '45', '45', 'und', '0', '17', 'Commoveo damnum gilvus magna pala tego usitas vel vero zelus.', 'Et facilisi haero lucidus nunc praesent saepius sagaciter utrum virtus.', '464', '183'),
('node', 'article', '0', '46', '46', 'und', '0', '22', 'Abigo mauris nisl quadrum quia sino typicus.', 'Elit gilvus interdico luptatum odio premo si.', '448', '258'),
('node', 'article', '0', '47', '47', 'und', '0', '21', 'Commodo dolore incassum pertineo tum.', 'Huic quae quidem vel.', '383', '277'),
('node', 'article', '0', '48', '48', 'und', '0', '18', 'Camur cogo eros minim virtus.', 'Bene plaga quadrum quidem refero vero.', '261', '396'),
('node', 'article', '0', '49', '49', 'und', '0', '23', 'Esca et exputo gemino.', 'Abluo commodo consequat enim hendrerit huic ille laoreet verto ymo.', '502', '426'),
('node', 'article', '0', '50', '50', 'und', '0', '15', 'Esse gemino sed suscipit vicis.', 'Persto plaga probo vereor.', '310', '114'),
('node', 'article', '0', '51', '51', 'und', '0', '23', 'Commoveo consectetuer defui enim quae quia.', 'Esca humo scisco tincidunt.', '502', '426');
/*!40000 ALTER TABLE field_data_field_image ENABLE KEYS */;

--
-- Table structure for table 'field_data_field_school_year'
--

CREATE TABLE IF NOT EXISTS `field_data_field_school_year` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_school_year_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_school_year_tid` (`field_school_year_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Data storage for field 6 (field_school_year)';

--
-- Dumping data for table 'field_data_field_school_year'
--

/*!40000 ALTER TABLE field_data_field_school_year DISABLE KEYS */;
INSERT INTO `field_data_field_school_year` VALUES
('node', 'article', '0', '27', '27', 'und', '0', '9'),
('node', 'article', '0', '28', '28', 'und', '0', '6'),
('node', 'article', '0', '29', '29', 'und', '0', '6'),
('node', 'article', '0', '30', '30', 'und', '0', '10'),
('node', 'article', '0', '31', '31', 'und', '0', '6'),
('node', 'article', '0', '32', '32', 'und', '0', '8'),
('node', 'article', '0', '33', '33', 'und', '0', '6'),
('node', 'article', '0', '34', '34', 'und', '0', '9'),
('node', 'article', '0', '35', '35', 'und', '0', '6'),
('node', 'article', '0', '36', '36', 'und', '0', '8'),
('node', 'article', '0', '37', '37', 'und', '0', '6'),
('node', 'article', '0', '38', '38', 'und', '0', '7'),
('node', 'article', '0', '39', '39', 'und', '0', '6'),
('node', 'article', '0', '40', '40', 'und', '0', '10'),
('node', 'article', '0', '41', '41', 'und', '0', '6'),
('node', 'article', '0', '42', '42', 'und', '0', '6'),
('node', 'article', '0', '43', '43', 'und', '0', '6'),
('node', 'article', '0', '44', '44', 'und', '0', '6'),
('node', 'article', '0', '45', '45', 'und', '0', '6'),
('node', 'article', '0', '46', '46', 'und', '0', '6'),
('node', 'article', '0', '47', '47', 'und', '0', '6'),
('node', 'article', '0', '48', '48', 'und', '0', '6'),
('node', 'article', '0', '49', '49', 'und', '0', '6'),
('node', 'article', '0', '50', '50', 'und', '0', '6'),
('node', 'article', '0', '51', '51', 'und', '0', '7');
/*!40000 ALTER TABLE field_data_field_school_year ENABLE KEYS */;

--
-- Table structure for table 'field_data_field_sections'
--

CREATE TABLE IF NOT EXISTS `field_data_field_sections` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_sections_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_sections_tid` (`field_sections_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Data storage for field 5 (field_sections)';

--
-- Dumping data for table 'field_data_field_sections'
--

/*!40000 ALTER TABLE field_data_field_sections DISABLE KEYS */;
INSERT INTO `field_data_field_sections` VALUES
('node', 'article', '0', '2', '2', 'und', '0', '5'),
('node', 'article', '0', '27', '27', 'und', '0', '5'),
('node', 'article', '0', '28', '28', 'und', '0', '5'),
('node', 'article', '0', '29', '29', 'und', '0', '5'),
('node', 'article', '0', '30', '30', 'und', '0', '5'),
('node', 'article', '0', '31', '31', 'und', '0', '5'),
('node', 'article', '0', '32', '32', 'und', '0', '5'),
('node', 'article', '0', '33', '33', 'und', '0', '5'),
('node', 'article', '0', '34', '34', 'und', '0', '5'),
('node', 'article', '0', '35', '35', 'und', '0', '5'),
('node', 'article', '0', '36', '36', 'und', '0', '5'),
('node', 'article', '0', '37', '37', 'und', '0', '5'),
('node', 'article', '0', '38', '38', 'und', '0', '5'),
('node', 'article', '0', '39', '39', 'und', '0', '5'),
('node', 'article', '0', '40', '40', 'und', '0', '5'),
('node', 'article', '0', '41', '41', 'und', '0', '5'),
('node', 'article', '0', '42', '42', 'und', '0', '5'),
('node', 'article', '0', '43', '43', 'und', '0', '5'),
('node', 'article', '0', '44', '44', 'und', '0', '5'),
('node', 'article', '0', '45', '45', 'und', '0', '5'),
('node', 'article', '0', '46', '46', 'und', '0', '5'),
('node', 'article', '0', '47', '47', 'und', '0', '5'),
('node', 'article', '0', '48', '48', 'und', '0', '5'),
('node', 'article', '0', '49', '49', 'und', '0', '5'),
('node', 'article', '0', '50', '50', 'und', '0', '5'),
('node', 'article', '0', '51', '51', 'und', '0', '5');
/*!40000 ALTER TABLE field_data_field_sections ENABLE KEYS */;

--
-- Table structure for table 'field_data_field_tags'
--

CREATE TABLE IF NOT EXISTS `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Data storage for field 3 (field_tags)';

--
-- Dumping data for table 'field_data_field_tags'
--

/*!40000 ALTER TABLE field_data_field_tags DISABLE KEYS */;
/*!40000 ALTER TABLE field_data_field_tags ENABLE KEYS */;

--
-- Table structure for table 'field_revision_body'
--

CREATE TABLE IF NOT EXISTS `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Revision archive storage for field 2 (body)';

--
-- Dumping data for table 'field_revision_body'
--

/*!40000 ALTER TABLE field_revision_body DISABLE KEYS */;
INSERT INTO `field_revision_body` VALUES
('node', 'article', '0', '1', '1', 'und', '0', 'Principal Dries has commissioned this exciting new Web site.\r\nThis Web site is based on Drupal - the powerful CMS with outstanding support for building a community-based Web site.\r\nCheck back often as this Web site will take off fast!\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi commodo, ipsum sed pharetra gravida, orci magna rhoncus neque, id pulvinar odio lorem non turpis. Nullam sit amet enim. Suspendisse id velit vitae ligula volutpat condimentum. Aliquam erat volutpat. Sed quis velit. Nulla facilisi. Nulla libero. Vivamus pharetra posuere sapien. Nam consectetuer. Sed aliquam, nunc eget euismod ullamcorper, lectus nunc ullamcorper orci, fermentum bibendum enim nibh eget ipsum. Donec porttitor ligula eu dolor. Maecenas vitae nulla consequat libero cursus venenatis. Nam magna enim, accumsan eu, blandit sed, blandit a, eros.\r\n\r\nQuisque facilisis erat a dui. Nam malesuada ornare dolor. Cras gravida, diam sit amet rhoncus ornare, erat elit consectetuer erat, id egestas pede nibh eget odio. Proin tincidunt, velit vel porta elementum, magna diam molestie sapien, non aliquet massa pede eu diam. Aliquam iaculis. Fusce et ipsum et nulla tristique facilisis. Donec eget sem sit amet ligula viverra gravida. Etiam vehicula urna vel turpis. Suspendisse sagittis ante a urna. Morbi a est quis orci consequat rutrum. Nullam egestas feugiat felis. Integer adipiscing semper ligula. Nunc molestie, nisl sit amet cursus convallis, sapien lectus pretium metus, vitae pretium enim wisi id lectus. Donec vestibulum. Etiam vel nibh. Nulla facilisi. Mauris pharetra. Donec augue.\r\n', 'This is a quick summary of our story.\r\nFusce et ipsum et nulla tristique facilisis. Donec eget sem sit amet ligula viverra gravida. Etiam vehicula urna vel turpis. Suspendisse sagittis ante a urna. Morbi a est quis orci consequat rutrum.\r\n', 'filtered_html'),
('node', 'article', '0', '2', '2', 'und', '0', '<p><strong>Principal Dries</strong> here!</p> <p>Welcome to a new school year at Drupal U! We hope you are looking forward to the new year just as we are. Check back soon for more news and information. We''ll have information for students, teachers, and parents.</p> <p> - <em>D.B</em></p>', '', 'filtered_html'),
('node', 'page', '0', '3', '3', 'und', '0', 'Placeholder for an about us page.', '', 'filtered_html'),
('node', 'page', '0', '5', '5', 'und', '0', ' <ul><li><a href="www.Drupal .org">Drupal Home Page</a></li><li><a href="http://groups.Drupal .org">Drupal Groups</a></li></ul>', '', 'filtered_html'),
('node', 'page', '0', '6', '6', 'und', '0', '<ul><li>Dries</li><li>Webchick</li><li>chx</li><li>merlinofchaos</li></ul>', '', 'filtered_html'),
('node', 'article', '0', '27', '27', 'und', '0', 'Causa cogo defui feugiat hendrerit praemitto quis roto valetudo vulpes. Ea exputo illum nisl nostrud os voco zelus. Abluo acsi comis facilisi iriure laoreet nulla nutus scisco. Dignissim duis gravis hos jumentum loquor secundum turpis. Gilvus obruo patria. Camur ea eros iriure metuo praemitto utinam vereor.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '28', '28', 'und', '0', 'Abbas abigo aptent fere molior olim pala premo vel vulpes. Decet esca facilisis hos huic quibus sed suscipit vereor. Aliquam damnum distineo facilisi gemino interdico jugis quidne.\n\nAd conventio cui genitus iriure paulatim te usitas ut. Mauris melior wisi. Augue loquor pala pneum singularis uxor vulpes. Abdo huic melior mos quae sudo tation verto vicis.\n\n', NULL, 'full_html'),
('node', 'article', '0', '29', '29', 'und', '0', 'Abico amet antehabeo aptent camur dignissim hendrerit suscipere turpis valetudo. Damnum nimis probo quidem. Feugiat gemino imputo iustum modo obruo pagus proprius turpis zelus. Dignissim eu ibidem letalis molior tamen tego typicus wisi. Conventio hendrerit huic iustum occuro pala roto sit utrum. Comis ea letalis saluto. Brevitas ludus mos ratis tum. Abbas interdico loquor oppeto velit. At mauris os pagus praesent ulciscor.\n\nDuis exputo hendrerit immitto magna nobis odio quis suscipit. Blandit comis commoveo conventio feugiat olim quadrum vel vicis. Blandit consectetuer dolore elit et praemitto sagaciter.\n\nAbdo bene blandit cogo decet duis enim luctus mauris torqueo. In nutus odio vulpes. Autem blandit causa cogo fere haero quibus saluto. Aliquip capto luptatum nutus paulatim valetudo.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '30', '30', 'und', '0', 'Abluo brevitas defui et hos veniam. Dignissim dolor esca nibh te ut. At blandit metuo modo similis typicus ullamcorper volutpat ymo. Amet cogo erat. Hendrerit ideo pertineo pneum si tego torqueo uxor. Ea feugiat mos utinam. Abbas ad eligo lenis mos pagus ullamcorper usitas verto. Ad antehabeo dignissim gemino lobortis torqueo. Dignissim ex iustum modo sino valde.\n\nAbbas duis ea et eu fere hendrerit magna validus voco. Euismod fere gravis iustum luptatum paulatim praesent utrum valde voco. Abbas adipiscing aliquam lenis. Facilisis os si te. Ibidem nunc pneum saluto typicus. Accumsan commodo facilisis plaga praesent ulciscor ymo. Cogo dolor ea quibus vereor vicis. Eligo ibidem illum torqueo. Aptent humo illum molior secundum sit torqueo vero.\n\nAntehabeo dolus fere feugiat hos iustum nobis. Augue incassum quis secundum si turpis ut. Defui enim exputo melior. Neo paratus tego utinam venio. Ludus minim refero. Camur conventio haero ratis sed vel.\n\nIdeo sed similis tamen. Eu praemitto refoveo wisi. Caecus humo paratus quidem tamen usitas. Amet autem eum modo ulciscor.\n\nAccumsan modo nibh premo secundum tamen tum vel. Dolore gilvus humo meus natu neque populus ut. At consectetuer erat huic luctus saluto valde. Cui suscipit tation verto vicis. Bene inhibeo metuo molior obruo quidem venio. Fere jumentum praesent tego vulpes. Acsi capto erat eros nibh pala proprius sudo wisi. Abigo aliquam dolus molior neque suscipit tego veniam.\n\nAd diam ex occuro os pertineo pneum scisco. Facilisi humo importunus praemitto. Et pneum qui. Amet at commodo consequat illum olim suscipere. Appellatio capto magna modo ut.\n\nFeugiat quibus tum. Abico appellatio distineo dolore iaceo imputo luptatum tincidunt veniam vicis. Ea facilisi iustum quidem. Antehabeo diam valetudo. Ex iriure jugis nimis nutus pertineo saepius torqueo.\n\nAccumsan eligo feugiat gravis humo meus secundum sino typicus validus. Importunus singularis tamen uxor. Aliquip esca esse iaceo. Blandit et ideo letalis nimis rusticus secundum tincidunt ullamcorper. Haero immitto occuro tamen. Acsi consectetuer melior sagaciter. Augue capto consectetuer jus magna mauris molior refoveo te wisi.\n\nLuctus nunc os te. Hendrerit illum premo virtus. Gilvus gravis loquor ludus te vel. Cogo comis gravis minim olim proprius tation typicus ut volutpat.\n\nFacilisis incassum mos. Luptatum nulla obruo singularis tum utinam velit verto volutpat zelus. Augue eligo ibidem nibh saluto secundum ullamcorper vero. Elit erat eu fere huic ibidem minim praesent ratis singularis. Aptent blandit gravis ibidem metuo vel vicis. Abico blandit eligo esca inhibeo neque nunc saepius ullamcorper valde. Abico commodo dignissim duis et gilvus nutus si ullamcorper.\n\nAbluo eros lenis macto natu populus. Distineo ideo si. Accumsan causa dolus enim eum gemino nutus suscipere. Abigo acsi brevitas distineo esca nostrud tego tincidunt veniam. Caecus elit facilisis jumentum nibh nisl qui saluto tation utinam. Acsi capto elit loquor obruo tamen tation. Consectetuer gravis macto obruo scisco torqueo ullamcorper ymo. Humo pala rusticus usitas.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '31', '31', 'und', '0', 'Accumsan consectetuer dolor molior nisl rusticus tego utinam. Bene laoreet macto neque tation tincidunt vindico wisi. Aptent at illum laoreet lucidus neque plaga quidem veniam. Abdo esse hendrerit importunus luptatum ut valde. Abico enim in ludus roto secundum valde vereor. Dolore gemino molior obruo paratus premo quae roto zelus.\n\nIdeo jus neque nibh praesent vindico vulpes. Abbas augue dignissim huic si tego ullamcorper velit.\n\nAdipiscing camur conventio ideo laoreet magna mauris quidem saluto suscipit. Augue blandit gravis immitto neo nunc persto utinam vulpes. Aliquip amet aptent et fere in interdico neo probo te. Genitus probo veniam venio vero volutpat. Aptent metuo odio persto. Feugiat melior nutus occuro quidem roto sed vereor vicis. Defui laoreet ullamcorper vicis. Eligo facilisis iusto odio. Dolore et fere gravis metuo olim quia.\n\nEligo elit meus obruo paulatim vindico. Erat feugiat in qui refero utrum. Interdico nulla sagaciter. Antehabeo hendrerit iriure neo pneum typicus vindico.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '32', '32', 'und', '0', 'Decet eum facilisi ibidem interdico macto magna meus paulatim vero. Aptent dignissim interdico ludus premo rusticus zelus. Consequat ludus pala sit ullamcorper wisi. Facilisi in interdico nibh pertineo proprius quibus roto ymo zelus.\n\nIn iriure jus odio quis ullamcorper valetudo. Aliquam cui enim et iustum nisl si. Consectetuer ille nibh. Conventio dolor duis eum quidem sed veniam voco. Fere refoveo similis te. Hos interdico ludus. Dignissim dolus eum vulputate. Damnum genitus illum importunus jus molior populus si singularis. Cogo eligo erat huic iaceo lenis luctus paulatim tation.\n\nAugue hos importunus lenis pecus praemitto vereor zelus. Cogo euismod ex gemino natu nutus saluto. Enim erat eum humo illum minim nostrud refoveo saluto volutpat. Abico ad inhibeo lucidus nibh obruo verto vulputate.\n\nDolus lobortis metuo mos natu os si. Amet os tego. Damnum erat haero interdico minim quidne secundum similis vicis. Antehabeo gravis humo iriure pertineo sudo. Abigo abluo conventio decet virtus wisi. Brevitas hos imputo iusto luptatum mos os praemitto.\n\nAntehabeo gilvus quia tum utrum ymo. Aptent ex gemino gilvus nostrud quidne similis torqueo. Dolore esca ex hos illum inhibeo si tamen verto. Augue minim populus tego. Adipiscing eum ex lucidus oppeto scisco. Appellatio genitus jugis mauris metuo. Ille illum neque paulatim similis sit veniam volutpat.\n\nAcsi aliquip molior neo tego. Enim nimis os. Gemino mauris paratus sagaciter usitas. Amet causa comis eros eu lenis luptatum quae qui velit.\n\nEum nunc quia. Aptent importunus letalis magna melior paratus probo uxor.\n\nMetuo quidne sagaciter. Camur hendrerit paratus verto. Commoveo cui feugiat nunc. Commodo consequat iriure iusto. Adipiscing distineo melior nulla probo ullamcorper velit.\n\nConventio macto oppeto pecus premo tincidunt. Dolus esca exerci. Et mauris plaga pneum saepius sagaciter scisco singularis wisi. Autem euismod facilisis interdico iriure iustum paulatim sudo volutpat. Defui luctus melior pagus.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '33', '33', 'und', '0', 'Qui sagaciter singularis venio. Blandit commodo esca in lobortis ludus metuo os utinam. Mauris pecus te validus. Abdo autem molior pecus. Aliquip duis esca iaceo immitto neque plaga ratis similis singularis.\n\nAd aliquam ea elit nimis quadrum singularis. At incassum refero tamen. Ex nobis refoveo vicis vulpes. Abbas bene fere lobortis quidem. Abico adipiscing camur causa cui gemino ibidem populus te. Acsi aliquam capto distineo gravis lobortis lucidus nutus saluto.\n\nEligo lucidus paratus tamen. Incassum ludus paulatim ulciscor. Camur ille nunc. Elit eu illum immitto molior premo quae qui sudo utinam. Gemino ille iusto macto paratus quadrum refero. Meus nimis premo tego.\n\nCogo haero iriure nutus ymo. Adipiscing euismod huic illum jugis jus modo nisl. Capto eu loquor luptatum meus nunc populus saluto sudo tego.\n\nAmet dignissim erat eros minim occuro. Gemino paulatim refero secundum singularis suscipit. Abigo blandit euismod luctus quadrum quidem tation tincidunt. Autem ludus proprius valetudo. Abico augue comis distineo. Abigo cogo genitus imputo iriure paulatim sagaciter utinam.\n\nAd amet diam luctus occuro scisco te tego valde. Premo rusticus suscipit tincidunt utinam. Abigo appellatio conventio genitus iriure nimis odio quidem torqueo.\n\nDolor fere gemino iusto lucidus natu obruo vulputate. Abluo ad jugis loquor luptatum natu quidne saepius. Bene gemino iriure neo pagus refoveo sino venio zelus. Commoveo eros eum humo molior mos nibh oppeto tamen veniam. Accumsan comis diam dolore et hos pala.\n\nEuismod exputo huic. Abbas esse gemino nostrud praemitto tamen turpis ut vereor voco. Gravis iusto loquor ludus. Illum iustum lobortis sino voco vulpes. Abbas ibidem jumentum. Comis eu magna sudo ut valde. Inhibeo laoreet mos occuro secundum tamen vereor. Adipiscing at lobortis nibh patria quis.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '34', '34', 'und', '0', 'Aliquip facilisis macto qui sudo turpis. Enim eum facilisis iusto laoreet zelus. Adipiscing gilvus iusto pertineo suscipit tation typicus vereor vulputate. Augue jugis nimis tincidunt. Dolore duis euismod nisl nunc usitas vulputate. Consectetuer conventio praemitto secundum. Defui incassum pneum. Appellatio camur inhibeo lobortis. Erat huic modo valde. Caecus dolor pala ratis vindico. Ea elit nutus.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '35', '35', 'und', '0', 'Dolor incassum jugis jumentum praesent sagaciter sudo tego vel vero. Abico exerci nobis paratus probo ratis sed suscipere. Causa consectetuer et jus olim validus veniam. Abigo amet gemino magna meus occuro oppeto sagaciter sino vel. Autem dignissim dolor jumentum scisco. Ad commodo cui hos patria.\n\nAbico enim iriure jumentum occuro roto sudo tamen utinam voco. Caecus imputo in iustum jus lobortis minim natu vulpes. Humo neque nulla saluto tamen zelus. Jumentum nulla persto quis.\n\nDolor eros premo. Augue capto exputo imputo pecus refero. Abdo abluo amet antehabeo ludus odio quae veniam. Antehabeo appellatio commodo consectetuer neque sagaciter si torqueo. Abbas abluo aptent commodo ea iriure jumentum letalis quibus usitas. Abigo aliquam hendrerit minim natu rusticus veniam. Abdo pertineo premo validus vindico.\n\nCommoveo ea eu gilvus tincidunt virtus. Ad appellatio facilisis mauris saluto scisco. Hos paratus turpis. Camur commoveo probo quibus. Distineo elit enim occuro utrum wisi. Exputo ideo ille jumentum suscipere. Comis distineo genitus nimis nutus obruo sudo turpis utrum vindico. Genitus huic magna nutus. Abluo eu ibidem pagus paratus pneum quae suscipere vulputate.\n\nIbidem nimis obruo quia secundum ut vero. Ad cogo dolore eu imputo os populus sed. Accumsan blandit nimis saluto ut utinam. Exerci imputo laoreet neo obruo qui valde. Aliquam distineo mos tamen.\n\nAcsi meus qui. Aptent meus nutus paratus tego. Antehabeo camur esca facilisis jus ratis singularis voco volutpat.\n\nHuic sit utrum. Commoveo letalis macto nibh odio pagus suscipit torqueo valde voco. At commoveo ea ex fere haero ludus ratis. Commoveo fere loquor luptatum nostrud os proprius quidne sudo ulciscor.\n\nAbbas defui distineo haero neque valde zelus. Consequat hos interdico loquor luptatum quadrum quibus tation wisi. Nisl probo secundum. Imputo jumentum pagus sudo. Ille in nutus scisco. Adipiscing jumentum melior os ulciscor. Dolore feugiat haero hos letalis quidne. Adipiscing bene hos ideo importunus roto suscipere te vicis. Abdo at genitus populus veniam. Acsi ea esse interdico macto patria quadrum ratis utrum vel.\n\nAntehabeo caecus esca eu ex importunus incassum neo. Aliquip blandit facilisi quidne. Amet bene blandit decet iusto metuo neque os sino. Abluo antehabeo ille lucidus nobis quis scisco singularis valetudo. Dolore enim eu euismod illum nobis olim usitas. Amet lucidus praemitto premo quae si tum valde.\n\nGravis olim saepius si singularis. Acsi dolus luctus refoveo ut. Pneum quis vulputate. Abigo ad amet antehabeo autem minim patria refero rusticus vero. Abigo dignissim distineo euismod gemino mauris modo natu nunc validus.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '36', '36', 'und', '0', 'Abluo cui decet et refoveo suscipere tincidunt vereor. Adipiscing caecus elit in meus populus refero. Dolus et iriure iusto luctus mos quidem volutpat. Dolus hos immitto mauris quis refero tum typicus utrum. Mos pertineo quibus scisco vulputate ymo. Commoveo iriure nobis velit. Et gravis haero oppeto wisi. Antehabeo consectetuer magna rusticus sagaciter valetudo volutpat. Aliquip bene dolus eligo ibidem imputo mauris pecus suscipere vel.\n\nAdipiscing conventio haero refoveo. Aliquam causa duis elit facilisi iustum pala patria premo saluto. Abico commoveo et pala vulpes. Camur eros jugis magna olim. Antehabeo at cogo dolor facilisis paratus quia roto ut. Exerci tation uxor. Causa et imputo pertineo praesent roto sudo tum usitas vero. Abluo augue cogo comis jus macto natu quibus. Molior patria praemitto venio.\n\nDistineo ea sagaciter sit utinam. Ad ibidem interdico laoreet melior obruo ulciscor. Ibidem importunus melior saepius. Causa humo in iustum melior pneum secundum. Aliquam mos pecus. Acsi autem ea erat euismod ibidem mauris mos probo.\n\nAbigo cogo consectetuer eum letalis lobortis pala probo quadrum validus. Aliquam hos huic nisl oppeto persto quadrum tum valde. Dolore ibidem lenis lucidus neque olim probo quae singularis vereor. Et haero illum metuo quidem usitas.\n\nAbluo damnum dignissim duis eu hendrerit metuo nunc. Eu haero melior minim obruo pertineo quae quidne refero. Aptent distineo eligo inhibeo lucidus nulla occuro quibus sagaciter ymo.\n\nEa modo nisl olim. Autem facilisis gemino modo nisl pneum ratis. Comis luctus plaga scisco tamen turpis. Camur lenis metuo olim sit. Aptent commoveo laoreet loquor neo pneum. Dolor eu exerci importunus magna modo molior olim refoveo vulpes. Abdo dolore hos inhibeo nunc occuro quae suscipit validus ymo. Ideo lenis scisco.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '37', '37', 'und', '0', 'Antehabeo distineo facilisis nutus paratus paulatim pertineo qui sudo vel. Caecus dolus natu nibh olim utinam veniam vindico ymo. Abluo distineo esca fere incassum jumentum melior nunc valde. Abdo abico distineo gilvus lucidus luptatum mos occuro proprius quidem.\n\nBene eum praemitto saluto utinam. Commodo duis et macto neo odio si. Illum mos obruo paratus persto populus quae qui suscipere. Abbas feugiat os tum ullamcorper usitas. Appellatio aptent esca importunus incassum praesent. Autem brevitas capto cogo eligo quia ut validus vel vicis. Commodo distineo ille luptatum nobis nulla typicus ulciscor virtus.\n\nAbdo euismod natu neque nulla nunc vero virtus. Abluo adipiscing consectetuer dolus gilvus lobortis nobis pneum validus. Antehabeo dignissim inhibeo ludus suscipit. Blandit dolus euismod gravis lobortis oppeto paulatim turpis ut vulpes. Cui distineo paulatim sino sit torqueo. Hendrerit lucidus nulla oppeto zelus.\n\nDamnum elit feugiat iaceo inhibeo nostrud veniam. Bene macto patria quadrum quae uxor. Exerci in incassum ludus pertineo tamen. Accumsan elit ideo os quidne validus. Conventio enim incassum nobis rusticus sino te ullamcorper. Adipiscing aliquam imputo lobortis persto sit veniam.\n\nAd feugiat ille laoreet paratus praesent ratis ullamcorper vero. Ad augue duis luctus obruo quia rusticus verto vicis vulputate. Abigo decet elit ibidem macto os patria populus vicis ymo. Ad esse saluto ymo. Gilvus gravis praesent quae ratis refoveo singularis voco.\n\nCogo iriure molior quibus rusticus. Enim macto praesent zelus. Aliquam dolore inhibeo populus tum. Caecus cui eu plaga scisco. Adipiscing euismod eum gilvus iaceo oppeto paratus secundum. Aptent jumentum melior nimis pagus pecus praemitto. Abico abluo saluto singularis ut.\n\nNostrud proprius similis ymo. Abigo diam eros neque nibh scisco suscipit veniam. Mauris nunc ut. Abdo autem euismod iaceo nibh paulatim quia saluto usitas utrum. Augue letalis probo vulputate. Abigo ad damnum eligo iusto molior quadrum similis tation vulpes. Damnum iustum meus neo. Commoveo conventio modo plaga. Abico abluo aliquip macto modo tum.\n\nCommodo consequat erat molior nutus plaga. Damnum ex tamen usitas. Comis elit laoreet obruo utinam. Ideo lenis modo nimis persto sed suscipit tincidunt usitas vereor.\n\nAdipiscing mos plaga. At illum inhibeo singularis valde wisi. Exerci gilvus illum quia. Caecus decet eum in nutus paratus ratis validus volutpat vulpes. Accumsan eu eum imputo laoreet melior metuo quae sit ymo. Abigo aliquam bene gilvus haero jus loquor ludus quadrum velit. Aptent consequat ex facilisi iriure molior nisl voco. Autem iustum nunc praesent quae virtus voco.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '38', '38', 'und', '0', 'Autem conventio hos praemitto sagaciter. Ad antehabeo decet et ideo importunus vel verto virtus. Autem consequat dignissim elit eros ideo nimis quibus ratis. Abigo brevitas damnum dignissim dolor eu hendrerit humo odio scisco.\n\nAbigo bene esca eum gilvus ille importunus odio utrum vero. Blandit letalis lucidus rusticus usitas.\n\nAbbas facilisis fere gravis haero lobortis nulla persto utinam. Aptent feugiat loquor lucidus olim probo ullamcorper. Camur comis huic. Et ex metuo secundum te. Feugiat incassum plaga refoveo tation utrum. Abluo autem consectetuer inhibeo pagus populus. Aliquip autem ex premo secundum sed usitas. Comis eligo ideo luptatum pneum rusticus ulciscor vel vero.\n\nCogo minim probo proprius quibus utinam vulputate. At oppeto ulciscor. Consectetuer esca mauris metuo nisl quibus utinam.\n\nAcsi damnum dolore dolus nulla singularis sino ulciscor usitas utinam. Blandit consequat et ex gemino lucidus ratis refoveo vero.\n\nNeo nulla quadrum. Commodo consequat duis nibh paratus sagaciter secundum similis te virtus. Brevitas commoveo cui damnum. Iaceo illum ut utrum. Huic quadrum typicus. Brevitas loquor nobis nutus refoveo tum verto voco.\n\nDignissim elit meus neque plaga pneum sit. Acsi aliquip brevitas commoveo interdico melior te. Ad aliquam laoreet lenis loquor te typicus veniam vereor.\n\nCausa dignissim incassum lenis neque ymo. Adipiscing facilisis huic lenis quibus refoveo vulpes. Augue minim suscipit torqueo. Augue brevitas dolore laoreet minim mos nutus sagaciter sed uxor. Bene eligo nulla praesent refero vereor. Defui erat in letalis occuro tego ulciscor zelus. Eum fere immitto jugis meus. Eligo qui quidne ratis. Appellatio capto consectetuer gravis humo incassum jumentum lenis patria valde.\n\nBlandit esse gemino lenis os pecus quidem volutpat. Conventio gravis imputo jugis neque saepius tum. Gilvus nostrud plaga uxor. Ibidem lobortis nimis tamen volutpat. Acsi feugiat gemino letalis nisl populus si vulpes. Aliquam appellatio conventio gemino haero nibh qui suscipere. Dignissim imputo obruo os singularis. Ex iaceo meus rusticus saluto secundum tation veniam zelus.\n\nAbdo caecus camur decet luptatum pneum refero te vel vindico. Dignissim eligo eu hos pneum populus quibus tamen ut. Exputo inhibeo mos roto rusticus sudo venio. Bene jus laoreet pneum typicus utinam validus. Accumsan aliquam et imputo occuro. Abico decet dolus exerci illum occuro pala qui singularis valde. Elit pneum similis. Appellatio loquor magna secundum utrum. Accumsan decet quibus refoveo tation vel volutpat.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '39', '39', 'und', '0', 'Enim eros odio quidem similis. Commodo consequat iaceo lenis. Camur cogo facilisis ideo iusto jugis neque tamen velit. Consectetuer decet esse melior nunc populus. Feugiat nibh quis rusticus sagaciter ut zelus.\n\nCausa enim exerci ibidem nisl probo quibus turpis. Accumsan blandit ille natu quis. Cogo consectetuer eros verto. Jumentum magna proprius. Dolore ille incassum lobortis ludus quis. Inhibeo iustum paratus paulatim quis turpis vindico vulpes. Caecus exputo nisl saepius ut vulputate.\n\nAbigo adipiscing ex ibidem iustum melior neo nostrud vel virtus. Bene defui esse ille modo odio quis suscipere ut. Antehabeo illum immitto patria pneum qui sit utinam valetudo vicis. Augue camur genitus illum inhibeo iriure odio quadrum. Aliquam feugiat jumentum. Acsi distineo vulpes. Fere quadrum refero saluto tego zelus. Accumsan acsi consequat fere ibidem loquor luctus quis vulputate wisi.\n\nCamur interdico volutpat. Brevitas consequat damnum defui humo lenis lobortis plaga venio vicis. Amet imputo ludus nostrud obruo odio pagus validus vulpes ymo. Elit erat hendrerit in. Antehabeo caecus distineo loquor luptatum macto magna pala. Abico ad aliquip aptent blandit exerci exputo neque nunc ut.\n\nAbbas amet damnum distineo meus premo roto singularis volutpat. Blandit conventio et eum facilisis macto pagus pertineo zelus. Causa euismod interdico nutus populus quis rusticus sagaciter. Eum in laoreet melior obruo suscipit virtus ymo. Diam euismod neque praesent. Abico haero incassum iusto magna pertineo utinam utrum. Letalis similis sit. Appellatio incassum modo obruo quidem tego ullamcorper velit veniam vicis.\n\nConsectetuer dolus et letalis suscipere usitas. Facilisi obruo praemitto. Consectetuer ex ludus natu. Abluo aliquip autem nimis si sudo valetudo zelus.\n\nDecet lobortis pecus pertineo suscipit venio. Abico augue autem lobortis os secundum volutpat. Cogo distineo facilisis luctus melior. Camur lobortis probo utinam. Antehabeo consequat iaceo neo neque patria vero.\n\nCaecus ea et. Abdo camur eligo letalis nibh proprius quia usitas vereor virtus. Commodo consectetuer diam euismod exputo premo te tum veniam verto.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '40', '40', 'und', '0', 'Amet appellatio natu pecus scisco te utrum valde. Amet commodo dolor elit iriure sagaciter saluto sudo te ut. Appellatio ea genitus lenis lobortis quia te usitas vel. Duis eligo lucidus proprius quae qui quis sagaciter tamen.\n\nBene cogo macto nibh occuro quidem sino ullamcorper validus wisi. Aliquip causa diam dolus ea occuro wisi. Dolore genitus meus olim quis singularis vindico. Brevitas commodo gravis importunus laoreet sudo venio wisi. Elit gemino hendrerit meus occuro saepius tamen venio vero. Aliquam aliquip commoveo elit eu iustum singularis vereor vulpes. Cogo distineo facilisi jus luptatum sagaciter similis.\n\nHos luctus mos nulla pala pertineo praemitto premo tincidunt. Commodo consequat molior populus typicus ullamcorper. Luptatum magna natu tincidunt voco. Appellatio incassum lenis nulla suscipit tincidunt torqueo typicus verto. Hos inhibeo lucidus olim sit utrum. Abico eum iaceo pertineo ratis vero.\n\nIn jumentum ratis volutpat. Aptent at duis in jus lenis odio refoveo rusticus. Haero iaceo nisl nobis. Abbas aptent exputo laoreet neque oppeto paulatim tamen valde. Aliquip exputo feugiat huic iusto jumentum neque pala vicis zelus.\n\nCapto fere gemino ibidem quia ullamcorper validus wisi. Abdo premo sino turpis. Abdo paratus pertineo. Distineo facilisis letalis utrum vereor. Dolore feugiat hendrerit in laoreet oppeto pala. Abico at exputo gemino paulatim praemitto ullamcorper utrum vulputate. Capto hos melior veniam vulputate wisi. Appellatio bene eum facilisis mos nulla oppeto quae quis saluto.\n\nEum hos letalis loquor. Elit luctus obruo persto probo suscipit tation ut. Eu immitto os si utinam vindico.\n\nAutem iaceo probo sed sit. Comis singularis valetudo wisi. Aliquip diam esse gravis iusto occuro.\n\nDolus suscipere tincidunt uxor wisi. Euismod laoreet lenis ludus modo neque nobis. Abdo ad damnum eu importunus lucidus nimis olim pagus ulciscor. Gravis pertineo premo. Cogo esse hos incassum nisl patria persto si. Aliquam iriure occuro persto singularis tum.\n\nHos loquor praesent suscipere tego. Diam dignissim facilisis nulla vel. Bene damnum exerci immitto nisl pertineo quis. Illum melior praesent tincidunt valetudo. Abbas capto erat haero hendrerit incassum nisl os pagus. Genitus hendrerit letalis mauris scisco torqueo tum ullamcorper. Eros exerci humo molior refero secundum sudo tego vel.\n\nBene cui exerci immitto patria suscipit venio. Eligo tation usitas vindico. Dignissim eros ideo imputo mos saepius vero. Decet importunus laoreet nunc occuro refero saluto te vulputate.\n\nAcsi autem inhibeo nobis paratus tego. Distineo jugis quadrum sagaciter vel vero voco. Adipiscing cogo euismod exerci odio. Antehabeo appellatio damnum ratis ymo. Brevitas caecus odio sagaciter turpis usitas vero. Blandit brevitas dolus euismod gravis nostrud nulla suscipit virtus. Comis dolor ille pecus quadrum scisco torqueo.\n\n', NULL, 'plain_text'),
('node', 'article', '0', '41', '41', 'und', '0', 'Ad eligo iriure patria. Euismod ex pneum uxor. Autem nutus ut. Erat exputo facilisis patria quadrum singularis sit tum.\n\nAcsi humo jus loquor scisco turpis. Abdo abico modo neque uxor vicis. Antehabeo damnum hendrerit iusto nisl os si usitas utinam veniam. Ad eum lenis metuo obruo pertineo probo ratis uxor.\n\nDolore eligo gemino metuo similis volutpat. Aliquip aptent incassum interdico olim pala utrum. Comis cui euismod genitus jus letalis nimis scisco similis utinam. Euismod paratus valde wisi. Damnum luptatum minim. Euismod ideo neo. Acsi in tation velit zelus. Appellatio diam esca illum nibh nisl praesent.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '42', '42', 'und', '0', 'Hendrerit pala veniam. Enim iriure scisco. Accumsan huic iaceo lenis roto sino voco zelus. Aliquam illum inhibeo loquor luptatum magna praesent utrum uxor vindico. Abdo blandit elit ibidem iusto zelus. Commodo erat fere immitto jumentum nostrud nutus pagus.\n\nEsca iusto magna nutus os pala qui ut valde. Commoveo eu feugiat plaga populus qui ratis. Facilisi gravis mauris nibh oppeto os refero tincidunt torqueo. Eum inhibeo vel. Obruo os valetudo. Bene damnum genitus hendrerit nunc quia tincidunt virtus. Defui nobis os paratus quidne validus. Abigo dolore exputo nisl plaga quidne sagaciter te ullamcorper uxor. Blandit brevitas cui ex nulla quidem singularis usitas.\n\nAccumsan amet autem hendrerit jus meus rusticus tego ut. Gemino utrum vindico. Abigo autem iustum sagaciter. Comis hos obruo. Appellatio cui dignissim humo interdico odio praemitto praesent ut. Aliquam causa iustum jumentum olim pecus vel virtus. Aliquam autem dolor occuro pertineo vindico. Camur euismod in neo os persto plaga vulpes zelus. Gravis hos importunus luctus nibh quibus venio wisi.\n\nAppellatio eu euismod gilvus lucidus mauris modo nisl proprius. Adipiscing enim iaceo iusto mauris melior nibh pagus si usitas.\n\nEsse hos molior os. Abluo nobis premo sed. Adipiscing comis lobortis quia quidne refero roto sit vereor. Commoveo hos illum in laoreet nulla quibus ratis si suscipere.\n\nAcsi aliquam appellatio consequat esca importunus incassum loquor ulciscor velit. Abluo amet comis eu illum melior paratus plaga roto wisi. Autem brevitas et pala vel. Abluo hos melior nisl paulatim praesent qui singularis. Bene commoveo enim illum paulatim refoveo torqueo zelus. Abbas commodo hos quidem tum.\n\nAliquam nimis quidne ratis vicis. Appellatio huic lucidus. Iriure praesent tamen. Abbas cui eros humo praesent probo quia saepius vereor zelus. Antehabeo dolore ea jumentum magna nimis pneum quibus saepius torqueo. Cui dolor facilisi zelus. Huic meus neque nisl persto quadrum quia torqueo. At damnum erat eum natu refoveo secundum te usitas ymo. At facilisis interdico neo nutus populus quadrum rusticus ulciscor.\n\nAd causa minim quae quidne sit. Distineo facilisi nutus. Abdo aliquam erat melior praemitto quadrum singularis. Amet damnum diam haero. Euismod nibh quia sed. Amet esca euismod natu pala ymo. Causa commodo gravis jumentum neo tincidunt. Commoveo facilisis hendrerit typicus ulciscor. Damnum duis genitus letalis. Abico abigo bene consectetuer dignissim genitus virtus. Accumsan huic luptatum mauris natu tego.\n\nExerci gravis laoreet neque persto quidem sino tum ulciscor. Abdo autem gilvus in laoreet refero verto. Aliquam luptatum vereor vulputate. At duis eligo haero hendrerit nutus saepius similis sudo valetudo. Decet fere metuo molior vulputate. Elit haero iusto letalis molior quae tincidunt vereor.\n\nAbluo aptent consectetuer diam ludus neo quia secundum vulpes vulputate. Abigo comis incassum verto. Commodo consequat erat genitus ibidem modo nimis paulatim vulpes.\n\nAccumsan adipiscing aliquam amet capto eligo enim quadrum venio verto. Ad ex exputo quae voco ymo. Laoreet probo similis valde. Caecus commoveo eligo laoreet suscipere. Ea enim et illum jumentum modo singularis valde vel vereor. Ad decet dignissim letalis lobortis lucidus pertineo quidem roto singularis. Blandit eum interdico molior nobis nulla pneum valde. Dolor nisl olim.\n\n', NULL, 'full_html'),
('node', 'article', '0', '43', '43', 'und', '0', 'Duis similis vindico. Antehabeo euismod haero sudo suscipit. Abbas commodo consequat eligo jugis melior metuo olim praemitto utrum. Appellatio causa diam luptatum neo rusticus velit.\n\nAbbas facilisis quis utinam vicis. Abico adipiscing rusticus. Ea lenis paulatim. Aliquip comis gemino. At cui iusto lobortis. Aptent caecus exerci gemino humo inhibeo loquor populus valetudo. Commoveo hendrerit imputo iriure lenis paulatim premo sagaciter. Ea elit enim molior paulatim premo verto. Accumsan amet antehabeo brevitas comis et iaceo qui.\n\nAbigo importunus os quibus saluto similis tum velit. Blandit dolor eligo erat nimis suscipit. Cogo dolus feugiat jumentum molior velit venio vereor. Ideo jumentum nimis.\n\nAmet eum os pneum praesent velit voco zelus. Amet iustum lobortis voco. Augue consectetuer consequat enim iusto obruo os quae uxor.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '44', '44', 'und', '0', 'Haero tation voco. Adipiscing luctus praemitto typicus. Conventio dignissim dolore euismod ex luctus natu nibh quibus torqueo. Loquor mauris nunc odio os praesent utinam vulputate. Aliquam saluto suscipit wisi. Dignissim dolus natu saluto. Metuo persto utrum.\n\nEu utinam voco. Dignissim inhibeo jumentum laoreet quae wisi. Commodo haero illum iusto verto virtus.\n\nHaero natu plaga sino tincidunt ullamcorper. Appellatio augue melior patria paulatim vel. Interdico jumentum utinam venio vereor. Aliquam camur cui elit interdico probo quis scisco uxor.\n\nAbdo ludus nimis pertineo premo vulputate. Ad camur exputo hos iaceo metuo quibus si ulciscor voco. Patria pecus quae vicis. Aliquip bene eum luptatum nunc persto quia uxor. Causa os tamen tego wisi. Abdo esse gravis hendrerit humo jugis probo quis sudo vindico. Dolore genitus incassum. Acsi eum praemitto sagaciter. Iustum nunc olim scisco sino.\n\nAugue eros lucidus paulatim sagaciter. Appellatio blandit euismod iusto letalis pagus rusticus saluto valetudo. Augue eu eum importunus magna obruo utinam. Odio quia sagaciter volutpat. Dignissim eu letalis neque praemitto scisco venio virtus.\n\n', NULL, 'full_html'),
('node', 'article', '0', '45', '45', 'und', '0', 'At dolor illum magna odio zelus. Augue iustum suscipere verto. Consectetuer dolore lucidus luptatum nobis singularis ullamcorper utrum ymo. Commoveo esse eum laoreet roto turpis ullamcorper velit vulputate. Damnum eros genitus gilvus nunc premo tum. Acsi torqueo valetudo. Amet nibh rusticus veniam. Cogo consequat illum magna pneum tum zelus.\n\nMagna paratus proprius ullamcorper. Antehabeo brevitas immitto pecus usitas. Eligo luptatum macto vulputate. Damnum eros minim nisl si. Abluo cogo comis nobis nostrud obruo occuro sed similis vindico.\n\nPecus quia ullamcorper venio volutpat vulpes. Erat esca ex iaceo interdico oppeto quibus scisco tamen vulputate. Damnum ex iustum nisl saepius ullamcorper vindico volutpat. Accumsan amet decet elit macto metuo mos sagaciter sino suscipit.\n\nAbico gemino haero mos neo odio quis singularis tation virtus. Ad caecus cui mauris nimis os premo si tego valde.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '46', '46', 'und', '0', 'Ad aliquip causa damnum elit in ludus roto secundum tego. Similis torqueo ut. Aliquam esse lucidus plaga sagaciter virtus vulputate. Camur sino ullamcorper. Capto facilisi occuro patria. Feugiat natu si sudo tum. Imputo interdico sudo zelus. Antehabeo augue interdico lobortis saepius singularis ullamcorper utinam. Facilisis secundum sed si zelus.\n\nEu hos olim. Ad antehabeo autem commoveo sit. Dignissim lenis nibh occuro praemitto refero vulputate. Conventio neque vindico. Abbas abico ad conventio erat et importunus modo oppeto secundum. Genitus os quidne suscipere. Humo iusto obruo persto quadrum quae tum vel. Abigo exerci lobortis veniam vicis. At cui elit esse gravis minim persto.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '47', '47', 'und', '0', 'Abigo euismod haero interdico nimis secundum. Accumsan ille sed tation. Amet plaga sed. Abbas decet elit eros incassum luctus persto. Aliquam ratis refoveo verto. Aliquam at iaceo ludus magna quae tincidunt torqueo voco. Dolor dolore dolus huic ibidem ille suscipit vicis ymo. Adipiscing bene cui nobis praemitto probo quidem tincidunt vel. Camur consequat esca hos iusto probo typicus.\n\nIlle iusto premo quis veniam vulpes. Amet at ille jus obruo oppeto pala suscipit tum venio. Abbas quae turpis. Cogo commodo euismod exerci verto. Roto valde vero. Camur consequat defui facilisis hendrerit lobortis tum. Ad et importunus molior obruo. Haero inhibeo premo veniam. Conventio duis importunus iustum luptatum nibh praemitto ratis ut. Abluo aptent laoreet macto sed. Brevitas haero ludus olim utinam.\n\nAmet dolus eros os paulatim. Aliquip antehabeo brevitas commoveo hos inhibeo nibh populus praemitto ulciscor. Damnum nisl qui. Cogo haero laoreet mauris neque paulatim te. Et ex gilvus huic ille mos nimis pagus vulpes vulputate. Ad blandit ea magna os pala pecus premo. Abigo letalis neo oppeto tego typicus validus veniam.\n\nBene et exerci feugiat laoreet melior pneum suscipit voco. Aliquam capto duis facilisis jumentum lenis luctus nostrud ulciscor. Capto damnum ludus melior os paratus scisco si.\n\nHuic jugis quadrum refoveo. Facilisis importunus nunc olim si sino tego. Feugiat nibh quia utrum zelus. Commoveo esca luctus persto. Cogo fere feugiat olim pneum saepius vindico.\n\n', NULL, 'full_html'),
('node', 'article', '0', '48', '48', 'und', '0', 'Enim et ex ibidem ille pneum si te valetudo. Damnum eros facilisis quia rusticus validus wisi. Antehabeo eu huic ibidem incassum nimis paulatim rusticus utinam validus. Defui ex veniam. Acsi nisl scisco vereor. Blandit damnum odio uxor. Elit feugiat mauris meus praesent utinam. Cui dolore gilvus haero mos torqueo. Consectetuer importunus tamen wisi.\n\nAccumsan camur eros lucidus praemitto quidne virtus. Melior natu occuro plaga typicus. Antehabeo camur distineo gilvus nostrud populus. Damnum decet defui facilisi nimis paulatim quidne rusticus vel vindico.\n\nBlandit camur et gemino nimis persto. Interdico luptatum odio pala saepius. Abico elit hendrerit macto mauris metuo molior obruo occuro refoveo. Facilisis jumentum singularis tum. Consectetuer duis gemino ille nostrud os refoveo sit virtus ymo.\n\nConsectetuer gilvus interdico venio. Luctus nisl pertineo. Acsi antehabeo eros euismod huic macto nimis si. Eros eu haero praesent si. Causa consequat dignissim eum hos nulla pala quidem refoveo vicis. Augue jus nobis ulciscor. Duis euismod quae ullamcorper.\n\nErat euismod exerci jugis meus saepius sed si usitas vulpes. Diam immitto jumentum minim natu plaga.\n\nErat ibidem loquor mauris meus. Jus melior odio patria vel. Autem caecus melior quae qui.\n\nAppellatio causa cogo cui damnum melior persto sudo tation ullamcorper. Duis ea facilisis gravis suscipit. Abigo dolus esca ideo velit zelus.\n\nConsequat dolore facilisis huic loquor sed. Adipiscing causa humo lucidus vicis. Abluo laoreet nostrud pecus usitas. Abdo elit eum ideo imputo mos tum utrum.\n\nAppellatio augue cui melior populus roto si sudo vindico. Blandit causa esca exerci iaceo.\n\nAd euismod ex gemino laoreet macto neque patria scisco venio. Adipiscing caecus damnum decet immitto probo tation wisi. Abico consequat damnum loquor pagus quidne sudo suscipit ut.\n\nAccumsan comis feugiat iusto luptatum sudo torqueo. Inhibeo laoreet ratis similis usitas. Causa gravis haero iaceo melior nobis praesent si usitas voco. Abbas hos immitto interdico iusto macto vicis. At letalis loquor usitas. Ad caecus dolor hos illum iriure letalis nulla paulatim. Appellatio esse odio. Bene euismod gravis quidem similis uxor. Camur commoveo defui nobis obruo praemitto premo tego valde.\n\nAugue consectetuer cui exputo gilvus immitto neo verto vindico. Huic humo magna similis. Augue cui feugiat gemino iaceo lobortis valde veniam. Diam erat praesent tego. Causa premo volutpat. Acsi brevitas commoveo cui dolor proprius vindico. Accumsan dignissim esse jumentum os ulciscor voco. Cogo cui feugiat ludus macto natu refero tation ut utinam.\n\n', NULL, 'full_html'),
('node', 'article', '0', '49', '49', 'und', '0', 'Distineo ille ludus. Dolor ex nunc veniam. Melior quis singularis valde. At inhibeo jugis ludus mos nisl quadrum ratis si vel. Abbas abigo consequat genitus neo refero sino sit te vereor. Ad bene caecus letalis pala paratus suscipit valetudo verto. Bene dolor eligo humo modo. Elit iustum luptatum macto molior paratus typicus vereor.\n\nIlle in valetudo. Humo ille praemitto. Esse jugis melior neo praemitto refero virtus. Blandit huic natu neque odio wisi. Amet conventio elit odio rusticus. Exputo genitus qui quibus sit te utrum. Abigo autem esse haero huic neque persto praesent secundum vicis. Autem ex gilvus pagus quia quibus rusticus saluto tincidunt utinam.\n\nAbigo aliquip commodo consequat decet humo refero vel vindico. Jugis natu nimis pagus patria suscipit vicis.\n\nFacilisi importunus lenis neo qui saepius torqueo velit. At eu feugiat imputo incassum letalis sed singularis turpis venio. Commoveo gilvus inhibeo jus mos. Premo quidem utinam. Gilvus ludus luptatum suscipit uxor. Autem cogo facilisis letalis melior plaga sino tation. Abdo accumsan decet distineo genitus in luptatum ut voco.\n\nCui dolus molior pagus paratus similis. At praesent quis rusticus saepius scisco tego verto.\n\nBlandit luctus premo quadrum quae si. Appellatio capto lucidus pertineo tum utrum venio zelus. Abluo bene nisl paulatim plaga quadrum. Abico probo ymo. Abdo distineo hendrerit ibidem jumentum melior si valde venio. Abbas huic iustum os praemitto. Aliquam eligo exputo gravis metuo nutus occuro probo secundum. Capto cui eligo exputo.\n\nPlaga saluto utinam validus. Gemino humo meus natu valde. Letalis patria quadrum si. Abluo caecus feugiat gilvus immitto olim pertineo tamen ulciscor.\n\nCommoveo eligo meus. Aptent damnum immitto lobortis mauris occuro oppeto os quidne tum.\n\n', NULL, 'filtered_html'),
('node', 'article', '0', '50', '50', 'und', '0', 'Cogo damnum defui loquor virtus zelus. Abbas ad adipiscing consectetuer feugiat iriure persto quibus saepius virtus. Hendrerit ibidem oppeto quae sit venio. Abigo autem decet diam pagus pecus suscipere. Aliquip amet capto gravis nibh nisl rusticus ullamcorper ut validus.\n\nAt autem bene loquor melior quidem vereor. Aptent commoveo iusto loquor melior nibh nulla praemitto quae virtus. Accumsan gemino saluto. Ea et ibidem. Consectetuer elit neo praesent proprius secundum venio. Ad facilisi fere feugiat gravis importunus suscipere tincidunt. Abigo ad camur feugiat ludus nobis nulla ut voco. Immitto incassum nimis quis. Appellatio brevitas probo qui veniam vulpes. Cogo luctus nostrud quadrum roto ullamcorper velit veniam voco.\n\nAdipiscing aliquam eum facilisi molior nunc roto similis sit veniam. Aliquam causa feugiat interdico magna neque pecus. Et lenis modo nulla pertineo tincidunt utinam vicis. At consectetuer conventio minim natu ulciscor veniam. Abluo jumentum natu obruo ullamcorper vicis.\n\nEx iaceo incassum usitas veniam. Facilisis genitus ratis volutpat ymo. Defui distineo letalis. Abdo ex illum occuro. Eros paratus suscipere. Abigo adipiscing capto iusto iustum nibh singularis tego valetudo. Commodo luptatum secundum vulpes. Dignissim dolus wisi. Dignissim gravis magna nibh quia. Abigo duis facilisi genitus mauris minim sagaciter turpis.\n\nCaecus erat humo occuro. Amet et exerci ratis tego tincidunt. Brevitas gilvus populus vero verto volutpat. Consequat illum incassum turpis. Abdo ideo incassum. Humo jus quae. Acsi et iustum ludus modo occuro paratus quia.\n\nBrevitas dignissim incassum. Camur luctus voco. Comis lobortis obruo saluto valde. Aliquip bene ille jugis singularis turpis. Abbas dolor melior modo te torqueo ut. Acsi at diam erat exerci pneum quae saluto tum.\n\n', NULL, 'full_html'),
('node', 'article', '0', '51', '51', 'und', '0', 'Elit hendrerit incassum nisl occuro quidem validus vulpes. Acsi autem blandit distineo sed suscipere. At erat huic iustum natu proprius tation ulciscor. Acsi capto eum gemino luctus meus neo secundum ulciscor virtus. Decet humo nisl os pala validus wisi. Eum jus luctus magna.\n\nAd aliquip duis imputo obruo quidem turpis validus. Conventio et feugiat immitto lenis letalis. Commoveo eu importunus imputo jugis nobis persto roto similis utrum. Enim incassum si. Cogo eros gravis refero ullamcorper. Abico diam eu feugiat haero olim quis refoveo tum uxor. Blandit dolor importunus iustum mos pala probo tation te validus. Abbas eu exputo gemino lucidus si vulpes.\n\nAdipiscing blandit caecus dolor inhibeo neque pneum sudo. Cogo macto pecus vereor. Abdo et exerci ibidem tation. At imputo quia velit. Consequat exerci haero obruo quadrum ullamcorper. Aliquam dolor dolus importunus interdico modo nunc probo proprius refero. Commoveo distineo dolore erat exputo importunus in paratus tego valde.\n\nEa erat eu imputo quis. Genitus praesent proprius quibus secundum. Eu jus olim. Consequat conventio jus refoveo similis sit usitas. Aliquip duis et haero immitto melior ullamcorper uxor vel. Abluo antehabeo caecus cogo elit gravis luctus neo quadrum valde.\n\nAppellatio nimis saluto sit wisi. Autem in luctus vel veniam virtus. Gravis iaceo interdico populus praemitto refero utrum velit. At consectetuer diam jus lobortis lucidus nutus. Jumentum letalis scisco singularis sit tego.\n\nDolus exputo nobis sed te velit. Augue ideo melior minim nisl praemitto quadrum ratis tego. Eros iustum mos veniam vicis. Appellatio commodo commoveo iusto saluto. Abdo accumsan aliquam esca letalis patria pertineo quadrum saepius sed.\n\n', NULL, 'full_html');
/*!40000 ALTER TABLE field_revision_body ENABLE KEYS */;

--
-- Table structure for table 'field_revision_comment_body'
--

CREATE TABLE IF NOT EXISTS `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Revision archive storage for field 1 (comment_body)';

--
-- Dumping data for table 'field_revision_comment_body'
--

/*!40000 ALTER TABLE field_revision_comment_body DISABLE KEYS */;
/*!40000 ALTER TABLE field_revision_comment_body ENABLE KEYS */;

--
-- Table structure for table 'field_revision_field_image'
--

CREATE TABLE IF NOT EXISTS `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Revision archive storage for field 4 (field_image)';

--
-- Dumping data for table 'field_revision_field_image'
--

/*!40000 ALTER TABLE field_revision_field_image DISABLE KEYS */;
INSERT INTO `field_revision_field_image` VALUES
('node', 'article', '0', '27', '27', 'und', '0', '13', 'Causa eu ex lenis letalis odio typicus usitas virtus.', 'Antehabeo in inhibeo praemitto praesent ratis sino ymo.', '496', '339'),
('node', 'article', '0', '28', '28', 'und', '0', '14', 'Abluo scisco turpis vulputate.', 'Consectetuer ideo illum modo pala proprius valde wisi.', '144', '341'),
('node', 'article', '0', '29', '29', 'und', '0', '15', 'Aliquam blandit obruo. Camur elit humo ille iriure luctus oppeto pala si virtus.', 'Abdo amet appellatio defui lucidus meus ullamcorper.', '310', '114'),
('node', 'article', '0', '30', '30', 'und', '0', '16', 'Illum neque olim ratis similis ullamcorper ut.', 'Adipiscing caecus gemino letalis minim pecus turpis ymo.', '373', '347'),
('node', 'article', '0', '31', '31', 'und', '0', '17', 'Feugiat letalis nutus sudo.', 'Camur jus meus plaga suscipere.', '464', '183'),
('node', 'article', '0', '32', '32', 'und', '0', '18', 'Damnum facilisi iaceo. Commoveo nimis praesent velit.', 'Brevitas damnum exerci inhibeo jugis macto nisl plaga praemitto.', '261', '396'),
('node', 'article', '0', '33', '33', 'und', '0', '19', 'Abdo imputo incassum interdico proprius ut wisi.', 'Ibidem lobortis macto sed si te tego.', '149', '493'),
('node', 'article', '0', '34', '34', 'und', '0', '20', 'Abbas cui defui elit eu gilvus gravis saluto vulputate.', 'Diam humo vulpes wisi.', '152', '273'),
('node', 'article', '0', '35', '35', 'und', '0', '21', 'Ad laoreet meus quis sit tum utinam.', 'Eum illum incassum nutus paulatim pertineo roto vulpes ymo.', '383', '277'),
('node', 'article', '0', '36', '36', 'und', '0', '22', 'Augue consectetuer facilisis olim pertineo quidem singularis validus.', 'Euismod patria proprius similis tamen te.', '448', '258'),
('node', 'article', '0', '37', '37', 'und', '0', '23', 'Appellatio comis nulla obruo quadrum refoveo te ullamcorper vereor.', 'Appellatio dolore duis haero laoreet melior pala paratus pneum premo.', '502', '426'),
('node', 'article', '0', '38', '38', 'und', '0', '15', 'Amet dolor duis incassum neo probo quibus sino ulciscor vero.', 'Causa decet eros obruo sit tum venio vulpes.', '310', '114'),
('node', 'article', '0', '39', '39', 'und', '0', '14', 'Obruo veniam vulpes. Caecus consectetuer elit ex laoreet mauris veniam.', 'Appellatio et inhibeo luctus magna paulatim proprius singularis.', '144', '341'),
('node', 'article', '0', '40', '40', 'und', '0', '21', 'Autem cui imputo magna minim nostrud suscipere validus.', 'Camur ex tamen torqueo.', '383', '277'),
('node', 'article', '0', '41', '41', 'und', '0', '19', 'Dolore eu gravis mos nostrud patria praesent quibus rusticus.', 'Antehabeo esse haero melior validus wisi ymo.', '149', '493'),
('node', 'article', '0', '42', '42', 'und', '0', '24', 'Genitus iaceo neo tation.', 'Ea nunc secundum. Et gemino hendrerit saluto te valetudo vero volutpat.', '367', '406'),
('node', 'article', '0', '43', '43', 'und', '0', '15', 'Acsi blandit dignissim distineo facilisi pneum refoveo.', 'Abigo adipiscing eros exerci inhibeo interdico olim singularis ymo.', '310', '114'),
('node', 'article', '0', '44', '44', 'und', '0', '18', 'Commodo duis illum neque pneum premo sit.', 'Abluo amet dolor exputo iustum qui sit virtus.', '261', '396'),
('node', 'article', '0', '45', '45', 'und', '0', '17', 'Commoveo damnum gilvus magna pala tego usitas vel vero zelus.', 'Et facilisi haero lucidus nunc praesent saepius sagaciter utrum virtus.', '464', '183'),
('node', 'article', '0', '46', '46', 'und', '0', '22', 'Abigo mauris nisl quadrum quia sino typicus.', 'Elit gilvus interdico luptatum odio premo si.', '448', '258'),
('node', 'article', '0', '47', '47', 'und', '0', '21', 'Commodo dolore incassum pertineo tum.', 'Huic quae quidem vel.', '383', '277'),
('node', 'article', '0', '48', '48', 'und', '0', '18', 'Camur cogo eros minim virtus.', 'Bene plaga quadrum quidem refero vero.', '261', '396'),
('node', 'article', '0', '49', '49', 'und', '0', '23', 'Esca et exputo gemino.', 'Abluo commodo consequat enim hendrerit huic ille laoreet verto ymo.', '502', '426'),
('node', 'article', '0', '50', '50', 'und', '0', '15', 'Esse gemino sed suscipit vicis.', 'Persto plaga probo vereor.', '310', '114'),
('node', 'article', '0', '51', '51', 'und', '0', '23', 'Commoveo consectetuer defui enim quae quia.', 'Esca humo scisco tincidunt.', '502', '426');
/*!40000 ALTER TABLE field_revision_field_image ENABLE KEYS */;

--
-- Table structure for table 'field_revision_field_school_year'
--

CREATE TABLE IF NOT EXISTS `field_revision_field_school_year` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_school_year_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_school_year_tid` (`field_school_year_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Revision archive storage for field 6 (field_school_year)';

--
-- Dumping data for table 'field_revision_field_school_year'
--

/*!40000 ALTER TABLE field_revision_field_school_year DISABLE KEYS */;
INSERT INTO `field_revision_field_school_year` VALUES
('node', 'article', '0', '27', '27', 'und', '0', '9'),
('node', 'article', '0', '28', '28', 'und', '0', '6'),
('node', 'article', '0', '29', '29', 'und', '0', '6'),
('node', 'article', '0', '30', '30', 'und', '0', '10'),
('node', 'article', '0', '31', '31', 'und', '0', '6'),
('node', 'article', '0', '32', '32', 'und', '0', '8'),
('node', 'article', '0', '33', '33', 'und', '0', '6'),
('node', 'article', '0', '34', '34', 'und', '0', '9'),
('node', 'article', '0', '35', '35', 'und', '0', '6'),
('node', 'article', '0', '36', '36', 'und', '0', '8'),
('node', 'article', '0', '37', '37', 'und', '0', '6'),
('node', 'article', '0', '38', '38', 'und', '0', '7'),
('node', 'article', '0', '39', '39', 'und', '0', '6'),
('node', 'article', '0', '40', '40', 'und', '0', '10'),
('node', 'article', '0', '41', '41', 'und', '0', '6'),
('node', 'article', '0', '42', '42', 'und', '0', '6'),
('node', 'article', '0', '43', '43', 'und', '0', '6'),
('node', 'article', '0', '44', '44', 'und', '0', '6'),
('node', 'article', '0', '45', '45', 'und', '0', '6'),
('node', 'article', '0', '46', '46', 'und', '0', '6'),
('node', 'article', '0', '47', '47', 'und', '0', '6'),
('node', 'article', '0', '48', '48', 'und', '0', '6'),
('node', 'article', '0', '49', '49', 'und', '0', '6'),
('node', 'article', '0', '50', '50', 'und', '0', '6'),
('node', 'article', '0', '51', '51', 'und', '0', '7');
/*!40000 ALTER TABLE field_revision_field_school_year ENABLE KEYS */;

--
-- Table structure for table 'field_revision_field_sections'
--

CREATE TABLE IF NOT EXISTS `field_revision_field_sections` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_sections_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_sections_tid` (`field_sections_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Revision archive storage for field 5 (field_sections)';

--
-- Dumping data for table 'field_revision_field_sections'
--

/*!40000 ALTER TABLE field_revision_field_sections DISABLE KEYS */;
INSERT INTO `field_revision_field_sections` VALUES
('node', 'article', '0', '2', '2', 'und', '0', '5'),
('node', 'article', '0', '27', '27', 'und', '0', '5'),
('node', 'article', '0', '28', '28', 'und', '0', '5'),
('node', 'article', '0', '29', '29', 'und', '0', '5'),
('node', 'article', '0', '30', '30', 'und', '0', '5'),
('node', 'article', '0', '31', '31', 'und', '0', '5'),
('node', 'article', '0', '32', '32', 'und', '0', '5'),
('node', 'article', '0', '33', '33', 'und', '0', '5'),
('node', 'article', '0', '34', '34', 'und', '0', '5'),
('node', 'article', '0', '35', '35', 'und', '0', '5'),
('node', 'article', '0', '36', '36', 'und', '0', '5'),
('node', 'article', '0', '37', '37', 'und', '0', '5'),
('node', 'article', '0', '38', '38', 'und', '0', '5'),
('node', 'article', '0', '39', '39', 'und', '0', '5'),
('node', 'article', '0', '40', '40', 'und', '0', '5'),
('node', 'article', '0', '41', '41', 'und', '0', '5'),
('node', 'article', '0', '42', '42', 'und', '0', '5'),
('node', 'article', '0', '43', '43', 'und', '0', '5'),
('node', 'article', '0', '44', '44', 'und', '0', '5'),
('node', 'article', '0', '45', '45', 'und', '0', '5'),
('node', 'article', '0', '46', '46', 'und', '0', '5'),
('node', 'article', '0', '47', '47', 'und', '0', '5'),
('node', 'article', '0', '48', '48', 'und', '0', '5'),
('node', 'article', '0', '49', '49', 'und', '0', '5'),
('node', 'article', '0', '50', '50', 'und', '0', '5'),
('node', 'article', '0', '51', '51', 'und', '0', '5');
/*!40000 ALTER TABLE field_revision_field_sections ENABLE KEYS */;

--
-- Table structure for table 'field_revision_field_tags'
--

CREATE TABLE IF NOT EXISTS `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Revision archive storage for field 3 (field_tags)';

--
-- Dumping data for table 'field_revision_field_tags'
--

/*!40000 ALTER TABLE field_revision_field_tags DISABLE KEYS */;
/*!40000 ALTER TABLE field_revision_field_tags ENABLE KEYS */;

--
-- Table structure for table 'file_managed'
--

CREATE TABLE IF NOT EXISTS `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores information for uploaded files.';

--
-- Dumping data for table 'file_managed'
--

/*!40000 ALTER TABLE file_managed DISABLE KEYS */;
INSERT INTO `file_managed` VALUES
('13', '1', '', 'public://field/image/imagefield_xLhixp.png', 'image/png', '1872', '1', '1331586404'),
('14', '1', '', 'public://field/image/imagefield_VmzjmI.jpg', 'image/jpg', '3302', '1', '1331586404'),
('15', '1', '', 'public://field/image/imagefield_Pvghx1.jpg', 'image/jpg', '3304', '1', '1331586404'),
('16', '1', '', 'public://field/image/imagefield_ZAjq0k.png', 'image/png', '1824', '1', '1331586404'),
('17', '1', '', 'public://field/image/imagefield_32WUIF.png', 'image/png', '1071', '1', '1331586404'),
('18', '1', '', 'public://field/image/imagefield_Zw0jd3.png', 'image/png', '1453', '1', '1331586404'),
('19', '1', '', 'public://field/image/imagefield_RQviRs.jpg', 'image/jpg', '4784', '1', '1331586404'),
('20', '1', '', 'public://field/image/imagefield_3sQM1T.png', 'image/png', '759', '1', '1331586404'),
('21', '1', '', 'public://field/image/imagefield_5Pt5Wl.jpg', 'image/jpg', '5446', '1', '1331586404'),
('22', '1', '', 'public://field/image/imagefield_bnGt8P.jpg', 'image/jpg', '5929', '1', '1331586404'),
('23', '1', '', 'public://field/image/imagefield_zgwRll.jpg', 'image/jpg', '9290', '1', '1331586404'),
('24', '1', '', 'public://field/image/imagefield_3rk0OV.png', 'image/png', '2001', '1', '1331586404');
/*!40000 ALTER TABLE file_managed ENABLE KEYS */;

--
-- Table structure for table 'file_usage'
--

CREATE TABLE IF NOT EXISTS `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Track where a file is used.';

--
-- Dumping data for table 'file_usage'
--

/*!40000 ALTER TABLE file_usage DISABLE KEYS */;
INSERT INTO `file_usage` VALUES
('13', 'file', 'node', '27', '1'),
('14', 'file', 'node', '28', '1'),
('14', 'file', 'node', '39', '1'),
('15', 'file', 'node', '29', '1'),
('15', 'file', 'node', '38', '1'),
('15', 'file', 'node', '43', '1'),
('15', 'file', 'node', '50', '1'),
('16', 'file', 'node', '30', '1'),
('17', 'file', 'node', '31', '1'),
('17', 'file', 'node', '45', '1'),
('18', 'file', 'node', '32', '1'),
('18', 'file', 'node', '44', '1'),
('18', 'file', 'node', '48', '1'),
('19', 'file', 'node', '33', '1'),
('19', 'file', 'node', '41', '1'),
('20', 'file', 'node', '34', '1'),
('21', 'file', 'node', '35', '1'),
('21', 'file', 'node', '40', '1'),
('21', 'file', 'node', '47', '1'),
('22', 'file', 'node', '36', '1'),
('22', 'file', 'node', '46', '1'),
('23', 'file', 'node', '37', '1'),
('23', 'file', 'node', '49', '1'),
('23', 'file', 'node', '51', '1'),
('24', 'file', 'node', '42', '1');
/*!40000 ALTER TABLE file_usage ENABLE KEYS */;

--
-- Table structure for table 'filter'
--

CREATE TABLE IF NOT EXISTS `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Table that maps filters (HTML corrector) to text formats ...';

--
-- Dumping data for table 'filter'
--

/*!40000 ALTER TABLE filter DISABLE KEYS */;
INSERT INTO `filter` VALUES
('filtered_html', 'filter', 'filter_autop', '2', '1', 'a:0:{}'),
('filtered_html', 'filter', 'filter_html', '1', '1', 'a:3:{s:12:"allowed_html";s:74:"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>";s:16:"filter_html_help";i:1;s:20:"filter_html_nofollow";i:0;}'),
('filtered_html', 'filter', 'filter_htmlcorrector', '10', '1', 'a:0:{}'),
('filtered_html', 'filter', 'filter_html_escape', '10', '0', 'a:0:{}'),
('filtered_html', 'filter', 'filter_url', '0', '1', 'a:1:{s:17:"filter_url_length";i:72;}'),
('full_html', 'filter', 'filter_autop', '1', '1', 'a:0:{}'),
('full_html', 'filter', 'filter_html', '10', '0', 'a:3:{s:12:"allowed_html";s:74:"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>";s:16:"filter_html_help";i:1;s:20:"filter_html_nofollow";i:0;}'),
('full_html', 'filter', 'filter_htmlcorrector', '10', '1', 'a:0:{}'),
('full_html', 'filter', 'filter_html_escape', '10', '0', 'a:0:{}'),
('full_html', 'filter', 'filter_url', '0', '1', 'a:1:{s:17:"filter_url_length";i:72;}'),
('plain_text', 'filter', 'filter_autop', '2', '1', 'a:0:{}'),
('plain_text', 'filter', 'filter_html', '10', '0', 'a:3:{s:12:"allowed_html";s:74:"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>";s:16:"filter_html_help";i:1;s:20:"filter_html_nofollow";i:0;}'),
('plain_text', 'filter', 'filter_htmlcorrector', '10', '0', 'a:0:{}'),
('plain_text', 'filter', 'filter_html_escape', '0', '1', 'a:0:{}'),
('plain_text', 'filter', 'filter_url', '1', '1', 'a:1:{s:17:"filter_url_length";i:72;}');
/*!40000 ALTER TABLE filter ENABLE KEYS */;

--
-- Table structure for table 'filter_format'
--

CREATE TABLE IF NOT EXISTS `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores text formats: custom groupings of filters, such as...';

--
-- Dumping data for table 'filter_format'
--

/*!40000 ALTER TABLE filter_format DISABLE KEYS */;
INSERT INTO `filter_format` VALUES
('filtered_html', 'Filtered HTML', '1', '1', '0'),
('full_html', 'Full HTML', '1', '1', '1'),
('plain_text', 'Plain text', '1', '1', '10');
/*!40000 ALTER TABLE filter_format ENABLE KEYS */;

--
-- Table structure for table 'flood'
--

CREATE TABLE IF NOT EXISTS `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Flood controls the threshold of events, such as the...';

--
-- Dumping data for table 'flood'
--

/*!40000 ALTER TABLE flood DISABLE KEYS */;
/*!40000 ALTER TABLE flood ENABLE KEYS */;

--
-- Table structure for table 'history'
--

CREATE TABLE IF NOT EXISTS `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A record of which users have read which nodes.';

--
-- Dumping data for table 'history'
--

/*!40000 ALTER TABLE history DISABLE KEYS */;
INSERT INTO `history` VALUES
('1', '1', '1331574599'),
('1', '2', '1331586098'),
('1', '3', '1331585632'),
('1', '4', '1331579028'),
('1', '5', '1331582134'),
('1', '6', '1331583642');
/*!40000 ALTER TABLE history ENABLE KEYS */;

--
-- Table structure for table 'image_effects'
--

CREATE TABLE IF NOT EXISTS `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores configuration options for image effects.';

--
-- Dumping data for table 'image_effects'
--

/*!40000 ALTER TABLE image_effects DISABLE KEYS */;
/*!40000 ALTER TABLE image_effects ENABLE KEYS */;

--
-- Table structure for table 'image_styles'
--

CREATE TABLE IF NOT EXISTS `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores configuration options for image styles.';

--
-- Dumping data for table 'image_styles'
--

/*!40000 ALTER TABLE image_styles DISABLE KEYS */;
/*!40000 ALTER TABLE image_styles ENABLE KEYS */;

--
-- Table structure for table 'menu_custom'
--

CREATE TABLE IF NOT EXISTS `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Holds definitions for top-level custom menus (for example...';

--
-- Dumping data for table 'menu_custom'
--

/*!40000 ALTER TABLE menu_custom DISABLE KEYS */;
INSERT INTO `menu_custom` VALUES
('devel', 'Development', 'Development link'),
('main-menu', 'Main menu', 'The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.'),
('management', 'Management', 'The <em>Management</em> menu contains links for administrative tasks.'),
('navigation', 'Navigation', 'The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.'),
('user-menu', 'User menu', 'The <em>User</em> menu contains links related to the user''s account, as well as the ''Log out'' link.');
/*!40000 ALTER TABLE menu_custom ENABLE KEYS */;

--
-- Table structure for table 'menu_links'
--

CREATE TABLE IF NOT EXISTS `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Contains the individual links within a menu.';

--
-- Dumping data for table 'menu_links'
--

/*!40000 ALTER TABLE menu_links DISABLE KEYS */;
INSERT INTO `menu_links` VALUES
('management', '1', '0', 'admin', 'admin', 'Administration', 'a:0:{}', 'system', 0, 0, 1, 0, '9', 1, 0, '1', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('user-menu', '2', '0', 'user', 'user', 'User account', 'a:1:{s:5:"alter";b:1;}', 'system', 0, 0, 0, 0, '-10', 1, 0, '2', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '3', '0', 'comment/%', 'comment/%', 'Comment permalink', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 1, 0, '3', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '4', '0', 'filter/tips', 'filter/tips', 'Compose tips', 'a:0:{}', 'system', 1, 0, 0, 0, '0', 1, 0, '4', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '5', '0', 'node/%', 'node/%', '', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 1, 0, '5', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '6', '0', 'node/add', 'node/add', 'Add content', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 1, 0, '6', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '7', '1', 'admin/appearance', 'admin/appearance', 'Appearance', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:33:"Select and configure your themes.";}}', 'system', 0, 0, 0, 0, '-6', 2, 0, '1', '7', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '8', '1', 'admin/config', 'admin/config', 'Configuration', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:20:"Administer settings.";}}', 'system', 0, 0, 1, 0, '0', 2, 0, '1', '8', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '9', '1', 'admin/content', 'admin/content', 'Content', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:32:"Administer content and comments.";}}', 'system', 0, 0, 1, 0, '-10', 2, 0, '1', '9', '0', '0', '0', '0', '0', '0', '0', 0),
('user-menu', '10', '2', 'user/register', 'user/register', 'Create new account', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '2', '10', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '11', '1', 'admin/dashboard', 'admin/dashboard', 'Dashboard', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:34:"View and customize your dashboard.";}}', 'system', 0, 0, 0, 0, '-15', 2, 0, '1', '11', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '12', '1', 'admin/help', 'admin/help', 'Help', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:48:"Reference for usage, configuration, and modules.";}}', 'system', 0, 0, 0, 0, '9', 2, 0, '1', '12', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '13', '1', 'admin/index', 'admin/index', 'Index', 'a:0:{}', 'system', -1, 0, 0, 0, '-18', 2, 0, '1', '13', '0', '0', '0', '0', '0', '0', '0', 0),
('user-menu', '14', '2', 'user/login', 'user/login', 'Log in', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '2', '14', '0', '0', '0', '0', '0', '0', '0', 0),
('user-menu', '15', '0', 'user/logout', 'user/logout', 'Log out', 'a:0:{}', 'system', 0, 0, 0, 0, '10', 1, 0, '15', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '16', '1', 'admin/modules', 'admin/modules', 'Modules', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:26:"Extend site functionality.";}}', 'system', 0, 0, 0, 0, '-2', 2, 0, '1', '16', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '17', '0', 'user/%', 'user/%', 'My account', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 1, 0, '17', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '18', '1', 'admin/people', 'admin/people', 'People', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:45:"Manage user accounts, roles, and permissions.";}}', 'system', 0, 0, 0, 0, '-4', 2, 0, '1', '18', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '19', '1', 'admin/reports', 'admin/reports', 'Reports', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:34:"View reports, updates, and errors.";}}', 'system', 0, 0, 1, 0, '5', 2, 0, '1', '19', '0', '0', '0', '0', '0', '0', '0', 0),
('user-menu', '20', '2', 'user/password', 'user/password', 'Request new password', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '2', '20', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '21', '1', 'admin/structure', 'admin/structure', 'Structure', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:45:"Administer blocks, content types, menus, etc.";}}', 'system', 0, 0, 1, 0, '-8', 2, 0, '1', '21', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '22', '1', 'admin/tasks', 'admin/tasks', 'Tasks', 'a:0:{}', 'system', -1, 0, 0, 0, '-20', 2, 0, '1', '22', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '23', '0', 'comment/reply/%', 'comment/reply/%', 'Add new comment', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 1, 0, '23', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '24', '3', 'comment/%/approve', 'comment/%/approve', 'Approve', 'a:0:{}', 'system', 0, 0, 0, 0, '1', 2, 0, '3', '24', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '25', '3', 'comment/%/delete', 'comment/%/delete', 'Delete', 'a:0:{}', 'system', -1, 0, 0, 0, '2', 2, 0, '3', '25', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '26', '3', 'comment/%/edit', 'comment/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '3', '26', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '27', '0', 'taxonomy/term/%', 'taxonomy/term/%', 'Taxonomy term', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 1, 0, '27', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '28', '3', 'comment/%/view', 'comment/%/view', 'View comment', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 2, 0, '3', '28', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '29', '18', 'admin/people/create', 'admin/people/create', 'Add user', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '18', '29', '0', '0', '0', '0', '0', '0', 0),
('management', '30', '21', 'admin/structure/block', 'admin/structure/block', 'Blocks', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:79:"Configure what block content appears in your site''s sidebars and other regions.";}}', 'system', 0, 0, 1, 0, '0', 3, 0, '1', '21', '30', '0', '0', '0', '0', '0', '0', 0),
('navigation', '31', '17', 'user/%/cancel', 'user/%/cancel', 'Cancel account', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 2, 0, '17', '31', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '32', '9', 'admin/content/comment', 'admin/content/comment', 'Comments', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:59:"List and edit site comments and the comment approval queue.";}}', 'system', 0, 0, 0, 0, '0', 3, 0, '1', '9', '32', '0', '0', '0', '0', '0', '0', 0),
('management', '33', '11', 'admin/dashboard/configure', 'admin/dashboard/configure', 'Configure available dashboard blocks', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:53:"Configure which blocks can be shown on the dashboard.";}}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '11', '33', '0', '0', '0', '0', '0', '0', 0),
('management', '34', '9', 'admin/content/node', 'admin/content/node', 'Content', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 3, 0, '1', '9', '34', '0', '0', '0', '0', '0', '0', 0),
('management', '35', '8', 'admin/config/content', 'admin/config/content', 'Content authoring', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:53:"Settings related to formatting and authoring content.";}}', 'system', 0, 0, 1, 0, '-15', 3, 0, '1', '8', '35', '0', '0', '0', '0', '0', '0', 0),
('management', '36', '21', 'admin/structure/types', 'admin/structure/types', 'Content types', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:92:"Manage content types, including default status, front page promotion, comment settings, etc.";}}', 'system', 0, 0, 1, 0, '0', 3, 0, '1', '21', '36', '0', '0', '0', '0', '0', '0', 0),
('management', '37', '11', 'admin/dashboard/customize', 'admin/dashboard/customize', 'Customize dashboard', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:25:"Customize your dashboard.";}}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '11', '37', '0', '0', '0', '0', '0', '0', 0),
('navigation', '38', '5', 'node/%/delete', 'node/%/delete', 'Delete', 'a:0:{}', 'system', -1, 0, 0, 0, '1', 2, 0, '5', '38', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '39', '8', 'admin/config/development', 'admin/config/development', 'Development', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:18:"Development tools.";}}', 'system', 0, 0, 1, 0, '-10', 3, 0, '1', '8', '39', '0', '0', '0', '0', '0', '0', 0),
('navigation', '40', '17', 'user/%/edit', 'user/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '17', '40', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '41', '5', 'node/%/edit', 'node/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '5', '41', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '42', '19', 'admin/reports/fields', 'admin/reports/fields', 'Field list', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:39:"Overview of fields on all entity types.";}}', 'system', 0, 0, 0, 0, '0', 3, 0, '1', '19', '42', '0', '0', '0', '0', '0', '0', 0),
('management', '43', '7', 'admin/appearance/list', 'admin/appearance/list', 'List', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:31:"Select and configure your theme";}}', 'system', -1, 0, 0, 0, '-1', 3, 0, '1', '7', '43', '0', '0', '0', '0', '0', '0', 0),
('management', '44', '16', 'admin/modules/list', 'admin/modules/list', 'List', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '16', '44', '0', '0', '0', '0', '0', '0', 0),
('management', '45', '18', 'admin/people/people', 'admin/people/people', 'List', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:50:"Find and manage people interacting with your site.";}}', 'system', -1, 0, 0, 0, '-10', 3, 0, '1', '18', '45', '0', '0', '0', '0', '0', '0', 0),
('management', '46', '8', 'admin/config/media', 'admin/config/media', 'Media', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:12:"Media tools.";}}', 'system', 0, 0, 1, 0, '-10', 3, 0, '1', '8', '46', '0', '0', '0', '0', '0', '0', 0),
('management', '47', '21', 'admin/structure/menu', 'admin/structure/menu', 'Menus', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:86:"Add new menus to your site, edit existing menus, and rename and reorganize menu links.";}}', 'system', 0, 0, 1, 0, '0', 3, 0, '1', '21', '47', '0', '0', '0', '0', '0', '0', 0),
('management', '48', '8', 'admin/config/people', 'admin/config/people', 'People', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:24:"Configure user accounts.";}}', 'system', 0, 0, 1, 0, '-20', 3, 0, '1', '8', '48', '0', '0', '0', '0', '0', '0', 0),
('management', '49', '18', 'admin/people/permissions', 'admin/people/permissions', 'Permissions', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:64:"Determine access to features by selecting permissions for roles.";}}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '18', '49', '0', '0', '0', '0', '0', '0', 0),
('management', '50', '19', 'admin/reports/dblog', 'admin/reports/dblog', 'Recent log messages', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:43:"View events that have recently been logged.";}}', 'system', 0, 0, 0, 0, '-1', 3, 0, '1', '19', '50', '0', '0', '0', '0', '0', '0', 0),
('management', '51', '8', 'admin/config/regional', 'admin/config/regional', 'Regional and language', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:48:"Regional settings, localization and translation.";}}', 'system', 0, 0, 1, 0, '-5', 3, 0, '1', '8', '51', '0', '0', '0', '0', '0', '0', 0),
('navigation', '52', '5', 'node/%/revisions', 'node/%/revisions', 'Revisions', 'a:0:{}', 'system', -1, 0, 1, 0, '2', 2, 0, '5', '52', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '53', '8', 'admin/config/search', 'admin/config/search', 'Search and metadata', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:36:"Local site search, metadata and SEO.";}}', 'system', 0, 0, 1, 0, '-10', 3, 0, '1', '8', '53', '0', '0', '0', '0', '0', '0', 0),
('management', '54', '7', 'admin/appearance/settings', 'admin/appearance/settings', 'Settings', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:46:"Configure default and theme specific settings.";}}', 'system', -1, 0, 0, 0, '20', 3, 0, '1', '7', '54', '0', '0', '0', '0', '0', '0', 0),
('management', '55', '19', 'admin/reports/status', 'admin/reports/status', 'Status report', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:74:"Get a status report about your site''s operation and any detected problems.";}}', 'system', 0, 0, 0, 0, '-60', 3, 0, '1', '19', '55', '0', '0', '0', '0', '0', '0', 0),
('management', '56', '8', 'admin/config/system', 'admin/config/system', 'System', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:37:"General system related configuration.";}}', 'system', 0, 0, 1, 0, '-20', 3, 0, '1', '8', '56', '0', '0', '0', '0', '0', '0', 0),
('management', '57', '21', 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Taxonomy', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:67:"Manage tagging, categorization, and classification of your content.";}}', 'system', 0, 0, 1, 0, '0', 3, 0, '1', '21', '57', '0', '0', '0', '0', '0', '0', 0),
('management', '58', '19', 'admin/reports/access-denied', 'admin/reports/access-denied', 'Top ''access denied'' errors', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:35:"View ''access denied'' errors (403s).";}}', 'system', 0, 0, 0, 0, '0', 3, 0, '1', '19', '58', '0', '0', '0', '0', '0', '0', 0),
('management', '59', '19', 'admin/reports/page-not-found', 'admin/reports/page-not-found', 'Top ''page not found'' errors', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:36:"View ''page not found'' errors (404s).";}}', 'system', 0, 0, 0, 0, '0', 3, 0, '1', '19', '59', '0', '0', '0', '0', '0', '0', 0),
('management', '60', '16', 'admin/modules/uninstall', 'admin/modules/uninstall', 'Uninstall', 'a:0:{}', 'system', -1, 0, 0, 0, '20', 3, 0, '1', '16', '60', '0', '0', '0', '0', '0', '0', 0),
('management', '61', '8', 'admin/config/user-interface', 'admin/config/user-interface', 'User interface', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:38:"Tools that enhance the user interface.";}}', 'system', 0, 0, 1, 0, '-15', 3, 0, '1', '8', '61', '0', '0', '0', '0', '0', '0', 0),
('navigation', '62', '5', 'node/%/view', 'node/%/view', 'View', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 2, 0, '5', '62', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '63', '17', 'user/%/view', 'user/%/view', 'View', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 2, 0, '17', '63', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '64', '8', 'admin/config/services', 'admin/config/services', 'Web services', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:30:"Tools related to web services.";}}', 'system', 0, 0, 1, 0, '0', 3, 0, '1', '8', '64', '0', '0', '0', '0', '0', '0', 0),
('management', '65', '8', 'admin/config/workflow', 'admin/config/workflow', 'Workflow', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:43:"Content workflow, editorial workflow tools.";}}', 'system', 0, 0, 0, 0, '5', 3, 0, '1', '8', '65', '0', '0', '0', '0', '0', '0', 0),
('management', '66', '12', 'admin/help/block', 'admin/help/block', 'block', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '66', '0', '0', '0', '0', '0', '0', 0),
('management', '67', '12', 'admin/help/color', 'admin/help/color', 'color', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '67', '0', '0', '0', '0', '0', '0', 0),
('management', '68', '12', 'admin/help/comment', 'admin/help/comment', 'comment', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '68', '0', '0', '0', '0', '0', '0', 0),
('management', '69', '12', 'admin/help/contextual', 'admin/help/contextual', 'contextual', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '69', '0', '0', '0', '0', '0', '0', 0),
('management', '70', '12', 'admin/help/dashboard', 'admin/help/dashboard', 'dashboard', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '70', '0', '0', '0', '0', '0', '0', 0),
('management', '71', '12', 'admin/help/dblog', 'admin/help/dblog', 'dblog', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '71', '0', '0', '0', '0', '0', '0', 0),
('management', '72', '12', 'admin/help/field', 'admin/help/field', 'field', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '72', '0', '0', '0', '0', '0', '0', 0),
('management', '73', '12', 'admin/help/field_sql_storage', 'admin/help/field_sql_storage', 'field_sql_storage', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '73', '0', '0', '0', '0', '0', '0', 0),
('management', '74', '12', 'admin/help/field_ui', 'admin/help/field_ui', 'field_ui', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '74', '0', '0', '0', '0', '0', '0', 0),
('management', '75', '12', 'admin/help/file', 'admin/help/file', 'file', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '75', '0', '0', '0', '0', '0', '0', 0),
('management', '76', '12', 'admin/help/filter', 'admin/help/filter', 'filter', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '76', '0', '0', '0', '0', '0', '0', 0),
('management', '77', '12', 'admin/help/help', 'admin/help/help', 'help', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '77', '0', '0', '0', '0', '0', '0', 0),
('management', '78', '12', 'admin/help/image', 'admin/help/image', 'image', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '78', '0', '0', '0', '0', '0', '0', 0),
('management', '79', '12', 'admin/help/list', 'admin/help/list', 'list', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '79', '0', '0', '0', '0', '0', '0', 0),
('management', '80', '12', 'admin/help/menu', 'admin/help/menu', 'menu', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '80', '0', '0', '0', '0', '0', '0', 0),
('management', '81', '12', 'admin/help/node', 'admin/help/node', 'node', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '81', '0', '0', '0', '0', '0', '0', 0),
('management', '82', '12', 'admin/help/options', 'admin/help/options', 'options', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '82', '0', '0', '0', '0', '0', '0', 0),
('management', '83', '12', 'admin/help/system', 'admin/help/system', 'system', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '83', '0', '0', '0', '0', '0', '0', 0),
('management', '84', '12', 'admin/help/taxonomy', 'admin/help/taxonomy', 'taxonomy', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '84', '0', '0', '0', '0', '0', '0', 0),
('management', '85', '12', 'admin/help/text', 'admin/help/text', 'text', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '85', '0', '0', '0', '0', '0', '0', 0),
('management', '86', '12', 'admin/help/user', 'admin/help/user', 'user', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '86', '0', '0', '0', '0', '0', '0', 0),
('navigation', '87', '27', 'taxonomy/term/%/edit', 'taxonomy/term/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '10', 2, 0, '27', '87', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '88', '27', 'taxonomy/term/%/view', 'taxonomy/term/%/view', 'View', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '27', '88', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '89', '48', 'admin/config/people/accounts', 'admin/config/people/accounts', 'Account settings', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:109:"Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.";}}', 'system', 0, 0, 0, 0, '-10', 4, 0, '1', '8', '48', '89', '0', '0', '0', '0', '0', 0),
('management', '90', '56', 'admin/config/system/actions', 'admin/config/system/actions', 'Actions', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:41:"Manage the actions defined for your site.";}}', 'system', 0, 0, 1, 0, '0', 4, 0, '1', '8', '56', '90', '0', '0', '0', '0', '0', 0),
('management', '91', '30', 'admin/structure/block/add', 'admin/structure/block/add', 'Add block', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '30', '91', '0', '0', '0', '0', '0', 0),
('management', '92', '36', 'admin/structure/types/add', 'admin/structure/types/add', 'Add content type', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '36', '92', '0', '0', '0', '0', '0', 0),
('management', '93', '47', 'admin/structure/menu/add', 'admin/structure/menu/add', 'Add menu', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '47', '93', '0', '0', '0', '0', '0', 0),
('management', '94', '57', 'admin/structure/taxonomy/add', 'admin/structure/taxonomy/add', 'Add vocabulary', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '57', '94', '0', '0', '0', '0', '0', 0),
('management', '95', '54', 'admin/appearance/settings/bartik', 'admin/appearance/settings/bartik', 'Bartik', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '7', '54', '95', '0', '0', '0', '0', '0', 0),
('management', '96', '53', 'admin/config/search/clean-urls', 'admin/config/search/clean-urls', 'Clean URLs', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:43:"Enable or disable clean URLs for your site.";}}', 'system', 0, 0, 0, 0, '5', 4, 0, '1', '8', '53', '96', '0', '0', '0', '0', '0', 0),
('management', '97', '56', 'admin/config/system/cron', 'admin/config/system/cron', 'Cron', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:40:"Manage automatic site maintenance tasks.";}}', 'system', 0, 0, 0, 0, '20', 4, 0, '1', '8', '56', '97', '0', '0', '0', '0', '0', 0),
('management', '98', '51', 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Date and time', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:44:"Configure display formats for date and time.";}}', 'system', 0, 0, 0, 0, '-15', 4, 0, '1', '8', '51', '98', '0', '0', '0', '0', '0', 0),
('management', '99', '19', 'admin/reports/event/%', 'admin/reports/event/%', 'Details', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 3, 0, '1', '19', '99', '0', '0', '0', '0', '0', '0', 0),
('management', '100', '46', 'admin/config/media/file-system', 'admin/config/media/file-system', 'File system', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:68:"Tell Drupal where to store uploaded files and how they are accessed.";}}', 'system', 0, 0, 0, 0, '-10', 4, 0, '1', '8', '46', '100', '0', '0', '0', '0', '0', 0),
('management', '101', '54', 'admin/appearance/settings/garland', 'admin/appearance/settings/garland', 'Garland', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '7', '54', '101', '0', '0', '0', '0', '0', 0),
('management', '102', '54', 'admin/appearance/settings/global', 'admin/appearance/settings/global', 'Global settings', 'a:0:{}', 'system', -1, 0, 0, 0, '-1', 4, 0, '1', '7', '54', '102', '0', '0', '0', '0', '0', 0),
('management', '103', '48', 'admin/config/people/ip-blocking', 'admin/config/people/ip-blocking', 'IP address blocking', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:28:"Manage blocked IP addresses.";}}', 'system', 0, 0, 1, 0, '10', 4, 0, '1', '8', '48', '103', '0', '0', '0', '0', '0', 0),
('management', '104', '46', 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Image styles', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:78:"Configure styles that can be used for resizing or adjusting images on display.";}}', 'system', 0, 0, 1, 0, '0', 4, 0, '1', '8', '46', '104', '0', '0', '0', '0', '0', 0),
('management', '105', '46', 'admin/config/media/image-toolkit', 'admin/config/media/image-toolkit', 'Image toolkit', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:74:"Choose which image toolkit to use if you have installed optional toolkits.";}}', 'system', 0, 0, 0, 0, '20', 4, 0, '1', '8', '46', '105', '0', '0', '0', '0', '0', 0),
('management', '106', '36', 'admin/structure/types/list', 'admin/structure/types/list', 'List', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 4, 0, '1', '21', '36', '106', '0', '0', '0', '0', '0', 0),
('management', '107', '44', 'admin/modules/list/confirm', 'admin/modules/list/confirm', 'List', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '16', '44', '107', '0', '0', '0', '0', '0', 0),
('management', '108', '57', 'admin/structure/taxonomy/list', 'admin/structure/taxonomy/list', 'List', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 4, 0, '1', '21', '57', '108', '0', '0', '0', '0', '0', 0),
('management', '109', '47', 'admin/structure/menu/list', 'admin/structure/menu/list', 'List menus', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 4, 0, '1', '21', '47', '109', '0', '0', '0', '0', '0', 0),
('management', '110', '39', 'admin/config/development/logging', 'admin/config/development/logging', 'Logging and errors', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:154:"Settings for logging and alerts modules. Various modules can route Drupal''s system events to different destinations, such as syslog, database, email, etc.";}}', 'system', 0, 0, 0, 0, '-15', 4, 0, '1', '8', '39', '110', '0', '0', '0', '0', '0', 0),
('management', '111', '39', 'admin/config/development/maintenance', 'admin/config/development/maintenance', 'Maintenance mode', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:62:"Take the site offline for maintenance or bring it back online.";}}', 'system', 0, 0, 0, 0, '-10', 4, 0, '1', '8', '39', '111', '0', '0', '0', '0', '0', 0),
('management', '112', '39', 'admin/config/development/performance', 'admin/config/development/performance', 'Performance', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:101:"Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.";}}', 'system', 0, 0, 0, 0, '-20', 4, 0, '1', '8', '39', '112', '0', '0', '0', '0', '0', 0),
('management', '113', '49', 'admin/people/permissions/list', 'admin/people/permissions/list', 'Permissions', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:64:"Determine access to features by selecting permissions for roles.";}}', 'system', -1, 0, 0, 0, '-8', 4, 0, '1', '18', '49', '113', '0', '0', '0', '0', '0', 0),
('management', '114', '32', 'admin/content/comment/new', 'admin/content/comment/new', 'Published comments', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 4, 0, '1', '9', '32', '114', '0', '0', '0', '0', '0', 0),
('management', '115', '64', 'admin/config/services/rss-publishing', 'admin/config/services/rss-publishing', 'RSS publishing', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:114:"Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.";}}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '8', '64', '115', '0', '0', '0', '0', '0', 0),
('management', '116', '51', 'admin/config/regional/settings', 'admin/config/regional/settings', 'Regional settings', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:54:"Settings for the site''s default time zone and country.";}}', 'system', 0, 0, 0, 0, '-20', 4, 0, '1', '8', '51', '116', '0', '0', '0', '0', '0', 0),
('management', '117', '49', 'admin/people/permissions/roles', 'admin/people/permissions/roles', 'Roles', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:30:"List, edit, or add user roles.";}}', 'system', -1, 0, 1, 0, '-5', 4, 0, '1', '18', '49', '117', '0', '0', '0', '0', '0', 0),
('management', '118', '47', 'admin/structure/menu/settings', 'admin/structure/menu/settings', 'Settings', 'a:0:{}', 'system', -1, 0, 0, 0, '5', 4, 0, '1', '21', '47', '118', '0', '0', '0', '0', '0', 0),
('management', '119', '54', 'admin/appearance/settings/seven', 'admin/appearance/settings/seven', 'Seven', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '7', '54', '119', '0', '0', '0', '0', '0', 0),
('management', '120', '56', 'admin/config/system/site-information', 'admin/config/system/site-information', 'Site information', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:104:"Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.";}}', 'system', 0, 0, 0, 0, '-20', 4, 0, '1', '8', '56', '120', '0', '0', '0', '0', '0', 0),
('management', '121', '54', 'admin/appearance/settings/stark', 'admin/appearance/settings/stark', 'Stark', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '7', '54', '121', '0', '0', '0', '0', '0', 0),
('management', '122', '35', 'admin/config/content/formats', 'admin/config/content/formats', 'Text formats', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:127:"Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.";}}', 'system', 0, 0, 1, 0, '0', 4, 0, '1', '8', '35', '122', '0', '0', '0', '0', '0', 0),
('management', '123', '60', 'admin/modules/uninstall/confirm', 'admin/modules/uninstall/confirm', 'Uninstall', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '16', '60', '123', '0', '0', '0', '0', '0', 0),
('management', '124', '57', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', '', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '21', '57', '124', '0', '0', '0', '0', '0', 0),
('management', '125', '32', 'admin/content/comment/approval', 'admin/content/comment/approval', 'Unapproved comments', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '9', '32', '125', '0', '0', '0', '0', '0', 0),
('navigation', '126', '40', 'user/%/edit/account', 'user/%/edit/account', 'Account', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '17', '40', '126', '0', '0', '0', '0', '0', '0', 0),
('management', '127', '122', 'admin/config/content/formats/%', 'admin/config/content/formats/%', '', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 5, 0, '1', '8', '35', '122', '127', '0', '0', '0', '0', 0),
('management', '128', '104', 'admin/config/media/image-styles/add', 'admin/config/media/image-styles/add', 'Add style', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:22:"Add a new image style.";}}', 'system', -1, 0, 0, 0, '2', 5, 0, '1', '8', '46', '104', '128', '0', '0', '0', '0', 0),
('management', '129', '124', 'admin/structure/taxonomy/%/add', 'admin/structure/taxonomy/%/add', 'Add term', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '57', '124', '129', '0', '0', '0', '0', 0),
('management', '130', '122', 'admin/config/content/formats/add', 'admin/config/content/formats/add', 'Add text format', 'a:0:{}', 'system', -1, 0, 0, 0, '1', 5, 0, '1', '8', '35', '122', '130', '0', '0', '0', '0', 0),
('management', '131', '30', 'admin/structure/block/list/bartik', 'admin/structure/block/list/bartik', 'Bartik', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 4, 0, '1', '21', '30', '131', '0', '0', '0', '0', '0', 0),
('management', '132', '90', 'admin/config/system/actions/configure', 'admin/config/system/actions/configure', 'Configure an advanced action', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '8', '56', '90', '132', '0', '0', '0', '0', 0),
('management', '133', '47', 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Customize menu', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 4, 0, '1', '21', '47', '133', '0', '0', '0', '0', '0', 0),
('management', '134', '124', 'admin/structure/taxonomy/%/edit', 'admin/structure/taxonomy/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 5, 0, '1', '21', '57', '124', '134', '0', '0', '0', '0', 0),
('management', '135', '36', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit content type', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 4, 0, '1', '21', '36', '135', '0', '0', '0', '0', '0', 0),
('management', '136', '98', 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time/formats', 'Formats', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:51:"Configure display format strings for date and time.";}}', 'system', -1, 0, 1, 0, '-9', 5, 0, '1', '8', '51', '98', '136', '0', '0', '0', '0', 0),
('management', '137', '30', 'admin/structure/block/list/garland', 'admin/structure/block/list/garland', 'Garland', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '30', '137', '0', '0', '0', '0', '0', 0),
('management', '138', '122', 'admin/config/content/formats/list', 'admin/config/content/formats/list', 'List', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '8', '35', '122', '138', '0', '0', '0', '0', 0),
('management', '139', '124', 'admin/structure/taxonomy/%/list', 'admin/structure/taxonomy/%/list', 'List', 'a:0:{}', 'system', -1, 0, 0, 0, '-20', 5, 0, '1', '21', '57', '124', '139', '0', '0', '0', '0', 0),
('management', '140', '104', 'admin/config/media/image-styles/list', 'admin/config/media/image-styles/list', 'List', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:42:"List the current image styles on the site.";}}', 'system', -1, 0, 0, 0, '1', 5, 0, '1', '8', '46', '104', '140', '0', '0', '0', '0', 0),
('management', '141', '90', 'admin/config/system/actions/manage', 'admin/config/system/actions/manage', 'Manage actions', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:41:"Manage the actions defined for your site.";}}', 'system', -1, 0, 0, 0, '-2', 5, 0, '1', '8', '56', '90', '141', '0', '0', '0', '0', 0),
('management', '142', '89', 'admin/config/people/accounts/settings', 'admin/config/people/accounts/settings', 'Settings', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 5, 0, '1', '8', '48', '89', '142', '0', '0', '0', '0', 0),
('management', '143', '30', 'admin/structure/block/list/seven', 'admin/structure/block/list/seven', 'Seven', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '30', '143', '0', '0', '0', '0', '0', 0),
('management', '144', '30', 'admin/structure/block/list/stark', 'admin/structure/block/list/stark', 'Stark', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '30', '144', '0', '0', '0', '0', '0', 0),
('management', '145', '98', 'admin/config/regional/date-time/types', 'admin/config/regional/date-time/types', 'Types', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:44:"Configure display formats for date and time.";}}', 'system', -1, 0, 1, 0, '-10', 5, 0, '1', '8', '51', '98', '145', '0', '0', '0', '0', 0),
('navigation', '146', '52', 'node/%/revisions/%/delete', 'node/%/revisions/%/delete', 'Delete earlier revision', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 3, 0, '5', '52', '146', '0', '0', '0', '0', '0', '0', 0),
('navigation', '147', '52', 'node/%/revisions/%/revert', 'node/%/revisions/%/revert', 'Revert to earlier revision', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 3, 0, '5', '52', '147', '0', '0', '0', '0', '0', '0', 0),
('navigation', '148', '52', 'node/%/revisions/%/view', 'node/%/revisions/%/view', 'Revisions', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 3, 0, '5', '52', '148', '0', '0', '0', '0', '0', '0', 0),
('management', '149', '137', 'admin/structure/block/list/garland/add', 'admin/structure/block/list/garland/add', 'Add block', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '30', '137', '149', '0', '0', '0', '0', 0),
('management', '150', '143', 'admin/structure/block/list/seven/add', 'admin/structure/block/list/seven/add', 'Add block', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '30', '143', '150', '0', '0', '0', '0', 0),
('management', '151', '144', 'admin/structure/block/list/stark/add', 'admin/structure/block/list/stark/add', 'Add block', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '30', '144', '151', '0', '0', '0', '0', 0),
('management', '152', '145', 'admin/config/regional/date-time/types/add', 'admin/config/regional/date-time/types/add', 'Add date type', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:18:"Add new date type.";}}', 'system', -1, 0, 0, 0, '-10', 6, 0, '1', '8', '51', '98', '145', '152', '0', '0', '0', 0),
('management', '153', '136', 'admin/config/regional/date-time/formats/add', 'admin/config/regional/date-time/formats/add', 'Add format', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:43:"Allow users to add additional date formats.";}}', 'system', -1, 0, 0, 0, '-10', 6, 0, '1', '8', '51', '98', '136', '153', '0', '0', '0', 0),
('management', '154', '133', 'admin/structure/menu/manage/%/add', 'admin/structure/menu/manage/%/add', 'Add link', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '47', '133', '154', '0', '0', '0', '0', 0),
('management', '155', '30', 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '21', '30', '155', '0', '0', '0', '0', '0', 0),
('navigation', '156', '31', 'user/%/cancel/confirm/%/%', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 3, 0, '17', '31', '156', '0', '0', '0', '0', '0', '0', 0),
('management', '157', '135', 'admin/structure/types/manage/%/delete', 'admin/structure/types/manage/%/delete', 'Delete', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '21', '36', '135', '157', '0', '0', '0', '0', 0),
('management', '158', '103', 'admin/config/people/ip-blocking/delete/%', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '8', '48', '103', '158', '0', '0', '0', '0', 0),
('management', '159', '90', 'admin/config/system/actions/delete/%', 'admin/config/system/actions/delete/%', 'Delete action', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:17:"Delete an action.";}}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '8', '56', '90', '159', '0', '0', '0', '0', 0),
('management', '160', '133', 'admin/structure/menu/manage/%/delete', 'admin/structure/menu/manage/%/delete', 'Delete menu', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '21', '47', '133', '160', '0', '0', '0', '0', 0),
('management', '161', '47', 'admin/structure/menu/item/%/delete', 'admin/structure/menu/item/%/delete', 'Delete menu link', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '21', '47', '161', '0', '0', '0', '0', '0', 0),
('management', '162', '117', 'admin/people/permissions/roles/delete/%', 'admin/people/permissions/roles/delete/%', 'Delete role', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '18', '49', '117', '162', '0', '0', '0', '0', 0),
('management', '163', '127', 'admin/config/content/formats/%/disable', 'admin/config/content/formats/%/disable', 'Disable text format', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '8', '35', '122', '127', '163', '0', '0', '0', 0),
('management', '164', '135', 'admin/structure/types/manage/%/edit', 'admin/structure/types/manage/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '36', '135', '164', '0', '0', '0', '0', 0),
('management', '165', '133', 'admin/structure/menu/manage/%/edit', 'admin/structure/menu/manage/%/edit', 'Edit menu', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '47', '133', '165', '0', '0', '0', '0', 0),
('management', '166', '47', 'admin/structure/menu/item/%/edit', 'admin/structure/menu/item/%/edit', 'Edit menu link', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '21', '47', '166', '0', '0', '0', '0', '0', 0),
('management', '167', '117', 'admin/people/permissions/roles/edit/%', 'admin/people/permissions/roles/edit/%', 'Edit role', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '18', '49', '117', '167', '0', '0', '0', '0', 0),
('management', '168', '104', 'admin/config/media/image-styles/edit/%', 'admin/config/media/image-styles/edit/%', 'Edit style', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:25:"Configure an image style.";}}', 'system', 0, 0, 1, 0, '0', 5, 0, '1', '8', '46', '104', '168', '0', '0', '0', '0', 0),
('management', '169', '133', 'admin/structure/menu/manage/%/list', 'admin/structure/menu/manage/%/list', 'List links', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 5, 0, '1', '21', '47', '133', '169', '0', '0', '0', '0', 0),
('management', '170', '47', 'admin/structure/menu/item/%/reset', 'admin/structure/menu/item/%/reset', 'Reset menu link', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '21', '47', '170', '0', '0', '0', '0', '0', 0),
('management', '171', '104', 'admin/config/media/image-styles/delete/%', 'admin/config/media/image-styles/delete/%', 'Delete style', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:22:"Delete an image style.";}}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '8', '46', '104', '171', '0', '0', '0', '0', 0),
('management', '172', '104', 'admin/config/media/image-styles/revert/%', 'admin/config/media/image-styles/revert/%', 'Revert style', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:22:"Revert an image style.";}}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '8', '46', '104', '172', '0', '0', '0', '0', 0),
('management', '173', '135', 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%/comment/display', 'Comment display', 'a:0:{}', 'system', -1, 0, 0, 0, '4', 5, 0, '1', '21', '36', '135', '173', '0', '0', '0', '0', 0),
('management', '174', '135', 'admin/structure/types/manage/%/comment/fields', 'admin/structure/types/manage/%/comment/fields', 'Comment fields', 'a:0:{}', 'system', -1, 0, 1, 0, '3', 5, 0, '1', '21', '36', '135', '174', '0', '0', '0', '0', 0),
('management', '175', '155', 'admin/structure/block/manage/%/%/configure', 'admin/structure/block/manage/%/%/configure', 'Configure block', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '30', '155', '175', '0', '0', '0', '0', 0),
('management', '176', '155', 'admin/structure/block/manage/%/%/delete', 'admin/structure/block/manage/%/%/delete', 'Delete block', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '21', '30', '155', '176', '0', '0', '0', '0', 0),
('management', '177', '136', 'admin/config/regional/date-time/formats/%/delete', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:47:"Allow users to delete a configured date format.";}}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '8', '51', '98', '136', '177', '0', '0', '0', 0),
('management', '178', '145', 'admin/config/regional/date-time/types/%/delete', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:45:"Allow users to delete a configured date type.";}}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '8', '51', '98', '145', '178', '0', '0', '0', 0),
('management', '179', '136', 'admin/config/regional/date-time/formats/%/edit', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:45:"Allow users to edit a configured date format.";}}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '8', '51', '98', '136', '179', '0', '0', '0', 0),
('management', '180', '168', 'admin/config/media/image-styles/edit/%/add/%', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:28:"Add a new effect to a style.";}}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '8', '46', '104', '168', '180', '0', '0', '0', 0),
('management', '181', '168', 'admin/config/media/image-styles/edit/%/effects/%', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:39:"Edit an existing effect within a style.";}}', 'system', 0, 0, 1, 0, '0', 6, 0, '1', '8', '46', '104', '168', '181', '0', '0', '0', 0),
('management', '182', '181', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:39:"Delete an existing effect from a style.";}}', 'system', 0, 0, 0, 0, '0', 7, 0, '1', '8', '46', '104', '168', '181', '182', '0', '0', 0),
('management', '183', '47', 'admin/structure/menu/manage/main-menu', 'admin/structure/menu/manage/%', 'Main menu', 'a:0:{}', 'menu', 0, 0, 0, 0, '0', 4, 0, '1', '21', '47', '183', '0', '0', '0', '0', '0', 0),
('management', '184', '47', 'admin/structure/menu/manage/management', 'admin/structure/menu/manage/%', 'Management', 'a:0:{}', 'menu', 0, 0, 0, 0, '0', 4, 0, '1', '21', '47', '184', '0', '0', '0', '0', '0', 0),
('management', '185', '47', 'admin/structure/menu/manage/navigation', 'admin/structure/menu/manage/%', 'Navigation', 'a:0:{}', 'menu', 0, 0, 0, 0, '0', 4, 0, '1', '21', '47', '185', '0', '0', '0', '0', '0', 0),
('management', '186', '47', 'admin/structure/menu/manage/user-menu', 'admin/structure/menu/manage/%', 'User menu', 'a:0:{}', 'menu', 0, 0, 0, 0, '0', 4, 0, '1', '21', '47', '186', '0', '0', '0', '0', '0', 0),
('navigation', '187', '0', 'search', 'search', 'Search', 'a:0:{}', 'system', 1, 0, 0, 0, '0', 1, 0, '187', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '188', '187', 'search/node', 'search/node', 'Content', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 2, 0, '187', '188', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '189', '187', 'search/user', 'search/user', 'Users', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '187', '189', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '190', '188', 'search/node/%', 'search/node/%', 'Content', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '187', '188', '190', '0', '0', '0', '0', '0', '0', 0),
('navigation', '191', '17', 'user/%/shortcuts', 'user/%/shortcuts', 'Shortcuts', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 2, 0, '17', '191', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '192', '19', 'admin/reports/search', 'admin/reports/search', 'Top search phrases', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:33:"View most popular search phrases.";}}', 'system', 0, 0, 0, 0, '0', 3, 0, '1', '19', '192', '0', '0', '0', '0', '0', '0', 0),
('navigation', '193', '189', 'search/user/%', 'search/user/%', 'Users', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '187', '189', '193', '0', '0', '0', '0', '0', '0', 0),
('management', '194', '12', 'admin/help/number', 'admin/help/number', 'number', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '194', '0', '0', '0', '0', '0', '0', 0),
('management', '195', '12', 'admin/help/overlay', 'admin/help/overlay', 'overlay', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '195', '0', '0', '0', '0', '0', '0', 0),
('management', '196', '12', 'admin/help/path', 'admin/help/path', 'path', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '196', '0', '0', '0', '0', '0', '0', 0),
('management', '197', '12', 'admin/help/rdf', 'admin/help/rdf', 'rdf', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '197', '0', '0', '0', '0', '0', '0', 0),
('management', '198', '12', 'admin/help/search', 'admin/help/search', 'search', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '198', '0', '0', '0', '0', '0', '0', 0),
('management', '199', '12', 'admin/help/shortcut', 'admin/help/shortcut', 'shortcut', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '199', '0', '0', '0', '0', '0', '0', 0),
('management', '200', '53', 'admin/config/search/settings', 'admin/config/search/settings', 'Search settings', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:67:"Configure relevance settings for search and other indexing options.";}}', 'system', 0, 0, 0, 0, '-10', 4, 0, '1', '8', '53', '200', '0', '0', '0', '0', '0', 0),
('management', '201', '61', 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Shortcuts', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:29:"Add and modify shortcut sets.";}}', 'system', 0, 0, 1, 0, '0', 4, 0, '1', '8', '61', '201', '0', '0', '0', '0', '0', 0),
('management', '202', '53', 'admin/config/search/path', 'admin/config/search/path', 'URL aliases', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:46:"Change your site''s URL paths by aliasing them.";}}', 'system', 0, 0, 1, 0, '-5', 4, 0, '1', '8', '53', '202', '0', '0', '0', '0', '0', 0),
('management', '203', '202', 'admin/config/search/path/add', 'admin/config/search/path/add', 'Add alias', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '8', '53', '202', '203', '0', '0', '0', '0', 0),
('management', '204', '201', 'admin/config/user-interface/shortcut/add-set', 'admin/config/user-interface/shortcut/add-set', 'Add shortcut set', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '8', '61', '201', '204', '0', '0', '0', '0', 0),
('management', '205', '200', 'admin/config/search/settings/reindex', 'admin/config/search/settings/reindex', 'Clear index', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 5, 0, '1', '8', '53', '200', '205', '0', '0', '0', '0', 0),
('management', '206', '201', 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 5, 0, '1', '8', '61', '201', '206', '0', '0', '0', '0', 0),
('management', '207', '202', 'admin/config/search/path/list', 'admin/config/search/path/list', 'List', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 5, 0, '1', '8', '53', '202', '207', '0', '0', '0', '0', 0),
('management', '208', '206', 'admin/config/user-interface/shortcut/%/add-link', 'admin/config/user-interface/shortcut/%/add-link', 'Add shortcut', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 6, 0, '1', '8', '61', '201', '206', '208', '0', '0', '0', 0),
('management', '209', '202', 'admin/config/search/path/delete/%', 'admin/config/search/path/delete/%', 'Delete alias', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '8', '53', '202', '209', '0', '0', '0', '0', 0),
('management', '210', '206', 'admin/config/user-interface/shortcut/%/delete', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '8', '61', '201', '206', '210', '0', '0', '0', 0),
('management', '211', '202', 'admin/config/search/path/edit/%', 'admin/config/search/path/edit/%', 'Edit alias', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 5, 0, '1', '8', '53', '202', '211', '0', '0', '0', '0', 0),
('management', '212', '206', 'admin/config/user-interface/shortcut/%/edit', 'admin/config/user-interface/shortcut/%/edit', 'Edit set name', 'a:0:{}', 'system', -1, 0, 0, 0, '10', 6, 0, '1', '8', '61', '201', '206', '212', '0', '0', '0', 0),
('management', '213', '201', 'admin/config/user-interface/shortcut/link/%', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 'a:0:{}', 'system', 0, 0, 1, 0, '0', 5, 0, '1', '8', '61', '201', '213', '0', '0', '0', '0', 0),
('management', '214', '206', 'admin/config/user-interface/shortcut/%/links', 'admin/config/user-interface/shortcut/%/links', 'List links', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 6, 0, '1', '8', '61', '201', '206', '214', '0', '0', '0', 0),
('management', '215', '213', 'admin/config/user-interface/shortcut/link/%/delete', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '8', '61', '201', '213', '215', '0', '0', '0', 0),
('shortcut-set-1', '216', '0', 'node/add', 'node/add', 'Add content', 'a:0:{}', 'menu', 0, 0, 0, 0, '-50', 1, 0, '216', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('shortcut-set-1', '217', '0', 'admin/content', 'admin/content', 'Find content', 'a:0:{}', 'menu', 0, 0, 0, 0, '-49', 1, 0, '217', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('main-menu', '218', '0', '<front>', '', 'Home', 'a:0:{}', 'menu', 0, 1, 0, 0, '-50', 1, 1, '218', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '219', '6', 'node/add/article', 'node/add/article', 'Article', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:89:"Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.";}}', 'system', 0, 0, 0, 0, '0', 2, 0, '6', '219', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '220', '6', 'node/add/page', 'node/add/page', 'Basic page', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:77:"Use <em>basic pages</em> for your static content, such as an ''About us'' page.";}}', 'system', 0, 0, 0, 0, '0', 2, 0, '6', '220', '0', '0', '0', '0', '0', '0', '0', 0);
INSERT INTO `menu_links` VALUES
('management', '221', '12', 'admin/help/toolbar', 'admin/help/toolbar', 'toolbar', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '221', '0', '0', '0', '0', '0', '0', 0),
('management', '298', '21', 'admin/structure/demo', 'admin/structure/demo', 'Snapshots', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:36:"Create snapshots and reset the site.";}}', 'system', 0, 0, 0, 0, '0', 3, 0, '1', '21', '298', '0', '0', '0', '0', '0', '0', 0),
('management', '299', '298', 'admin/structure/demo/dump', 'admin/structure/demo/dump', 'Create snapshot', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '298', '299', '0', '0', '0', '0', '0', 0),
('management', '300', '298', 'admin/structure/demo/list', 'admin/structure/demo/list', 'List', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 4, 0, '1', '21', '298', '300', '0', '0', '0', '0', '0', 0),
('management', '301', '298', 'admin/structure/demo/reset', 'admin/structure/demo/reset', 'Reset', 'a:0:{}', 'system', -1, 0, 0, 0, '3', 4, 0, '1', '21', '298', '301', '0', '0', '0', '0', '0', 0),
('management', '302', '298', 'admin/structure/demo/settings', 'admin/structure/demo/settings', 'Settings', 'a:0:{}', 'system', -1, 0, 0, 0, '10', 4, 0, '1', '21', '298', '302', '0', '0', '0', '0', '0', 0),
('management', '303', '298', 'admin/structure/demo/delete/%', 'admin/structure/demo/delete/%', 'Delete snapshot', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 4, 0, '1', '21', '298', '303', '0', '0', '0', '0', '0', 0),
('management', '342', '124', 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%/display', 'Manage display', 'a:0:{}', 'system', -1, 0, 0, 0, '2', 5, 0, '1', '21', '57', '124', '342', '0', '0', '0', '0', 0),
('management', '343', '89', 'admin/config/people/accounts/display', 'admin/config/people/accounts/display', 'Manage display', 'a:0:{}', 'system', -1, 0, 0, 0, '2', 5, 0, '1', '8', '48', '89', '343', '0', '0', '0', '0', 0),
('management', '344', '124', 'admin/structure/taxonomy/%/fields', 'admin/structure/taxonomy/%/fields', 'Manage fields', 'a:0:{}', 'system', -1, 0, 1, 0, '1', 5, 0, '1', '21', '57', '124', '344', '0', '0', '0', '0', 0),
('management', '345', '89', 'admin/config/people/accounts/fields', 'admin/config/people/accounts/fields', 'Manage fields', 'a:0:{}', 'system', -1, 0, 1, 0, '1', 5, 0, '1', '8', '48', '89', '345', '0', '0', '0', '0', 0),
('management', '346', '342', 'admin/structure/taxonomy/%/display/default', 'admin/structure/taxonomy/%/display/default', 'Default', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 6, 0, '1', '21', '57', '124', '342', '346', '0', '0', '0', 0),
('management', '347', '343', 'admin/config/people/accounts/display/default', 'admin/config/people/accounts/display/default', 'Default', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 6, 0, '1', '8', '48', '89', '343', '347', '0', '0', '0', 0),
('management', '348', '135', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%/display', 'Manage display', 'a:0:{}', 'system', -1, 0, 0, 0, '2', 5, 0, '1', '21', '36', '135', '348', '0', '0', '0', '0', 0),
('management', '349', '135', 'admin/structure/types/manage/%/fields', 'admin/structure/types/manage/%/fields', 'Manage fields', 'a:0:{}', 'system', -1, 0, 1, 0, '1', 5, 0, '1', '21', '36', '135', '349', '0', '0', '0', '0', 0),
('management', '350', '342', 'admin/structure/taxonomy/%/display/full', 'admin/structure/taxonomy/%/display/full', 'Taxonomy term page', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 6, 0, '1', '21', '57', '124', '342', '350', '0', '0', '0', 0),
('management', '351', '343', 'admin/config/people/accounts/display/full', 'admin/config/people/accounts/display/full', 'User account', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 6, 0, '1', '8', '48', '89', '343', '351', '0', '0', '0', 0),
('management', '352', '344', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', '', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '21', '57', '124', '344', '352', '0', '0', '0', 0),
('management', '353', '345', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', '', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '8', '48', '89', '345', '353', '0', '0', '0', 0),
('management', '354', '348', 'admin/structure/types/manage/%/display/default', 'admin/structure/types/manage/%/display/default', 'Default', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 6, 0, '1', '21', '36', '135', '348', '354', '0', '0', '0', 0),
('management', '355', '348', 'admin/structure/types/manage/%/display/full', 'admin/structure/types/manage/%/display/full', 'Full content', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 6, 0, '1', '21', '36', '135', '348', '355', '0', '0', '0', 0),
('management', '356', '348', 'admin/structure/types/manage/%/display/rss', 'admin/structure/types/manage/%/display/rss', 'RSS', 'a:0:{}', 'system', -1, 0, 0, 0, '2', 6, 0, '1', '21', '36', '135', '348', '356', '0', '0', '0', 0),
('management', '357', '348', 'admin/structure/types/manage/%/display/search_index', 'admin/structure/types/manage/%/display/search_index', 'Search index', 'a:0:{}', 'system', -1, 0, 0, 0, '3', 6, 0, '1', '21', '36', '135', '348', '357', '0', '0', '0', 0),
('management', '358', '348', 'admin/structure/types/manage/%/display/search_result', 'admin/structure/types/manage/%/display/search_result', 'Search result', 'a:0:{}', 'system', -1, 0, 0, 0, '4', 6, 0, '1', '21', '36', '135', '348', '358', '0', '0', '0', 0),
('management', '359', '348', 'admin/structure/types/manage/%/display/teaser', 'admin/structure/types/manage/%/display/teaser', 'Teaser', 'a:0:{}', 'system', -1, 0, 0, 0, '1', 6, 0, '1', '21', '36', '135', '348', '359', '0', '0', '0', 0),
('management', '360', '349', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', '', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '21', '36', '135', '349', '360', '0', '0', '0', 0),
('management', '361', '352', 'admin/structure/taxonomy/%/fields/%/delete', 'admin/structure/taxonomy/%/fields/%/delete', 'Delete', 'a:0:{}', 'system', -1, 0, 0, 0, '10', 7, 0, '1', '21', '57', '124', '344', '352', '361', '0', '0', 0),
('management', '362', '352', 'admin/structure/taxonomy/%/fields/%/edit', 'admin/structure/taxonomy/%/fields/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '57', '124', '344', '352', '362', '0', '0', 0),
('management', '363', '352', 'admin/structure/taxonomy/%/fields/%/field-settings', 'admin/structure/taxonomy/%/fields/%/field-settings', 'Field settings', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '57', '124', '344', '352', '363', '0', '0', 0),
('management', '364', '352', 'admin/structure/taxonomy/%/fields/%/widget-type', 'admin/structure/taxonomy/%/fields/%/widget-type', 'Widget type', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '57', '124', '344', '352', '364', '0', '0', 0),
('management', '365', '353', 'admin/config/people/accounts/fields/%/delete', 'admin/config/people/accounts/fields/%/delete', 'Delete', 'a:0:{}', 'system', -1, 0, 0, 0, '10', 7, 0, '1', '8', '48', '89', '345', '353', '365', '0', '0', 0),
('management', '366', '353', 'admin/config/people/accounts/fields/%/edit', 'admin/config/people/accounts/fields/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '8', '48', '89', '345', '353', '366', '0', '0', 0),
('management', '367', '353', 'admin/config/people/accounts/fields/%/field-settings', 'admin/config/people/accounts/fields/%/field-settings', 'Field settings', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '8', '48', '89', '345', '353', '367', '0', '0', 0),
('management', '368', '353', 'admin/config/people/accounts/fields/%/widget-type', 'admin/config/people/accounts/fields/%/widget-type', 'Widget type', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '8', '48', '89', '345', '353', '368', '0', '0', 0),
('management', '369', '173', 'admin/structure/types/manage/%/comment/display/default', 'admin/structure/types/manage/%/comment/display/default', 'Default', 'a:0:{}', 'system', -1, 0, 0, 0, '-10', 6, 0, '1', '21', '36', '135', '173', '369', '0', '0', '0', 0),
('management', '370', '173', 'admin/structure/types/manage/%/comment/display/full', 'admin/structure/types/manage/%/comment/display/full', 'Full comment', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 6, 0, '1', '21', '36', '135', '173', '370', '0', '0', '0', 0),
('management', '371', '174', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', '', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 6, 0, '1', '21', '36', '135', '174', '371', '0', '0', '0', 0),
('management', '372', '360', 'admin/structure/types/manage/%/fields/%/edit', 'admin/structure/types/manage/%/fields/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '36', '135', '349', '360', '372', '0', '0', 0),
('management', '373', '360', 'admin/structure/types/manage/%/fields/%/delete', 'admin/structure/types/manage/%/fields/%/delete', 'Delete', 'a:0:{}', 'system', -1, 0, 0, 0, '10', 7, 0, '1', '21', '36', '135', '349', '360', '373', '0', '0', 0),
('management', '374', '360', 'admin/structure/types/manage/%/fields/%/field-settings', 'admin/structure/types/manage/%/fields/%/field-settings', 'Field settings', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '36', '135', '349', '360', '374', '0', '0', 0),
('management', '375', '360', 'admin/structure/types/manage/%/fields/%/widget-type', 'admin/structure/types/manage/%/fields/%/widget-type', 'Widget type', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '36', '135', '349', '360', '375', '0', '0', 0),
('management', '376', '371', 'admin/structure/types/manage/%/comment/fields/%/delete', 'admin/structure/types/manage/%/comment/fields/%/delete', 'Delete', 'a:0:{}', 'system', -1, 0, 0, 0, '10', 7, 0, '1', '21', '36', '135', '174', '371', '376', '0', '0', 0),
('management', '377', '371', 'admin/structure/types/manage/%/comment/fields/%/edit', 'admin/structure/types/manage/%/comment/fields/%/edit', 'Edit', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '36', '135', '174', '371', '377', '0', '0', 0),
('management', '378', '371', 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'Field settings', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '36', '135', '174', '371', '378', '0', '0', 0),
('management', '379', '371', 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'Widget type', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 7, 0, '1', '21', '36', '135', '174', '371', '379', '0', '0', 0),
('management', '380', '61', 'admin/config/user-interface/modulefilter', 'admin/config/user-interface/modulefilter', 'Module filter', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:37:"Configure settings for Module Filter.";}}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '8', '61', '380', '0', '0', '0', '0', '0', 0),
('main-menu', '381', '0', 'node/3', 'node/%', 'About Us', 'a:0:{}', 'menu', 0, 0, 1, 0, '-46', 1, 1, '381', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('main-menu', '382', '0', 'poll', 'poll', 'Polls', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:0:"";}}', 'system', 0, 0, 0, 0, '-47', 1, 1, '382', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '383', '6', 'node/add/poll', 'node/add/poll', 'Poll', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:191:"A <em>poll</em> is a question with a set of possible responses. A <em>poll</em>, once created, automatically provides a simple running count of the number of votes received for each response.";}}', 'system', 0, 0, 0, 0, '0', 2, 0, '6', '383', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '384', '5', 'node/%/results', 'node/%/results', 'Results', 'a:0:{}', 'system', -1, 0, 0, 0, '3', 2, 0, '5', '384', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '385', '5', 'node/%/votes', 'node/%/votes', 'Votes', 'a:0:{}', 'system', -1, 0, 0, 0, '3', 2, 0, '5', '385', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '386', '12', 'admin/help/poll', 'admin/help/poll', 'poll', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '386', '0', '0', '0', '0', '0', '0', 0),
('shortcut-set-1', '387', '0', 'admin/structure/demo', 'admin/structure/demo', 'Snapshots', 'a:0:{}', 'menu', 0, 0, 0, 0, '-48', 1, 0, '387', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('main-menu', '388', '0', 'node/5', 'node/%', 'Resources', 'a:0:{}', 'menu', 0, 0, 0, 0, '-49', 1, 1, '388', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('main-menu', '389', '0', 'http://drupal.org', '', 'Drupal Home', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:25:"Go to the home of Drupal!";}}', 'menu', 0, 1, 0, 0, '-48', 1, 1, '389', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('main-menu', '390', '381', 'node/6', 'node/%', 'Staff', 'a:0:{}', 'menu', 0, 0, 0, 0, '0', 2, 0, '381', '390', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '391', '0', 'devel/settings', 'devel/settings', 'Devel settings', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:168:"Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href="/admin/structure/block">block administration</a> page.";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '391', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '392', '0', 'devel/php', 'devel/php', 'Execute PHP Code', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:21:"Execute some PHP code";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '392', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '393', '0', 'devel/reference', 'devel/reference', 'Function reference', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:73:"View a list of currently defined user functions with documentation links.";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '393', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '394', '0', 'devel/elements', 'devel/elements', 'Hook_elements()', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:51:"View the active form/render elements for this site.";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '394', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '395', '0', 'devel/phpinfo', 'devel/phpinfo', 'PHPinfo()', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:36:"View your server''s PHP configuration";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '395', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '396', '0', 'devel/reinstall', 'devel/reinstall', 'Reinstall modules', 'a:2:{s:10:"attributes";a:1:{s:5:"title";s:64:"Run hook_uninstall() and then hook_install() for a given module.";}s:5:"alter";b:1;}', 'system', 0, 0, 0, 0, '0', 1, 0, '396', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '397', '0', 'devel/run-cron', 'devel/run-cron', 'Run cron', 'a:0:{}', 'system', 0, 0, 0, 0, '0', 1, 0, '397', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '398', '0', 'devel/session', 'devel/session', 'Session viewer', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:31:"List the contents of $_SESSION.";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '398', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '399', '0', 'devel/variable', 'devel/variable', 'Variable editor', 'a:2:{s:10:"attributes";a:1:{s:5:"title";s:31:"Edit and delete site variables.";}s:5:"alter";b:1;}', 'system', 0, 0, 0, 0, '0', 1, 0, '399', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '400', '3', 'comment/%/devel', 'comment/%/devel', 'Devel', 'a:0:{}', 'system', -1, 0, 0, 0, '100', 2, 0, '3', '400', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '401', '5', 'node/%/devel', 'node/%/devel', 'Devel', 'a:0:{}', 'system', -1, 0, 0, 0, '100', 2, 0, '5', '401', '0', '0', '0', '0', '0', '0', '0', 0),
('navigation', '402', '17', 'user/%/devel', 'user/%/devel', 'Devel', 'a:0:{}', 'system', -1, 0, 0, 0, '100', 2, 0, '17', '402', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '403', '0', 'devel/cache/clear', 'devel/cache/clear', 'Empty cache', 'a:2:{s:10:"attributes";a:1:{s:5:"title";s:100:"Clear the CSS cache and all database cache tables which store page, node, theme and variable caches.";}s:5:"alter";b:1;}', 'system', 0, 0, 0, 0, '0', 1, 0, '403', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '404', '0', 'devel/entity/info', 'devel/entity/info', 'Entity info', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:46:"View entity information across the whole site.";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '404', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '405', '0', 'devel/field/info', 'devel/field/info', 'Field info', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:46:"View fields information across the whole site.";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '405', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '406', '0', 'devel/menu/item', 'devel/menu/item', 'Menu item', 'a:2:{s:10:"attributes";a:1:{s:5:"title";s:32:"Details about a given menu item.";}s:5:"alter";b:1;}', 'system', 0, 0, 0, 0, '0', 1, 0, '406', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '407', '0', 'devel/menu/reset', 'devel/menu/reset', 'Rebuild menus', 'a:2:{s:10:"attributes";a:1:{s:5:"title";s:113:"Rebuild menu based on hook_menu() and revert any custom changes. All menu items return to their default settings.";}s:5:"alter";b:1;}', 'system', 0, 0, 0, 0, '0', 1, 0, '407', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('devel', '408', '0', 'devel/theme/registry', 'devel/theme/registry', 'Theme registry', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:63:"View a list of available theme functions across the whole site.";}}', 'system', 0, 0, 0, 0, '0', 1, 0, '408', '0', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '409', '12', 'admin/help/devel', 'admin/help/devel', 'devel', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '1', '12', '409', '0', '0', '0', '0', '0', '0', 0),
('navigation', '410', '27', 'taxonomy/term/%/devel', 'taxonomy/term/%/devel', 'Devel', 'a:0:{}', 'system', -1, 0, 0, 0, '100', 2, 0, '27', '410', '0', '0', '0', '0', '0', '0', '0', 0),
('management', '411', '39', 'admin/config/development/devel', 'admin/config/development/devel', 'Devel settings', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:168:"Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href="/admin/structure/block">block administration</a> page.";}}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '8', '39', '411', '0', '0', '0', '0', '0', 0),
('navigation', '412', '400', 'comment/%/devel/load', 'comment/%/devel/load', 'Load', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '3', '400', '412', '0', '0', '0', '0', '0', '0', 0),
('navigation', '413', '401', 'node/%/devel/load', 'node/%/devel/load', 'Load', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '5', '401', '413', '0', '0', '0', '0', '0', '0', 0),
('navigation', '414', '402', 'user/%/devel/load', 'user/%/devel/load', 'Load', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '17', '402', '414', '0', '0', '0', '0', '0', '0', 0),
('navigation', '415', '400', 'comment/%/devel/render', 'comment/%/devel/render', 'Render', 'a:0:{}', 'system', -1, 0, 0, 0, '100', 3, 0, '3', '400', '415', '0', '0', '0', '0', '0', '0', 0),
('navigation', '416', '401', 'node/%/devel/render', 'node/%/devel/render', 'Render', 'a:0:{}', 'system', -1, 0, 0, 0, '100', 3, 0, '5', '401', '416', '0', '0', '0', '0', '0', '0', 0),
('navigation', '417', '402', 'user/%/devel/render', 'user/%/devel/render', 'Render', 'a:0:{}', 'system', -1, 0, 0, 0, '100', 3, 0, '17', '402', '417', '0', '0', '0', '0', '0', '0', 0),
('management', '418', '39', 'admin/config/development/generate/content', 'admin/config/development/generate/content', 'Generate content', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:79:"Generate a given number of nodes and comments. Optionally delete current items.";}}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '8', '39', '418', '0', '0', '0', '0', '0', 0),
('management', '419', '39', 'admin/config/development/generate/menu', 'admin/config/development/generate/menu', 'Generate menus', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:81:"Generate a given number of menus and menu links. Optionally delete current menus.";}}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '8', '39', '419', '0', '0', '0', '0', '0', 0),
('management', '420', '39', 'admin/config/development/generate/taxonomy', 'admin/config/development/generate/taxonomy', 'Generate terms', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:66:"Generate a given number of terms. Optionally delete current terms.";}}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '8', '39', '420', '0', '0', '0', '0', '0', 0),
('management', '421', '39', 'admin/config/development/generate/user', 'admin/config/development/generate/user', 'Generate users', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:66:"Generate a given number of users. Optionally delete current users.";}}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '8', '39', '421', '0', '0', '0', '0', '0', 0),
('management', '422', '39', 'admin/config/development/generate/vocabs', 'admin/config/development/generate/vocabs', 'Generate vocabularies', 'a:1:{s:10:"attributes";a:1:{s:5:"title";s:80:"Generate a given number of vocabularies. Optionally delete current vocabularies.";}}', 'system', 0, 0, 0, 0, '0', 4, 0, '1', '8', '39', '422', '0', '0', '0', '0', '0', 0),
('navigation', '423', '410', 'taxonomy/term/%/devel/load', 'taxonomy/term/%/devel/load', 'Load', 'a:0:{}', 'system', -1, 0, 0, 0, '0', 3, 0, '27', '410', '423', '0', '0', '0', '0', '0', '0', 0),
('navigation', '424', '410', 'taxonomy/term/%/devel/render', 'taxonomy/term/%/devel/render', 'Render', 'a:0:{}', 'system', -1, 0, 0, 0, '100', 3, 0, '27', '410', '424', '0', '0', '0', '0', '0', '0', 0);
/*!40000 ALTER TABLE menu_links ENABLE KEYS */;

--
-- Table structure for table 'menu_router'
--

CREATE TABLE IF NOT EXISTS `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Maps paths to various callbacks (access, page and title)';

--
-- Dumping data for table 'menu_router'
--

/*!40000 ALTER TABLE menu_router DISABLE KEYS */;
INSERT INTO `menu_router` VALUES
('admin', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '1', 1, '0', '', 'admin', 'Administration', 't', '', '', 'a:0:{}', '6', '', '', '9', 'modules/system/system.admin.inc'),
('admin/appearance', '', '', 'user_access', 'a:1:{i:0;s:17:"administer themes";}', 'system_themes_page', 'a:0:{}', '', '3', 2, '0', '', 'admin/appearance', 'Appearance', 't', '', '', 'a:0:{}', '6', 'Select and configure your themes.', 'left', '-6', 'modules/system/system.admin.inc'),
('admin/appearance/default', '', '', 'user_access', 'a:1:{i:0;s:17:"administer themes";}', 'system_theme_default', 'a:0:{}', '', '7', 3, '0', '', 'admin/appearance/default', 'Set default theme', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/appearance/disable', '', '', 'user_access', 'a:1:{i:0;s:17:"administer themes";}', 'system_theme_disable', 'a:0:{}', '', '7', 3, '0', '', 'admin/appearance/disable', 'Disable theme', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/appearance/enable', '', '', 'user_access', 'a:1:{i:0;s:17:"administer themes";}', 'system_theme_enable', 'a:0:{}', '', '7', 3, '0', '', 'admin/appearance/enable', 'Enable theme', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/appearance/list', '', '', 'user_access', 'a:1:{i:0;s:17:"administer themes";}', 'system_themes_page', 'a:0:{}', '', '7', 3, '1', 'admin/appearance', 'admin/appearance', 'List', 't', '', '', 'a:0:{}', '140', 'Select and configure your theme', '', '-1', 'modules/system/system.admin.inc'),
('admin/appearance/settings', '', '', 'user_access', 'a:1:{i:0;s:17:"administer themes";}', 'drupal_get_form', 'a:1:{i:0;s:21:"system_theme_settings";}', '', '7', 3, '1', 'admin/appearance', 'admin/appearance', 'Settings', 't', '', '', 'a:0:{}', '132', 'Configure default and theme specific settings.', '', '20', 'modules/system/system.admin.inc'),
('admin/appearance/settings/bartik', '', '', '_system_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:25:"themes/bartik/bartik.info";s:4:"name";s:6:"bartik";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"1";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:6:"Bartik";s:11:"description";s:48:"A flexible, recolorable theme with many regions.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:3:{s:14:"css/layout.css";s:28:"themes/bartik/css/layout.css";s:13:"css/style.css";s:27:"themes/bartik/css/style.css";s:14:"css/colors.css";s:28:"themes/bartik/css/colors.css";}s:5:"print";a:1:{s:13:"css/print.css";s:27:"themes/bartik/css/print.css";}}s:7:"regions";a:20:{s:6:"header";s:6:"Header";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:11:"highlighted";s:11:"Highlighted";s:8:"featured";s:8:"Featured";s:7:"content";s:7:"Content";s:13:"sidebar_first";s:13:"Sidebar first";s:14:"sidebar_second";s:14:"Sidebar second";s:14:"triptych_first";s:14:"Triptych first";s:15:"triptych_middle";s:15:"Triptych middle";s:13:"triptych_last";s:13:"Triptych last";s:18:"footer_firstcolumn";s:19:"Footer first column";s:19:"footer_secondcolumn";s:20:"Footer second column";s:18:"footer_thirdcolumn";s:19:"Footer third column";s:19:"footer_fourthcolumn";s:20:"Footer fourth column";s:6:"footer";s:6:"Footer";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"settings";a:1:{s:20:"shortcut_module_link";s:1:"0";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:28:"themes/bartik/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:2:{s:3:"all";a:3:{s:14:"css/layout.css";s:28:"themes/bartik/css/layout.css";s:13:"css/style.css";s:27:"themes/bartik/css/style.css";s:14:"css/colors.css";s:28:"themes/bartik/css/colors.css";}s:5:"print";a:1:{s:13:"css/print.css";s:27:"themes/bartik/css/print.css";}}s:6:"engine";s:11:"phptemplate";}}', 'drupal_get_form', 'a:2:{i:0;s:21:"system_theme_settings";i:1;s:6:"bartik";}', '', '15', 4, '1', 'admin/appearance/settings', 'admin/appearance', 'Bartik', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc'),
('admin/appearance/settings/garland', '', '', '_system_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:27:"themes/garland/garland.info";s:4:"name";s:7:"garland";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"0";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:7:"Garland";s:11:"description";s:111:"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:1:{s:9:"style.css";s:24:"themes/garland/style.css";}s:5:"print";a:1:{s:9:"print.css";s:24:"themes/garland/print.css";}}s:8:"settings";a:1:{s:13:"garland_width";s:5:"fluid";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:7:"regions";a:12:{s:13:"sidebar_first";s:12:"Left sidebar";s:14:"sidebar_second";s:13:"Right sidebar";s:7:"content";s:7:"Content";s:6:"header";s:6:"Header";s:6:"footer";s:6:"Footer";s:11:"highlighted";s:11:"Highlighted";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:29:"themes/garland/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:2:{s:3:"all";a:1:{s:9:"style.css";s:24:"themes/garland/style.css";}s:5:"print";a:1:{s:9:"print.css";s:24:"themes/garland/print.css";}}s:6:"engine";s:11:"phptemplate";}}', 'drupal_get_form', 'a:2:{i:0;s:21:"system_theme_settings";i:1;s:7:"garland";}', '', '15', 4, '1', 'admin/appearance/settings', 'admin/appearance', 'Garland', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc'),
('admin/appearance/settings/global', '', '', 'user_access', 'a:1:{i:0;s:17:"administer themes";}', 'drupal_get_form', 'a:1:{i:0;s:21:"system_theme_settings";}', '', '15', 4, '1', 'admin/appearance/settings', 'admin/appearance', 'Global settings', 't', '', '', 'a:0:{}', '140', '', '', '-1', 'modules/system/system.admin.inc'),
('admin/appearance/settings/seven', '', '', '_system_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:23:"themes/seven/seven.info";s:4:"name";s:5:"seven";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"1";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:5:"Seven";s:11:"description";s:65:"A simple one-column, tableless, fluid width administration theme.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:1:{s:6:"screen";a:2:{s:9:"reset.css";s:22:"themes/seven/reset.css";s:9:"style.css";s:22:"themes/seven/style.css";}}s:8:"settings";a:1:{s:20:"shortcut_module_link";s:1:"1";}s:7:"regions";a:8:{s:7:"content";s:7:"Content";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:13:"sidebar_first";s:13:"First sidebar";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:14:"regions_hidden";a:3:{i:0;s:13:"sidebar_first";i:1;s:8:"page_top";i:2;s:11:"page_bottom";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:27:"themes/seven/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:1:{s:6:"screen";a:2:{s:9:"reset.css";s:22:"themes/seven/reset.css";s:9:"style.css";s:22:"themes/seven/style.css";}}s:6:"engine";s:11:"phptemplate";}}', 'drupal_get_form', 'a:2:{i:0;s:21:"system_theme_settings";i:1;s:5:"seven";}', '', '15', 4, '1', 'admin/appearance/settings', 'admin/appearance', 'Seven', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc'),
('admin/appearance/settings/stark', '', '', '_system_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:23:"themes/stark/stark.info";s:4:"name";s:5:"stark";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"0";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:17:{s:4:"name";s:5:"Stark";s:11:"description";s:208:"This theme demonstrates Drupal''s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal''s default code, see the <a href="http://drupal.org/theme-guide">Theming Guide</a>.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:10:"layout.css";s:23:"themes/stark/layout.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:7:"regions";a:12:{s:13:"sidebar_first";s:12:"Left sidebar";s:14:"sidebar_second";s:13:"Right sidebar";s:7:"content";s:7:"Content";s:6:"header";s:6:"Header";s:6:"footer";s:6:"Footer";s:11:"highlighted";s:11:"Highlighted";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:27:"themes/stark/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:10:"layout.css";s:23:"themes/stark/layout.css";}}s:6:"engine";s:11:"phptemplate";}}', 'drupal_get_form', 'a:2:{i:0;s:21:"system_theme_settings";i:1;s:5:"stark";}', '', '15', 4, '1', 'admin/appearance/settings', 'admin/appearance', 'Stark', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc'),
('admin/compact', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_compact_page', 'a:0:{}', '', '3', 2, '0', '', 'admin/compact', 'Compact mode', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/config', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_config_page', 'a:0:{}', '', '3', 2, '0', '', 'admin/config', 'Configuration', 't', '', '', 'a:0:{}', '6', 'Administer settings.', '', '0', 'modules/system/system.admin.inc'),
('admin/config/content', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/content', 'Content authoring', 't', '', '', 'a:0:{}', '6', 'Settings related to formatting and authoring content.', 'left', '-15', 'modules/system/system.admin.inc'),
('admin/config/content/formats', '', '', 'user_access', 'a:1:{i:0;s:18:"administer filters";}', 'drupal_get_form', 'a:1:{i:0;s:21:"filter_admin_overview";}', '', '15', 4, '0', '', 'admin/config/content/formats', 'Text formats', 't', '', '', 'a:0:{}', '6', 'Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.', '', '0', 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%', 'a:1:{i:4;s:18:"filter_format_load";}', '', 'user_access', 'a:1:{i:0;s:18:"administer filters";}', 'filter_admin_format_page', 'a:1:{i:0;i:4;}', '', '30', 5, '0', '', 'admin/config/content/formats/%', '', 'filter_admin_format_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', '6', '', '', '0', 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%/disable', 'a:1:{i:4;s:18:"filter_format_load";}', '', '_filter_disable_format_access', 'a:1:{i:0;i:4;}', 'drupal_get_form', 'a:2:{i:0;s:20:"filter_admin_disable";i:1;i:4;}', '', '61', 6, '0', '', 'admin/config/content/formats/%/disable', 'Disable text format', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/add', '', '', 'user_access', 'a:1:{i:0;s:18:"administer filters";}', 'filter_admin_format_page', 'a:0:{}', '', '31', 5, '1', 'admin/config/content/formats', 'admin/config/content/formats', 'Add text format', 't', '', '', 'a:0:{}', '388', '', '', '1', 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/list', '', '', 'user_access', 'a:1:{i:0;s:18:"administer filters";}', 'drupal_get_form', 'a:1:{i:0;s:21:"filter_admin_overview";}', '', '31', 5, '1', 'admin/config/content/formats', 'admin/config/content/formats', 'List', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/filter/filter.admin.inc'),
('admin/config/development', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/development', 'Development', 't', '', '', 'a:0:{}', '6', 'Development tools.', 'right', '-10', 'modules/system/system.admin.inc'),
('admin/config/development/devel', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:20:"devel_admin_settings";}', '', '15', 4, '0', '', 'admin/config/development/devel', 'Devel settings', 't', '', '', 'a:0:{}', '6', 'Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href="/admin/structure/block">block administration</a> page.', '', '0', 'sites/all/modules/devel/devel.admin.inc'),
('admin/config/development/generate/content', '', '', 'user_access', 'a:1:{i:0;s:16:"administer nodes";}', 'drupal_get_form', 'a:1:{i:0;s:27:"devel_generate_content_form";}', '', '31', 5, '0', '', 'admin/config/development/generate/content', 'Generate content', 't', '', '', 'a:0:{}', '6', 'Generate a given number of nodes and comments. Optionally delete current items.', '', '0', ''),
('admin/config/development/generate/menu', '', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:1:{i:0;s:24:"devel_generate_menu_form";}', '', '31', 5, '0', '', 'admin/config/development/generate/menu', 'Generate menus', 't', '', '', 'a:0:{}', '6', 'Generate a given number of menus and menu links. Optionally delete current menus.', '', '0', ''),
('admin/config/development/generate/taxonomy', '', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:1:{i:0;s:24:"devel_generate_term_form";}', '', '31', 5, '0', '', 'admin/config/development/generate/taxonomy', 'Generate terms', 't', '', '', 'a:0:{}', '6', 'Generate a given number of terms. Optionally delete current terms.', '', '0', ''),
('admin/config/development/generate/user', '', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:1:{i:0;s:25:"devel_generate_users_form";}', '', '31', 5, '0', '', 'admin/config/development/generate/user', 'Generate users', 't', '', '', 'a:0:{}', '6', 'Generate a given number of users. Optionally delete current users.', '', '0', ''),
('admin/config/development/generate/vocabs', '', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:1:{i:0;s:25:"devel_generate_vocab_form";}', '', '31', 5, '0', '', 'admin/config/development/generate/vocabs', 'Generate vocabularies', 't', '', '', 'a:0:{}', '6', 'Generate a given number of vocabularies. Optionally delete current vocabularies.', '', '0', ''),
('admin/config/development/logging', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:23:"system_logging_settings";}', '', '15', 4, '0', '', 'admin/config/development/logging', 'Logging and errors', 't', '', '', 'a:0:{}', '6', 'Settings for logging and alerts modules. Various modules can route Drupal''s system events to different destinations, such as syslog, database, email, etc.', '', '-15', 'modules/system/system.admin.inc'),
('admin/config/development/maintenance', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:28:"system_site_maintenance_mode";}', '', '15', 4, '0', '', 'admin/config/development/maintenance', 'Maintenance mode', 't', '', '', 'a:0:{}', '6', 'Take the site offline for maintenance or bring it back online.', '', '-10', 'modules/system/system.admin.inc'),
('admin/config/development/performance', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:27:"system_performance_settings";}', '', '15', 4, '0', '', 'admin/config/development/performance', 'Performance', 't', '', '', 'a:0:{}', '6', 'Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.', '', '-20', 'modules/system/system.admin.inc'),
('admin/config/media', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/media', 'Media', 't', '', '', 'a:0:{}', '6', 'Media tools.', 'left', '-10', 'modules/system/system.admin.inc'),
('admin/config/media/file-system', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:27:"system_file_system_settings";}', '', '15', 4, '0', '', 'admin/config/media/file-system', 'File system', 't', '', '', 'a:0:{}', '6', 'Tell Drupal where to store uploaded files and how they are accessed.', '', '-10', 'modules/system/system.admin.inc'),
('admin/config/media/image-styles', '', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'image_style_list', 'a:0:{}', '', '15', 4, '0', '', 'admin/config/media/image-styles', 'Image styles', 't', '', '', 'a:0:{}', '6', 'Configure styles that can be used for resizing or adjusting images on display.', '', '0', 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/add', '', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'drupal_get_form', 'a:1:{i:0;s:20:"image_style_add_form";}', '', '31', 5, '1', 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Add style', 't', '', '', 'a:0:{}', '388', 'Add a new image style.', '', '2', 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/delete/%', 'a:1:{i:5;a:1:{s:16:"image_style_load";a:2:{i:0;N;i:1;s:1:"1";}}}', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'drupal_get_form', 'a:2:{i:0;s:23:"image_style_delete_form";i:1;i:5;}', '', '62', 6, '0', '', 'admin/config/media/image-styles/delete/%', 'Delete style', 't', '', '', 'a:0:{}', '6', 'Delete an image style.', '', '0', 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%', 'a:1:{i:5;s:16:"image_style_load";}', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'drupal_get_form', 'a:2:{i:0;s:16:"image_style_form";i:1;i:5;}', '', '62', 6, '0', '', 'admin/config/media/image-styles/edit/%', 'Edit style', 't', '', '', 'a:0:{}', '6', 'Configure an image style.', '', '0', 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/add/%', 'a:2:{i:5;a:1:{s:16:"image_style_load";a:1:{i:0;i:5;}}i:7;a:1:{s:28:"image_effect_definition_load";a:1:{i:0;i:5;}}}', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'drupal_get_form', 'a:3:{i:0;s:17:"image_effect_form";i:1;i:5;i:2;i:7;}', '', '250', 8, '0', '', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 't', '', '', 'a:0:{}', '6', 'Add a new effect to a style.', '', '0', 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%', 'a:2:{i:5;a:1:{s:16:"image_style_load";a:2:{i:0;i:5;i:1;s:1:"3";}}i:7;a:1:{s:17:"image_effect_load";a:2:{i:0;i:5;i:1;s:1:"3";}}}', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'drupal_get_form', 'a:3:{i:0;s:17:"image_effect_form";i:1;i:5;i:2;i:7;}', '', '250', 8, '0', '', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 't', '', '', 'a:0:{}', '6', 'Edit an existing effect within a style.', '', '0', 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%/delete', 'a:2:{i:5;a:1:{s:16:"image_style_load";a:2:{i:0;i:5;i:1;s:1:"3";}}i:7;a:1:{s:17:"image_effect_load";a:2:{i:0;i:5;i:1;s:1:"3";}}}', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'drupal_get_form', 'a:3:{i:0;s:24:"image_effect_delete_form";i:1;i:5;i:2;i:7;}', '', '501', 9, '0', '', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 't', '', '', 'a:0:{}', '6', 'Delete an existing effect from a style.', '', '0', 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/list', '', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'image_style_list', 'a:0:{}', '', '31', 5, '1', 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'List', 't', '', '', 'a:0:{}', '140', 'List the current image styles on the site.', '', '1', 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/revert/%', 'a:1:{i:5;a:1:{s:16:"image_style_load";a:2:{i:0;N;i:1;s:1:"2";}}}', '', 'user_access', 'a:1:{i:0;s:23:"administer image styles";}', 'drupal_get_form', 'a:2:{i:0;s:23:"image_style_revert_form";i:1;i:5;}', '', '62', 6, '0', '', 'admin/config/media/image-styles/revert/%', 'Revert style', 't', '', '', 'a:0:{}', '6', 'Revert an image style.', '', '0', 'modules/image/image.admin.inc'),
('admin/config/media/image-toolkit', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:29:"system_image_toolkit_settings";}', '', '15', 4, '0', '', 'admin/config/media/image-toolkit', 'Image toolkit', 't', '', '', 'a:0:{}', '6', 'Choose which image toolkit to use if you have installed optional toolkits.', '', '20', 'modules/system/system.admin.inc'),
('admin/config/people', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/people', 'People', 't', '', '', 'a:0:{}', '6', 'Configure user accounts.', 'left', '-20', 'modules/system/system.admin.inc'),
('admin/config/people/accounts', '', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:1:{i:0;s:19:"user_admin_settings";}', '', '15', 4, '0', '', 'admin/config/people/accounts', 'Account settings', 't', '', '', 'a:0:{}', '6', 'Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.', '', '-10', 'modules/user/user.admin.inc'),
('admin/config/people/accounts/display', '', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"user";i:2;s:4:"user";i:3;s:7:"default";}', '', '31', 5, '1', 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage display', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/default', '', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:4:"user";i:1;s:4:"user";i:2;s:7:"default";i:3;s:11:"user_access";i:4;s:16:"administer users";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"user";i:2;s:4:"user";i:3;s:7:"default";}', '', '63', 6, '1', 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'Default', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/full', '', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:4:"user";i:1;s:4:"user";i:2;s:4:"full";i:3;s:11:"user_access";i:4;s:16:"administer users";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"user";i:2;s:4:"user";i:3;s:4:"full";}', '', '63', 6, '1', 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'User account', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields', '', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:3:{i:0;s:28:"field_ui_field_overview_form";i:1;s:4:"user";i:2;s:4:"user";}', '', '31', 5, '1', 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage fields', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%', 'a:1:{i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"user";i:1;s:4:"user";i:2;s:1:"0";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:2:{i:0;s:24:"field_ui_field_edit_form";i:1;i:5;}', '', '62', 6, '0', '', 'admin/config/people/accounts/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', '6', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/delete', 'a:1:{i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"user";i:1;s:4:"user";i:2;s:1:"0";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:2:{i:0;s:26:"field_ui_field_delete_form";i:1;i:5;}', '', '125', 7, '1', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/edit', 'a:1:{i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"user";i:1;s:4:"user";i:2;s:1:"0";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:2:{i:0;s:24:"field_ui_field_edit_form";i:1;i:5;}', '', '125', 7, '1', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/field-settings', 'a:1:{i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"user";i:1;s:4:"user";i:2;s:1:"0";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:2:{i:0;s:28:"field_ui_field_settings_form";i:1;i:5;}', '', '125', 7, '1', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Field settings', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/widget-type', 'a:1:{i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"user";i:1;s:4:"user";i:2;s:1:"0";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:2:{i:0;s:25:"field_ui_widget_type_form";i:1;i:5;}', '', '125', 7, '1', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Widget type', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/settings', '', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'drupal_get_form', 'a:1:{i:0;s:19:"user_admin_settings";}', '', '31', 5, '1', 'admin/config/people/accounts', 'admin/config/people/accounts', 'Settings', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/user/user.admin.inc'),
('admin/config/people/ip-blocking', '', '', 'user_access', 'a:1:{i:0;s:18:"block IP addresses";}', 'system_ip_blocking', 'a:0:{}', '', '15', 4, '0', '', 'admin/config/people/ip-blocking', 'IP address blocking', 't', '', '', 'a:0:{}', '6', 'Manage blocked IP addresses.', '', '10', 'modules/system/system.admin.inc'),
('admin/config/people/ip-blocking/delete/%', 'a:1:{i:5;s:15:"blocked_ip_load";}', '', 'user_access', 'a:1:{i:0;s:18:"block IP addresses";}', 'drupal_get_form', 'a:2:{i:0;s:25:"system_ip_blocking_delete";i:1;i:5;}', '', '62', 6, '0', '', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/system/system.admin.inc'),
('admin/config/regional', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/regional', 'Regional and language', 't', '', '', 'a:0:{}', '6', 'Regional settings, localization and translation.', 'left', '-5', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:25:"system_date_time_settings";}', '', '15', 4, '0', '', 'admin/config/regional/date-time', 'Date and time', 't', '', '', 'a:0:{}', '6', 'Configure display formats for date and time.', '', '-15', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'system_date_time_formats', 'a:0:{}', '', '31', 5, '1', 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Formats', 't', '', '', 'a:0:{}', '132', 'Configure display format strings for date and time.', '', '-9', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/delete', 'a:1:{i:5;N;}', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:2:{i:0;s:30:"system_date_delete_format_form";i:1;i:5;}', '', '125', 7, '0', '', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 't', '', '', 'a:0:{}', '6', 'Allow users to delete a configured date format.', '', '0', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/edit', 'a:1:{i:5;N;}', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:2:{i:0;s:34:"system_configure_date_formats_form";i:1;i:5;}', '', '125', 7, '0', '', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 't', '', '', 'a:0:{}', '6', 'Allow users to edit a configured date format.', '', '0', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/add', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:34:"system_configure_date_formats_form";}', '', '63', 6, '1', 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time', 'Add format', 't', '', '', 'a:0:{}', '388', 'Allow users to add additional date formats.', '', '-10', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/lookup', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'system_date_time_lookup', 'a:0:{}', '', '63', 6, '0', '', 'admin/config/regional/date-time/formats/lookup', 'Date and time lookup', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:25:"system_date_time_settings";}', '', '31', 5, '1', 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Types', 't', '', '', 'a:0:{}', '140', 'Configure display formats for date and time.', '', '-10', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/%/delete', 'a:1:{i:5;N;}', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:2:{i:0;s:35:"system_delete_date_format_type_form";i:1;i:5;}', '', '125', 7, '0', '', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 't', '', '', 'a:0:{}', '6', 'Allow users to delete a configured date type.', '', '0', 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/add', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:32:"system_add_date_format_type_form";}', '', '63', 6, '1', 'admin/config/regional/date-time/types', 'admin/config/regional/date-time', 'Add date type', 't', '', '', 'a:0:{}', '388', 'Add new date type.', '', '-10', 'modules/system/system.admin.inc'),
('admin/config/regional/settings', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:24:"system_regional_settings";}', '', '15', 4, '0', '', 'admin/config/regional/settings', 'Regional settings', 't', '', '', 'a:0:{}', '6', 'Settings for the site''s default time zone and country.', '', '-20', 'modules/system/system.admin.inc'),
('admin/config/search', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/search', 'Search and metadata', 't', '', '', 'a:0:{}', '6', 'Local site search, metadata and SEO.', 'left', '-10', 'modules/system/system.admin.inc'),
('admin/config/search/clean-urls', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:25:"system_clean_url_settings";}', '', '15', 4, '0', '', 'admin/config/search/clean-urls', 'Clean URLs', 't', '', '', 'a:0:{}', '6', 'Enable or disable clean URLs for your site.', '', '5', 'modules/system/system.admin.inc'),
('admin/config/search/clean-urls/check', '', '', '1', 'a:0:{}', 'drupal_json_output', 'a:1:{i:0;a:1:{s:6:"status";b:1;}}', '', '31', 5, '0', '', 'admin/config/search/clean-urls/check', 'Clean URL check', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/config/search/path', '', '', 'user_access', 'a:1:{i:0;s:22:"administer url aliases";}', 'path_admin_overview', 'a:0:{}', '', '15', 4, '0', '', 'admin/config/search/path', 'URL aliases', 't', '', '', 'a:0:{}', '6', 'Change your site''s URL paths by aliasing them.', '', '-5', 'modules/path/path.admin.inc'),
('admin/config/search/path/add', '', '', 'user_access', 'a:1:{i:0;s:22:"administer url aliases";}', 'path_admin_edit', 'a:0:{}', '', '31', 5, '1', 'admin/config/search/path', 'admin/config/search/path', 'Add alias', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/path/path.admin.inc'),
('admin/config/search/path/delete/%', 'a:1:{i:5;s:9:"path_load";}', '', 'user_access', 'a:1:{i:0;s:22:"administer url aliases";}', 'drupal_get_form', 'a:2:{i:0;s:25:"path_admin_delete_confirm";i:1;i:5;}', '', '62', 6, '0', '', 'admin/config/search/path/delete/%', 'Delete alias', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/path/path.admin.inc'),
('admin/config/search/path/edit/%', 'a:1:{i:5;s:9:"path_load";}', '', 'user_access', 'a:1:{i:0;s:22:"administer url aliases";}', 'path_admin_edit', 'a:1:{i:0;i:5;}', '', '62', 6, '0', '', 'admin/config/search/path/edit/%', 'Edit alias', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/path/path.admin.inc'),
('admin/config/search/path/list', '', '', 'user_access', 'a:1:{i:0;s:22:"administer url aliases";}', 'path_admin_overview', 'a:0:{}', '', '31', 5, '1', 'admin/config/search/path', 'admin/config/search/path', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/path/path.admin.inc'),
('admin/config/search/settings', '', '', 'user_access', 'a:1:{i:0;s:17:"administer search";}', 'drupal_get_form', 'a:1:{i:0;s:21:"search_admin_settings";}', '', '15', 4, '0', '', 'admin/config/search/settings', 'Search settings', 't', '', '', 'a:0:{}', '6', 'Configure relevance settings for search and other indexing options.', '', '-10', 'modules/search/search.admin.inc'),
('admin/config/search/settings/reindex', '', '', 'user_access', 'a:1:{i:0;s:17:"administer search";}', 'drupal_get_form', 'a:1:{i:0;s:22:"search_reindex_confirm";}', '', '31', 5, '0', '', 'admin/config/search/settings/reindex', 'Clear index', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/search/search.admin.inc'),
('admin/config/services', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/services', 'Web services', 't', '', '', 'a:0:{}', '6', 'Tools related to web services.', 'right', '0', 'modules/system/system.admin.inc'),
('admin/config/services/rss-publishing', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:25:"system_rss_feeds_settings";}', '', '15', 4, '0', '', 'admin/config/services/rss-publishing', 'RSS publishing', 't', '', '', 'a:0:{}', '6', 'Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.', '', '0', 'modules/system/system.admin.inc'),
('admin/config/system', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/system', 'System', 't', '', '', 'a:0:{}', '6', 'General system related configuration.', 'right', '-20', 'modules/system/system.admin.inc'),
('admin/config/system/actions', '', '', 'user_access', 'a:1:{i:0;s:18:"administer actions";}', 'system_actions_manage', 'a:0:{}', '', '15', 4, '0', '', 'admin/config/system/actions', 'Actions', 't', '', '', 'a:0:{}', '6', 'Manage the actions defined for your site.', '', '0', 'modules/system/system.admin.inc'),
('admin/config/system/actions/configure', '', '', 'user_access', 'a:1:{i:0;s:18:"administer actions";}', 'drupal_get_form', 'a:1:{i:0;s:24:"system_actions_configure";}', '', '31', 5, '0', '', 'admin/config/system/actions/configure', 'Configure an advanced action', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/system/system.admin.inc'),
('admin/config/system/actions/delete/%', 'a:1:{i:5;s:12:"actions_load";}', '', 'user_access', 'a:1:{i:0;s:18:"administer actions";}', 'drupal_get_form', 'a:2:{i:0;s:26:"system_actions_delete_form";i:1;i:5;}', '', '62', 6, '0', '', 'admin/config/system/actions/delete/%', 'Delete action', 't', '', '', 'a:0:{}', '6', 'Delete an action.', '', '0', 'modules/system/system.admin.inc'),
('admin/config/system/actions/manage', '', '', 'user_access', 'a:1:{i:0;s:18:"administer actions";}', 'system_actions_manage', 'a:0:{}', '', '31', 5, '1', 'admin/config/system/actions', 'admin/config/system/actions', 'Manage actions', 't', '', '', 'a:0:{}', '140', 'Manage the actions defined for your site.', '', '-2', 'modules/system/system.admin.inc'),
('admin/config/system/actions/orphan', '', '', 'user_access', 'a:1:{i:0;s:18:"administer actions";}', 'system_actions_remove_orphans', 'a:0:{}', '', '31', 5, '0', '', 'admin/config/system/actions/orphan', 'Remove orphans', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/config/system/cron', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:20:"system_cron_settings";}', '', '15', 4, '0', '', 'admin/config/system/cron', 'Cron', 't', '', '', 'a:0:{}', '6', 'Manage automatic site maintenance tasks.', '', '20', 'modules/system/system.admin.inc'),
('admin/config/system/site-information', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:32:"system_site_information_settings";}', '', '15', 4, '0', '', 'admin/config/system/site-information', 'Site information', 't', '', '', 'a:0:{}', '6', 'Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.', '', '-20', 'modules/system/system.admin.inc'),
('admin/config/user-interface', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/user-interface', 'User interface', 't', '', '', 'a:0:{}', '6', 'Tools that enhance the user interface.', 'right', '-15', 'modules/system/system.admin.inc'),
('admin/config/user-interface/modulefilter', '', '', 'user_access', 'a:1:{i:0;s:24:"administer module filter";}', 'drupal_get_form', 'a:1:{i:0;s:22:"module_filter_settings";}', '', '15', 4, '0', '', 'admin/config/user-interface/modulefilter', 'Module filter', 't', '', '', 'a:0:{}', '6', 'Configure settings for Module Filter.', '', '0', 'sites/all/modules/module_filter/module_filter.admin.inc'),
('admin/config/user-interface/shortcut', '', '', 'user_access', 'a:1:{i:0;s:20:"administer shortcuts";}', 'shortcut_set_admin', 'a:0:{}', '', '15', 4, '0', '', 'admin/config/user-interface/shortcut', 'Shortcuts', 't', '', '', 'a:0:{}', '6', 'Add and modify shortcut sets.', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%', 'a:1:{i:4;s:17:"shortcut_set_load";}', '', 'shortcut_set_edit_access', 'a:1:{i:0;i:4;}', 'drupal_get_form', 'a:2:{i:0;s:22:"shortcut_set_customize";i:1;i:4;}', '', '30', 5, '0', '', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 'shortcut_set_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', '6', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/add-link', 'a:1:{i:4;s:17:"shortcut_set_load";}', '', 'shortcut_set_edit_access', 'a:1:{i:0;i:4;}', 'drupal_get_form', 'a:2:{i:0;s:17:"shortcut_link_add";i:1;i:4;}', '', '61', 6, '1', 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Add shortcut', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/add-link-inline', 'a:1:{i:4;s:17:"shortcut_set_load";}', '', 'shortcut_set_edit_access', 'a:1:{i:0;i:4;}', 'shortcut_link_add_inline', 'a:1:{i:0;i:4;}', '', '61', 6, '0', '', 'admin/config/user-interface/shortcut/%/add-link-inline', 'Add shortcut', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/delete', 'a:1:{i:4;s:17:"shortcut_set_load";}', '', 'shortcut_set_delete_access', 'a:1:{i:0;i:4;}', 'drupal_get_form', 'a:2:{i:0;s:24:"shortcut_set_delete_form";i:1;i:4;}', '', '61', 6, '0', '', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/edit', 'a:1:{i:4;s:17:"shortcut_set_load";}', '', 'shortcut_set_edit_access', 'a:1:{i:0;i:4;}', 'drupal_get_form', 'a:2:{i:0;s:22:"shortcut_set_edit_form";i:1;i:4;}', '', '61', 6, '1', 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit set name', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/links', 'a:1:{i:4;s:17:"shortcut_set_load";}', '', 'shortcut_set_edit_access', 'a:1:{i:0;i:4;}', 'drupal_get_form', 'a:2:{i:0;s:22:"shortcut_set_customize";i:1;i:4;}', '', '61', 6, '1', 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'List links', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/add-set', '', '', 'user_access', 'a:1:{i:0;s:20:"administer shortcuts";}', 'drupal_get_form', 'a:1:{i:0;s:21:"shortcut_set_add_form";}', '', '31', 5, '1', 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Add shortcut set', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/link/%', 'a:1:{i:5;s:14:"menu_link_load";}', '', 'shortcut_link_access', 'a:1:{i:0;i:5;}', 'drupal_get_form', 'a:2:{i:0;s:18:"shortcut_link_edit";i:1;i:5;}', '', '62', 6, '0', '', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/link/%/delete', 'a:1:{i:5;s:14:"menu_link_load";}', '', 'shortcut_link_access', 'a:1:{i:0;i:5;}', 'drupal_get_form', 'a:2:{i:0;s:20:"shortcut_link_delete";i:1;i:5;}', '', '125', 7, '0', '', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('admin/config/workflow', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/config/workflow', 'Workflow', 't', '', '', 'a:0:{}', '6', 'Content workflow, editorial workflow tools.', 'right', '5', 'modules/system/system.admin.inc'),
('admin/content', '', '', 'user_access', 'a:1:{i:0;s:23:"access content overview";}', 'drupal_get_form', 'a:1:{i:0;s:18:"node_admin_content";}', '', '3', 2, '0', '', 'admin/content', 'Content', 't', '', '', 'a:0:{}', '6', 'Administer content and comments.', '', '-10', 'modules/node/node.admin.inc'),
('admin/content/comment', '', '', 'user_access', 'a:1:{i:0;s:19:"administer comments";}', 'comment_admin', 'a:0:{}', '', '7', 3, '1', 'admin/content', 'admin/content', 'Comments', 't', '', '', 'a:0:{}', '134', 'List and edit site comments and the comment approval queue.', '', '0', 'modules/comment/comment.admin.inc'),
('admin/content/comment/approval', '', '', 'user_access', 'a:1:{i:0;s:19:"administer comments";}', 'comment_admin', 'a:1:{i:0;s:8:"approval";}', '', '15', 4, '1', 'admin/content/comment', 'admin/content', 'Unapproved comments', 'comment_count_unpublished', '', '', 'a:0:{}', '132', '', '', '0', 'modules/comment/comment.admin.inc'),
('admin/content/comment/new', '', '', 'user_access', 'a:1:{i:0;s:19:"administer comments";}', 'comment_admin', 'a:0:{}', '', '15', 4, '1', 'admin/content/comment', 'admin/content', 'Published comments', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/comment/comment.admin.inc'),
('admin/content/node', '', '', 'user_access', 'a:1:{i:0;s:23:"access content overview";}', 'drupal_get_form', 'a:1:{i:0;s:18:"node_admin_content";}', '', '7', 3, '1', 'admin/content', 'admin/content', 'Content', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/node/node.admin.inc'),
('admin/dashboard', '', '', 'user_access', 'a:1:{i:0;s:16:"access dashboard";}', 'dashboard_admin', 'a:0:{}', '', '3', 2, '0', '', 'admin/dashboard', 'Dashboard', 't', '', '', 'a:0:{}', '6', 'View and customize your dashboard.', '', '-15', ''),
('admin/dashboard/block-content/%/%', 'a:2:{i:3;N;i:4;N;}', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'dashboard_show_block_content', 'a:2:{i:0;i:3;i:1;i:4;}', '', '28', 5, '0', '', 'admin/dashboard/block-content/%/%', '', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('admin/dashboard/configure', '', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'dashboard_admin_blocks', 'a:0:{}', '', '7', 3, '0', '', 'admin/dashboard/configure', 'Configure available dashboard blocks', 't', '', '', 'a:0:{}', '4', 'Configure which blocks can be shown on the dashboard.', '', '0', ''),
('admin/dashboard/customize', '', '', 'user_access', 'a:1:{i:0;s:16:"access dashboard";}', 'dashboard_admin', 'a:1:{i:0;b:1;}', '', '7', 3, '0', '', 'admin/dashboard/customize', 'Customize dashboard', 't', '', '', 'a:0:{}', '4', 'Customize your dashboard.', '', '0', ''),
('admin/dashboard/drawer', '', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'dashboard_show_disabled', 'a:0:{}', '', '7', 3, '0', '', 'admin/dashboard/drawer', '', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('admin/dashboard/update', '', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'dashboard_update', 'a:0:{}', '', '7', 3, '0', '', 'admin/dashboard/update', '', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('admin/help', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_main', 'a:0:{}', '', '3', 2, '0', '', 'admin/help', 'Help', 't', '', '', 'a:0:{}', '6', 'Reference for usage, configuration, and modules.', '', '9', 'modules/help/help.admin.inc'),
('admin/help/block', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/block', 'block', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/color', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/color', 'color', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/comment', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/comment', 'comment', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES
('admin/help/contextual', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/contextual', 'contextual', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/dashboard', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/dashboard', 'dashboard', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/dblog', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/dblog', 'dblog', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/devel', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/devel', 'devel', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/field', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/field', 'field', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/field_sql_storage', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/field_sql_storage', 'field_sql_storage', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/field_ui', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/field_ui', 'field_ui', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/file', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/file', 'file', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/filter', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/filter', 'filter', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/help', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/help', 'help', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/image', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/image', 'image', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/list', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/list', 'list', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/menu', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/menu', 'menu', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/node', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/node', 'node', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/number', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/number', 'number', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/options', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/options', 'options', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/overlay', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/overlay', 'overlay', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/path', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/path', 'path', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/poll', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/poll', 'poll', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/rdf', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/rdf', 'rdf', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/search', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/search', 'search', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/shortcut', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/shortcut', 'shortcut', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/system', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/system', 'system', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/taxonomy', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/taxonomy', 'taxonomy', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/text', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/text', 'text', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/toolbar', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/toolbar', 'toolbar', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/help/user', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'help_page', 'a:1:{i:0;i:2;}', '', '7', 3, '0', '', 'admin/help/user', 'user', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc'),
('admin/index', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_index', 'a:0:{}', '', '3', 2, '1', 'admin', 'admin', 'Index', 't', '', '', 'a:0:{}', '132', '', '', '-18', 'modules/system/system.admin.inc'),
('admin/modules', '', '', 'user_access', 'a:1:{i:0;s:18:"administer modules";}', 'drupal_get_form', 'a:1:{i:0;s:14:"system_modules";}', '', '3', 2, '0', '', 'admin/modules', 'Modules', 't', '', '', 'a:0:{}', '6', 'Extend site functionality.', '', '-2', 'modules/system/system.admin.inc'),
('admin/modules/list', '', '', 'user_access', 'a:1:{i:0;s:18:"administer modules";}', 'drupal_get_form', 'a:1:{i:0;s:14:"system_modules";}', '', '7', 3, '1', 'admin/modules', 'admin/modules', 'List', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/system/system.admin.inc'),
('admin/modules/list/confirm', '', '', 'user_access', 'a:1:{i:0;s:18:"administer modules";}', 'drupal_get_form', 'a:1:{i:0;s:14:"system_modules";}', '', '15', 4, '0', '', 'admin/modules/list/confirm', 'List', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/system/system.admin.inc'),
('admin/modules/uninstall', '', '', 'user_access', 'a:1:{i:0;s:18:"administer modules";}', 'drupal_get_form', 'a:1:{i:0;s:24:"system_modules_uninstall";}', '', '7', 3, '1', 'admin/modules', 'admin/modules', 'Uninstall', 't', '', '', 'a:0:{}', '132', '', '', '20', 'modules/system/system.admin.inc'),
('admin/modules/uninstall/confirm', '', '', 'user_access', 'a:1:{i:0;s:18:"administer modules";}', 'drupal_get_form', 'a:1:{i:0;s:24:"system_modules_uninstall";}', '', '15', 4, '0', '', 'admin/modules/uninstall/confirm', 'Uninstall', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/system/system.admin.inc'),
('admin/people', '', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'user_admin', 'a:1:{i:0;s:4:"list";}', '', '3', 2, '0', '', 'admin/people', 'People', 't', '', '', 'a:0:{}', '6', 'Manage user accounts, roles, and permissions.', 'left', '-4', 'modules/user/user.admin.inc'),
('admin/people/create', '', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'user_admin', 'a:1:{i:0;s:6:"create";}', '', '7', 3, '1', 'admin/people', 'admin/people', 'Add user', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/user/user.admin.inc'),
('admin/people/people', '', '', 'user_access', 'a:1:{i:0;s:16:"administer users";}', 'user_admin', 'a:1:{i:0;s:4:"list";}', '', '7', 3, '1', 'admin/people', 'admin/people', 'List', 't', '', '', 'a:0:{}', '140', 'Find and manage people interacting with your site.', '', '-10', 'modules/user/user.admin.inc'),
('admin/people/permissions', '', '', 'user_access', 'a:1:{i:0;s:22:"administer permissions";}', 'drupal_get_form', 'a:1:{i:0;s:22:"user_admin_permissions";}', '', '7', 3, '1', 'admin/people', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', '132', 'Determine access to features by selecting permissions for roles.', '', '0', 'modules/user/user.admin.inc'),
('admin/people/permissions/list', '', '', 'user_access', 'a:1:{i:0;s:22:"administer permissions";}', 'drupal_get_form', 'a:1:{i:0;s:22:"user_admin_permissions";}', '', '15', 4, '1', 'admin/people/permissions', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', '140', 'Determine access to features by selecting permissions for roles.', '', '-8', 'modules/user/user.admin.inc'),
('admin/people/permissions/roles', '', '', 'user_access', 'a:1:{i:0;s:22:"administer permissions";}', 'drupal_get_form', 'a:1:{i:0;s:16:"user_admin_roles";}', '', '15', 4, '1', 'admin/people/permissions', 'admin/people', 'Roles', 't', '', '', 'a:0:{}', '132', 'List, edit, or add user roles.', '', '-5', 'modules/user/user.admin.inc'),
('admin/people/permissions/roles/delete/%', 'a:1:{i:5;s:14:"user_role_load";}', '', 'user_role_edit_access', 'a:1:{i:0;i:5;}', 'drupal_get_form', 'a:2:{i:0;s:30:"user_admin_role_delete_confirm";i:1;i:5;}', '', '62', 6, '0', '', 'admin/people/permissions/roles/delete/%', 'Delete role', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/user/user.admin.inc'),
('admin/people/permissions/roles/edit/%', 'a:1:{i:5;s:14:"user_role_load";}', '', 'user_role_edit_access', 'a:1:{i:0;i:5;}', 'drupal_get_form', 'a:2:{i:0;s:15:"user_admin_role";i:1;i:5;}', '', '62', 6, '0', '', 'admin/people/permissions/roles/edit/%', 'Edit role', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/user/user.admin.inc'),
('admin/reports', '', '', 'user_access', 'a:1:{i:0;s:19:"access site reports";}', 'system_admin_menu_block_page', 'a:0:{}', '', '3', 2, '0', '', 'admin/reports', 'Reports', 't', '', '', 'a:0:{}', '6', 'View reports, updates, and errors.', 'left', '5', 'modules/system/system.admin.inc'),
('admin/reports/access-denied', '', '', 'user_access', 'a:1:{i:0;s:19:"access site reports";}', 'dblog_top', 'a:1:{i:0;s:13:"access denied";}', '', '7', 3, '0', '', 'admin/reports/access-denied', 'Top ''access denied'' errors', 't', '', '', 'a:0:{}', '6', 'View ''access denied'' errors (403s).', '', '0', 'modules/dblog/dblog.admin.inc'),
('admin/reports/dblog', '', '', 'user_access', 'a:1:{i:0;s:19:"access site reports";}', 'dblog_overview', 'a:0:{}', '', '7', 3, '0', '', 'admin/reports/dblog', 'Recent log messages', 't', '', '', 'a:0:{}', '6', 'View events that have recently been logged.', '', '-1', 'modules/dblog/dblog.admin.inc'),
('admin/reports/event/%', 'a:1:{i:3;N;}', '', 'user_access', 'a:1:{i:0;s:19:"access site reports";}', 'dblog_event', 'a:1:{i:0;i:3;}', '', '14', 4, '0', '', 'admin/reports/event/%', 'Details', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/dblog/dblog.admin.inc'),
('admin/reports/fields', '', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'field_ui_fields_list', 'a:0:{}', '', '7', 3, '0', '', 'admin/reports/fields', 'Field list', 't', '', '', 'a:0:{}', '6', 'Overview of fields on all entity types.', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/reports/page-not-found', '', '', 'user_access', 'a:1:{i:0;s:19:"access site reports";}', 'dblog_top', 'a:1:{i:0;s:14:"page not found";}', '', '7', 3, '0', '', 'admin/reports/page-not-found', 'Top ''page not found'' errors', 't', '', '', 'a:0:{}', '6', 'View ''page not found'' errors (404s).', '', '0', 'modules/dblog/dblog.admin.inc'),
('admin/reports/search', '', '', 'user_access', 'a:1:{i:0;s:19:"access site reports";}', 'dblog_top', 'a:1:{i:0;s:6:"search";}', '', '7', 3, '0', '', 'admin/reports/search', 'Top search phrases', 't', '', '', 'a:0:{}', '6', 'View most popular search phrases.', '', '0', 'modules/dblog/dblog.admin.inc'),
('admin/reports/status', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'system_status', 'a:0:{}', '', '7', 3, '0', '', 'admin/reports/status', 'Status report', 't', '', '', 'a:0:{}', '6', 'Get a status report about your site''s operation and any detected problems.', '', '-60', 'modules/system/system.admin.inc'),
('admin/reports/status/php', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'system_php', 'a:0:{}', '', '15', 4, '0', '', 'admin/reports/status/php', 'PHP', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/reports/status/rebuild', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'drupal_get_form', 'a:1:{i:0;s:30:"node_configure_rebuild_confirm";}', '', '15', 4, '0', '', 'admin/reports/status/rebuild', 'Rebuild permissions', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/node/node.admin.inc'),
('admin/reports/status/run-cron', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'system_run_cron', 'a:0:{}', '', '15', 4, '0', '', 'admin/reports/status/run-cron', 'Run cron', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('admin/structure', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '3', 2, '0', '', 'admin/structure', 'Structure', 't', '', '', 'a:0:{}', '6', 'Administer blocks, content types, menus, etc.', 'right', '-8', 'modules/system/system.admin.inc'),
('admin/structure/block', '', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'block_admin_display', 'a:1:{i:0;s:6:"bartik";}', '', '7', 3, '0', '', 'admin/structure/block', 'Blocks', 't', '', '', 'a:0:{}', '6', 'Configure what block content appears in your site''s sidebars and other regions.', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/add', '', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'drupal_get_form', 'a:1:{i:0;s:20:"block_add_block_form";}', '', '15', 4, '1', 'admin/structure/block', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/demo/bartik', '', '', '_block_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:25:"themes/bartik/bartik.info";s:4:"name";s:6:"bartik";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"1";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:6:"Bartik";s:11:"description";s:48:"A flexible, recolorable theme with many regions.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:3:{s:14:"css/layout.css";s:28:"themes/bartik/css/layout.css";s:13:"css/style.css";s:27:"themes/bartik/css/style.css";s:14:"css/colors.css";s:28:"themes/bartik/css/colors.css";}s:5:"print";a:1:{s:13:"css/print.css";s:27:"themes/bartik/css/print.css";}}s:7:"regions";a:20:{s:6:"header";s:6:"Header";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:11:"highlighted";s:11:"Highlighted";s:8:"featured";s:8:"Featured";s:7:"content";s:7:"Content";s:13:"sidebar_first";s:13:"Sidebar first";s:14:"sidebar_second";s:14:"Sidebar second";s:14:"triptych_first";s:14:"Triptych first";s:15:"triptych_middle";s:15:"Triptych middle";s:13:"triptych_last";s:13:"Triptych last";s:18:"footer_firstcolumn";s:19:"Footer first column";s:19:"footer_secondcolumn";s:20:"Footer second column";s:18:"footer_thirdcolumn";s:19:"Footer third column";s:19:"footer_fourthcolumn";s:20:"Footer fourth column";s:6:"footer";s:6:"Footer";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"settings";a:1:{s:20:"shortcut_module_link";s:1:"0";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:28:"themes/bartik/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:2:{s:3:"all";a:3:{s:14:"css/layout.css";s:28:"themes/bartik/css/layout.css";s:13:"css/style.css";s:27:"themes/bartik/css/style.css";s:14:"css/colors.css";s:28:"themes/bartik/css/colors.css";}s:5:"print";a:1:{s:13:"css/print.css";s:27:"themes/bartik/css/print.css";}}s:6:"engine";s:11:"phptemplate";}}', 'block_admin_demo', 'a:1:{i:0;s:6:"bartik";}', '', '31', 5, '0', '', 'admin/structure/block/demo/bartik', 'Bartik', 't', '', '_block_custom_theme', 'a:1:{i:0;s:6:"bartik";}', '0', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/demo/garland', '', '', '_block_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:27:"themes/garland/garland.info";s:4:"name";s:7:"garland";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"0";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:7:"Garland";s:11:"description";s:111:"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:1:{s:9:"style.css";s:24:"themes/garland/style.css";}s:5:"print";a:1:{s:9:"print.css";s:24:"themes/garland/print.css";}}s:8:"settings";a:1:{s:13:"garland_width";s:5:"fluid";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:7:"regions";a:12:{s:13:"sidebar_first";s:12:"Left sidebar";s:14:"sidebar_second";s:13:"Right sidebar";s:7:"content";s:7:"Content";s:6:"header";s:6:"Header";s:6:"footer";s:6:"Footer";s:11:"highlighted";s:11:"Highlighted";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:29:"themes/garland/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:2:{s:3:"all";a:1:{s:9:"style.css";s:24:"themes/garland/style.css";}s:5:"print";a:1:{s:9:"print.css";s:24:"themes/garland/print.css";}}s:6:"engine";s:11:"phptemplate";}}', 'block_admin_demo', 'a:1:{i:0;s:7:"garland";}', '', '31', 5, '0', '', 'admin/structure/block/demo/garland', 'Garland', 't', '', '_block_custom_theme', 'a:1:{i:0;s:7:"garland";}', '0', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/demo/seven', '', '', '_block_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:23:"themes/seven/seven.info";s:4:"name";s:5:"seven";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"1";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:5:"Seven";s:11:"description";s:65:"A simple one-column, tableless, fluid width administration theme.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:1:{s:6:"screen";a:2:{s:9:"reset.css";s:22:"themes/seven/reset.css";s:9:"style.css";s:22:"themes/seven/style.css";}}s:8:"settings";a:1:{s:20:"shortcut_module_link";s:1:"1";}s:7:"regions";a:8:{s:7:"content";s:7:"Content";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:13:"sidebar_first";s:13:"First sidebar";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:14:"regions_hidden";a:3:{i:0;s:13:"sidebar_first";i:1;s:8:"page_top";i:2;s:11:"page_bottom";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:27:"themes/seven/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:1:{s:6:"screen";a:2:{s:9:"reset.css";s:22:"themes/seven/reset.css";s:9:"style.css";s:22:"themes/seven/style.css";}}s:6:"engine";s:11:"phptemplate";}}', 'block_admin_demo', 'a:1:{i:0;s:5:"seven";}', '', '31', 5, '0', '', 'admin/structure/block/demo/seven', 'Seven', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:"seven";}', '0', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/demo/stark', '', '', '_block_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:23:"themes/stark/stark.info";s:4:"name";s:5:"stark";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"0";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:17:{s:4:"name";s:5:"Stark";s:11:"description";s:208:"This theme demonstrates Drupal''s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal''s default code, see the <a href="http://drupal.org/theme-guide">Theming Guide</a>.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:10:"layout.css";s:23:"themes/stark/layout.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:7:"regions";a:12:{s:13:"sidebar_first";s:12:"Left sidebar";s:14:"sidebar_second";s:13:"Right sidebar";s:7:"content";s:7:"Content";s:6:"header";s:6:"Header";s:6:"footer";s:6:"Footer";s:11:"highlighted";s:11:"Highlighted";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:27:"themes/stark/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:10:"layout.css";s:23:"themes/stark/layout.css";}}s:6:"engine";s:11:"phptemplate";}}', 'block_admin_demo', 'a:1:{i:0;s:5:"stark";}', '', '31', 5, '0', '', 'admin/structure/block/demo/stark', 'Stark', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:"stark";}', '0', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/list/bartik', '', '', '_block_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:25:"themes/bartik/bartik.info";s:4:"name";s:6:"bartik";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"1";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:6:"Bartik";s:11:"description";s:48:"A flexible, recolorable theme with many regions.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:3:{s:14:"css/layout.css";s:28:"themes/bartik/css/layout.css";s:13:"css/style.css";s:27:"themes/bartik/css/style.css";s:14:"css/colors.css";s:28:"themes/bartik/css/colors.css";}s:5:"print";a:1:{s:13:"css/print.css";s:27:"themes/bartik/css/print.css";}}s:7:"regions";a:20:{s:6:"header";s:6:"Header";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:11:"highlighted";s:11:"Highlighted";s:8:"featured";s:8:"Featured";s:7:"content";s:7:"Content";s:13:"sidebar_first";s:13:"Sidebar first";s:14:"sidebar_second";s:14:"Sidebar second";s:14:"triptych_first";s:14:"Triptych first";s:15:"triptych_middle";s:15:"Triptych middle";s:13:"triptych_last";s:13:"Triptych last";s:18:"footer_firstcolumn";s:19:"Footer first column";s:19:"footer_secondcolumn";s:20:"Footer second column";s:18:"footer_thirdcolumn";s:19:"Footer third column";s:19:"footer_fourthcolumn";s:20:"Footer fourth column";s:6:"footer";s:6:"Footer";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"settings";a:1:{s:20:"shortcut_module_link";s:1:"0";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:28:"themes/bartik/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:2:{s:3:"all";a:3:{s:14:"css/layout.css";s:28:"themes/bartik/css/layout.css";s:13:"css/style.css";s:27:"themes/bartik/css/style.css";s:14:"css/colors.css";s:28:"themes/bartik/css/colors.css";}s:5:"print";a:1:{s:13:"css/print.css";s:27:"themes/bartik/css/print.css";}}s:6:"engine";s:11:"phptemplate";}}', 'block_admin_display', 'a:1:{i:0;s:6:"bartik";}', '', '31', 5, '1', 'admin/structure/block', 'admin/structure/block', 'Bartik', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/block/block.admin.inc'),
('admin/structure/block/list/garland', '', '', '_block_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:27:"themes/garland/garland.info";s:4:"name";s:7:"garland";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"0";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:7:"Garland";s:11:"description";s:111:"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:1:{s:9:"style.css";s:24:"themes/garland/style.css";}s:5:"print";a:1:{s:9:"print.css";s:24:"themes/garland/print.css";}}s:8:"settings";a:1:{s:13:"garland_width";s:5:"fluid";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:7:"regions";a:12:{s:13:"sidebar_first";s:12:"Left sidebar";s:14:"sidebar_second";s:13:"Right sidebar";s:7:"content";s:7:"Content";s:6:"header";s:6:"Header";s:6:"footer";s:6:"Footer";s:11:"highlighted";s:11:"Highlighted";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:29:"themes/garland/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:2:{s:3:"all";a:1:{s:9:"style.css";s:24:"themes/garland/style.css";}s:5:"print";a:1:{s:9:"print.css";s:24:"themes/garland/print.css";}}s:6:"engine";s:11:"phptemplate";}}', 'block_admin_display', 'a:1:{i:0;s:7:"garland";}', '', '31', 5, '1', 'admin/structure/block', 'admin/structure/block', 'Garland', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/list/garland/add', '', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'drupal_get_form', 'a:1:{i:0;s:20:"block_add_block_form";}', '', '63', 6, '1', 'admin/structure/block/list/garland', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/list/seven', '', '', '_block_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:23:"themes/seven/seven.info";s:4:"name";s:5:"seven";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"1";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:18:{s:4:"name";s:5:"Seven";s:11:"description";s:65:"A simple one-column, tableless, fluid width administration theme.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:1:{s:6:"screen";a:2:{s:9:"reset.css";s:22:"themes/seven/reset.css";s:9:"style.css";s:22:"themes/seven/style.css";}}s:8:"settings";a:1:{s:20:"shortcut_module_link";s:1:"1";}s:7:"regions";a:8:{s:7:"content";s:7:"Content";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:13:"sidebar_first";s:13:"First sidebar";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:14:"regions_hidden";a:3:{i:0;s:13:"sidebar_first";i:1;s:8:"page_top";i:2;s:11:"page_bottom";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:27:"themes/seven/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:1:{s:6:"screen";a:2:{s:9:"reset.css";s:22:"themes/seven/reset.css";s:9:"style.css";s:22:"themes/seven/style.css";}}s:6:"engine";s:11:"phptemplate";}}', 'block_admin_display', 'a:1:{i:0;s:5:"seven";}', '', '31', 5, '1', 'admin/structure/block', 'admin/structure/block', 'Seven', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/list/seven/add', '', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'drupal_get_form', 'a:1:{i:0;s:20:"block_add_block_form";}', '', '63', 6, '1', 'admin/structure/block/list/seven', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/list/stark', '', '', '_block_themes_access', 'a:1:{i:0;O:8:"stdClass":11:{s:8:"filename";s:23:"themes/stark/stark.info";s:4:"name";s:5:"stark";s:4:"type";s:5:"theme";s:5:"owner";s:45:"themes/engines/phptemplate/phptemplate.engine";s:6:"status";s:1:"0";s:9:"bootstrap";s:1:"0";s:14:"schema_version";s:2:"-1";s:6:"weight";s:1:"0";s:4:"info";a:17:{s:4:"name";s:5:"Stark";s:11:"description";s:208:"This theme demonstrates Drupal''s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal''s default code, see the <a href="http://drupal.org/theme-guide">Theming Guide</a>.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:10:"layout.css";s:23:"themes/stark/layout.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:7:"regions";a:12:{s:13:"sidebar_first";s:12:"Left sidebar";s:14:"sidebar_second";s:13:"Right sidebar";s:7:"content";s:7:"Content";s:6:"header";s:6:"Header";s:6:"footer";s:6:"Footer";s:11:"highlighted";s:11:"Highlighted";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:27:"themes/stark/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:10:"layout.css";s:23:"themes/stark/layout.css";}}s:6:"engine";s:11:"phptemplate";}}', 'block_admin_display', 'a:1:{i:0;s:5:"stark";}', '', '31', 5, '1', 'admin/structure/block', 'admin/structure/block', 'Stark', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/list/stark/add', '', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'drupal_get_form', 'a:1:{i:0;s:20:"block_add_block_form";}', '', '63', 6, '1', 'admin/structure/block/list/stark', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%', 'a:2:{i:4;N;i:5;N;}', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'drupal_get_form', 'a:3:{i:0;s:21:"block_admin_configure";i:1;i:4;i:2;i:5;}', '', '60', 6, '0', '', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/configure', 'a:2:{i:4;N;i:5;N;}', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'drupal_get_form', 'a:3:{i:0;s:21:"block_admin_configure";i:1;i:4;i:2;i:5;}', '', '121', 7, '2', 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/delete', 'a:2:{i:4;N;i:5;N;}', '', 'user_access', 'a:1:{i:0;s:17:"administer blocks";}', 'drupal_get_form', 'a:3:{i:0;s:25:"block_custom_block_delete";i:1;i:4;i:2;i:5;}', '', '121', 7, '0', 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Delete block', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc'),
('admin/structure/demo', '', '', 'user_access', 'a:1:{i:0;s:24:"administer demo settings";}', 'drupal_get_form', 'a:1:{i:0;s:16:"demo_manage_form";}', '', '7', 3, '0', '', 'admin/structure/demo', 'Snapshots', 't', '', '', 'a:0:{}', '6', 'Create snapshots and reset the site.', '', '0', 'sites/all/modules/demo/demo.admin.inc'),
('admin/structure/demo/delete/%', 'a:1:{i:4;N;}', '', 'user_access', 'a:1:{i:0;s:24:"administer demo settings";}', 'drupal_get_form', 'a:2:{i:0;s:19:"demo_delete_confirm";i:1;i:4;}', '', '30', 5, '0', '', 'admin/structure/demo/delete/%', 'Delete snapshot', 't', '', '', 'a:0:{}', '4', '', '', '0', 'sites/all/modules/demo/demo.admin.inc'),
('admin/structure/demo/dump', '', '', 'user_access', 'a:1:{i:0;s:24:"administer demo settings";}', 'drupal_get_form', 'a:1:{i:0;s:14:"demo_dump_form";}', '', '15', 4, '1', 'admin/structure/demo', 'admin/structure/demo', 'Create snapshot', 't', '', '', 'a:0:{}', '388', '', '', '0', 'sites/all/modules/demo/demo.admin.inc'),
('admin/structure/demo/list', '', '', 'user_access', 'a:1:{i:0;s:24:"administer demo settings";}', 'drupal_get_form', 'a:1:{i:0;s:16:"demo_manage_form";}', '', '15', 4, '1', 'admin/structure/demo', 'admin/structure/demo', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'sites/all/modules/demo/demo.admin.inc'),
('admin/structure/demo/reset', '', '', 'user_access', 'a:1:{i:0;s:24:"administer demo settings";}', 'drupal_get_form', 'a:1:{i:0;s:18:"demo_reset_confirm";}', '', '15', 4, '1', 'admin/structure/demo', 'admin/structure/demo', 'Reset', 't', '', '', 'a:0:{}', '132', '', '', '3', 'sites/all/modules/demo/demo.admin.inc'),
('admin/structure/demo/settings', '', '', 'user_access', 'a:1:{i:0;s:24:"administer demo settings";}', 'drupal_get_form', 'a:1:{i:0;s:19:"demo_admin_settings";}', '', '15', 4, '1', 'admin/structure/demo', 'admin/structure/demo', 'Settings', 't', '', '', 'a:0:{}', '132', '', '', '10', 'sites/all/modules/demo/demo.admin.inc'),
('admin/structure/menu', '', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'menu_overview_page', 'a:0:{}', '', '7', 3, '0', '', 'admin/structure/menu', 'Menus', 't', '', '', 'a:0:{}', '6', 'Add new menus to your site, edit existing menus, and rename and reorganize menu links.', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/add', '', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:2:{i:0;s:14:"menu_edit_menu";i:1;s:3:"add";}', '', '15', 4, '1', 'admin/structure/menu', 'admin/structure/menu', 'Add menu', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/delete', 'a:1:{i:4;s:14:"menu_link_load";}', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'menu_item_delete_page', 'a:1:{i:0;i:4;}', '', '61', 6, '0', '', 'admin/structure/menu/item/%/delete', 'Delete menu link', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/edit', 'a:1:{i:4;s:14:"menu_link_load";}', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:4:{i:0;s:14:"menu_edit_item";i:1;s:4:"edit";i:2;i:4;i:3;N;}', '', '61', 6, '0', '', 'admin/structure/menu/item/%/edit', 'Edit menu link', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/reset', 'a:1:{i:4;s:14:"menu_link_load";}', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:2:{i:0;s:23:"menu_reset_item_confirm";i:1;i:4;}', '', '61', 6, '0', '', 'admin/structure/menu/item/%/reset', 'Reset menu link', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/list', '', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'menu_overview_page', 'a:0:{}', '', '15', 4, '1', 'admin/structure/menu', 'admin/structure/menu', 'List menus', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%', 'a:1:{i:4;s:9:"menu_load";}', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:2:{i:0;s:18:"menu_overview_form";i:1;i:4;}', '', '30', 5, '0', '', 'admin/structure/menu/manage/%', 'Customize menu', 'menu_overview_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/add', 'a:1:{i:4;s:9:"menu_load";}', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:4:{i:0;s:14:"menu_edit_item";i:1;s:3:"add";i:2;N;i:3;i:4;}', '', '61', 6, '1', 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Add link', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/delete', 'a:1:{i:4;s:9:"menu_load";}', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'menu_delete_menu_page', 'a:1:{i:0;i:4;}', '', '61', 6, '0', '', 'admin/structure/menu/manage/%/delete', 'Delete menu', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/edit', 'a:1:{i:4;s:9:"menu_load";}', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:3:{i:0;s:14:"menu_edit_menu";i:1;s:4:"edit";i:2;i:4;}', '', '61', 6, '3', 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Edit menu', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/list', 'a:1:{i:4;s:9:"menu_load";}', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:2:{i:0;s:18:"menu_overview_form";i:1;i:4;}', '', '61', 6, '3', 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'List links', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/menu/menu.admin.inc'),
('admin/structure/menu/parents', '', '', 'user_access', 'a:1:{i:0;b:1;}', 'menu_parent_options_js', 'a:0:{}', '', '15', 4, '0', '', 'admin/structure/menu/parents', 'Parent menu items', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('admin/structure/menu/settings', '', '', 'user_access', 'a:1:{i:0;s:15:"administer menu";}', 'drupal_get_form', 'a:1:{i:0;s:14:"menu_configure";}', '', '15', 4, '1', 'admin/structure/menu', 'admin/structure/menu', 'Settings', 't', '', '', 'a:0:{}', '132', '', '', '5', 'modules/menu/menu.admin.inc'),
('admin/structure/taxonomy', '', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:1:{i:0;s:30:"taxonomy_overview_vocabularies";}', '', '7', 3, '0', '', 'admin/structure/taxonomy', 'Taxonomy', 't', '', '', 'a:0:{}', '6', 'Manage tagging, categorization, and classification of your content.', '', '0', 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%', 'a:1:{i:3;s:37:"taxonomy_vocabulary_machine_name_load";}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:2:{i:0;s:23:"taxonomy_overview_terms";i:1;i:3;}', '', '14', 4, '0', '', 'admin/structure/taxonomy/%', '', 'taxonomy_admin_vocabulary_title_callback', 'a:1:{i:0;i:3;}', '', 'a:0:{}', '6', '', '', '0', 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/add', 'a:1:{i:3;s:37:"taxonomy_vocabulary_machine_name_load";}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:3:{i:0;s:18:"taxonomy_form_term";i:1;a:0:{}i:2;i:3;}', '', '29', 5, '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Add term', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/display', 'a:1:{i:3;s:37:"taxonomy_vocabulary_machine_name_load";}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:13:"taxonomy_term";i:2;i:3;i:3;s:7:"default";}', '', '29', 5, '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage display', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/display/default', 'a:1:{i:3;s:37:"taxonomy_vocabulary_machine_name_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:7:"default";i:3;s:11:"user_access";i:4;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:13:"taxonomy_term";i:2;i:3;i:3;s:7:"default";}', '', '59', 6, '1', 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Default', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/display/full', 'a:1:{i:3;s:37:"taxonomy_vocabulary_machine_name_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:4:"full";i:3;s:11:"user_access";i:4;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:13:"taxonomy_term";i:2;i:3;i:3;s:4:"full";}', '', '59', 6, '1', 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Taxonomy term page', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/edit', 'a:1:{i:3;s:37:"taxonomy_vocabulary_machine_name_load";}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:2:{i:0;s:24:"taxonomy_form_vocabulary";i:1;i:3;}', '', '29', 5, '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '-10', 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/fields', 'a:1:{i:3;s:37:"taxonomy_vocabulary_machine_name_load";}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:3:{i:0;s:28:"field_ui_field_overview_form";i:1;s:13:"taxonomy_term";i:2;i:3;}', '', '29', 5, '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage fields', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%', 'a:2:{i:3;a:1:{s:37:"taxonomy_vocabulary_machine_name_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:2:{i:0;s:24:"field_ui_field_edit_form";i:1;i:5;}', '', '58', 6, '0', '', 'admin/structure/taxonomy/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', '6', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/delete', 'a:2:{i:3;a:1:{s:37:"taxonomy_vocabulary_machine_name_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:2:{i:0;s:26:"field_ui_field_delete_form";i:1;i:5;}', '', '117', 7, '1', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/edit', 'a:2:{i:3;a:1:{s:37:"taxonomy_vocabulary_machine_name_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:2:{i:0;s:24:"field_ui_field_edit_form";i:1;i:5;}', '', '117', 7, '1', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/field-settings', 'a:2:{i:3;a:1:{s:37:"taxonomy_vocabulary_machine_name_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:2:{i:0;s:28:"field_ui_field_settings_form";i:1;i:5;}', '', '117', 7, '1', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/widget-type', 'a:2:{i:3;a:1:{s:37:"taxonomy_vocabulary_machine_name_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}i:5;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:13:"taxonomy_term";i:1;i:3;i:2;s:1:"3";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:2:{i:0;s:25:"field_ui_widget_type_form";i:1;i:5;}', '', '117', 7, '1', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES
('admin/structure/taxonomy/%/list', 'a:1:{i:3;s:37:"taxonomy_vocabulary_machine_name_load";}', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:2:{i:0;s:23:"taxonomy_overview_terms";i:1;i:3;}', '', '29', 5, '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-20', 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/add', '', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:1:{i:0;s:24:"taxonomy_form_vocabulary";}', '', '15', 4, '1', 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Add vocabulary', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/list', '', '', 'user_access', 'a:1:{i:0;s:19:"administer taxonomy";}', 'drupal_get_form', 'a:1:{i:0;s:30:"taxonomy_overview_vocabularies";}', '', '15', 4, '1', 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/types', '', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'node_overview_types', 'a:0:{}', '', '7', 3, '0', '', 'admin/structure/types', 'Content types', 't', '', '', 'a:0:{}', '6', 'Manage content types, including default status, front page promotion, comment settings, etc.', '', '0', 'modules/node/content_types.inc'),
('admin/structure/types/add', '', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:1:{i:0;s:14:"node_type_form";}', '', '15', 4, '1', 'admin/structure/types', 'admin/structure/types', 'Add content type', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/node/content_types.inc'),
('admin/structure/types/list', '', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'node_overview_types', 'a:0:{}', '', '15', 4, '1', 'admin/structure/types', 'admin/structure/types', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/node/content_types.inc'),
('admin/structure/types/manage/%', 'a:1:{i:4;s:14:"node_type_load";}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:14:"node_type_form";i:1;i:4;}', '', '30', 5, '0', '', 'admin/structure/types/manage/%', 'Edit content type', 'node_type_page_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', '6', '', '', '0', 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/comment/display', 'a:1:{i:4;s:22:"comment_node_type_load";}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:7:"comment";i:2;i:4;i:3;s:7:"default";}', '', '123', 7, '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment display', 't', '', '', 'a:0:{}', '132', '', '', '4', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/display/default', 'a:1:{i:4;s:22:"comment_node_type_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:7:"comment";i:1;i:4;i:2;s:7:"default";i:3;s:11:"user_access";i:4;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:7:"comment";i:2;i:4;i:3;s:7:"default";}', '', '247', 8, '1', 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/display/full', 'a:1:{i:4;s:22:"comment_node_type_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:7:"comment";i:1;i:4;i:2;s:4:"full";i:3;s:11:"user_access";i:4;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:7:"comment";i:2;i:4;i:3;s:4:"full";}', '', '247', 8, '1', 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Full comment', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields', 'a:1:{i:4;s:22:"comment_node_type_load";}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:3:{i:0;s:28:"field_ui_field_overview_form";i:1;s:7:"comment";i:2;i:4;}', '', '123', 7, '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment fields', 't', '', '', 'a:0:{}', '132', '', '', '3', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%', 'a:2:{i:4;a:1:{s:22:"comment_node_type_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:7;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:24:"field_ui_field_edit_form";i:1;i:7;}', '', '246', 8, '0', '', 'admin/structure/types/manage/%/comment/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:7;}', '', 'a:0:{}', '6', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/delete', 'a:2:{i:4;a:1:{s:22:"comment_node_type_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:7;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:26:"field_ui_field_delete_form";i:1;i:7;}', '', '493', 9, '1', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/edit', 'a:2:{i:4;a:1:{s:22:"comment_node_type_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:7;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:24:"field_ui_field_edit_form";i:1;i:7;}', '', '493', 9, '1', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/field-settings', 'a:2:{i:4;a:1:{s:22:"comment_node_type_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:7;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:28:"field_ui_field_settings_form";i:1;i:7;}', '', '493', 9, '1', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Field settings', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/widget-type', 'a:2:{i:4;a:1:{s:22:"comment_node_type_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:7;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:7:"comment";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:25:"field_ui_widget_type_form";i:1;i:7;}', '', '493', 9, '1', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Widget type', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/delete', 'a:1:{i:4;s:14:"node_type_load";}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:24:"node_type_delete_confirm";i:1;i:4;}', '', '61', 6, '0', '', 'admin/structure/types/manage/%/delete', 'Delete', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/display', 'a:1:{i:4;s:14:"node_type_load";}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"node";i:2;i:4;i:3;s:7:"default";}', '', '61', 6, '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage display', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/default', 'a:1:{i:4;s:14:"node_type_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:4:"node";i:1;i:4;i:2;s:7:"default";i:3;s:11:"user_access";i:4;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"node";i:2;i:4;i:3;s:7:"default";}', '', '123', 7, '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/full', 'a:1:{i:4;s:14:"node_type_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:4:"node";i:1;i:4;i:2;s:4:"full";i:3;s:11:"user_access";i:4;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"node";i:2;i:4;i:3;s:4:"full";}', '', '123', 7, '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Full content', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/rss', 'a:1:{i:4;s:14:"node_type_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:4:"node";i:1;i:4;i:2;s:3:"rss";i:3;s:11:"user_access";i:4;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"node";i:2;i:4;i:3;s:3:"rss";}', '', '123', 7, '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'RSS', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/search_index', 'a:1:{i:4;s:14:"node_type_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:4:"node";i:1;i:4;i:2;s:12:"search_index";i:3;s:11:"user_access";i:4;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"node";i:2;i:4;i:3;s:12:"search_index";}', '', '123', 7, '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search index', 't', '', '', 'a:0:{}', '132', '', '', '3', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/search_result', 'a:1:{i:4;s:14:"node_type_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:4:"node";i:1;i:4;i:2;s:13:"search_result";i:3;s:11:"user_access";i:4;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"node";i:2;i:4;i:3;s:13:"search_result";}', '', '123', 7, '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search result', 't', '', '', 'a:0:{}', '132', '', '', '4', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/teaser', 'a:1:{i:4;s:14:"node_type_load";}', '', '_field_ui_view_mode_menu_access', 'a:5:{i:0;s:4:"node";i:1;i:4;i:2;s:6:"teaser";i:3;s:11:"user_access";i:4;s:24:"administer content types";}', 'drupal_get_form', 'a:4:{i:0;s:30:"field_ui_display_overview_form";i:1;s:4:"node";i:2;i:4;i:3;s:6:"teaser";}', '', '123', 7, '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Teaser', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/edit', 'a:1:{i:4;s:14:"node_type_load";}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:14:"node_type_form";i:1;i:4;}', '', '61', 6, '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/fields', 'a:1:{i:4;s:14:"node_type_load";}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:3:{i:0;s:28:"field_ui_field_overview_form";i:1;s:4:"node";i:2;i:4;}', '', '61', 6, '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage fields', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%', 'a:2:{i:4;a:1:{s:14:"node_type_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:6;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:24:"field_ui_field_edit_form";i:1;i:6;}', '', '122', 7, '0', '', 'admin/structure/types/manage/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:6;}', '', 'a:0:{}', '6', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/delete', 'a:2:{i:4;a:1:{s:14:"node_type_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:6;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:26:"field_ui_field_delete_form";i:1;i:6;}', '', '245', 8, '1', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/edit', 'a:2:{i:4;a:1:{s:14:"node_type_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:6;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:24:"field_ui_field_edit_form";i:1;i:6;}', '', '245', 8, '1', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/field-settings', 'a:2:{i:4;a:1:{s:14:"node_type_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:6;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:28:"field_ui_field_settings_form";i:1;i:6;}', '', '245', 8, '1', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/widget-type', 'a:2:{i:4;a:1:{s:14:"node_type_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}i:6;a:1:{s:18:"field_ui_menu_load";a:4:{i:0;s:4:"node";i:1;i:4;i:2;s:1:"4";i:3;s:4:"%map";}}}', '', 'user_access', 'a:1:{i:0;s:24:"administer content types";}', 'drupal_get_form', 'a:2:{i:0;s:25:"field_ui_widget_type_form";i:1;i:6;}', '', '245', 8, '1', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc'),
('admin/tasks', '', '', 'user_access', 'a:1:{i:0;s:27:"access administration pages";}', 'system_admin_menu_block_page', 'a:0:{}', '', '3', 2, '1', 'admin', 'admin', 'Tasks', 't', '', '', 'a:0:{}', '140', '', '', '-20', 'modules/system/system.admin.inc'),
('batch', '', '', '1', 'a:0:{}', 'system_batch_page', 'a:0:{}', '', '1', 1, '0', '', 'batch', '', 't', '', '_system_batch_theme', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('comment/%', 'a:1:{i:1;N;}', '', 'user_access', 'a:1:{i:0;s:15:"access comments";}', 'comment_permalink', 'a:1:{i:0;i:1;}', '', '2', 2, '0', '', 'comment/%', 'Comment permalink', 't', '', '', 'a:0:{}', '6', '', '', '0', ''),
('comment/%/approve', 'a:1:{i:1;N;}', '', 'user_access', 'a:1:{i:0;s:19:"administer comments";}', 'comment_approve', 'a:1:{i:0;i:1;}', '', '5', 3, '0', '', 'comment/%/approve', 'Approve', 't', '', '', 'a:0:{}', '6', '', '', '1', 'modules/comment/comment.pages.inc'),
('comment/%/delete', 'a:1:{i:1;N;}', '', 'user_access', 'a:1:{i:0;s:19:"administer comments";}', 'comment_confirm_delete_page', 'a:1:{i:0;i:1;}', '', '5', 3, '1', 'comment/%', 'comment/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/comment/comment.admin.inc'),
('comment/%/devel', 'a:1:{i:1;s:12:"comment_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_load_object', 'a:2:{i:0;s:7:"comment";i:1;i:1;}', '', '5', 3, '1', 'comment/%', 'comment/%', 'Devel', 't', '', '', 'a:0:{}', '132', '', '', '100', 'sites/all/modules/devel/devel.pages.inc'),
('comment/%/devel/load', 'a:1:{i:1;s:12:"comment_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_load_object', 'a:2:{i:0;s:7:"comment";i:1;i:1;}', '', '11', 4, '1', 'comment/%/devel', 'comment/%', 'Load', 't', '', '', 'a:0:{}', '140', '', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('comment/%/devel/render', 'a:1:{i:1;s:12:"comment_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_render_object', 'a:2:{i:0;s:7:"comment";i:1;i:1;}', '', '11', 4, '1', 'comment/%/devel', 'comment/%', 'Render', 't', '', '', 'a:0:{}', '132', '', '', '100', 'sites/all/modules/devel/devel.pages.inc'),
('comment/%/edit', 'a:1:{i:1;s:12:"comment_load";}', '', 'comment_access', 'a:2:{i:0;s:4:"edit";i:1;i:1;}', 'comment_edit_page', 'a:1:{i:0;i:1;}', '', '5', 3, '1', 'comment/%', 'comment/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '0', ''),
('comment/%/view', 'a:1:{i:1;N;}', '', 'user_access', 'a:1:{i:0;s:15:"access comments";}', 'comment_permalink', 'a:1:{i:0;i:1;}', '', '5', 3, '1', 'comment/%', 'comment/%', 'View comment', 't', '', '', 'a:0:{}', '140', '', '', '-10', ''),
('comment/reply/%', 'a:1:{i:2;s:9:"node_load";}', '', 'node_access', 'a:2:{i:0;s:4:"view";i:1;i:2;}', 'comment_reply', 'a:1:{i:0;i:2;}', '', '6', 3, '0', '', 'comment/reply/%', 'Add new comment', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/comment/comment.pages.inc'),
('demo/autocomplete', '', '', 'user_access', 'a:1:{i:0;s:24:"administer demo settings";}', 'demo_autocomplete', 'a:0:{}', '', '3', 2, '0', '', 'demo/autocomplete', '', 't', '', '', 'a:0:{}', '0', '', '', '0', 'sites/all/modules/demo/demo.admin.inc'),
('demo/download', '', '', 'user_access', 'a:1:{i:0;s:24:"administer demo settings";}', 'demo_download', 'a:0:{}', '', '3', 2, '0', '', 'demo/download', '', 't', '', '', 'a:0:{}', '0', '', '', '0', 'sites/all/modules/demo/demo.admin.inc'),
('devel/arguments', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_querylog_arguments', 'a:0:{}', '', '3', 2, '0', '', 'devel/arguments', 'Arguments query', 't', '', '', 'a:0:{}', '0', 'Return a given query, with arguments instead of placeholders. Used by query log', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/cache/clear', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_cache_clear', 'a:0:{}', '', '7', 3, '0', '', 'devel/cache/clear', 'Empty cache', 't', '', '', 'a:0:{}', '6', 'Clear the CSS cache and all database cache tables which store page, node, theme and variable caches.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/elements', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_elements_page', 'a:0:{}', '', '3', 2, '0', '', 'devel/elements', 'Hook_elements()', 't', '', '', 'a:0:{}', '6', 'View the active form/render elements for this site.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/entity/info', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_entity_info_page', 'a:0:{}', '', '7', 3, '0', '', 'devel/entity/info', 'Entity info', 't', '', '', 'a:0:{}', '6', 'View entity information across the whole site.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/explain', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_querylog_explain', 'a:0:{}', '', '3', 2, '0', '', 'devel/explain', 'Explain query', 't', '', '', 'a:0:{}', '0', 'Run an EXPLAIN on a given query. Used by query log', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/field/info', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_field_info_page', 'a:0:{}', '', '7', 3, '0', '', 'devel/field/info', 'Field info', 't', '', '', 'a:0:{}', '6', 'View fields information across the whole site.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/menu/item', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_menu_item', 'a:0:{}', '', '7', 3, '0', '', 'devel/menu/item', 'Menu item', 't', '', '', 'a:0:{}', '6', 'Details about a given menu item.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/menu/reset', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'drupal_get_form', 'a:1:{i:0;s:18:"devel_menu_rebuild";}', '', '7', 3, '0', '', 'devel/menu/reset', 'Rebuild menus', 't', '', '', 'a:0:{}', '6', 'Rebuild menu based on hook_menu() and revert any custom changes. All menu items return to their default settings.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/php', '', '', 'user_access', 'a:1:{i:0;s:16:"execute php code";}', 'drupal_get_form', 'a:1:{i:0;s:18:"devel_execute_form";}', '', '3', 2, '0', '', 'devel/php', 'Execute PHP Code', 't', '', '', 'a:0:{}', '6', 'Execute some PHP code', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/phpinfo', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_phpinfo', 'a:0:{}', '', '3', 2, '0', '', 'devel/phpinfo', 'PHPinfo()', 't', '', '', 'a:0:{}', '6', 'View your server''s PHP configuration', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/reference', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_function_reference', 'a:0:{}', '', '3', 2, '0', '', 'devel/reference', 'Function reference', 't', '', '', 'a:0:{}', '6', 'View a list of currently defined user functions with documentation links.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/reinstall', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'drupal_get_form', 'a:1:{i:0;s:15:"devel_reinstall";}', '', '3', 2, '0', '', 'devel/reinstall', 'Reinstall modules', 't', '', '', 'a:0:{}', '6', 'Run hook_uninstall() and then hook_install() for a given module.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/run-cron', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'system_run_cron', 'a:0:{}', '', '3', 2, '0', '', 'devel/run-cron', 'Run cron', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/system/system.admin.inc'),
('devel/session', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_session', 'a:0:{}', '', '3', 2, '0', '', 'devel/session', 'Session viewer', 't', '', '', 'a:0:{}', '6', 'List the contents of $_SESSION.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/settings', '', '', 'user_access', 'a:1:{i:0;s:29:"administer site configuration";}', 'drupal_get_form', 'a:1:{i:0;s:20:"devel_admin_settings";}', '', '3', 2, '0', '', 'devel/settings', 'Devel settings', 't', '', '', 'a:0:{}', '6', 'Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href="/admin/structure/block">block administration</a> page.', '', '0', 'sites/all/modules/devel/devel.admin.inc'),
('devel/switch', '', '', 'user_access', 'a:1:{i:0;s:12:"switch users";}', 'devel_switch_user', 'a:0:{}', '', '3', 2, '0', '', 'devel/switch', 'Switch user', 't', '', '', 'a:0:{}', '0', '', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/theme/registry', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_theme_registry', 'a:0:{}', '', '7', 3, '0', '', 'devel/theme/registry', 'Theme registry', 't', '', '', 'a:0:{}', '6', 'View a list of available theme functions across the whole site.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/variable', '', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_variable_page', 'a:0:{}', '', '3', 2, '0', '', 'devel/variable', 'Variable editor', 't', '', '', 'a:0:{}', '6', 'Edit and delete site variables.', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('devel/variable/edit/%', 'a:1:{i:3;N;}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'drupal_get_form', 'a:2:{i:0;s:19:"devel_variable_edit";i:1;i:3;}', '', '14', 4, '0', '', 'devel/variable/edit/%', 'Variable editor', 't', '', '', 'a:0:{}', '0', '', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('file/ajax', '', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'file_ajax_upload', 'a:0:{}', 'ajax_deliver', '3', 2, '0', '', 'file/ajax', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', '0', '', '', '0', ''),
('file/progress', '', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'file_ajax_progress', 'a:0:{}', '', '3', 2, '0', '', 'file/progress', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', '0', '', '', '0', ''),
('filter/tips', '', '', '1', 'a:0:{}', 'filter_tips_long', 'a:0:{}', '', '3', 2, '0', '', 'filter/tips', 'Compose tips', 't', '', '', 'a:0:{}', '20', '', '', '0', 'modules/filter/filter.pages.inc'),
('node', '', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'node_page_default', 'a:0:{}', '', '1', 1, '0', '', 'node', '', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('node/%', 'a:1:{i:1;s:9:"node_load";}', '', 'node_access', 'a:2:{i:0;s:4:"view";i:1;i:1;}', 'node_page_view', 'a:1:{i:0;i:1;}', '', '2', 2, '0', '', 'node/%', '', 'node_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', '6', '', '', '0', ''),
('node/%/delete', 'a:1:{i:1;s:9:"node_load";}', '', 'node_access', 'a:2:{i:0;s:6:"delete";i:1;i:1;}', 'drupal_get_form', 'a:2:{i:0;s:19:"node_delete_confirm";i:1;i:1;}', '', '5', 3, '2', 'node/%', 'node/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/node/node.pages.inc'),
('node/%/devel', 'a:1:{i:1;s:9:"node_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_load_object', 'a:2:{i:0;s:4:"node";i:1;i:1;}', '', '5', 3, '1', 'node/%', 'node/%', 'Devel', 't', '', '', 'a:0:{}', '132', '', '', '100', 'sites/all/modules/devel/devel.pages.inc'),
('node/%/devel/load', 'a:1:{i:1;s:9:"node_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_load_object', 'a:2:{i:0;s:4:"node";i:1;i:1;}', '', '11', 4, '1', 'node/%/devel', 'node/%', 'Load', 't', '', '', 'a:0:{}', '140', '', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('node/%/devel/render', 'a:1:{i:1;s:9:"node_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_render_object', 'a:2:{i:0;s:4:"node";i:1;i:1;}', '', '11', 4, '1', 'node/%/devel', 'node/%', 'Render', 't', '', '', 'a:0:{}', '132', '', '', '100', 'sites/all/modules/devel/devel.pages.inc'),
('node/%/edit', 'a:1:{i:1;s:9:"node_load";}', '', 'node_access', 'a:2:{i:0;s:6:"update";i:1;i:1;}', 'node_page_edit', 'a:1:{i:0;i:1;}', '', '5', 3, '3', 'node/%', 'node/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/node/node.pages.inc'),
('node/%/results', 'a:1:{i:1;s:9:"node_load";}', '', '_poll_menu_access', 'a:3:{i:0;i:1;i:1;s:14:"access content";i:2;b:1;}', 'poll_results', 'a:1:{i:0;i:1;}', '', '5', 3, '1', 'node/%', 'node/%', 'Results', 't', '', '', 'a:0:{}', '132', '', '', '3', 'modules/poll/poll.pages.inc'),
('node/%/revisions', 'a:1:{i:1;s:9:"node_load";}', '', '_node_revision_access', 'a:1:{i:0;i:1;}', 'node_revision_overview', 'a:1:{i:0;i:1;}', '', '5', 3, '1', 'node/%', 'node/%', 'Revisions', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/node/node.pages.inc'),
('node/%/revisions/%/delete', 'a:2:{i:1;a:1:{s:9:"node_load";a:1:{i:0;i:3;}}i:3;N;}', '', '_node_revision_access', 'a:2:{i:0;i:1;i:1;s:6:"delete";}', 'drupal_get_form', 'a:2:{i:0;s:28:"node_revision_delete_confirm";i:1;i:1;}', '', '21', 5, '0', '', 'node/%/revisions/%/delete', 'Delete earlier revision', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/node/node.pages.inc'),
('node/%/revisions/%/revert', 'a:2:{i:1;a:1:{s:9:"node_load";a:1:{i:0;i:3;}}i:3;N;}', '', '_node_revision_access', 'a:2:{i:0;i:1;i:1;s:6:"update";}', 'drupal_get_form', 'a:2:{i:0;s:28:"node_revision_revert_confirm";i:1;i:1;}', '', '21', 5, '0', '', 'node/%/revisions/%/revert', 'Revert to earlier revision', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/node/node.pages.inc'),
('node/%/revisions/%/view', 'a:2:{i:1;a:1:{s:9:"node_load";a:1:{i:0;i:3;}}i:3;N;}', '', '_node_revision_access', 'a:1:{i:0;i:1;}', 'node_show', 'a:2:{i:0;i:1;i:1;b:1;}', '', '21', 5, '0', '', 'node/%/revisions/%/view', 'Revisions', 't', '', '', 'a:0:{}', '6', '', '', '0', ''),
('node/%/view', 'a:1:{i:1;s:9:"node_load";}', '', 'node_access', 'a:2:{i:0;s:4:"view";i:1;i:1;}', 'node_page_view', 'a:1:{i:0;i:1;}', '', '5', 3, '1', 'node/%', 'node/%', 'View', 't', '', '', 'a:0:{}', '140', '', '', '-10', ''),
('node/%/votes', 'a:1:{i:1;s:9:"node_load";}', '', '_poll_menu_access', 'a:3:{i:0;i:1;i:1;s:17:"inspect all votes";i:2;b:0;}', 'poll_votes', 'a:1:{i:0;i:1;}', '', '5', 3, '1', 'node/%', 'node/%', 'Votes', 't', '', '', 'a:0:{}', '132', '', '', '3', 'modules/poll/poll.pages.inc'),
('node/add', '', '', '_node_add_access', 'a:0:{}', 'node_add_page', 'a:0:{}', '', '3', 2, '0', '', 'node/add', 'Add content', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/node/node.pages.inc'),
('node/add/article', '', '', 'node_access', 'a:2:{i:0;s:6:"create";i:1;s:7:"article";}', 'node_add', 'a:1:{i:0;s:7:"article";}', '', '7', 3, '0', '', 'node/add/article', 'Article', 'check_plain', '', '', 'a:0:{}', '6', 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', '0', 'modules/node/node.pages.inc'),
('node/add/page', '', '', 'node_access', 'a:2:{i:0;s:6:"create";i:1;s:4:"page";}', 'node_add', 'a:1:{i:0;s:4:"page";}', '', '7', 3, '0', '', 'node/add/page', 'Basic page', 'check_plain', '', '', 'a:0:{}', '6', 'Use <em>basic pages</em> for your static content, such as an ''About us'' page.', '', '0', 'modules/node/node.pages.inc'),
('node/add/poll', '', '', 'node_access', 'a:2:{i:0;s:6:"create";i:1;s:4:"poll";}', 'node_add', 'a:1:{i:0;s:4:"poll";}', '', '7', 3, '0', '', 'node/add/poll', 'Poll', 'check_plain', '', '', 'a:0:{}', '6', 'A <em>poll</em> is a question with a set of possible responses. A <em>poll</em>, once created, automatically provides a simple running count of the number of votes received for each response.', '', '0', 'modules/node/node.pages.inc'),
('overlay-ajax/%', 'a:1:{i:1;N;}', '', 'user_access', 'a:1:{i:0;s:14:"access overlay";}', 'overlay_ajax_render_region', 'a:1:{i:0;i:1;}', '', '2', 2, '0', '', 'overlay-ajax/%', '', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('overlay/dismiss-message', '', '', 'user_access', 'a:1:{i:0;s:14:"access overlay";}', 'overlay_user_dismiss_message', 'a:0:{}', '', '3', 2, '0', '', 'overlay/dismiss-message', '', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('poll', '', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'poll_page', 'a:0:{}', '', '1', 1, '0', '', 'poll', 'Polls', 't', '', '', 'a:0:{}', '20', '', '', '0', 'modules/poll/poll.pages.inc'),
('rss.xml', '', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'node_feed', 'a:0:{}', '', '1', 1, '0', '', 'rss.xml', 'RSS feed', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('search', '', '', 'search_is_active', 'a:0:{}', 'search_view', 'a:0:{}', '', '1', 1, '0', '', 'search', 'Search', 't', '', '', 'a:0:{}', '20', '', '', '0', 'modules/search/search.pages.inc'),
('search/node', '', '', '_search_menu_access', 'a:1:{i:0;s:4:"node";}', 'search_view', 'a:2:{i:0;s:4:"node";i:1;s:0:"";}', '', '3', 2, '1', 'search', 'search', 'Content', 't', '', '', 'a:0:{}', '132', '', '', '-10', 'modules/search/search.pages.inc'),
('search/node/%', 'a:1:{i:2;a:1:{s:14:"menu_tail_load";a:2:{i:0;s:4:"%map";i:1;s:6:"%index";}}}', 'a:1:{i:2;s:16:"menu_tail_to_arg";}', '_search_menu_access', 'a:1:{i:0;s:4:"node";}', 'search_view', 'a:2:{i:0;s:4:"node";i:1;i:2;}', '', '6', 3, '1', 'search/node', 'search/node/%', 'Content', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/search/search.pages.inc'),
('search/user', '', '', '_search_menu_access', 'a:1:{i:0;s:4:"user";}', 'search_view', 'a:2:{i:0;s:4:"user";i:1;s:0:"";}', '', '3', 2, '1', 'search', 'search', 'Users', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/search/search.pages.inc'),
('search/user/%', 'a:1:{i:2;a:1:{s:14:"menu_tail_load";a:2:{i:0;s:4:"%map";i:1;s:6:"%index";}}}', 'a:1:{i:2;s:16:"menu_tail_to_arg";}', '_search_menu_access', 'a:1:{i:0;s:4:"user";}', 'search_view', 'a:2:{i:0;s:4:"user";i:1;i:2;}', '', '6', 3, '1', 'search/node', 'search/node/%', 'Users', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/search/search.pages.inc'),
('sites/default/files/styles/%', 'a:1:{i:4;s:16:"image_style_load";}', '', '1', 'a:0:{}', 'image_style_deliver', 'a:1:{i:0;i:4;}', '', '30', 5, '0', '', 'sites/default/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('system/ajax', '', '', '1', 'a:0:{}', 'ajax_form_callback', 'a:0:{}', 'ajax_deliver', '3', 2, '0', '', 'system/ajax', 'AHAH callback', 't', '', 'ajax_base_page_theme', 'a:0:{}', '0', '', '', '0', 'includes/form.inc'),
('system/files', '', '', '1', 'a:0:{}', 'file_download', 'a:1:{i:0;s:7:"private";}', '', '3', 2, '0', '', 'system/files', 'File download', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('system/files/styles/%', 'a:1:{i:3;s:16:"image_style_load";}', '', '1', 'a:0:{}', 'image_style_deliver', 'a:1:{i:0;i:3;}', '', '14', 4, '0', '', 'system/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('system/temporary', '', '', '1', 'a:0:{}', 'file_download', 'a:1:{i:0;s:9:"temporary";}', '', '3', 2, '0', '', 'system/temporary', 'Temporary files', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('system/timezone', '', '', '1', 'a:0:{}', 'system_timezone', 'a:0:{}', '', '3', 2, '0', '', 'system/timezone', 'Time zone', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc'),
('taxonomy/autocomplete', '', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'taxonomy_autocomplete', 'a:0:{}', '', '3', 2, '0', '', 'taxonomy/autocomplete', 'Autocomplete taxonomy', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%', 'a:1:{i:2;s:18:"taxonomy_term_load";}', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'taxonomy_term_page', 'a:1:{i:0;i:2;}', '', '6', 3, '0', '', 'taxonomy/term/%', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', '6', '', '', '0', 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%/devel', 'a:1:{i:2;s:18:"taxonomy_term_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_load_object', 'a:3:{i:0;s:13:"taxonomy_term";i:1;i:2;i:2;s:4:"term";}', '', '13', 4, '1', 'taxonomy/term/%', 'taxonomy/term/%', 'Devel', 't', '', '', 'a:0:{}', '132', '', '', '100', 'sites/all/modules/devel/devel.pages.inc'),
('taxonomy/term/%/devel/load', 'a:1:{i:2;s:18:"taxonomy_term_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_load_object', 'a:3:{i:0;s:13:"taxonomy_term";i:1;i:2;i:2;s:4:"term";}', '', '27', 5, '1', 'taxonomy/term/%/devel', 'taxonomy/term/%', 'Load', 't', '', '', 'a:0:{}', '140', '', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('taxonomy/term/%/devel/render', 'a:1:{i:2;s:18:"taxonomy_term_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_render_object', 'a:3:{i:0;s:13:"taxonomy_term";i:1;i:2;i:2;s:4:"term";}', '', '27', 5, '1', 'taxonomy/term/%/devel', 'taxonomy/term/%', 'Render', 't', '', '', 'a:0:{}', '132', '', '', '100', 'sites/all/modules/devel/devel.pages.inc'),
('taxonomy/term/%/edit', 'a:1:{i:2;s:18:"taxonomy_term_load";}', '', 'taxonomy_term_edit_access', 'a:1:{i:0;i:2;}', 'drupal_get_form', 'a:3:{i:0;s:18:"taxonomy_form_term";i:1;i:2;i:2;N;}', '', '13', 4, '1', 'taxonomy/term/%', 'taxonomy/term/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/taxonomy/taxonomy.admin.inc'),
('taxonomy/term/%/feed', 'a:1:{i:2;s:18:"taxonomy_term_load";}', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'taxonomy_term_feed', 'a:1:{i:0;i:2;}', '', '13', 4, '0', '', 'taxonomy/term/%/feed', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', '0', '', '', '0', 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%/view', 'a:1:{i:2;s:18:"taxonomy_term_load";}', '', 'user_access', 'a:1:{i:0;s:14:"access content";}', 'taxonomy_term_page', 'a:1:{i:0;i:2;}', '', '13', 4, '1', 'taxonomy/term/%', 'taxonomy/term/%', 'View', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/taxonomy/taxonomy.pages.inc'),
('toolbar/toggle', '', '', 'user_access', 'a:1:{i:0;s:14:"access toolbar";}', 'toolbar_toggle_page', 'a:0:{}', '', '3', 2, '0', '', 'toolbar/toggle', 'Toggle drawer visibility', 't', '', '', 'a:0:{}', '0', '', '', '0', ''),
('user', '', '', '1', 'a:0:{}', 'user_page', 'a:0:{}', '', '1', 1, '0', '', 'user', 'User account', 'user_menu_title', '', '', 'a:0:{}', '6', '', '', '-10', 'modules/user/user.pages.inc'),
('user/%', 'a:1:{i:1;s:9:"user_load";}', '', 'user_view_access', 'a:1:{i:0;i:1;}', 'user_view_page', 'a:1:{i:0;i:1;}', '', '2', 2, '0', '', 'user/%', 'My account', 'user_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', '6', '', '', '0', ''),
('user/%/cancel', 'a:1:{i:1;s:9:"user_load";}', '', 'user_cancel_access', 'a:1:{i:0;i:1;}', 'drupal_get_form', 'a:2:{i:0;s:24:"user_cancel_confirm_form";i:1;i:1;}', '', '5', 3, '0', '', 'user/%/cancel', 'Cancel account', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/user/user.pages.inc'),
('user/%/cancel/confirm/%/%', 'a:3:{i:1;s:9:"user_load";i:4;N;i:5;N;}', '', 'user_cancel_access', 'a:1:{i:0;i:1;}', 'user_cancel_confirm', 'a:3:{i:0;i:1;i:1;i:4;i:2;i:5;}', '', '44', 6, '0', '', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/user/user.pages.inc'),
('user/%/devel', 'a:1:{i:1;s:9:"user_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_load_object', 'a:2:{i:0;s:4:"user";i:1;i:1;}', '', '5', 3, '1', 'user/%', 'user/%', 'Devel', 't', '', '', 'a:0:{}', '132', '', '', '100', 'sites/all/modules/devel/devel.pages.inc'),
('user/%/devel/load', 'a:1:{i:1;s:9:"user_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_load_object', 'a:2:{i:0;s:4:"user";i:1;i:1;}', '', '11', 4, '1', 'user/%/devel', 'user/%', 'Load', 't', '', '', 'a:0:{}', '140', '', '', '0', 'sites/all/modules/devel/devel.pages.inc'),
('user/%/devel/render', 'a:1:{i:1;s:9:"user_load";}', '', 'user_access', 'a:1:{i:0;s:24:"access devel information";}', 'devel_render_object', 'a:2:{i:0;s:4:"user";i:1;i:1;}', '', '11', 4, '1', 'user/%/devel', 'user/%', 'Render', 't', '', '', 'a:0:{}', '132', '', '', '100', 'sites/all/modules/devel/devel.pages.inc'),
('user/%/edit', 'a:1:{i:1;s:9:"user_load";}', '', 'user_edit_access', 'a:1:{i:0;i:1;}', 'drupal_get_form', 'a:2:{i:0;s:17:"user_profile_form";i:1;i:1;}', '', '5', 3, '1', 'user/%', 'user/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/user/user.pages.inc'),
('user/%/edit/account', 'a:1:{i:1;a:1:{s:18:"user_category_load";a:2:{i:0;s:4:"%map";i:1;s:6:"%index";}}}', '', 'user_edit_access', 'a:1:{i:0;i:1;}', 'drupal_get_form', 'a:2:{i:0;s:17:"user_profile_form";i:1;i:1;}', '', '11', 4, '1', 'user/%/edit', 'user/%', 'Account', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/user/user.pages.inc'),
('user/%/shortcuts', 'a:1:{i:1;s:9:"user_load";}', '', 'shortcut_set_switch_access', 'a:1:{i:0;i:1;}', 'drupal_get_form', 'a:2:{i:0;s:19:"shortcut_set_switch";i:1;i:1;}', '', '5', 3, '1', 'user/%', 'user/%', 'Shortcuts', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/shortcut/shortcut.admin.inc'),
('user/%/view', 'a:1:{i:1;s:9:"user_load";}', '', 'user_view_access', 'a:1:{i:0;i:1;}', 'user_view_page', 'a:1:{i:0;i:1;}', '', '5', 3, '1', 'user/%', 'user/%', 'View', 't', '', '', 'a:0:{}', '140', '', '', '-10', ''),
('user/autocomplete', '', '', 'user_access', 'a:1:{i:0;s:20:"access user profiles";}', 'user_autocomplete', 'a:0:{}', '', '3', 2, '0', '', 'user/autocomplete', 'User autocomplete', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/user/user.pages.inc'),
('user/login', '', '', 'user_is_anonymous', 'a:0:{}', 'user_page', 'a:0:{}', '', '3', 2, '1', 'user', 'user', 'Log in', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/user/user.pages.inc'),
('user/logout', '', '', 'user_is_logged_in', 'a:0:{}', 'user_logout', 'a:0:{}', '', '3', 2, '0', '', 'user/logout', 'Log out', 't', '', '', 'a:0:{}', '6', '', '', '10', 'modules/user/user.pages.inc'),
('user/password', '', '', '1', 'a:0:{}', 'drupal_get_form', 'a:1:{i:0;s:9:"user_pass";}', '', '3', 2, '1', 'user', 'user', 'Request new password', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/user/user.pages.inc'),
('user/register', '', '', 'user_register_access', 'a:0:{}', 'drupal_get_form', 'a:1:{i:0;s:18:"user_register_form";}', '', '3', 2, '1', 'user', 'user', 'Create new account', 't', '', '', 'a:0:{}', '132', '', '', '0', ''),
('user/reset/%/%/%', 'a:3:{i:2;N;i:3;N;i:4;N;}', '', '1', 'a:0:{}', 'drupal_get_form', 'a:4:{i:0;s:15:"user_pass_reset";i:1;i:2;i:2;i:3;i:3;i:4;}', '', '24', 5, '0', '', 'user/reset/%/%/%', 'Reset password', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/user/user.pages.inc');
/*!40000 ALTER TABLE menu_router ENABLE KEYS */;

--
-- Table structure for table 'node'
--

CREATE TABLE IF NOT EXISTS `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='The base table for nodes.';

--
-- Dumping data for table 'node'
--

/*!40000 ALTER TABLE node DISABLE KEYS */;
INSERT INTO `node` VALUES
('1', '1', 'article', 'und', 'Drupal High Web Site Launched', '1', '1', '1331571475', '1331575411', '2', '0', '0', '0', '0'),
('2', '2', 'article', 'und', 'Welcome Returning Students!', '1', '1', '1331574365', '1331585767', '2', '1', '0', '0', '0'),
('3', '3', 'page', 'und', 'About Us', '1', '1', '1331575606', '1331582175', '1', '0', '0', '0', '0'),
('4', '4', 'poll', 'und', 'What is your favorite class?', '1', '1', '1331578913', '1331579025', '2', '0', '0', '0', '0'),
('5', '5', 'page', 'und', 'Offsite Resources', '1', '1', '1331582132', '1331582132', '1', '0', '0', '0', '0'),
('6', '6', 'page', 'und', 'Staff', '1', '1', '1331583641', '1331583641', '1', '0', '0', '0', '0'),
('27', '27', 'article', 'und', 'Dolor Enim', '1', '1', '1330126442', '1331586404', '2', '0', '0', '0', '0'),
('28', '28', 'article', 'und', 'Capto Tamen', '0', '1', '1329872515', '1331586404', '2', '0', '0', '0', '0'),
('29', '29', 'article', 'und', 'Amet Dolore Facilisis Valetudo', '0', '1', '1329985661', '1331586404', '2', '0', '0', '0', '0'),
('30', '30', 'article', 'und', 'Abluo Ille Illum Te', '0', '1', '1329252976', '1331586404', '2', '0', '0', '0', '0'),
('31', '31', 'article', 'und', 'Loquor Natu', '0', '1', '1329353650', '1331586404', '2', '0', '0', '0', '0'),
('32', '32', 'article', 'und', 'Erat Qui Virtus', '0', '1', '1331345127', '1331586404', '2', '0', '0', '0', '0'),
('33', '33', 'article', 'und', 'Damnum Gravis Minim Patria', '1', '1', '1329900144', '1331586404', '2', '0', '0', '0', '0'),
('34', '34', 'article', 'und', 'Caecus Diam Secundum Zelus', '1', '1', '1331050751', '1331586404', '2', '0', '0', '0', '0'),
('35', '35', 'article', 'und', 'Lobortis Ratis Vindico', '0', '1', '1330001654', '1331586404', '2', '1', '0', '0', '0'),
('36', '36', 'article', 'und', 'Tum Valde', '1', '1', '1330403466', '1331586404', '2', '0', '0', '0', '0'),
('37', '37', 'article', 'und', 'Distineo Dolore Secundum', '1', '1', '1331527564', '1331586404', '2', '1', '0', '0', '0'),
('38', '38', 'article', 'und', 'Dolore Vel Virtus', '1', '1', '1330689814', '1331586404', '2', '1', '0', '0', '0'),
('39', '39', 'article', 'und', 'Et Virtus', '0', '1', '1329645032', '1331586404', '2', '0', '0', '0', '0'),
('40', '40', 'article', 'und', 'Nobis Proprius Quibus Tation', '1', '1', '1331075063', '1331586404', '2', '1', '0', '0', '0'),
('41', '41', 'article', 'und', 'Luptatum Rusticus', '0', '1', '1330238212', '1331586404', '2', '0', '0', '0', '0'),
('42', '42', 'article', 'und', 'Bene Brevitas Facilisis Proprius', '1', '1', '1331081742', '1331586404', '2', '0', '0', '0', '0'),
('43', '43', 'article', 'und', 'Dignissim Nimis Pecus Utinam', '1', '1', '1330596709', '1331586404', '2', '1', '0', '0', '0'),
('44', '44', 'article', 'und', 'Hos Nostrud Quae', '0', '1', '1331468534', '1331586404', '2', '0', '0', '0', '0'),
('45', '45', 'article', 'und', 'Gilvus Praemitto Refoveo', '0', '1', '1330073747', '1331586404', '2', '1', '0', '0', '0'),
('46', '46', 'article', 'und', 'Modo Neo Obruo', '1', '1', '1331012992', '1331586404', '2', '0', '0', '0', '0'),
('47', '47', 'article', 'und', 'Modo Quidem', '0', '1', '1330251381', '1331586404', '2', '1', '0', '0', '0'),
('48', '48', 'article', 'und', 'Esse Mos Populus', '0', '1', '1330574602', '1331586404', '2', '1', '0', '0', '0'),
('49', '49', 'article', 'und', 'Ea Magna Olim Voco', '0', '1', '1331148018', '1331586404', '2', '0', '0', '0', '0'),
('50', '50', 'article', 'und', 'Abluo Conventio Pagus Zelus', '0', '1', '1329085967', '1331586404', '2', '0', '0', '0', '0'),
('51', '51', 'article', 'und', 'Oppeto Suscipere Vero Ymo', '0', '1', '1329821183', '1331586404', '2', '1', '0', '0', '0');
/*!40000 ALTER TABLE node ENABLE KEYS */;

--
-- Table structure for table 'node_access'
--

CREATE TABLE IF NOT EXISTS `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Identifies which realm/grant pairs a user must possess in...';

--
-- Dumping data for table 'node_access'
--

/*!40000 ALTER TABLE node_access DISABLE KEYS */;
INSERT INTO `node_access` VALUES
('0', '0', 'all', '1', '0', '0');
/*!40000 ALTER TABLE node_access ENABLE KEYS */;

--
-- Table structure for table 'node_comment_statistics'
--

CREATE TABLE IF NOT EXISTS `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Maintains statistics of node and comments posts to show ...';

--
-- Dumping data for table 'node_comment_statistics'
--

/*!40000 ALTER TABLE node_comment_statistics DISABLE KEYS */;
INSERT INTO `node_comment_statistics` VALUES
('1', '0', '1331571475', NULL, '1', '0'),
('2', '0', '1331574365', NULL, '1', '0'),
('3', '0', '1331575606', NULL, '1', '0'),
('4', '0', '1331578913', NULL, '1', '0'),
('5', '0', '1331582132', NULL, '1', '0'),
('6', '0', '1331583641', NULL, '1', '0'),
('27', '0', '1331586404', NULL, '1', '0'),
('28', '0', '1331586404', NULL, '0', '0'),
('29', '0', '1331586404', NULL, '0', '0'),
('30', '0', '1331586404', NULL, '0', '0'),
('31', '0', '1331586404', NULL, '0', '0'),
('32', '0', '1331586404', NULL, '0', '0'),
('33', '0', '1331586404', NULL, '1', '0'),
('34', '0', '1331586404', NULL, '1', '0'),
('35', '0', '1331586404', NULL, '0', '0'),
('36', '0', '1331586404', NULL, '1', '0'),
('37', '0', '1331586404', NULL, '1', '0'),
('38', '0', '1331586404', NULL, '1', '0'),
('39', '0', '1331586404', NULL, '0', '0'),
('40', '0', '1331586404', NULL, '1', '0'),
('41', '0', '1331586404', NULL, '0', '0'),
('42', '0', '1331586404', NULL, '1', '0'),
('43', '0', '1331586404', NULL, '1', '0'),
('44', '0', '1331586404', NULL, '0', '0'),
('45', '0', '1331586404', NULL, '0', '0'),
('46', '0', '1331586404', NULL, '1', '0'),
('47', '0', '1331586404', NULL, '0', '0'),
('48', '0', '1331586404', NULL, '0', '0'),
('49', '0', '1331586404', NULL, '0', '0'),
('50', '0', '1331586404', NULL, '0', '0'),
('51', '0', '1331586404', NULL, '0', '0');
/*!40000 ALTER TABLE node_comment_statistics ENABLE KEYS */;

--
-- Table structure for table 'node_revision'
--

CREATE TABLE IF NOT EXISTS `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores information about each saved version of a node.';

--
-- Dumping data for table 'node_revision'
--

/*!40000 ALTER TABLE node_revision DISABLE KEYS */;
INSERT INTO `node_revision` VALUES
('1', '1', '1', 'Drupal High Web Site Launched', '', '1331575411', '1', '2', '0', '0'),
('2', '2', '1', 'Welcome Returning Students!', '', '1331585767', '1', '2', '1', '0'),
('3', '3', '1', 'About Us', '', '1331582175', '1', '1', '0', '0'),
('4', '4', '1', 'What is your favorite class?', '', '1331579025', '1', '2', '0', '0'),
('5', '5', '1', 'Offsite Resources', '', '1331582132', '1', '1', '0', '0'),
('6', '6', '1', 'Staff', '', '1331583641', '1', '1', '0', '0'),
('27', '27', '1', 'Dolor Enim', '', '1331586404', '1', '2', '0', '0'),
('28', '28', '1', 'Capto Tamen', '', '1331586404', '1', '2', '0', '0'),
('29', '29', '1', 'Amet Dolore Facilisis Valetudo', '', '1331586404', '1', '2', '0', '0'),
('30', '30', '1', 'Abluo Ille Illum Te', '', '1331586404', '1', '2', '0', '0'),
('31', '31', '1', 'Loquor Natu', '', '1331586404', '1', '2', '0', '0'),
('32', '32', '1', 'Erat Qui Virtus', '', '1331586404', '1', '2', '0', '0'),
('33', '33', '1', 'Damnum Gravis Minim Patria', '', '1331586404', '1', '2', '0', '0'),
('34', '34', '1', 'Caecus Diam Secundum Zelus', '', '1331586404', '1', '2', '0', '0'),
('35', '35', '1', 'Lobortis Ratis Vindico', '', '1331586404', '1', '2', '1', '0'),
('36', '36', '1', 'Tum Valde', '', '1331586404', '1', '2', '0', '0'),
('37', '37', '1', 'Distineo Dolore Secundum', '', '1331586404', '1', '2', '1', '0'),
('38', '38', '1', 'Dolore Vel Virtus', '', '1331586404', '1', '2', '1', '0'),
('39', '39', '1', 'Et Virtus', '', '1331586404', '1', '2', '0', '0'),
('40', '40', '1', 'Nobis Proprius Quibus Tation', '', '1331586404', '1', '2', '1', '0'),
('41', '41', '1', 'Luptatum Rusticus', '', '1331586404', '1', '2', '0', '0'),
('42', '42', '1', 'Bene Brevitas Facilisis Proprius', '', '1331586404', '1', '2', '0', '0'),
('43', '43', '1', 'Dignissim Nimis Pecus Utinam', '', '1331586404', '1', '2', '1', '0'),
('44', '44', '1', 'Hos Nostrud Quae', '', '1331586404', '1', '2', '0', '0'),
('45', '45', '1', 'Gilvus Praemitto Refoveo', '', '1331586404', '1', '2', '1', '0'),
('46', '46', '1', 'Modo Neo Obruo', '', '1331586404', '1', '2', '0', '0'),
('47', '47', '1', 'Modo Quidem', '', '1331586404', '1', '2', '1', '0'),
('48', '48', '1', 'Esse Mos Populus', '', '1331586404', '1', '2', '1', '0'),
('49', '49', '1', 'Ea Magna Olim Voco', '', '1331586404', '1', '2', '0', '0'),
('50', '50', '1', 'Abluo Conventio Pagus Zelus', '', '1331586404', '1', '2', '0', '0'),
('51', '51', '1', 'Oppeto Suscipere Vero Ymo', '', '1331586404', '1', '2', '1', '0');
/*!40000 ALTER TABLE node_revision ENABLE KEYS */;

--
-- Table structure for table 'node_type'
--

CREATE TABLE IF NOT EXISTS `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores information about all defined node types.';

--
-- Dumping data for table 'node_type'
--

/*!40000 ALTER TABLE node_type DISABLE KEYS */;
INSERT INTO `node_type` VALUES
('article', 'Article', 'node_content', 'node', 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', '1', 'Title', '1', '1', '0', '0', 'article'),
('page', 'Basic page', 'node_content', 'node', 'Use <em>basic pages</em> for your static content, such as an ''About us'' page.', '', '1', 'Title', '1', '1', '0', '0', 'page'),
('poll', 'Poll', 'poll', 'poll', 'A <em>poll</em> is a question with a set of possible responses. A <em>poll</em>, once created, automatically provides a simple running count of the number of votes received for each response.', '', '1', 'Question', '0', '0', '1', '0', 'poll');
/*!40000 ALTER TABLE node_type ENABLE KEYS */;

--
-- Table structure for table 'poll'
--

CREATE TABLE IF NOT EXISTS `poll` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The poll’s node.nid.',
  `runtime` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of seconds past node.created during which the poll is open.',
  `active` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not the poll is open.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores poll-specific information for poll nodes.';

--
-- Dumping data for table 'poll'
--

/*!40000 ALTER TABLE poll DISABLE KEYS */;
INSERT INTO `poll` VALUES
('4', '0', '1');
/*!40000 ALTER TABLE poll ENABLE KEYS */;

--
-- Table structure for table 'poll_choice'
--

CREATE TABLE IF NOT EXISTS `poll_choice` (
  `chid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for a poll choice.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this choice belongs to.',
  `chtext` varchar(128) NOT NULL DEFAULT '' COMMENT 'The text for this choice.',
  `chvotes` int(11) NOT NULL DEFAULT '0' COMMENT 'The total number of votes this choice has received by all users.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The sort order of this choice among all choices for the same node.',
  PRIMARY KEY (`chid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores information about all choices for all polls.';

--
-- Dumping data for table 'poll_choice'
--

/*!40000 ALTER TABLE poll_choice DISABLE KEYS */;
INSERT INTO `poll_choice` VALUES
('1', '4', 'Drupal Intro', '0', '1'),
('2', '4', 'Theming 101', '0', '2'),
('3', '4', 'Ninja Development', '0', '3');
/*!40000 ALTER TABLE poll_choice ENABLE KEYS */;

--
-- Table structure for table 'poll_vote'
--

CREATE TABLE IF NOT EXISTS `poll_vote` (
  `chid` int(10) unsigned NOT NULL COMMENT 'The users’s vote for this poll.',
  `nid` int(10) unsigned NOT NULL COMMENT 'The poll node this vote is for.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid this vote is from unless the voter was anonymous.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address this vote is from unless the voter was logged in.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The timestamp of the vote creation.',
  PRIMARY KEY (`nid`,`uid`,`hostname`),
  KEY `chid` (`chid`),
  KEY `hostname` (`hostname`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores per-users votes for each poll.';

--
-- Dumping data for table 'poll_vote'
--

/*!40000 ALTER TABLE poll_vote DISABLE KEYS */;
/*!40000 ALTER TABLE poll_vote ENABLE KEYS */;

--
-- Table structure for table 'queue'
--

CREATE TABLE IF NOT EXISTS `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores items in queues.';

--
-- Dumping data for table 'queue'
--

/*!40000 ALTER TABLE queue DISABLE KEYS */;
/*!40000 ALTER TABLE queue ENABLE KEYS */;

--
-- Table structure for table 'rdf_mapping'
--

CREATE TABLE IF NOT EXISTS `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores custom RDF mappings for user defined content types...';

--
-- Dumping data for table 'rdf_mapping'
--

/*!40000 ALTER TABLE rdf_mapping DISABLE KEYS */;
INSERT INTO `rdf_mapping` VALUES
('node', 'article', 'a:11:{s:11:"field_image";a:2:{s:10:"predicates";a:2:{i:0;s:8:"og:image";i:1;s:12:"rdfs:seeAlso";}s:4:"type";s:3:"rel";}s:10:"field_tags";a:2:{s:10:"predicates";a:1:{i:0;s:10:"dc:subject";}s:4:"type";s:3:"rel";}s:7:"rdftype";a:2:{i:0;s:9:"sioc:Item";i:1;s:13:"foaf:Document";}s:5:"title";a:1:{s:10:"predicates";a:1:{i:0;s:8:"dc:title";}}s:7:"created";a:3:{s:10:"predicates";a:2:{i:0;s:7:"dc:date";i:1;s:10:"dc:created";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}s:7:"changed";a:3:{s:10:"predicates";a:1:{i:0;s:11:"dc:modified";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}s:4:"body";a:1:{s:10:"predicates";a:1:{i:0;s:15:"content:encoded";}}s:3:"uid";a:2:{s:10:"predicates";a:1:{i:0;s:16:"sioc:has_creator";}s:4:"type";s:3:"rel";}s:4:"name";a:1:{s:10:"predicates";a:1:{i:0;s:9:"foaf:name";}}s:13:"comment_count";a:2:{s:10:"predicates";a:1:{i:0;s:16:"sioc:num_replies";}s:8:"datatype";s:11:"xsd:integer";}s:13:"last_activity";a:3:{s:10:"predicates";a:1:{i:0;s:23:"sioc:last_activity_date";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}}'),
('node', 'page', 'a:9:{s:7:"rdftype";a:1:{i:0;s:13:"foaf:Document";}s:5:"title";a:1:{s:10:"predicates";a:1:{i:0;s:8:"dc:title";}}s:7:"created";a:3:{s:10:"predicates";a:2:{i:0;s:7:"dc:date";i:1;s:10:"dc:created";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}s:7:"changed";a:3:{s:10:"predicates";a:1:{i:0;s:11:"dc:modified";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}s:4:"body";a:1:{s:10:"predicates";a:1:{i:0;s:15:"content:encoded";}}s:3:"uid";a:2:{s:10:"predicates";a:1:{i:0;s:16:"sioc:has_creator";}s:4:"type";s:3:"rel";}s:4:"name";a:1:{s:10:"predicates";a:1:{i:0;s:9:"foaf:name";}}s:13:"comment_count";a:2:{s:10:"predicates";a:1:{i:0;s:16:"sioc:num_replies";}s:8:"datatype";s:11:"xsd:integer";}s:13:"last_activity";a:3:{s:10:"predicates";a:1:{i:0;s:23:"sioc:last_activity_date";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}}'),
('node', 'poll', 'a:9:{s:7:"rdftype";a:2:{i:0;s:9:"sioc:Post";i:1;s:10:"sioct:Poll";}s:5:"title";a:1:{s:10:"predicates";a:1:{i:0;s:8:"dc:title";}}s:7:"created";a:3:{s:10:"predicates";a:2:{i:0;s:7:"dc:date";i:1;s:10:"dc:created";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}s:7:"changed";a:3:{s:10:"predicates";a:1:{i:0;s:11:"dc:modified";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}s:4:"body";a:1:{s:10:"predicates";a:1:{i:0;s:15:"content:encoded";}}s:3:"uid";a:2:{s:10:"predicates";a:1:{i:0;s:16:"sioc:has_creator";}s:4:"type";s:3:"rel";}s:4:"name";a:1:{s:10:"predicates";a:1:{i:0;s:9:"foaf:name";}}s:13:"comment_count";a:2:{s:10:"predicates";a:1:{i:0;s:16:"sioc:num_replies";}s:8:"datatype";s:11:"xsd:integer";}s:13:"last_activity";a:3:{s:10:"predicates";a:1:{i:0;s:23:"sioc:last_activity_date";}s:8:"datatype";s:12:"xsd:dateTime";s:8:"callback";s:12:"date_iso8601";}}');
/*!40000 ALTER TABLE rdf_mapping ENABLE KEYS */;

--
-- Table structure for table 'registry'
--

CREATE TABLE IF NOT EXISTS `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Each record is a function, class, or interface name and...';

--
-- Dumping data for table 'registry'
--

/*!40000 ALTER TABLE registry DISABLE KEYS */;
INSERT INTO `registry` VALUES
('AccessDeniedTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('AdminMetaTagTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('ArchiverInterface', 'interface', 'includes/archiver.inc', '', '0'),
('ArchiverTar', 'class', 'modules/system/system.archiver.inc', 'system', '0'),
('ArchiverZip', 'class', 'modules/system/system.archiver.inc', 'system', '0'),
('Archive_Tar', 'class', 'modules/system/system.tar.inc', 'system', '0'),
('BatchMemoryQueue', 'class', 'includes/batch.queue.inc', '', '0'),
('BatchQueue', 'class', 'includes/batch.queue.inc', '', '0'),
('BlockAdminThemeTestCase', 'class', 'modules/block/block.test', 'block', '0'),
('BlockCacheTestCase', 'class', 'modules/block/block.test', 'block', '0'),
('BlockHiddenRegionTestCase', 'class', 'modules/block/block.test', 'block', '0'),
('BlockHTMLIdTestCase', 'class', 'modules/block/block.test', 'block', '0'),
('BlockTemplateSuggestionsUnitTest', 'class', 'modules/block/block.test', 'block', '0'),
('BlockTestCase', 'class', 'modules/block/block.test', 'block', '0'),
('ColorTestCase', 'class', 'modules/color/color.test', 'color', '0'),
('CommentActionsTestCase', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentAnonymous', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentApprovalTest', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentBlockFunctionalTest', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentContentRebuild', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentController', 'class', 'modules/comment/comment.module', 'comment', '0'),
('CommentFieldsTest', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentHelperCase', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentInterfaceTest', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentNodeAccessTest', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentPagerTest', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentPreviewTest', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentRSSUnitTest', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CommentTokenReplaceTestCase', 'class', 'modules/comment/comment.test', 'comment', '0'),
('CronRunTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('DashboardBlocksTestCase', 'class', 'modules/dashboard/dashboard.test', 'dashboard', '0'),
('Database', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseCondition', 'class', 'includes/database/query.inc', '', '0'),
('DatabaseConnection', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseConnectionNotDefinedException', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseConnection_mysql', 'class', 'includes/database/mysql/database.inc', '', '0'),
('DatabaseConnection_pgsql', 'class', 'includes/database/pgsql/database.inc', '', '0'),
('DatabaseConnection_sqlite', 'class', 'includes/database/sqlite/database.inc', '', '0'),
('DatabaseDriverNotSpecifiedException', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseLog', 'class', 'includes/database/log.inc', '', '0'),
('DatabaseSchema', 'class', 'includes/database/schema.inc', '', '0'),
('DatabaseSchemaObjectDoesNotExistException', 'class', 'includes/database/schema.inc', '', '0'),
('DatabaseSchemaObjectExistsException', 'class', 'includes/database/schema.inc', '', '0'),
('DatabaseSchema_mysql', 'class', 'includes/database/mysql/schema.inc', '', '0'),
('DatabaseSchema_pgsql', 'class', 'includes/database/pgsql/schema.inc', '', '0'),
('DatabaseSchema_sqlite', 'class', 'includes/database/sqlite/schema.inc', '', '0'),
('DatabaseStatementBase', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseStatementEmpty', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseStatementInterface', 'interface', 'includes/database/database.inc', '', '0'),
('DatabaseStatementPrefetch', 'class', 'includes/database/prefetch.inc', '', '0'),
('DatabaseStatement_sqlite', 'class', 'includes/database/sqlite/database.inc', '', '0'),
('DatabaseTaskException', 'class', 'includes/install.inc', '', '0'),
('DatabaseTasks', 'class', 'includes/install.inc', '', '0'),
('DatabaseTasks_mysql', 'class', 'includes/database/mysql/install.inc', '', '0'),
('DatabaseTasks_pgsql', 'class', 'includes/database/pgsql/install.inc', '', '0'),
('DatabaseTasks_sqlite', 'class', 'includes/database/sqlite/install.inc', '', '0'),
('DatabaseTransaction', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseTransactionCommitFailedException', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseTransactionExplicitCommitNotAllowedException', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseTransactionNameNonUniqueException', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseTransactionNoActiveException', 'class', 'includes/database/database.inc', '', '0'),
('DatabaseTransactionOutOfOrderException', 'class', 'includes/database/database.inc', '', '0'),
('DateTimeFunctionalTest', 'class', 'modules/system/system.test', 'system', '0'),
('DBLogTestCase', 'class', 'modules/dblog/dblog.test', 'dblog', '0'),
('DefaultMailSystem', 'class', 'modules/system/system.mail.inc', 'system', '0'),
('DeleteQuery', 'class', 'includes/database/query.inc', '', '0'),
('DeleteQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', '0'),
('DevelMailLog', 'class', 'sites/all/modules/devel/devel.mail.inc', 'devel', '0'),
('DevelMailTest', 'class', 'sites/all/modules/devel/devel.test', 'devel', '0'),
('DrupalCacheArray', 'class', 'includes/bootstrap.inc', '', '0'),
('DrupalCacheInterface', 'interface', 'includes/cache.inc', '', '0'),
('DrupalDatabaseCache', 'class', 'includes/cache.inc', '', '0'),
('DrupalDefaultEntityController', 'class', 'includes/entity.inc', '', '0'),
('DrupalEntityControllerInterface', 'interface', 'includes/entity.inc', '', '0'),
('DrupalFakeCache', 'class', 'includes/cache-install.inc', '', '0'),
('DrupalLocalStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', '0'),
('DrupalPrivateStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', '0'),
('DrupalPublicStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', '0'),
('DrupalQueue', 'class', 'modules/system/system.queue.inc', 'system', '0'),
('DrupalQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', '0'),
('DrupalReliableQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', '0'),
('DrupalStreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', '0'),
('DrupalTemporaryStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', '0'),
('DrupalUpdateException', 'class', 'includes/update.inc', '', '0'),
('DrupalUpdaterInterface', 'interface', 'includes/updater.inc', '', '0'),
('EnableDisableTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('EntityFieldQuery', 'class', 'includes/entity.inc', '', '0'),
('EntityFieldQueryException', 'class', 'includes/entity.inc', '', '0'),
('EntityMalformedException', 'class', 'includes/entity.inc', '', '0'),
('EntityPropertiesTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldAttachOtherTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldAttachStorageTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldAttachTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldBulkDeleteTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldDisplayAPITestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldException', 'class', 'modules/field/field.module', 'field', '0'),
('FieldFormTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldInfoTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldInstanceCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldsOverlapException', 'class', 'includes/database/database.inc', '', '0'),
('FieldSqlStorageTestCase', 'class', 'modules/field/modules/field_sql_storage/field_sql_storage.test', 'field_sql_storage', '0'),
('FieldTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldTranslationsTestCase', 'class', 'modules/field/tests/field.test', 'field', '0'),
('FieldUIAlterTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', '0'),
('FieldUIManageDisplayTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', '0'),
('FieldUIManageFieldsTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', '0'),
('FieldUITestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', '0'),
('FieldUpdateForbiddenException', 'class', 'modules/field/field.module', 'field', '0'),
('FieldValidationException', 'class', 'modules/field/field.attach.inc', 'field', '0'),
('FileFieldDisplayTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FileFieldPathTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FileFieldRevisionTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FileFieldTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FileFieldValidateTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FileFieldWidgetTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FileManagedFileElementTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FilePrivateTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FileTokenReplaceTestCase', 'class', 'modules/file/tests/file.test', 'file', '0'),
('FileTransfer', 'class', 'includes/filetransfer/filetransfer.inc', '', '0'),
('FileTransferChmodInterface', 'interface', 'includes/filetransfer/filetransfer.inc', '', '0'),
('FileTransferException', 'class', 'includes/filetransfer/filetransfer.inc', '', '0'),
('FileTransferFTP', 'class', 'includes/filetransfer/ftp.inc', '', '0'),
('FileTransferFTPExtension', 'class', 'includes/filetransfer/ftp.inc', '', '0'),
('FileTransferLocal', 'class', 'includes/filetransfer/local.inc', '', '0'),
('FileTransferSSH', 'class', 'includes/filetransfer/ssh.inc', '', '0'),
('FilterAdminTestCase', 'class', 'modules/filter/filter.test', 'filter', '0'),
('FilterCRUDTestCase', 'class', 'modules/filter/filter.test', 'filter', '0'),
('FilterDefaultFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', '0'),
('FilterFormatAccessTestCase', 'class', 'modules/filter/filter.test', 'filter', '0'),
('FilterHooksTestCase', 'class', 'modules/filter/filter.test', 'filter', '0'),
('FilterNoFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', '0'),
('FilterSecurityTestCase', 'class', 'modules/filter/filter.test', 'filter', '0'),
('FilterUnitTestCase', 'class', 'modules/filter/filter.test', 'filter', '0'),
('FloodFunctionalTest', 'class', 'modules/system/system.test', 'system', '0'),
('FrontPageTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('HelpTestCase', 'class', 'modules/help/help.test', 'help', '0'),
('HookRequirementsTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('ImageAdminStylesUnitTest', 'class', 'modules/image/image.test', 'image', '0'),
('ImageDimensionsScaleTestCase', 'class', 'modules/image/image.test', 'image', '0'),
('ImageDimensionsUnitTest', 'class', 'modules/image/image.test', 'image', '0'),
('ImageEffectsUnitTest', 'class', 'modules/image/image.test', 'image', '0'),
('ImageFieldDisplayTestCase', 'class', 'modules/image/image.test', 'image', '0'),
('ImageFieldTestCase', 'class', 'modules/image/image.test', 'image', '0'),
('ImageFieldValidateTestCase', 'class', 'modules/image/image.test', 'image', '0'),
('ImageStylesPathAndUrlUnitTest', 'class', 'modules/image/image.test', 'image', '0'),
('InfoFileParserTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('InsertQuery', 'class', 'includes/database/query.inc', '', '0'),
('InsertQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', '0'),
('InsertQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', '0'),
('InsertQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', '0'),
('InvalidMergeQueryException', 'class', 'includes/database/database.inc', '', '0'),
('IPAddressBlockingTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('ListFieldTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', '0'),
('ListFieldUITestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', '0'),
('MailSystemInterface', 'interface', 'includes/mail.inc', '', '0'),
('MemoryQueue', 'class', 'modules/system/system.queue.inc', 'system', '0'),
('MenuNodeTestCase', 'class', 'modules/menu/menu.test', 'menu', '0'),
('MenuTestCase', 'class', 'modules/menu/menu.test', 'menu', '0'),
('MergeQuery', 'class', 'includes/database/query.inc', '', '0'),
('ModuleDependencyTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('ModuleRequiredTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('ModuleTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('ModuleUpdater', 'class', 'modules/system/system.updater.inc', 'system', '0'),
('ModuleVersionTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('MultiStepNodeFormBasicOptionsTest', 'class', 'modules/node/node.test', 'node', '0'),
('NewDefaultThemeBlocks', 'class', 'modules/block/block.test', 'block', '0'),
('NodeAccessBaseTableTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeAccessRebuildTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeAccessRecordsUnitTest', 'class', 'modules/node/node.test', 'node', '0'),
('NodeAccessUnitTest', 'class', 'modules/node/node.test', 'node', '0'),
('NodeAdminTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeBlockFunctionalTest', 'class', 'modules/node/node.test', 'node', '0'),
('NodeBlockTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeBuildContent', 'class', 'modules/node/node.test', 'node', '0'),
('NodeController', 'class', 'modules/node/node.module', 'node', '0'),
('NodeCreationTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeEntityFieldQueryAlter', 'class', 'modules/node/node.test', 'node', '0'),
('NodeFeedTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeLoadHooksTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeLoadMultipleUnitTest', 'class', 'modules/node/node.test', 'node', '0'),
('NodePostSettingsTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeQueryAlter', 'class', 'modules/node/node.test', 'node', '0'),
('NodeRevisionsTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeRSSContentTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeSaveTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeTitleTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeTitleXSSTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeTokenReplaceTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeTypePersistenceTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NodeTypeTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('NoFieldsException', 'class', 'includes/database/database.inc', '', '0'),
('NoHelpTestCase', 'class', 'modules/help/help.test', 'help', '0'),
('NonDefaultBlockAdmin', 'class', 'modules/block/block.test', 'block', '0'),
('NumberFieldTestCase', 'class', 'modules/field/modules/number/number.test', 'number', '0'),
('OptionsWidgetsTestCase', 'class', 'modules/field/modules/options/options.test', 'options', '0'),
('PageEditTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('PageNotFoundTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('PagePreviewTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('PagerDefault', 'class', 'includes/pager.inc', '', '0'),
('PageTitleFiltering', 'class', 'modules/system/system.test', 'system', '0'),
('PageViewTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('PathLanguageTestCase', 'class', 'modules/path/path.test', 'path', '0'),
('PathLanguageUITestCase', 'class', 'modules/path/path.test', 'path', '0'),
('PathMonolingualTestCase', 'class', 'modules/path/path.test', 'path', '0'),
('PathTaxonomyTermTestCase', 'class', 'modules/path/path.test', 'path', '0'),
('PathTestCase', 'class', 'modules/path/path.test', 'path', '0'),
('PollBlockTestCase', 'class', 'modules/poll/poll.test', 'poll', '0'),
('PollCreateTestCase', 'class', 'modules/poll/poll.test', 'poll', '0'),
('PollDeleteChoiceTestCase', 'class', 'modules/poll/poll.test', 'poll', '0'),
('PollExpirationTestCase', 'class', 'modules/poll/poll.test', 'poll', '0'),
('PollJSAddChoice', 'class', 'modules/poll/poll.test', 'poll', '0'),
('PollTestCase', 'class', 'modules/poll/poll.test', 'poll', '0'),
('PollTokenReplaceTestCase', 'class', 'modules/poll/poll.test', 'poll', '0'),
('PollVoteCheckHostname', 'class', 'modules/poll/poll.test', 'poll', '0'),
('PollVoteTestCase', 'class', 'modules/poll/poll.test', 'poll', '0'),
('Query', 'class', 'includes/database/query.inc', '', '0'),
('QueryAlterableInterface', 'interface', 'includes/database/query.inc', '', '0'),
('QueryConditionInterface', 'interface', 'includes/database/query.inc', '', '0'),
('QueryExtendableInterface', 'interface', 'includes/database/select.inc', '', '0'),
('QueryPlaceholderInterface', 'interface', 'includes/database/query.inc', '', '0'),
('QueueTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('RdfCommentAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0'),
('RdfCrudTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0'),
('RdfGetRdfNamespacesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0'),
('RdfMappingDefinitionTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0'),
('RdfMappingHookTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0'),
('RdfRdfaMarkupTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0'),
('RdfTrackerAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0'),
('RetrieveFileTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('SchemaCache', 'class', 'includes/bootstrap.inc', '', '0'),
('SearchAdvancedSearchForm', 'class', 'modules/search/search.test', 'search', '0'),
('SearchBlockTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchCommentCountToggleTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchCommentTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchConfigSettingsForm', 'class', 'modules/search/search.test', 'search', '0'),
('SearchEmbedForm', 'class', 'modules/search/search.test', 'search', '0'),
('SearchExactTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchExcerptTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchExpressionInsertExtractTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchKeywordsConditions', 'class', 'modules/search/search.test', 'search', '0'),
('SearchLanguageTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchMatchTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchNodeAccessTest', 'class', 'modules/search/search.test', 'search', '0'),
('SearchNumberMatchingTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchNumbersTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchPageOverride', 'class', 'modules/search/search.test', 'search', '0'),
('SearchPageText', 'class', 'modules/search/search.test', 'search', '0'),
('SearchQuery', 'class', 'modules/search/search.extender.inc', 'search', '0'),
('SearchRankingTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchSimplifyTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SearchTokenizerTestCase', 'class', 'modules/search/search.test', 'search', '0'),
('SelectQuery', 'class', 'includes/database/select.inc', '', '0'),
('SelectQueryExtender', 'class', 'includes/database/select.inc', '', '0'),
('SelectQueryInterface', 'interface', 'includes/database/select.inc', '', '0'),
('SelectQuery_pgsql', 'class', 'includes/database/pgsql/select.inc', '', '0'),
('SelectQuery_sqlite', 'class', 'includes/database/sqlite/select.inc', '', '0'),
('ShortcutLinksTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', '0'),
('ShortcutSetsTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', '0'),
('ShortcutTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', '0'),
('ShutdownFunctionsTest', 'class', 'modules/system/system.test', 'system', '0'),
('SiteMaintenanceTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('SkipDotsRecursiveDirectoryIterator', 'class', 'includes/filetransfer/filetransfer.inc', '', '0'),
('StreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', '0'),
('SummaryLengthTestCase', 'class', 'modules/node/node.test', 'node', '0'),
('SystemAdminTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('SystemAuthorizeCase', 'class', 'modules/system/system.test', 'system', '0'),
('SystemBlockTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('SystemIndexPhpTest', 'class', 'modules/system/system.test', 'system', '0'),
('SystemInfoAlterTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('SystemMainContentFallback', 'class', 'modules/system/system.test', 'system', '0'),
('SystemQueue', 'class', 'modules/system/system.queue.inc', 'system', '0'),
('SystemThemeFunctionalTest', 'class', 'modules/system/system.test', 'system', '0'),
('TableSort', 'class', 'includes/tablesort.inc', '', '0'),
('TaxonomyHooksTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyLegacyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyLoadMultipleUnitTest', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyTermController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', '0'),
('TaxonomyTermFieldTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyTermIndexTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyTermTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyTermUnitTest', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyThemeTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyTokenReplaceTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyVocabularyController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', '0'),
('TaxonomyVocabularyFunctionalTest', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyVocabularyUnitTest', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TaxonomyWebTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0'),
('TestingMailSystem', 'class', 'modules/system/system.mail.inc', 'system', '0'),
('TextFieldTestCase', 'class', 'modules/field/modules/text/text.test', 'text', '0'),
('TextSummaryTestCase', 'class', 'modules/field/modules/text/text.test', 'text', '0'),
('TextTranslationTestCase', 'class', 'modules/field/modules/text/text.test', 'text', '0'),
('ThemeRegistry', 'class', 'includes/theme.inc', '', '0'),
('ThemeUpdater', 'class', 'modules/system/system.updater.inc', 'system', '0'),
('TokenReplaceTestCase', 'class', 'modules/system/system.test', 'system', '0'),
('TruncateQuery', 'class', 'includes/database/query.inc', '', '0'),
('TruncateQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', '0'),
('TruncateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', '0'),
('UpdateQuery', 'class', 'includes/database/query.inc', '', '0'),
('UpdateQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', '0'),
('UpdateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', '0'),
('Updater', 'class', 'includes/updater.inc', '', '0'),
('UpdaterException', 'class', 'includes/updater.inc', '', '0'),
('UpdaterFileTransferException', 'class', 'includes/updater.inc', '', '0'),
('UpdateScriptFunctionalTest', 'class', 'modules/system/system.test', 'system', '0'),
('UserAccountLinksUnitTests', 'class', 'modules/user/user.test', 'user', '0'),
('UserAdminTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserAuthmapAssignmentTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserAutocompleteTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserBlocksUnitTests', 'class', 'modules/user/user.test', 'user', '0'),
('UserCancelTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserController', 'class', 'modules/user/user.module', 'user', '0'),
('UserCreateTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserEditedOwnAccountTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserEditTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserLoginTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserPermissionsTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserPictureTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserRegistrationTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserRoleAdminTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserRolesAssignmentTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserSaveTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserSignatureTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserTimeZoneFunctionalTest', 'class', 'modules/user/user.test', 'user', '0'),
('UserTokenReplaceTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserUserSearchTestCase', 'class', 'modules/user/user.test', 'user', '0'),
('UserValidateCurrentPassCustomForm', 'class', 'modules/user/user.test', 'user', '0'),
('UserValidationTestCase', 'class', 'modules/user/user.test', 'user', '0');
/*!40000 ALTER TABLE registry ENABLE KEYS */;

--
-- Table structure for table 'registry_file'
--

CREATE TABLE IF NOT EXISTS `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Files parsed to build the registry.';

--
-- Dumping data for table 'registry_file'
--

/*!40000 ALTER TABLE registry_file DISABLE KEYS */;
INSERT INTO `registry_file` VALUES
('includes/actions.inc', 'f36b066681463c7dfe189e0430cb1a89bf66f7e228cbb53cdfcd93987193f759'),
('includes/ajax.inc', 'e9c0653a0df32a81577d64980d74ef4f2423573b15fc86e9d7aa65227b52f470'),
('includes/archiver.inc', 'bdbb21b712a62f6b913590b609fd17cd9f3c3b77c0d21f68e71a78427ed2e3e9'),
('includes/authorize.inc', 'a8f26e722ddba490cdc0fcf80238af45f0f88e977b2e0c90c0c21d9df3380748'),
('includes/batch.inc', '059da9e36e1f3717f27840aae73f10dea7d6c8daf16f6520401cc1ca3b4c0388'),
('includes/batch.queue.inc', '554b2e92e1dad0f7fd5a19cb8dff7e109f10fbe2441a5692d076338ec908de0f'),
('includes/bootstrap.inc', '13dce2d47a624e417ab8cb325d8826d6777d55f5451d906d83045dfd0b8c1639'),
('includes/cache-install.inc', 'e7ed123c5805703c84ad2cce9c1ca46b3ce8caeeea0d8ef39a3024a4ab95fa0e'),
('includes/cache.inc', 'a8e3bc3affc37830d3a0b44e9049e2ba6893d0b0fbab451dd493c3c78a9d1a14'),
('includes/common.inc', '46763572f83a1e1181db34adb1f8a40ddb2cdde30db5757d7e98c8350dcf59c9'),
('includes/database/database.inc', '0c1112487b0c6232441a220d8cc5364019969aced844a5f030330fbe642d5c5b'),
('includes/database/log.inc', '4ecbdf9022d8c612310b41af575f10b0d4c041c0fbc41c6dc7e1f2ab6eacce6b'),
('includes/database/mysql/database.inc', 'b0f73402056edf41d3e9401df511d9179b708d1e21f1c367df45d4536c01f710'),
('includes/database/mysql/install.inc', '6ae316941f771732fbbabed7e1d6b4cbb41b1f429dd097d04b3345aa15e461a0'),
('includes/database/mysql/query.inc', 'e2a5457ec40a8f88f6a822bdc77f74865e4c02206fc733c2945c8897f46093de'),
('includes/database/mysql/schema.inc', 'f71af9dda287f0f37e7bd0077b801a6d3f38c951a9c2c6ea3b71dff1b69077d3'),
('includes/database/pgsql/database.inc', 'fa8b4f0f4997de02a34c47c5d8f38650e80e3a69d7e939b748fb4e789209e5b7'),
('includes/database/pgsql/install.inc', '585b80c5bbd6f134bff60d06397f15154657a577d4da8d1b181858905f09dea5'),
('includes/database/pgsql/query.inc', 'cb4c84f8f1ffc73098ed71137248dcd078a505a7530e60d979d74b3a3cdaa658'),
('includes/database/pgsql/schema.inc', '1442123ab5040a55797126cfa1cf9103f7a9df22b3c23b5055c9c27e4f12d262'),
('includes/database/pgsql/select.inc', 'ce06c4353d4322e519e1c90ca863e6666edc370fb3c12568fedf466334b2e2be'),
('includes/database/prefetch.inc', 'd32c8be47de08641f48327260d0df0dfa97543a2cd8902979bbe1586e273fee4'),
('includes/database/query.inc', 'd3cc668c48b938abe0283552053916fa076e0f877dfc36dc6368dda55791dd7a'),
('includes/database/schema.inc', '1996c5e11a984348f29baa6f19e9a995280828bdbbaa3e8c5d747dd28e93d7a2'),
('includes/database/select.inc', '80f33c7685b08a2f89178d82143225ade9bd464a8a5dac8bdff3b89f48270386'),
('includes/database/sqlite/database.inc', 'd90ddb4c457b27345a57e914c79267ab923466084230d4f21d2e290699e39d6a'),
('includes/database/sqlite/install.inc', '381f3db8c59837d961978ba3097bb6443534ed1659fd713aa563963fa0c42cc5'),
('includes/database/sqlite/query.inc', '61e0459c0c9252ca465b86c475d88e09ea34c8cdb28220eb37a7d44357f5474f'),
('includes/database/sqlite/schema.inc', '238414785aa96dd27f10f48c961783f4d1091392beee8d0e7ca8ae774e917da2'),
('includes/database/sqlite/select.inc', '4ecb9d21d2f07237f7603e925519886dde0b8da82f96999b865ff0803438744e'),
('includes/date.inc', '32124baa81a1411631de23ade5615be0d81bc7c7169ea60d22f9badd333cf284'),
('includes/entity.inc', 'ab7a4a5e133eb649370de9611f5224224985f167af4a407ecefc96b3600a491b'),
('includes/errors.inc', '24ed25ceed01f34ceaa01f3afa0ef17ba720dd55cda252ae2cd73efb8f7155bd'),
('includes/file.inc', 'b6fa05a6c21fe0b37e4c0c858d2acaece6ed457d60b285728916f303cba46fe3'),
('includes/file.mimetypes.inc', 'f88c967550576694b7a1ce2afd0f2f1bbc1a91d21cc2c20f86c44d39ff353867'),
('includes/filetransfer/filetransfer.inc', '4391b7228bd952fb351c9431a7c226b4e8a23d9a7307b9ffa63e097c17b25467'),
('includes/filetransfer/ftp.inc', '589ebf4b8bd4a2973aa56a156ac1fa83b6c73e703391361fb573167670e0d832'),
('includes/filetransfer/local.inc', '7cbfdb46abbdf539640db27e66fb30e5265128f31002bd0dfc3af16ae01a9492'),
('includes/filetransfer/ssh.inc', '002e24a24cac133d12728bd3843868ce378681237d7fad420761af84e6efe5ad'),
('includes/form.inc', '9a731e56d0aeaca2989b04dec95557fe1fa84e982e8d20b66fc4fbccbbdb43c7'),
('includes/graph.inc', '24809ef044b1779abb1125010c082680399e9f87cc88e3f3c1b3575d01257340'),
('includes/image.inc', '22c8ff48d46276b9bea1ad2cf4af9b65abcf69fb5ebca441259e774190fa5863'),
('includes/install.core.inc', 'a56ff7412d5fb68221a9f3bdd9f710d9f331f2d2c4bbb62ed98cb3c79c6882d5'),
('includes/install.inc', '23455f095ebd75c49ef8bf2a18145f77b6633670a5eb9eab860d907b0ba25f35'),
('includes/iso.inc', 'f53653843c75e12aa0b05e7197c5aebdf794e2517b9902fc07994fb7cb8f3ed6'),
('includes/json-encode.inc', '02a822a652d00151f79db9aa9e171c310b69b93a12f549bc2ce00533a8efa14e'),
('includes/language.inc', '5e0595c6def071694fa500b4636d15d482dafddb612a977201b5406b813be7a6'),
('includes/locale.inc', '65a378c399f7a9d583da378bf2bfb1eaf79d469701c1fa14ed071e8a01e952c6'),
('includes/lock.inc', 'daa62e95528f6b986b85680b600a896452bf2ce6f38921242857dcc5a3460a1b'),
('includes/mail.inc', 'bb50727f20717ffa17cbe11ddb27bd004bd814fc26115c3fca4b06f4cec179fa'),
('includes/menu.inc', '19fbd9d61c3fe511016b83ec38068e44b453bc74c3cee2a0f88f9534e975db88'),
('includes/module.inc', '496f4cb4f163a01f7236ded33587596ab166a3ca3fae9005df2a8f77b3b63808'),
('includes/pager.inc', '8ce2a8ff9c13b9a776712ec06ba0a06cfb87c27cb05f1b2947f514fdaf12fcee'),
('includes/password.inc', 'aba5df25a237c14cc69335c4cf72d57da130144410ab04d10917d9da21cd606c'),
('includes/path.inc', '895ddce7bcdcebf37cee1def1c5bac784f216a4a37719e28b448136249f8ece6'),
('includes/registry.inc', 'd7df0e1a8104d6f1466be2f2d8b9b1ca45e4e64b84da774a8609bb8f2e6bb3bd'),
('includes/session.inc', '07133a668c9103559099b5e6cd7f0178204c494770c384bb307e33f80b1f4c92'),
('includes/stream_wrappers.inc', '323e418fda2fdd29a44d8618f8855a92172c377eb745412d58ca55fdcaa8f2d1'),
('includes/tablesort.inc', '3f3cb2820920f7edc0c3d046ffba4fc4e3b73a699a2492780371141cf501aa50'),
('includes/theme.inc', 'a9df72af47876af3baa4802cc005f80c48b2bef94453ba9c90224fed7741976b'),
('includes/theme.maintenance.inc', 'd110314b4d943c3e965fcefe452f6873b53cd6a8844154467dfcbb2b6142dc82'),
('includes/token.inc', 'a975300558711bb49406a5c7f78294648baa2e5c912cb66f0c78bb2991c0f3c3'),
('includes/unicode.entities.inc', '2b858138596d961fbaa4c6e3986e409921df7f76b6ee1b109c4af5970f1e0f54'),
('includes/unicode.inc', '5409227091e55cef4c1b0bb9c159720aecaa07e7bf2683fe7c242691aa1036cc'),
('includes/update.inc', '2dac649d23b5d9a6b89d9c40b0c31ad682bf62af314baded14d08397b3d45ed9'),
('includes/updater.inc', '0574414b8be31dcadb49d4fe387b8f6ac989bddb0853a7207112ee9f50e47b4a'),
('includes/utility.inc', 'cfcc27d1d7537c9caf55cc06ef4a526b0526c29c2b5d955476322b36fee9ff19'),
('includes/xmlrpc.inc', 'c5b6ea78adeb135373d11aeaaea057d9fa8995faa4e8c0fec9b7c647f15cc4e0'),
('includes/xmlrpcs.inc', '79dc6e9882f4c506123d7dd8e228a61e22c46979c3aab21a5b1afa315ef6639c'),
('modules/block/block.test', '846852b1e8b36a3260e3e83f1bd42460771e0d2cb7f85bd2edfdb8be08d3e7b2'),
('modules/color/color.test', '013806279bd47ceb2f82ca854b57f880ba21058f7a2592c422afae881a7f5d15'),
('modules/comment/comment.module', '1a4a4538150af98d897e3204e2f274441d7ef32dfddb39e01481c1287ed0648c'),
('modules/comment/comment.test', '603ac28ee2d91ef04d73b9a18ff1ead5b6693467c305086e99efd209af76bd11'),
('modules/dashboard/dashboard.test', '0472cfe50d7f5f90ba6e55003bbb6a79d8cf4791f3d39740e2f1f3df65743d79'),
('modules/dblog/dblog.test', '8538535f68ac410003a9d0776915b4ca42e61f9fec848b4d65a79dc28a43d49c'),
('modules/field/field.attach.inc', 'ddb4a2a6c8114aaa993d875a23338ce2377b1b5ee3de15c494f8f0de16bbae9b'),
('modules/field/field.module', '34e127da0b251870bff7e240e299f18244792c3ba91161c61ad29fab72891340'),
('modules/field/modules/field_sql_storage/field_sql_storage.test', '8ede9843d771e307dfd3d7e7562976b07e0e0a9310a5cf409413581f199c897f'),
('modules/field/modules/list/tests/list.test', '5b2c194e6a62a82d7b162ee91a66c8175c4a40c842ba75f5f023a764e41507fc'),
('modules/field/modules/number/number.test', '2d8cf4f485ce54400b510b21f4414a04f0495bcad41185333ad6177975b00c65'),
('modules/field/modules/options/options.test', '2f2e15ab5e6da04033933af77663df220db3da30d0546327ef757968d628e43a'),
('modules/field/modules/text/text.test', '9d74c6d039f55dd7d6447a59186da8d48bf20617bfe58424612798f649797586'),
('modules/field/tests/field.test', '8235313617c78595bfe661ffdb91405794009fa6dd45cb646db70374028a6595'),
('modules/field_ui/field_ui.test', 'a51b63d55a873ef74c7f5a22c97415424a4357e47d8c6f59b8d37c9dfb10abc4'),
('modules/file/tests/file.test', 'f3297ce9cb46d818a7adcd50c44238e346c276d2b8cc4019189a5c017680d19d'),
('modules/filter/filter.test', 'd1c4f5c10917aa93b6cc1dab58a7f3a86fe4530d21d6c8e63a8fe58a7bd7487f'),
('modules/help/help.test', '957820f3f4fe14f8173644931685615a38c537ce432fcdba1d1dc26dd54395ed'),
('modules/image/image.test', '5ae681b9625025812376fd2b74cbc7df1e235a438e480661d0cd4efa4ce308df'),
('modules/menu/menu.test', 'b8ee602184584fab464900a946090dc1f3d81c15b8176004ee62022814632430'),
('modules/node/node.module', 'de612be547cff8ef31c3a7722c3dcee712559c340f11e460a0dad23cf51fdb4d'),
('modules/node/node.test', '08b48233c2ed842ac1a3de092ce25f6e8aada11e549729d8b512d3deedf5e60e'),
('modules/path/path.test', 'bf6a774f0d9b92a48d752eaa270f430ea21ce35e0c09da423442939ac56f9473'),
('modules/poll/poll.test', 'f955e487c8140d485b51b9bb0452d257f014853520e14c9ae058d117602b6e39'),
('modules/rdf/rdf.test', '358e2ae2069a15c6ba828f3428ab979632ece7aa0ba33a6a5bdbc1d065961373'),
('modules/search/search.extender.inc', 'fea036745113dca3fea52ba956af605c4789f4acfa2ab1650a5843c6e173d7fe'),
('modules/search/search.test', 'e90fa88b226b2ba86385ffca420aa49a64b71549d2cf9520943c60482c3d1064'),
('modules/shortcut/shortcut.test', 'b506a253353066e1f995e7f0e3541dadb8ef3c3ff9cf795db96e26599a0b6b7a'),
('modules/system/system.archiver.inc', 'faa849f3e646a910ab82fd6c8bbf0a4e6b8c60725d7ba81ec0556bd716616cd1'),
('modules/system/system.mail.inc', '3c2c06b55bded609e72add89db41af3bb405d42b9553793acba5fe51be8861d8'),
('modules/system/system.queue.inc', 'caf4feda51bdf7ad62cf782bc23274d367154e51897f2732f07bd06982d85ab1'),
('modules/system/system.tar.inc', '8a31d91f7b3cd7eac25b3fa46e1ed9a8527c39718ba76c3f8c0bbbeaa3aa4086'),
('modules/system/system.test', '813f2bedab3e93f61e86b386b9afffbb04e8e03d6b1d68a53a0339ca281c6e7a'),
('modules/system/system.updater.inc', 'e2eeed65b833a6215f807b113f6fb4cc3cc487e93efcb1402ed87c536d2c9ea6'),
('modules/taxonomy/taxonomy.module', '488147b91f19e9707499d6f1a5fe02a3ed8de956e37f7abffef742ece9780091'),
('modules/taxonomy/taxonomy.test', 'a45927b119d38b175c673b8a1f60319d9481fc01cafb943ac31ea978804434ba'),
('modules/user/user.module', '394c79feac46fe00fba2abd05ba47d9d16d7ad9875a3ba9d4dfaac4579c83627'),
('modules/user/user.test', '9b6cc136d3a267ad039069ac040f9ec33481ef43fd1fb888929750a076302c7c'),
('profiles/standard/standard.profile', '7237f80e54061c9611c6dc4fcf6225951eedba0704694f4d801673693ba11a05'),
('sites/all/modules/demo/database_mysql_dump.inc', 'c01e89e41321a7f15572f47a7fcc6aaf939e85d316d11b99f03e0b6de96183ff'),
('sites/all/modules/demo/demo.admin.inc', 'ff01e842171c749a39795823ef68003f217736c0b0cbc12dac4363813c93c82e'),
('sites/all/modules/demo/demo.module', 'd9b45ccbd366930a02d7d422a5408c79760e4fbf22e89407c4c4cb1e575c14eb'),
('sites/all/modules/demo/demo_reset.module', '067cef93fb16116e8f4ad70bd74e9466a9bd0060124fe800271c6ac822ffe19a'),
('sites/all/modules/devel/devel.mail.inc', 'dbdc696b3e023a588359ec1207ac6997e1abe425ed301d1b1513f68a0abcf9c2'),
('sites/all/modules/devel/devel.test', '7ee8668c46ce85c9307cf5f35ad2b18a0793dec8455114ee8c05eee36be76302'),
('sites/all/modules/module_filter/css/module_filter.css', '69609136efe52982305062cdf17756ad168aaf35920b7840ea1323e22b0ea0d0'),
('sites/all/modules/module_filter/css/module_filter_tab.css', '1789901bbb6bed007fff82895bf6d3ecfed7e237b408930c6c51a1c08e648487'),
('sites/all/modules/module_filter/js/module_filter.js', '90e47a6803c96a0e61219fd4e39e0e0055d7c8899d7cec2c23095d05e158c8a1'),
('sites/all/modules/module_filter/js/module_filter_tab.js', 'c0d5c3e74b1eaf0f9a85df654866c15539ffe3eac286a3947481dab8014f8081'),
('sites/all/modules/module_filter/module_filter.admin.inc', '30b1be9c743e4a4d468c2382cbe74666b45e50cfd9251deb0b1a149357c9d03a'),
('sites/all/modules/module_filter/module_filter.install', 'b05b0010641a06ed8f5d67403cae6c3a3a27aa687835b8f012136d3f68a3cbb3'),
('sites/all/modules/module_filter/module_filter.module', 'b84535147bd21ed59818d94c2f7aede7c75d8ea0b334c37d0b9f25912217a4aa'),
('sites/all/modules/module_filter/module_filter.theme.inc', '1f94a041fbdb8bbd6637a30b57d7aa9a171fdea61a4707eb3e2a0a08c0b497f0');
/*!40000 ALTER TABLE registry_file ENABLE KEYS */;

--
-- Table structure for table 'role'
--

CREATE TABLE IF NOT EXISTS `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores user roles.';

--
-- Dumping data for table 'role'
--

/*!40000 ALTER TABLE role DISABLE KEYS */;
INSERT INTO `role` VALUES
('3', 'administrator', '2'),
('1', 'anonymous user', '0'),
('2', 'authenticated user', '1');
/*!40000 ALTER TABLE role ENABLE KEYS */;

--
-- Table structure for table 'role_permission'
--

CREATE TABLE IF NOT EXISTS `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores the permissions assigned to user roles.';

--
-- Dumping data for table 'role_permission'
--

/*!40000 ALTER TABLE role_permission DISABLE KEYS */;
INSERT INTO `role_permission` VALUES
('1', 'access comments', 'comment'),
('1', 'access content', 'node'),
('1', 'use text format filtered_html', 'filter'),
('2', 'access comments', 'comment'),
('2', 'access content', 'node'),
('2', 'post comments', 'comment'),
('2', 'skip comment approval', 'comment'),
('2', 'use text format filtered_html', 'filter'),
('2', 'vote on polls', 'poll'),
('3', 'access administration pages', 'system'),
('3', 'access comments', 'comment'),
('3', 'access content', 'node'),
('3', 'access content overview', 'node'),
('3', 'access contextual links', 'contextual'),
('3', 'access dashboard', 'dashboard'),
('3', 'access devel information', 'devel'),
('3', 'access overlay', 'overlay'),
('3', 'access site in maintenance mode', 'system'),
('3', 'access site reports', 'system'),
('3', 'access toolbar', 'toolbar'),
('3', 'access user profiles', 'user'),
('3', 'administer actions', 'system'),
('3', 'administer blocks', 'block'),
('3', 'administer comments', 'comment'),
('3', 'administer content types', 'node'),
('3', 'administer demo settings', 'demo'),
('3', 'administer filters', 'filter'),
('3', 'administer image styles', 'image'),
('3', 'administer menu', 'menu'),
('3', 'administer module filter', 'module_filter'),
('3', 'administer modules', 'system'),
('3', 'administer nodes', 'node'),
('3', 'administer permissions', 'user'),
('3', 'administer search', 'search'),
('3', 'administer shortcuts', 'shortcut'),
('3', 'administer site configuration', 'system'),
('3', 'administer software updates', 'system'),
('3', 'administer taxonomy', 'taxonomy'),
('3', 'administer themes', 'system'),
('3', 'administer url aliases', 'path'),
('3', 'administer users', 'user'),
('3', 'block IP addresses', 'system'),
('3', 'bypass node access', 'node'),
('3', 'cancel account', 'user'),
('3', 'cancel own vote', 'poll'),
('3', 'change own username', 'user'),
('3', 'create article content', 'node'),
('3', 'create page content', 'node'),
('3', 'create url aliases', 'path'),
('3', 'customize shortcut links', 'shortcut'),
('3', 'delete any article content', 'node'),
('3', 'delete any page content', 'node'),
('3', 'delete own article content', 'node'),
('3', 'delete own page content', 'node'),
('3', 'delete revisions', 'node'),
('3', 'delete terms in 1', 'taxonomy'),
('3', 'edit any article content', 'node'),
('3', 'edit any page content', 'node'),
('3', 'edit own article content', 'node'),
('3', 'edit own comments', 'comment'),
('3', 'edit own page content', 'node'),
('3', 'edit terms in 1', 'taxonomy'),
('3', 'execute php code', 'devel'),
('3', 'inspect all votes', 'poll'),
('3', 'post comments', 'comment'),
('3', 'revert revisions', 'node'),
('3', 'search content', 'search'),
('3', 'select account cancellation method', 'user'),
('3', 'skip comment approval', 'comment'),
('3', 'switch shortcut sets', 'shortcut'),
('3', 'switch users', 'devel'),
('3', 'use advanced search', 'search'),
('3', 'use text format filtered_html', 'filter'),
('3', 'use text format full_html', 'filter'),
('3', 'view own unpublished content', 'node'),
('3', 'view revisions', 'node'),
('3', 'view the administration theme', 'system'),
('3', 'vote on polls', 'poll');
/*!40000 ALTER TABLE role_permission ENABLE KEYS */;

--
-- Table structure for table 'search_dataset'
--

CREATE TABLE IF NOT EXISTS `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores items that will be searched.';

--
-- Dumping data for table 'search_dataset'
--

/*!40000 ALTER TABLE search_dataset DISABLE KEYS */;
INSERT INTO `search_dataset` VALUES
('1', 'node', ' drupal high web site launched principal dries has commissioned this exciting new web site this web site is based on drupal the powerful cms with outstanding support for building a communitybased web site check back often as this web site will take off fast lorem ipsum dolor sit amet consectetuer adipiscing elit morbi commodo ipsum sed pharetra gravida orci magna rhoncus neque id pulvinar odio lorem non turpis nullam sit amet enim suspendisse id velit vitae ligula volutpat condimentum aliquam erat volutpat sed quis velit nulla facilisi nulla libero vivamus pharetra posuere sapien nam consectetuer sed aliquam nunc eget euismod ullamcorper lectus nunc ullamcorper orci fermentum bibendum enim nibh eget ipsum donec porttitor ligula eu dolor maecenas vitae nulla consequat libero cursus venenatis nam magna enim accumsan eu blandit sed blandit a eros quisque facilisis erat a dui nam malesuada ornare dolor cras gravida diam sit amet rhoncus ornare erat elit consectetuer erat id egestas pede nibh eget odio proin tincidunt velit vel porta elementum magna diam molestie sapien non aliquet massa pede eu diam aliquam iaculis fusce et ipsum et nulla tristique facilisis donec eget sem sit amet ligula viverra gravida etiam vehicula urna vel turpis suspendisse sagittis ante a urna morbi a est quis orci consequat rutrum nullam egestas feugiat felis integer adipiscing semper ligula nunc molestie nisl sit amet cursus convallis sapien lectus pretium metus vitae pretium enim wisi id lectus donec vestibulum etiam vel nibh nulla facilisi mauris pharetra donec augue  ', '0'),
('2', 'node', ' welcome returning students  principal dries here welcome to a new school year at drupal u we hope you are looking forward to the new year just as we are check back soon for more news and information we ll have information for students teachers and parents  db ', '1331585767'),
('3', 'node', ' about us placeholder for an about us page  ', '1331582175'),
('4', 'node', ' what is your favorite class  choices drupal intro theming 101 ninja development  ', '0');
/*!40000 ALTER TABLE search_dataset ENABLE KEYS */;

--
-- Table structure for table 'search_index'
--

CREATE TABLE IF NOT EXISTS `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores the search index, associating words, items and...';

--
-- Dumping data for table 'search_index'
--

/*!40000 ALTER TABLE search_index DISABLE KEYS */;
INSERT INTO `search_index` VALUES
('101', '4', 'node', '1'),
('about', '3', 'node', '27'),
('accumsan', '1', 'node', '1'),
('adipiscing', '1', 'node', '1.94209'),
('aliquam', '1', 'node', '3'),
('aliquet', '1', 'node', '1'),
('amet', '1', 'node', '4.91963'),
('and', '2', 'node', '2'),
('ante', '1', 'node', '0.96498'),
('are', '2', 'node', '2'),
('augue', '1', 'node', '0.913226'),
('back', '1', 'node', '1'),
('back', '2', 'node', '1'),
('based', '1', 'node', '1'),
('bibendum', '1', 'node', '1'),
('blandit', '1', 'node', '2'),
('building', '1', 'node', '1'),
('check', '1', 'node', '1'),
('check', '2', 'node', '1'),
('choices', '4', 'node', '1'),
('class', '4', 'node', '26'),
('cms', '1', 'node', '1'),
('commissioned', '1', 'node', '1'),
('commodo', '1', 'node', '1'),
('communitybased', '1', 'node', '1'),
('condimentum', '1', 'node', '1'),
('consectetuer', '1', 'node', '3'),
('consequat', '1', 'node', '1.95723'),
('convallis', '1', 'node', '0.934703'),
('cras', '1', 'node', '1'),
('cursus', '1', 'node', '1.9347'),
('development', '4', 'node', '1'),
('diam', '1', 'node', '3'),
('dolor', '1', 'node', '3'),
('donec', '1', 'node', '3.82252'),
('dries', '1', 'node', '1'),
('dries', '2', 'node', '4'),
('drupal', '1', 'node', '27'),
('drupal', '2', 'node', '1'),
('drupal', '4', 'node', '1'),
('dui', '1', 'node', '1'),
('egestas', '1', 'node', '1.9534'),
('eget', '1', 'node', '3.98902'),
('elementum', '1', 'node', '1'),
('elit', '1', 'node', '2'),
('enim', '1', 'node', '3.92384'),
('erat', '1', 'node', '4'),
('eros', '1', 'node', '1'),
('est', '1', 'node', '0.961087'),
('etiam', '1', 'node', '1.89761'),
('euismod', '1', 'node', '1'),
('exciting', '1', 'node', '1'),
('facilisi', '1', 'node', '1.91674'),
('facilisis', '1', 'node', '1.98902'),
('fast', '1', 'node', '1'),
('favorite', '4', 'node', '26'),
('felis', '1', 'node', '0.949597'),
('fermentum', '1', 'node', '1'),
('feugiat', '1', 'node', '0.953396'),
('for', '1', 'node', '1'),
('for', '2', 'node', '2'),
('for', '3', 'node', '1'),
('forward', '2', 'node', '1'),
('fusce', '1', 'node', '0.997306'),
('gravida', '1', 'node', '2.98087'),
('has', '1', 'node', '1'),
('have', '2', 'node', '1'),
('here', '2', 'node', '1'),
('high', '1', 'node', '26'),
('hope', '2', 'node', '1'),
('iaculis', '1', 'node', '1'),
('information', '2', 'node', '2'),
('integer', '1', 'node', '0.945829'),
('intro', '4', 'node', '1'),
('ipsum', '1', 'node', '3.99315'),
('just', '2', 'node', '1'),
('launched', '1', 'node', '26'),
('lectus', '1', 'node', '2.85133'),
('libero', '1', 'node', '2'),
('ligula', '1', 'node', '3.92331'),
('looking', '2', 'node', '1'),
('lorem', '1', 'node', '2'),
('maecenas', '1', 'node', '1'),
('magna', '1', 'node', '3'),
('malesuada', '1', 'node', '1'),
('massa', '1', 'node', '1'),
('mauris', '1', 'node', '0.916736'),
('metus', '1', 'node', '0.927431'),
('molestie', '1', 'node', '1.93838'),
('morbi', '1', 'node', '1.96109'),
('more', '2', 'node', '1'),
('nam', '1', 'node', '3'),
('neque', '1', 'node', '1'),
('new', '1', 'node', '1'),
('new', '2', 'node', '2'),
('news', '2', 'node', '1'),
('nibh', '1', 'node', '2.91674'),
('ninja', '4', 'node', '1'),
('nisl', '1', 'node', '0.938382'),
('non', '1', 'node', '2'),
('nulla', '1', 'node', '4.90988'),
('nullam', '1', 'node', '1.9534'),
('nunc', '1', 'node', '2.93838'),
('odio', '1', 'node', '2'),
('off', '1', 'node', '1'),
('often', '1', 'node', '1'),
('orci', '1', 'node', '2.95723'),
('ornare', '1', 'node', '2'),
('outstanding', '1', 'node', '1'),
('page', '3', 'node', '1'),
('parents', '2', 'node', '1'),
('pede', '1', 'node', '2'),
('pharetra', '1', 'node', '2.91323'),
('placeholder', '3', 'node', '1'),
('porta', '1', 'node', '1'),
('porttitor', '1', 'node', '1'),
('posuere', '1', 'node', '1'),
('powerful', '1', 'node', '1'),
('pretium', '1', 'node', '1.85489'),
('principal', '1', 'node', '1'),
('principal', '2', 'node', '4'),
('proin', '1', 'node', '1'),
('pulvinar', '1', 'node', '1'),
('quis', '1', 'node', '1.95723'),
('quisque', '1', 'node', '1'),
('returning', '2', 'node', '26'),
('rhoncus', '1', 'node', '2'),
('rutrum', '1', 'node', '0.957226'),
('sagittis', '1', 'node', '0.968904'),
('sapien', '1', 'node', '2.93105'),
('school', '2', 'node', '1'),
('sed', '1', 'node', '4'),
('sem', '1', 'node', '0.989021'),
('semper', '1', 'node', '0.942091'),
('sit', '1', 'node', '4.91963'),
('site', '1', 'node', '30'),
('soon', '2', 'node', '1'),
('students', '2', 'node', '27'),
('support', '1', 'node', '1'),
('suspendisse', '1', 'node', '1.9689'),
('take', '1', 'node', '1'),
('teachers', '2', 'node', '1'),
('the', '1', 'node', '1'),
('the', '2', 'node', '1'),
('theming', '4', 'node', '1'),
('this', '1', 'node', '3'),
('tincidunt', '1', 'node', '1'),
('tristique', '1', 'node', '0.993146'),
('turpis', '1', 'node', '1.9689'),
('ullamcorper', '1', 'node', '2'),
('urna', '1', 'node', '1.93395'),
('vehicula', '1', 'node', '0.976851'),
('vel', '1', 'node', '2.88564'),
('velit', '1', 'node', '3'),
('venenatis', '1', 'node', '1'),
('vestibulum', '1', 'node', '0.920273'),
('vitae', '1', 'node', '2.92384'),
('vivamus', '1', 'node', '1'),
('viverra', '1', 'node', '0.98493'),
('volutpat', '1', 'node', '2'),
('web', '1', 'node', '30'),
('welcome', '2', 'node', '27'),
('what', '4', 'node', '26'),
('will', '1', 'node', '1'),
('wisi', '1', 'node', '0.923838'),
('with', '1', 'node', '1'),
('year', '2', 'node', '2'),
('you', '2', 'node', '1'),
('your', '4', 'node', '26');
/*!40000 ALTER TABLE search_index ENABLE KEYS */;

--
-- Table structure for table 'search_node_links'
--

CREATE TABLE IF NOT EXISTS `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores items (like nodes) that link to other nodes, used...';

--
-- Dumping data for table 'search_node_links'
--

/*!40000 ALTER TABLE search_node_links DISABLE KEYS */;
/*!40000 ALTER TABLE search_node_links ENABLE KEYS */;

--
-- Table structure for table 'search_total'
--

CREATE TABLE IF NOT EXISTS `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores search totals for words.';

--
-- Dumping data for table 'search_total'
--

/*!40000 ALTER TABLE search_total DISABLE KEYS */;
INSERT INTO `search_total` VALUES
('101', '0.30103'),
('about', '0.0157943'),
('accumsan', '0.30103'),
('adipiscing', '0.180387'),
('aliquam', '0.124939'),
('aliquet', '0.30103'),
('amet', '0.0803621'),
('and', '0.176091'),
('ante', '0.30103'),
('are', '0.176091'),
('augue', '0.30103'),
('back', '0.176091'),
('based', '0.30103'),
('bibendum', '0.30103'),
('blandit', '0.176091'),
('building', '0.30103'),
('check', '0.176091'),
('choices', '0.30103'),
('class', '0.0163904'),
('cms', '0.30103'),
('commissioned', '0.30103'),
('commodo', '0.30103'),
('communitybased', '0.30103'),
('condimentum', '0.30103'),
('consectetuer', '0.124939'),
('consequat', '0.179244'),
('convallis', '0.30103'),
('cras', '0.30103'),
('cursus', '0.18095'),
('development', '0.30103'),
('diam', '0.124939'),
('dolor', '0.124939'),
('donec', '0.100924'),
('dries', '0.0791812'),
('drupal', '0.0147233'),
('dui', '0.30103'),
('egestas', '0.179531'),
('eget', '0.097149'),
('elementum', '0.30103'),
('elit', '0.176091'),
('enim', '0.0985927'),
('erat', '0.09691'),
('eros', '0.30103'),
('est', '0.30103'),
('etiam', '0.183833'),
('euismod', '0.30103'),
('exciting', '0.30103'),
('facilisi', '0.182335'),
('facilisis', '0.17689'),
('fast', '0.30103'),
('favorite', '0.0163904'),
('felis', '0.30103'),
('fermentum', '0.30103'),
('feugiat', '0.30103'),
('for', '0.09691'),
('forward', '0.30103'),
('fusce', '0.30103'),
('gravida', '0.125635'),
('has', '0.30103'),
('have', '0.30103'),
('here', '0.30103'),
('high', '0.0163904'),
('hope', '0.30103'),
('iaculis', '0.30103'),
('information', '0.176091'),
('integer', '0.30103'),
('intro', '0.30103'),
('ipsum', '0.0970591'),
('just', '0.30103'),
('launched', '0.0163904'),
('lectus', '0.130563'),
('libero', '0.176091'),
('ligula', '0.0986045'),
('looking', '0.30103'),
('lorem', '0.176091'),
('maecenas', '0.30103'),
('magna', '0.124939'),
('malesuada', '0.30103'),
('massa', '0.30103'),
('mauris', '0.30103'),
('metus', '0.30103'),
('molestie', '0.180669'),
('morbi', '0.178954'),
('more', '0.30103'),
('nam', '0.124939'),
('neque', '0.30103'),
('new', '0.124939'),
('news', '0.30103'),
('nibh', '0.128027'),
('ninja', '0.30103'),
('nisl', '0.30103'),
('non', '0.176091'),
('nulla', '0.0805078'),
('nullam', '0.179531'),
('nunc', '0.12721'),
('odio', '0.176091'),
('off', '0.30103'),
('often', '0.30103'),
('orci', '0.126506'),
('ornare', '0.176091'),
('outstanding', '0.30103'),
('page', '0.30103'),
('parents', '0.30103'),
('pede', '0.176091'),
('pharetra', '0.128161'),
('placeholder', '0.30103'),
('porta', '0.30103'),
('porttitor', '0.30103'),
('posuere', '0.30103'),
('powerful', '0.30103'),
('pretium', '0.187271'),
('principal', '0.0791812'),
('proin', '0.30103'),
('pulvinar', '0.30103'),
('quis', '0.179244'),
('quisque', '0.30103'),
('returning', '0.0163904'),
('rhoncus', '0.176091'),
('rutrum', '0.30103'),
('sagittis', '0.30103'),
('sapien', '0.127485'),
('school', '0.30103'),
('sed', '0.09691'),
('sem', '0.30103'),
('semper', '0.30103'),
('sit', '0.0803621'),
('site', '0.0142404'),
('soon', '0.30103'),
('students', '0.0157943'),
('support', '0.30103'),
('suspendisse', '0.178372'),
('take', '0.30103'),
('teachers', '0.30103'),
('the', '0.176091'),
('theming', '0.30103'),
('this', '0.124939'),
('tincidunt', '0.30103'),
('tristique', '0.30103'),
('turpis', '0.178372'),
('ullamcorper', '0.176091'),
('urna', '0.181008'),
('vehicula', '0.30103'),
('vel', '0.12922'),
('velit', '0.124939'),
('venenatis', '0.30103'),
('vestibulum', '0.30103'),
('vitae', '0.127758'),
('vivamus', '0.30103'),
('viverra', '0.30103'),
('volutpat', '0.176091'),
('web', '0.0142404'),
('welcome', '0.0157943'),
('what', '0.0163904'),
('will', '0.30103'),
('wisi', '0.30103'),
('with', '0.30103'),
('year', '0.176091'),
('you', '0.30103'),
('your', '0.0163904');
/*!40000 ALTER TABLE search_total ENABLE KEYS */;

--
-- Table structure for table 'semaphore'
--

CREATE TABLE IF NOT EXISTS `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Table for holding semaphores, locks, flags, etc. that...';

--
-- Dumping data for table 'semaphore'
--

/*!40000 ALTER TABLE semaphore DISABLE KEYS */;
/*!40000 ALTER TABLE semaphore ENABLE KEYS */;

--
-- Table structure for table 'sequences'
--

CREATE TABLE IF NOT EXISTS `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores IDs.';

--
-- Dumping data for table 'sequences'
--

/*!40000 ALTER TABLE sequences DISABLE KEYS */;
INSERT INTO `sequences` VALUES
('1');
/*!40000 ALTER TABLE sequences ENABLE KEYS */;

--
-- Table structure for table 'sessions'
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Drupal’s session handlers read and write into the...';

--
-- Dumping data for table 'sessions'
--

/*!40000 ALTER TABLE sessions DISABLE KEYS */;
INSERT INTO `sessions` VALUES
('1', 'XbEKUEsh1RBbZlsX4cIi2alARs1uqdn1QOZl3Nh2-mI', '', '208.73.113.6', '1331586415', '0', 'node_overview_filter|a:1:{i:0;a:2:{i:0;s:4:"type";i:1;s:7:"article";}}');
/*!40000 ALTER TABLE sessions ENABLE KEYS */;

--
-- Table structure for table 'shortcut_set'
--

CREATE TABLE IF NOT EXISTS `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores information about sets of shortcuts links.';

--
-- Dumping data for table 'shortcut_set'
--

/*!40000 ALTER TABLE shortcut_set DISABLE KEYS */;
INSERT INTO `shortcut_set` VALUES
('shortcut-set-1', 'Default');
/*!40000 ALTER TABLE shortcut_set ENABLE KEYS */;

--
-- Table structure for table 'shortcut_set_users'
--

CREATE TABLE IF NOT EXISTS `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Maps users to shortcut sets.';

--
-- Dumping data for table 'shortcut_set_users'
--

/*!40000 ALTER TABLE shortcut_set_users DISABLE KEYS */;
/*!40000 ALTER TABLE shortcut_set_users ENABLE KEYS */;

--
-- Table structure for table 'system'
--

CREATE TABLE IF NOT EXISTS `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of all modules, themes, and theme engines that are...';

--
-- Dumping data for table 'system'
--

/*!40000 ALTER TABLE system DISABLE KEYS */;
INSERT INTO `system` VALUES
('modules/aggregator/aggregator.module', 'aggregator', 'module', '', '0', '0', -1, '0', 'a:13:{s:4:"name";s:10:"Aggregator";s:11:"description";s:57:"Aggregates syndicated content (RSS, RDF, and Atom feeds).";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:15:"aggregator.test";}s:9:"configure";s:41:"admin/config/services/aggregator/settings";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:14:"aggregator.css";s:33:"modules/aggregator/aggregator.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/aggregator/tests/aggregator_test.module', 'aggregator_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:23:"Aggregator module tests";s:11:"description";s:46:"Support module for aggregator related testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/block/block.module', 'block', 'module', '', '1', '0', 7008, '-5', 'a:12:{s:4:"name";s:5:"Block";s:11:"description";s:140:"Controls the visual building blocks a page is constructed with. Blocks are boxes of content rendered into an area, or region, of a web page.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:10:"block.test";}s:9:"configure";s:21:"admin/structure/block";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/block/tests/block_test.module', 'block_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:10:"Block test";s:11:"description";s:21:"Provides test blocks.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/blog/blog.module', 'blog', 'module', '', '0', '0', -1, '0', 'a:11:{s:4:"name";s:4:"Blog";s:11:"description";s:25:"Enables multi-user blogs.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:9:"blog.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/book/book.module', 'book', 'module', '', '0', '0', -1, '0', 'a:13:{s:4:"name";s:4:"Book";s:11:"description";s:66:"Allows users to create and organize related content in an outline.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:9:"book.test";}s:9:"configure";s:27:"admin/content/book/settings";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:8:"book.css";s:21:"modules/book/book.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/color/color.module', 'color', 'module', '', '1', '0', 7001, '0', 'a:11:{s:4:"name";s:5:"Color";s:11:"description";s:70:"Allows administrators to change the color scheme of compatible themes.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:10:"color.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/comment/comment.module', 'comment', 'module', '', '1', '0', 7009, '0', 'a:13:{s:4:"name";s:7:"Comment";s:11:"description";s:57:"Allows users to comment on and discuss published content.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:4:"text";}s:5:"files";a:2:{i:0;s:14:"comment.module";i:1;s:12:"comment.test";}s:9:"configure";s:21:"admin/content/comment";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:11:"comment.css";s:27:"modules/comment/comment.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/contact/contact.module', 'contact', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:7:"Contact";s:11:"description";s:61:"Enables the use of both personal and site-wide contact forms.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:12:"contact.test";}s:9:"configure";s:23:"admin/structure/contact";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/contextual/contextual.module', 'contextual', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:16:"Contextual links";s:11:"description";s:75:"Provides contextual links to perform actions related to elements on a page.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/dashboard/dashboard.module', 'dashboard', 'module', '', '1', '0', 0, '0', 'a:12:{s:4:"name";s:9:"Dashboard";s:11:"description";s:136:"Provides a dashboard page in the administrative interface for organizing administrative tasks and tracking information within your site.";s:4:"core";s:3:"7.x";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:5:"files";a:1:{i:0;s:14:"dashboard.test";}s:12:"dependencies";a:1:{i:0;s:5:"block";}s:9:"configure";s:25:"admin/dashboard/customize";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/dblog/dblog.module', 'dblog', 'module', '', '1', '1', 7001, '0', 'a:11:{s:4:"name";s:16:"Database logging";s:11:"description";s:47:"Logs and records system events to the database.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:10:"dblog.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/field/field.module', 'field', 'module', '', '1', '0', 7001, '0', 'a:13:{s:4:"name";s:5:"Field";s:11:"description";s:57:"Field API to add fields to entities like nodes and users.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:3:{i:0;s:12:"field.module";i:1;s:16:"field.attach.inc";i:2;s:16:"tests/field.test";}s:12:"dependencies";a:1:{i:0;s:17:"field_sql_storage";}s:8:"required";b:1;s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:15:"theme/field.css";s:29:"modules/field/theme/field.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/field/modules/field_sql_storage/field_sql_storage.module', 'field_sql_storage', 'module', '', '1', '0', 7002, '0', 'a:12:{s:4:"name";s:17:"Field SQL storage";s:11:"description";s:37:"Stores field data in an SQL database.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:5:"field";}s:5:"files";a:1:{i:0;s:22:"field_sql_storage.test";}s:8:"required";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/field/modules/list/list.module', 'list', 'module', '', '1', '0', 7002, '0', 'a:11:{s:4:"name";s:4:"List";s:11:"description";s:69:"Defines list field types. Use with Options to create selection lists.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:2:{i:0;s:5:"field";i:1;s:7:"options";}s:5:"files";a:1:{i:0;s:15:"tests/list.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/field/modules/list/tests/list_test.module', 'list_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:9:"List test";s:11:"description";s:41:"Support module for the List module tests.";s:4:"core";s:3:"7.x";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/field/modules/number/number.module', 'number', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:6:"Number";s:11:"description";s:28:"Defines numeric field types.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:5:"field";}s:5:"files";a:1:{i:0;s:11:"number.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/field/modules/options/options.module', 'options', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:7:"Options";s:11:"description";s:82:"Defines selection, check box and radio button widgets for text and numeric fields.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:5:"field";}s:5:"files";a:1:{i:0;s:12:"options.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/field/modules/text/text.module', 'text', 'module', '', '1', '0', 7000, '0', 'a:13:{s:4:"name";s:4:"Text";s:11:"description";s:32:"Defines simple text field types.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:5:"field";}s:5:"files";a:1:{i:0;s:9:"text.test";}s:8:"required";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;s:11:"explanation";s:73:"Field type(s) in use - see <a href="/admin/reports/fields">Field list</a>";}'),
('modules/field/tests/field_test.module', 'field_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:14:"Field API Test";s:11:"description";s:39:"Support module for the Field API tests.";s:4:"core";s:3:"7.x";s:7:"package";s:7:"Testing";s:5:"files";a:1:{i:0;s:21:"field_test.entity.inc";}s:7:"version";s:4:"7.12";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/field_ui/field_ui.module', 'field_ui', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:8:"Field UI";s:11:"description";s:33:"User interface for the Field API.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:5:"field";}s:5:"files";a:1:{i:0;s:13:"field_ui.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/file/file.module', 'file', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:4:"File";s:11:"description";s:26:"Defines a file field type.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:5:"field";}s:5:"files";a:1:{i:0;s:15:"tests/file.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/file/tests/file_module_test.module', 'file_module_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:9:"File test";s:11:"description";s:53:"Provides hooks for testing File module functionality.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/filter/filter.module', 'filter', 'module', '', '1', '0', 7010, '0', 'a:13:{s:4:"name";s:6:"Filter";s:11:"description";s:43:"Filters content in preparation for display.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:11:"filter.test";}s:8:"required";b:1;s:9:"configure";s:28:"admin/config/content/formats";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/forum/forum.module', 'forum', 'module', '', '0', '0', -1, '0', 'a:13:{s:4:"name";s:5:"Forum";s:11:"description";s:27:"Provides discussion forums.";s:12:"dependencies";a:2:{i:0;s:8:"taxonomy";i:1;s:7:"comment";}s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:10:"forum.test";}s:9:"configure";s:21:"admin/structure/forum";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:9:"forum.css";s:23:"modules/forum/forum.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/help/help.module', 'help', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:4:"Help";s:11:"description";s:35:"Manages the display of online help.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:9:"help.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/image/image.module', 'image', 'module', '', '1', '0', 7004, '0', 'a:14:{s:4:"name";s:5:"Image";s:11:"description";s:34:"Provides image manipulation tools.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:4:"file";}s:5:"files";a:1:{i:0;s:10:"image.test";}s:9:"configure";s:31:"admin/config/media/image-styles";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;s:8:"required";b:1;s:11:"explanation";s:73:"Field type(s) in use - see <a href="/admin/reports/fields">Field list</a>";}'),
('modules/image/tests/image_module_test.module', 'image_module_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:10:"Image test";s:11:"description";s:69:"Provides hook implementations for testing Image module functionality.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:24:"image_module_test.module";}s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/locale/locale.module', 'locale', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:6:"Locale";s:11:"description";s:119:"Adds language handling functionality and enables the translation of the user interface to languages other than English.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:11:"locale.test";}s:9:"configure";s:30:"admin/config/regional/language";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/locale/tests/locale_test.module', 'locale_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:11:"Locale Test";s:11:"description";s:42:"Support module for the locale layer tests.";s:4:"core";s:3:"7.x";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/menu/menu.module', 'menu', 'module', '', '1', '0', 7003, '0', 'a:12:{s:4:"name";s:4:"Menu";s:11:"description";s:60:"Allows administrators to customize the site navigation menu.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:9:"menu.test";}s:9:"configure";s:20:"admin/structure/menu";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/node/node.module', 'node', 'module', '', '1', '0', 7012, '0', 'a:14:{s:4:"name";s:4:"Node";s:11:"description";s:66:"Allows content to be submitted to the site and displayed on pages.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:2:{i:0;s:11:"node.module";i:1;s:9:"node.test";}s:8:"required";b:1;s:9:"configure";s:21:"admin/structure/types";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:8:"node.css";s:21:"modules/node/node.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/node/tests/node_access_test.module', 'node_access_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:24:"Node module access tests";s:11:"description";s:43:"Support module for node permission testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/node/tests/node_test.module', 'node_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:17:"Node module tests";s:11:"description";s:40:"Support module for node related testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/node/tests/node_test_exception.module', 'node_test_exception', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:27:"Node module exception tests";s:11:"description";s:50:"Support module for node related exception testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/openid/openid.module', 'openid', 'module', '', '0', '0', -1, '0', 'a:11:{s:4:"name";s:6:"OpenID";s:11:"description";s:48:"Allows users to log into your site using OpenID.";s:7:"version";s:4:"7.12";s:7:"package";s:4:"Core";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:11:"openid.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/openid/tests/openid_test.module', 'openid_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:21:"OpenID dummy provider";s:11:"description";s:33:"OpenID provider used for testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:6:"openid";}s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/overlay/overlay.module', 'overlay', 'module', '', '1', '1', 0, '0', 'a:11:{s:4:"name";s:7:"Overlay";s:11:"description";s:59:"Displays the Drupal administration interface in an overlay.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/path/path.module', 'path', 'module', '', '1', '0', 0, '0', 'a:12:{s:4:"name";s:4:"Path";s:11:"description";s:28:"Allows users to rename URLs.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:9:"path.test";}s:9:"configure";s:24:"admin/config/search/path";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/php/php.module', 'php', 'module', '', '0', '0', -1, '0', 'a:11:{s:4:"name";s:10:"PHP filter";s:11:"description";s:50:"Allows embedded PHP code/snippets to be evaluated.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:8:"php.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/poll/poll.module', 'poll', 'module', '', '1', '0', 7004, '0', 'a:12:{s:4:"name";s:4:"Poll";s:11:"description";s:95:"Allows your site to capture votes on different topics in the form of multiple choice questions.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:9:"poll.test";}s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:8:"poll.css";s:21:"modules/poll/poll.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/profile/profile.module', 'profile', 'module', '', '0', '0', -1, '0', 'a:13:{s:4:"name";s:7:"Profile";s:11:"description";s:36:"Supports configurable user profiles.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:12:"profile.test";}s:9:"configure";s:27:"admin/config/people/profile";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/rdf/rdf.module', 'rdf', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:3:"RDF";s:11:"description";s:148:"Enriches your content with metadata to let other applications (e.g. search engines, aggregators) better understand its relationships and attributes.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:8:"rdf.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/rdf/tests/rdf_test.module', 'rdf_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:16:"RDF module tests";s:11:"description";s:38:"Support module for RDF module testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/search/search.module', 'search', 'module', '', '1', '0', 7000, '0', 'a:13:{s:4:"name";s:6:"Search";s:11:"description";s:36:"Enables site-wide keyword searching.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:2:{i:0;s:19:"search.extender.inc";i:1;s:11:"search.test";}s:9:"configure";s:28:"admin/config/search/settings";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:10:"search.css";s:25:"modules/search/search.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/search/tests/search_embedded_form.module', 'search_embedded_form', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:20:"Search embedded form";s:11:"description";s:59:"Support module for search module testing of embedded forms.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/search/tests/search_extra_type.module', 'search_extra_type', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:16:"Test search type";s:11:"description";s:41:"Support module for search module testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/shortcut/shortcut.module', 'shortcut', 'module', '', '1', '0', 0, '0', 'a:12:{s:4:"name";s:8:"Shortcut";s:11:"description";s:60:"Allows users to manage customizable lists of shortcut links.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:13:"shortcut.test";}s:9:"configure";s:36:"admin/config/user-interface/shortcut";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/simpletest/simpletest.module', 'simpletest', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:7:"Testing";s:11:"description";s:53:"Provides a framework for unit and functional testing.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:42:{i:0;s:15:"simpletest.test";i:1;s:24:"drupal_web_test_case.php";i:2;s:18:"tests/actions.test";i:3;s:15:"tests/ajax.test";i:4;s:16:"tests/batch.test";i:5;s:20:"tests/bootstrap.test";i:6;s:16:"tests/cache.test";i:7;s:17:"tests/common.test";i:8;s:24:"tests/database_test.test";i:9;s:32:"tests/entity_crud_hook_test.test";i:10;s:23:"tests/entity_query.test";i:11;s:16:"tests/error.test";i:12;s:15:"tests/file.test";i:13;s:23:"tests/filetransfer.test";i:14;s:15:"tests/form.test";i:15;s:16:"tests/graph.test";i:16;s:16:"tests/image.test";i:17;s:15:"tests/lock.test";i:18;s:15:"tests/mail.test";i:19;s:15:"tests/menu.test";i:20;s:17:"tests/module.test";i:21;s:19:"tests/password.test";i:22;s:15:"tests/path.test";i:23;s:19:"tests/registry.test";i:24;s:17:"tests/schema.test";i:25;s:18:"tests/session.test";i:26;s:20:"tests/tablesort.test";i:27;s:16:"tests/theme.test";i:28;s:18:"tests/unicode.test";i:29;s:17:"tests/update.test";i:30;s:17:"tests/xmlrpc.test";i:31;s:26:"tests/upgrade/upgrade.test";i:32;s:34:"tests/upgrade/upgrade.comment.test";i:33;s:33:"tests/upgrade/upgrade.filter.test";i:34;s:32:"tests/upgrade/upgrade.forum.test";i:35;s:33:"tests/upgrade/upgrade.locale.test";i:36;s:31:"tests/upgrade/upgrade.menu.test";i:37;s:31:"tests/upgrade/upgrade.node.test";i:38;s:35:"tests/upgrade/upgrade.taxonomy.test";i:39;s:39:"tests/upgrade/upgrade.translatable.test";i:40;s:33:"tests/upgrade/upgrade.upload.test";i:41;s:31:"tests/upgrade/upgrade.user.test";}s:9:"configure";s:41:"admin/config/development/testing/settings";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/actions_loop_test.module', 'actions_loop_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:17:"Actions loop test";s:11:"description";s:39:"Support module for action loop testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/ajax_forms_test.module', 'ajax_forms_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:26:"AJAX form test mock module";s:11:"description";s:25:"Test for AJAX form calls.";s:4:"core";s:3:"7.x";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/ajax_test.module', 'ajax_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:9:"AJAX Test";s:11:"description";s:40:"Support module for AJAX framework tests.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/batch_test.module', 'batch_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:14:"Batch API test";s:11:"description";s:35:"Support module for Batch API tests.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/common_test.module', 'common_test', 'module', '', '0', '0', -1, '0', 'a:13:{s:4:"name";s:11:"Common Test";s:11:"description";s:32:"Support module for Common tests.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:1:{s:15:"common_test.css";s:40:"modules/simpletest/tests/common_test.css";}s:5:"print";a:1:{s:21:"common_test.print.css";s:46:"modules/simpletest/tests/common_test.print.css";}}s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/common_test_cron_helper.module', 'common_test_cron_helper', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:23:"Common Test Cron Helper";s:11:"description";s:56:"Helper module for CronRunTestCase::testCronExceptions().";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/database_test.module', 'database_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:13:"Database Test";s:11:"description";s:40:"Support module for Database layer tests.";s:4:"core";s:3:"7.x";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module', 'drupal_system_listing_compatible_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:37:"Drupal system listing compatible test";s:11:"description";s:62:"Support module for testing the drupal_system_listing function.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module', 'drupal_system_listing_incompatible_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:39:"Drupal system listing incompatible test";s:11:"description";s:62:"Support module for testing the drupal_system_listing function.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/entity_cache_test.module', 'entity_cache_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:17:"Entity cache test";s:11:"description";s:40:"Support module for testing entity cache.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:28:"entity_cache_test_dependency";}s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/entity_cache_test_dependency.module', 'entity_cache_test_dependency', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:28:"Entity cache test dependency";s:11:"description";s:51:"Support dependency module for testing entity cache.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/entity_crud_hook_test.module', 'entity_crud_hook_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:22:"Entity CRUD Hooks Test";s:11:"description";s:35:"Support module for CRUD hook tests.";s:4:"core";s:3:"7.x";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/error_test.module', 'error_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:10:"Error test";s:11:"description";s:47:"Support module for error and exception testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/file_test.module', 'file_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:9:"File test";s:11:"description";s:39:"Support module for file handling tests.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:16:"file_test.module";}s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/filter_test.module', 'filter_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:18:"Filter test module";s:11:"description";s:33:"Tests filter hooks and functions.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/form_test.module', 'form_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:12:"FormAPI Test";s:11:"description";s:34:"Support module for Form API tests.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/image_test.module', 'image_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:10:"Image test";s:11:"description";s:39:"Support module for image toolkit tests.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/menu_test.module', 'menu_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:15:"Hook menu tests";s:11:"description";s:37:"Support module for menu hook testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/module_test.module', 'module_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:11:"Module test";s:11:"description";s:41:"Support module for module system testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/requirements1_test.module', 'requirements1_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:19:"Requirements 1 Test";s:11:"description";s:80:"Tests that a module is not installed when it fails hook_requirements(''install'').";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/requirements2_test.module', 'requirements2_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:19:"Requirements 2 Test";s:11:"description";s:98:"Tests that a module is not installed when the one it depends on fails hook_requirements(''install).";s:12:"dependencies";a:2:{i:0;s:18:"requirements1_test";i:1;s:7:"comment";}s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/session_test.module', 'session_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:12:"Session test";s:11:"description";s:40:"Support module for session data testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/system_dependencies_test.module', 'system_dependencies_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:22:"System dependency test";s:11:"description";s:47:"Support module for testing system dependencies.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:12:"dependencies";a:1:{i:0;s:19:"_missing_dependency";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/system_incompatible_core_version_dependencies_test.module', 'system_incompatible_core_version_dependencies_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:50:"System incompatible core version dependencies test";s:11:"description";s:47:"Support module for testing system dependencies.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:12:"dependencies";a:1:{i:0;s:37:"system_incompatible_core_version_test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/system_incompatible_core_version_test.module', 'system_incompatible_core_version_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:37:"System incompatible core version test";s:11:"description";s:47:"Support module for testing system dependencies.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"5.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/system_incompatible_module_version_dependencies_test.module', 'system_incompatible_module_version_dependencies_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:52:"System incompatible module version dependencies test";s:11:"description";s:47:"Support module for testing system dependencies.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:12:"dependencies";a:1:{i:0;s:46:"system_incompatible_module_version_test (>2.0)";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/system_incompatible_module_version_test.module', 'system_incompatible_module_version_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:39:"System incompatible module version test";s:11:"description";s:47:"Support module for testing system dependencies.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/system_test.module', 'system_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:11:"System test";s:11:"description";s:34:"Support module for system testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:18:"system_test.module";}s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/taxonomy_test.module', 'taxonomy_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:20:"Taxonomy test module";s:11:"description";s:45:""Tests functions and hooks not used in core".";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:12:"dependencies";a:1:{i:0;s:8:"taxonomy";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/theme_test.module', 'theme_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:10:"Theme test";s:11:"description";s:40:"Support module for theme system testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/update_script_test.module', 'update_script_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:18:"Update script test";s:11:"description";s:41:"Support module for update script testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/update_test_1.module', 'update_test_1', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:11:"Update test";s:11:"description";s:34:"Support module for update testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/update_test_2.module', 'update_test_2', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:11:"Update test";s:11:"description";s:34:"Support module for update testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/update_test_3.module', 'update_test_3', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:11:"Update test";s:11:"description";s:34:"Support module for update testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/url_alter_test.module', 'url_alter_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:15:"Url_alter tests";s:11:"description";s:45:"A support modules for url_alter hook testing.";s:4:"core";s:3:"7.x";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/simpletest/tests/xmlrpc_test.module', 'xmlrpc_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:12:"XML-RPC Test";s:11:"description";s:75:"Support module for XML-RPC tests according to the validator1 specification.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/statistics/statistics.module', 'statistics', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:10:"Statistics";s:11:"description";s:37:"Logs access statistics for your site.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:15:"statistics.test";}s:9:"configure";s:30:"admin/config/system/statistics";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/syslog/syslog.module', 'syslog', 'module', '', '0', '0', -1, '0', 'a:11:{s:4:"name";s:6:"Syslog";s:11:"description";s:41:"Logs and records system events to syslog.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:11:"syslog.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/system/system.module', 'system', 'module', '', '1', '0', 7072, '0', 'a:13:{s:4:"name";s:6:"System";s:11:"description";s:54:"Handles general site configuration for administrators.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:6:{i:0;s:19:"system.archiver.inc";i:1;s:15:"system.mail.inc";i:2;s:16:"system.queue.inc";i:3;s:14:"system.tar.inc";i:4;s:18:"system.updater.inc";i:5;s:11:"system.test";}s:8:"required";b:1;s:9:"configure";s:19:"admin/config/system";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/taxonomy/taxonomy.module', 'taxonomy', 'module', '', '1', '0', 7010, '0', 'a:14:{s:4:"name";s:8:"Taxonomy";s:11:"description";s:38:"Enables the categorization of content.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:7:"options";}s:5:"files";a:2:{i:0;s:15:"taxonomy.module";i:1;s:13:"taxonomy.test";}s:9:"configure";s:24:"admin/structure/taxonomy";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;s:8:"required";b:1;s:11:"explanation";s:73:"Field type(s) in use - see <a href="/admin/reports/fields">Field list</a>";}'),
('modules/toolbar/toolbar.module', 'toolbar', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:7:"Toolbar";s:11:"description";s:99:"Provides a toolbar that shows the top-level administration menu items and links from other modules.";s:4:"core";s:3:"7.x";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/tracker/tracker.module', 'tracker', 'module', '', '0', '0', -1, '0', 'a:11:{s:4:"name";s:7:"Tracker";s:11:"description";s:45:"Enables tracking of recent content for users.";s:12:"dependencies";a:1:{i:0;s:7:"comment";}s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:12:"tracker.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/translation/tests/translation_test.module', 'translation_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:24:"Content Translation Test";s:11:"description";s:49:"Support module for the content translation tests.";s:4:"core";s:3:"7.x";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/translation/translation.module', 'translation', 'module', '', '0', '0', -1, '0', 'a:11:{s:4:"name";s:19:"Content translation";s:11:"description";s:57:"Allows content to be translated into different languages.";s:12:"dependencies";a:1:{i:0;s:6:"locale";}s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:16:"translation.test";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/trigger/tests/trigger_test.module', 'trigger_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:12:"Trigger Test";s:11:"description";s:33:"Support module for Trigger tests.";s:7:"package";s:7:"Testing";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"version";s:4:"7.12";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/trigger/trigger.module', 'trigger', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:7:"Trigger";s:11:"description";s:90:"Enables actions to be fired on certain system events, such as when new content is created.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:12:"trigger.test";}s:9:"configure";s:23:"admin/structure/trigger";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/update/tests/aaa_update_test.module', 'aaa_update_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:15:"AAA Update test";s:11:"description";s:41:"Support module for update module testing.";s:7:"package";s:7:"Testing";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"version";s:4:"7.12";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/update/tests/bbb_update_test.module', 'bbb_update_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:15:"BBB Update test";s:11:"description";s:41:"Support module for update module testing.";s:7:"package";s:7:"Testing";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"version";s:4:"7.12";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/update/tests/ccc_update_test.module', 'ccc_update_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:15:"CCC Update test";s:11:"description";s:41:"Support module for update module testing.";s:7:"package";s:7:"Testing";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"version";s:4:"7.12";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/update/tests/update_test.module', 'update_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:11:"Update test";s:11:"description";s:41:"Support module for update module testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}');
INSERT INTO `system` VALUES
('modules/update/update.module', 'update', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:14:"Update manager";s:11:"description";s:104:"Checks for available updates, and can securely install or update modules and themes via a web interface.";s:7:"version";s:4:"7.12";s:7:"package";s:4:"Core";s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:11:"update.test";}s:9:"configure";s:30:"admin/reports/updates/settings";s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('modules/user/tests/user_form_test.module', 'user_form_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:22:"User module form tests";s:11:"description";s:37:"Support module for user form testing.";s:7:"package";s:7:"Testing";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:6:"hidden";b:1;s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('modules/user/user.module', 'user', 'module', '', '1', '0', 7017, '0', 'a:14:{s:4:"name";s:4:"User";s:11:"description";s:47:"Manages the user registration and login system.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:5:"files";a:2:{i:0;s:11:"user.module";i:1;s:9:"user.test";}s:8:"required";b:1;s:9:"configure";s:19:"admin/config/people";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:8:"user.css";s:21:"modules/user/user.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('profiles/standard/standard.profile', 'standard', 'module', '', '1', '0', 0, '1000', 'a:14:{s:4:"name";s:8:"Standard";s:11:"description";s:51:"Install with commonly used features pre-configured.";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:12:"dependencies";a:21:{i:0;s:5:"block";i:1;s:5:"color";i:2;s:7:"comment";i:3;s:10:"contextual";i:4;s:9:"dashboard";i:5;s:4:"help";i:6;s:5:"image";i:7;s:4:"list";i:8;s:4:"menu";i:9;s:6:"number";i:10;s:7:"options";i:11;s:4:"path";i:12;s:8:"taxonomy";i:13;s:5:"dblog";i:14;s:6:"search";i:15;s:8:"shortcut";i:16;s:7:"toolbar";i:17;s:7:"overlay";i:18;s:8:"field_ui";i:19;s:4:"file";i:20;s:3:"rdf";}s:5:"files";a:1:{i:0;s:16:"standard.profile";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:7:"package";s:5:"Other";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;s:6:"hidden";b:1;s:8:"required";b:1;s:17:"distribution_name";s:6:"Drupal";}'),
('sites/all/modules/admin/admin.module', 'admin', 'module', '', '0', '0', -1, '0', 'a:11:{s:4:"name";s:5:"Admin";s:11:"description";s:42:"UI helpers for Drupal admins and managers.";s:7:"package";s:14:"Administration";s:4:"core";s:3:"7.x";s:5:"files";a:8:{i:0;s:15:"admin.admin.inc";i:1;s:13:"admin.install";i:2;s:12:"admin.module";i:3;s:24:"includes/admin.devel.inc";i:4;s:24:"includes/admin.theme.inc";i:5;s:25:"theme/admin-panes.tpl.php";i:6;s:27:"theme/admin-toolbar.tpl.php";i:7;s:15:"theme/theme.inc";}s:7:"version";s:13:"7.x-2.0-beta3";s:7:"project";s:5:"admin";s:9:"datestamp";s:10:"1292541646";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('sites/all/modules/ckeditor/ckeditor.module', 'ckeditor', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:8:"CKEditor";s:11:"description";s:76:"Enables CKEditor (WYSIWYG HTML editor) for use instead of plain text fields.";s:4:"core";s:3:"7.x";s:7:"package";s:14:"User interface";s:9:"configure";s:29:"admin/config/content/ckeditor";s:5:"files";a:1:{i:0;s:26:"includes/ckeditor.user.inc";}s:7:"version";s:7:"7.x-1.6";s:7:"project";s:8:"ckeditor";s:9:"datestamp";s:10:"1320880530";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('sites/all/modules/demo/demo.module', 'demo', 'module', '', '1', '0', 6100, '0', 'a:12:{s:4:"name";s:18:"Demonstration site";s:11:"description";s:74:"Create snapshots and reset the site for demonstration or testing purposes.";s:7:"package";s:11:"Development";s:4:"core";s:3:"7.x";s:9:"configure";s:20:"admin/structure/demo";s:5:"files";a:3:{i:0;s:11:"demo.module";i:1;s:14:"demo.admin.inc";i:2;s:23:"database_mysql_dump.inc";}s:7:"version";s:7:"7.x-1.0";s:7:"project";s:4:"demo";s:9:"datestamp";s:10:"1294543925";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('sites/all/modules/demo/demo_reset.module', 'demo_reset', 'module', '', '1', '0', 0, '0', 'a:11:{s:4:"name";s:24:"Demonstration site reset";s:11:"description";s:176:"Allows to reset the site on cron runs and to <strong>reset the site WITHOUT CONFIRMATION.</strong> Only supposed to be used on public demonstration sites. Use at your own risk.";s:7:"package";s:11:"Development";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:4:"demo";}s:5:"files";a:1:{i:0;s:17:"demo_reset.module";}s:7:"version";s:7:"7.x-1.0";s:7:"project";s:4:"demo";s:9:"datestamp";s:10:"1294543925";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('sites/all/modules/devel/devel.module', 'devel', 'module', '', '1', '1', 7003, '88', 'a:13:{s:4:"name";s:5:"Devel";s:11:"description";s:52:"Various blocks, pages, and functions for developers.";s:7:"package";s:11:"Development";s:4:"core";s:3:"7.x";s:9:"configure";s:30:"admin/config/development/devel";s:4:"tags";a:1:{i:0;s:9:"developer";}s:5:"files";a:2:{i:0;s:10:"devel.test";i:1;s:14:"devel.mail.inc";}s:7:"version";s:7:"7.x-1.2";s:7:"project";s:5:"devel";s:9:"datestamp";s:10:"1311355316";s:12:"dependencies";a:0:{}s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('sites/all/modules/devel/devel_generate/devel_generate.module', 'devel_generate', 'module', '', '1', '0', 0, '0', 'a:12:{s:4:"name";s:14:"Devel generate";s:11:"description";s:48:"Generate dummy users, nodes, and taxonomy terms.";s:7:"package";s:11:"Development";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:5:"devel";}s:4:"tags";a:1:{i:0;s:9:"developer";}s:7:"version";s:7:"7.x-1.2";s:7:"project";s:5:"devel";s:9:"datestamp";s:10:"1311355316";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('sites/all/modules/devel/devel_node_access.module', 'devel_node_access', 'module', '', '0', '0', -1, '0', 'a:13:{s:4:"name";s:17:"Devel node access";s:11:"description";s:68:"Developer blocks and page illustrating relevant node_access records.";s:7:"package";s:11:"Development";s:12:"dependencies";a:1:{i:0;s:4:"menu";}s:4:"core";s:3:"7.x";s:9:"configure";s:30:"admin/config/development/devel";s:4:"tags";a:1:{i:0;s:9:"developer";}s:7:"version";s:7:"7.x-1.2";s:7:"project";s:5:"devel";s:9:"datestamp";s:10:"1311355316";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('sites/all/modules/module_filter/module_filter.module', 'module_filter', 'module', '', '1', '0', 7100, '0', 'a:12:{s:4:"name";s:13:"Module filter";s:11:"description";s:24:"Filter the modules list.";s:4:"core";s:3:"7.x";s:5:"files";a:9:{i:0;s:21:"module_filter.install";i:1;s:16:"module_filter.js";i:2;s:20:"module_filter.module";i:3;s:23:"module_filter.admin.inc";i:4;s:23:"module_filter.theme.inc";i:5;s:21:"css/module_filter.css";i:6;s:25:"css/module_filter_tab.css";i:7;s:19:"js/module_filter.js";i:8;s:23:"js/module_filter_tab.js";}s:9:"configure";s:40:"admin/config/user-interface/modulefilter";s:7:"version";s:7:"7.x-1.6";s:7:"project";s:13:"module_filter";s:9:"datestamp";s:10:"1316105205";s:12:"dependencies";a:0:{}s:7:"package";s:5:"Other";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('sites/all/modules/pathauto/pathauto.module', 'pathauto', 'module', '', '0', '0', -1, '0', 'a:13:{s:4:"name";s:8:"Pathauto";s:11:"description";s:95:"Provides a mechanism for modules to automatically generate aliases for the content they manage.";s:12:"dependencies";a:2:{i:0;s:4:"path";i:1;s:5:"token";}s:4:"core";s:3:"7.x";s:5:"files";a:1:{i:0;s:13:"pathauto.test";}s:9:"configure";s:33:"admin/config/search/path/patterns";s:10:"recommends";a:1:{i:0;s:8:"redirect";}s:7:"version";s:7:"7.x-1.0";s:7:"project";s:8:"pathauto";s:9:"datestamp";s:10:"1320072936";s:7:"package";s:5:"Other";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('sites/all/modules/views/tests/views_test.module', 'views_test', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:10:"Views Test";s:11:"description";s:22:"Test module for Views.";s:7:"package";s:5:"Views";s:4:"core";s:3:"7.x";s:12:"dependencies";a:1:{i:0;s:5:"views";}s:6:"hidden";b:1;s:7:"version";s:7:"7.x-3.3";s:7:"project";s:5:"views";s:9:"datestamp";s:10:"1329946249";s:3:"php";s:5:"5.2.4";s:5:"files";a:0:{}s:9:"bootstrap";i:0;}'),
('sites/all/modules/views/views.module', 'views', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:5:"Views";s:11:"description";s:55:"Create customized lists and queries from your database.";s:7:"package";s:5:"Views";s:4:"core";s:3:"7.x";s:3:"php";s:3:"5.2";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:13:"css/views.css";s:37:"sites/all/modules/views/css/views.css";}}s:12:"dependencies";a:1:{i:0;s:6:"ctools";}s:5:"files";a:279:{i:0;s:31:"handlers/views_handler_area.inc";i:1;s:38:"handlers/views_handler_area_result.inc";i:2;s:36:"handlers/views_handler_area_text.inc";i:3;s:36:"handlers/views_handler_area_view.inc";i:4;s:35:"handlers/views_handler_argument.inc";i:5;s:40:"handlers/views_handler_argument_date.inc";i:6;s:43:"handlers/views_handler_argument_formula.inc";i:7;s:47:"handlers/views_handler_argument_many_to_one.inc";i:8;s:40:"handlers/views_handler_argument_null.inc";i:9;s:43:"handlers/views_handler_argument_numeric.inc";i:10;s:42:"handlers/views_handler_argument_string.inc";i:11;s:52:"handlers/views_handler_argument_group_by_numeric.inc";i:12;s:32:"handlers/views_handler_field.inc";i:13;s:40:"handlers/views_handler_field_counter.inc";i:14;s:40:"handlers/views_handler_field_boolean.inc";i:15;s:49:"handlers/views_handler_field_contextual_links.inc";i:16;s:39:"handlers/views_handler_field_custom.inc";i:17;s:37:"handlers/views_handler_field_date.inc";i:18;s:39:"handlers/views_handler_field_entity.inc";i:19;s:39:"handlers/views_handler_field_markup.inc";i:20;s:37:"handlers/views_handler_field_math.inc";i:21;s:40:"handlers/views_handler_field_numeric.inc";i:22;s:47:"handlers/views_handler_field_prerender_list.inc";i:23;s:46:"handlers/views_handler_field_time_interval.inc";i:24;s:43:"handlers/views_handler_field_serialized.inc";i:25;s:45:"handlers/views_handler_field_machine_name.inc";i:26;s:36:"handlers/views_handler_field_url.inc";i:27;s:33:"handlers/views_handler_filter.inc";i:28;s:50:"handlers/views_handler_filter_boolean_operator.inc";i:29;s:57:"handlers/views_handler_filter_boolean_operator_string.inc";i:30;s:38:"handlers/views_handler_filter_date.inc";i:31;s:42:"handlers/views_handler_filter_equality.inc";i:32;s:50:"handlers/views_handler_filter_group_by_numeric.inc";i:33;s:45:"handlers/views_handler_filter_in_operator.inc";i:34;s:45:"handlers/views_handler_filter_many_to_one.inc";i:35;s:41:"handlers/views_handler_filter_numeric.inc";i:36;s:40:"handlers/views_handler_filter_string.inc";i:37;s:39:"handlers/views_handler_relationship.inc";i:38;s:53:"handlers/views_handler_relationship_groupwise_max.inc";i:39;s:31:"handlers/views_handler_sort.inc";i:40;s:36:"handlers/views_handler_sort_date.inc";i:41;s:39:"handlers/views_handler_sort_formula.inc";i:42;s:48:"handlers/views_handler_sort_group_by_numeric.inc";i:43;s:46:"handlers/views_handler_sort_menu_hierarchy.inc";i:44;s:38:"handlers/views_handler_sort_random.inc";i:45;s:17:"includes/base.inc";i:46;s:21:"includes/handlers.inc";i:47;s:20:"includes/plugins.inc";i:48;s:17:"includes/view.inc";i:49;s:60:"modules/aggregator/views_handler_argument_aggregator_fid.inc";i:50;s:60:"modules/aggregator/views_handler_argument_aggregator_iid.inc";i:51;s:69:"modules/aggregator/views_handler_argument_aggregator_category_cid.inc";i:52;s:64:"modules/aggregator/views_handler_field_aggregator_title_link.inc";i:53;s:62:"modules/aggregator/views_handler_field_aggregator_category.inc";i:54;s:70:"modules/aggregator/views_handler_field_aggregator_item_description.inc";i:55;s:57:"modules/aggregator/views_handler_field_aggregator_xss.inc";i:56;s:67:"modules/aggregator/views_handler_filter_aggregator_category_cid.inc";i:57;s:54:"modules/aggregator/views_plugin_row_aggregator_rss.inc";i:58;s:59:"modules/comment/views_handler_argument_comment_user_uid.inc";i:59;s:47:"modules/comment/views_handler_field_comment.inc";i:60;s:53:"modules/comment/views_handler_field_comment_depth.inc";i:61;s:52:"modules/comment/views_handler_field_comment_link.inc";i:62;s:60:"modules/comment/views_handler_field_comment_link_approve.inc";i:63;s:59:"modules/comment/views_handler_field_comment_link_delete.inc";i:64;s:57:"modules/comment/views_handler_field_comment_link_edit.inc";i:65;s:58:"modules/comment/views_handler_field_comment_link_reply.inc";i:66;s:57:"modules/comment/views_handler_field_comment_node_link.inc";i:67;s:56:"modules/comment/views_handler_field_comment_username.inc";i:68;s:61:"modules/comment/views_handler_field_ncs_last_comment_name.inc";i:69;s:56:"modules/comment/views_handler_field_ncs_last_updated.inc";i:70;s:52:"modules/comment/views_handler_field_node_comment.inc";i:71;s:57:"modules/comment/views_handler_field_node_new_comments.inc";i:72;s:62:"modules/comment/views_handler_field_last_comment_timestamp.inc";i:73;s:57:"modules/comment/views_handler_filter_comment_user_uid.inc";i:74;s:57:"modules/comment/views_handler_filter_ncs_last_updated.inc";i:75;s:53:"modules/comment/views_handler_filter_node_comment.inc";i:76;s:53:"modules/comment/views_handler_sort_comment_thread.inc";i:77;s:60:"modules/comment/views_handler_sort_ncs_last_comment_name.inc";i:78;s:55:"modules/comment/views_handler_sort_ncs_last_updated.inc";i:79;s:48:"modules/comment/views_plugin_row_comment_rss.inc";i:80;s:49:"modules/comment/views_plugin_row_comment_view.inc";i:81;s:52:"modules/contact/views_handler_field_contact_link.inc";i:82;s:43:"modules/field/views_handler_field_field.inc";i:83;s:59:"modules/field/views_handler_relationship_entity_reverse.inc";i:84;s:51:"modules/field/views_handler_argument_field_list.inc";i:85;s:49:"modules/field/views_handler_filter_field_list.inc";i:86;s:57:"modules/filter/views_handler_field_filter_format_name.inc";i:87;s:54:"modules/locale/views_handler_argument_locale_group.inc";i:88;s:57:"modules/locale/views_handler_argument_locale_language.inc";i:89;s:51:"modules/locale/views_handler_field_locale_group.inc";i:90;s:54:"modules/locale/views_handler_field_locale_language.inc";i:91;s:55:"modules/locale/views_handler_field_locale_link_edit.inc";i:92;s:52:"modules/locale/views_handler_filter_locale_group.inc";i:93;s:55:"modules/locale/views_handler_filter_locale_language.inc";i:94;s:54:"modules/locale/views_handler_filter_locale_version.inc";i:95;s:53:"modules/node/views_handler_argument_dates_various.inc";i:96;s:53:"modules/node/views_handler_argument_node_language.inc";i:97;s:48:"modules/node/views_handler_argument_node_nid.inc";i:98;s:49:"modules/node/views_handler_argument_node_type.inc";i:99;s:48:"modules/node/views_handler_argument_node_vid.inc";i:100;s:57:"modules/node/views_handler_argument_node_uid_revision.inc";i:101;s:59:"modules/node/views_handler_field_history_user_timestamp.inc";i:102;s:41:"modules/node/views_handler_field_node.inc";i:103;s:46:"modules/node/views_handler_field_node_link.inc";i:104;s:53:"modules/node/views_handler_field_node_link_delete.inc";i:105;s:51:"modules/node/views_handler_field_node_link_edit.inc";i:106;s:50:"modules/node/views_handler_field_node_revision.inc";i:107;s:62:"modules/node/views_handler_field_node_revision_link_delete.inc";i:108;s:62:"modules/node/views_handler_field_node_revision_link_revert.inc";i:109;s:46:"modules/node/views_handler_field_node_path.inc";i:110;s:46:"modules/node/views_handler_field_node_type.inc";i:111;s:60:"modules/node/views_handler_filter_history_user_timestamp.inc";i:112;s:49:"modules/node/views_handler_filter_node_access.inc";i:113;s:49:"modules/node/views_handler_filter_node_status.inc";i:114;s:47:"modules/node/views_handler_filter_node_type.inc";i:115;s:55:"modules/node/views_handler_filter_node_uid_revision.inc";i:116;s:51:"modules/node/views_plugin_argument_default_node.inc";i:117;s:52:"modules/node/views_plugin_argument_validate_node.inc";i:118;s:42:"modules/node/views_plugin_row_node_rss.inc";i:119;s:43:"modules/node/views_plugin_row_node_view.inc";i:120;s:52:"modules/profile/views_handler_field_profile_date.inc";i:121;s:52:"modules/profile/views_handler_field_profile_list.inc";i:122;s:58:"modules/profile/views_handler_filter_profile_selection.inc";i:123;s:48:"modules/search/views_handler_argument_search.inc";i:124;s:51:"modules/search/views_handler_field_search_score.inc";i:125;s:46:"modules/search/views_handler_filter_search.inc";i:126;s:50:"modules/search/views_handler_sort_search_score.inc";i:127;s:47:"modules/search/views_plugin_row_search_view.inc";i:128;s:57:"modules/statistics/views_handler_field_accesslog_path.inc";i:129;s:50:"modules/system/views_handler_argument_file_fid.inc";i:130;s:43:"modules/system/views_handler_field_file.inc";i:131;s:53:"modules/system/views_handler_field_file_extension.inc";i:132;s:52:"modules/system/views_handler_field_file_filemime.inc";i:133;s:47:"modules/system/views_handler_field_file_uri.inc";i:134;s:50:"modules/system/views_handler_field_file_status.inc";i:135;s:51:"modules/system/views_handler_filter_file_status.inc";i:136;s:52:"modules/taxonomy/views_handler_argument_taxonomy.inc";i:137;s:57:"modules/taxonomy/views_handler_argument_term_node_tid.inc";i:138;s:63:"modules/taxonomy/views_handler_argument_term_node_tid_depth.inc";i:139;s:72:"modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc";i:140;s:58:"modules/taxonomy/views_handler_argument_vocabulary_vid.inc";i:141;s:67:"modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc";i:142;s:49:"modules/taxonomy/views_handler_field_taxonomy.inc";i:143;s:54:"modules/taxonomy/views_handler_field_term_node_tid.inc";i:144;s:55:"modules/taxonomy/views_handler_field_term_link_edit.inc";i:145;s:55:"modules/taxonomy/views_handler_filter_term_node_tid.inc";i:146;s:61:"modules/taxonomy/views_handler_filter_term_node_tid_depth.inc";i:147;s:56:"modules/taxonomy/views_handler_filter_vocabulary_vid.inc";i:148;s:65:"modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc";i:149;s:62:"modules/taxonomy/views_handler_relationship_node_term_data.inc";i:150;s:65:"modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc";i:151;s:63:"modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc";i:152;s:51:"modules/system/views_handler_filter_system_type.inc";i:153;s:56:"modules/translation/views_handler_argument_node_tnid.inc";i:154;s:57:"modules/translation/views_handler_field_node_language.inc";i:155;s:63:"modules/translation/views_handler_field_node_link_translate.inc";i:156;s:65:"modules/translation/views_handler_field_node_translation_link.inc";i:157;s:58:"modules/translation/views_handler_filter_node_language.inc";i:158;s:54:"modules/translation/views_handler_filter_node_tnid.inc";i:159;s:60:"modules/translation/views_handler_filter_node_tnid_child.inc";i:160;s:62:"modules/translation/views_handler_relationship_translation.inc";i:161;s:57:"modules/upload/views_handler_field_upload_description.inc";i:162;s:49:"modules/upload/views_handler_field_upload_fid.inc";i:163;s:50:"modules/upload/views_handler_filter_upload_fid.inc";i:164;s:48:"modules/user/views_handler_argument_user_uid.inc";i:165;s:55:"modules/user/views_handler_argument_users_roles_rid.inc";i:166;s:41:"modules/user/views_handler_field_user.inc";i:167;s:50:"modules/user/views_handler_field_user_language.inc";i:168;s:46:"modules/user/views_handler_field_user_link.inc";i:169;s:53:"modules/user/views_handler_field_user_link_cancel.inc";i:170;s:51:"modules/user/views_handler_field_user_link_edit.inc";i:171;s:46:"modules/user/views_handler_field_user_mail.inc";i:172;s:46:"modules/user/views_handler_field_user_name.inc";i:173;s:53:"modules/user/views_handler_field_user_permissions.inc";i:174;s:49:"modules/user/views_handler_field_user_picture.inc";i:175;s:47:"modules/user/views_handler_field_user_roles.inc";i:176;s:50:"modules/user/views_handler_filter_user_current.inc";i:177;s:47:"modules/user/views_handler_filter_user_name.inc";i:178;s:54:"modules/user/views_handler_filter_user_permissions.inc";i:179;s:48:"modules/user/views_handler_filter_user_roles.inc";i:180;s:59:"modules/user/views_plugin_argument_default_current_user.inc";i:181;s:51:"modules/user/views_plugin_argument_default_user.inc";i:182;s:52:"modules/user/views_plugin_argument_validate_user.inc";i:183;s:43:"modules/user/views_plugin_row_user_view.inc";i:184;s:31:"plugins/views_plugin_access.inc";i:185;s:36:"plugins/views_plugin_access_none.inc";i:186;s:36:"plugins/views_plugin_access_perm.inc";i:187;s:36:"plugins/views_plugin_access_role.inc";i:188;s:41:"plugins/views_plugin_argument_default.inc";i:189;s:45:"plugins/views_plugin_argument_default_php.inc";i:190;s:47:"plugins/views_plugin_argument_default_fixed.inc";i:191;s:45:"plugins/views_plugin_argument_default_raw.inc";i:192;s:42:"plugins/views_plugin_argument_validate.inc";i:193;s:50:"plugins/views_plugin_argument_validate_numeric.inc";i:194;s:46:"plugins/views_plugin_argument_validate_php.inc";i:195;s:30:"plugins/views_plugin_cache.inc";i:196;s:35:"plugins/views_plugin_cache_none.inc";i:197;s:35:"plugins/views_plugin_cache_time.inc";i:198;s:32:"plugins/views_plugin_display.inc";i:199;s:43:"plugins/views_plugin_display_attachment.inc";i:200;s:38:"plugins/views_plugin_display_block.inc";i:201;s:40:"plugins/views_plugin_display_default.inc";i:202;s:38:"plugins/views_plugin_display_embed.inc";i:203;s:41:"plugins/views_plugin_display_extender.inc";i:204;s:37:"plugins/views_plugin_display_feed.inc";i:205;s:37:"plugins/views_plugin_display_page.inc";i:206;s:43:"plugins/views_plugin_exposed_form_basic.inc";i:207;s:37:"plugins/views_plugin_exposed_form.inc";i:208;s:52:"plugins/views_plugin_exposed_form_input_required.inc";i:209;s:42:"plugins/views_plugin_localization_core.inc";i:210;s:37:"plugins/views_plugin_localization.inc";i:211;s:42:"plugins/views_plugin_localization_none.inc";i:212;s:30:"plugins/views_plugin_pager.inc";i:213;s:35:"plugins/views_plugin_pager_full.inc";i:214;s:35:"plugins/views_plugin_pager_mini.inc";i:215;s:35:"plugins/views_plugin_pager_none.inc";i:216;s:35:"plugins/views_plugin_pager_some.inc";i:217;s:30:"plugins/views_plugin_query.inc";i:218;s:38:"plugins/views_plugin_query_default.inc";i:219;s:28:"plugins/views_plugin_row.inc";i:220;s:35:"plugins/views_plugin_row_fields.inc";i:221;s:30:"plugins/views_plugin_style.inc";i:222;s:38:"plugins/views_plugin_style_default.inc";i:223;s:35:"plugins/views_plugin_style_grid.inc";i:224;s:35:"plugins/views_plugin_style_list.inc";i:225;s:40:"plugins/views_plugin_style_jump_menu.inc";i:226;s:34:"plugins/views_plugin_style_rss.inc";i:227;s:38:"plugins/views_plugin_style_summary.inc";i:228;s:48:"plugins/views_plugin_style_summary_jump_menu.inc";i:229;s:50:"plugins/views_plugin_style_summary_unformatted.inc";i:230;s:36:"plugins/views_plugin_style_table.inc";i:231;s:43:"tests/handlers/views_handler_area_text.test";i:232;s:47:"tests/handlers/views_handler_argument_null.test";i:233;s:39:"tests/handlers/views_handler_field.test";i:234;s:47:"tests/handlers/views_handler_field_boolean.test";i:235;s:46:"tests/handlers/views_handler_field_custom.test";i:236;s:47:"tests/handlers/views_handler_field_counter.test";i:237;s:44:"tests/handlers/views_handler_field_date.test";i:238;s:49:"tests/handlers/views_handler_field_file_size.test";i:239;s:44:"tests/handlers/views_handler_field_math.test";i:240;s:43:"tests/handlers/views_handler_field_url.test";i:241;s:43:"tests/handlers/views_handler_field_xss.test";i:242;s:45:"tests/handlers/views_handler_filter_date.test";i:243;s:49:"tests/handlers/views_handler_filter_equality.test";i:244;s:52:"tests/handlers/views_handler_filter_in_operator.test";i:245;s:48:"tests/handlers/views_handler_filter_numeric.test";i:246;s:47:"tests/handlers/views_handler_filter_string.test";i:247;s:45:"tests/handlers/views_handler_sort_random.test";i:248;s:43:"tests/handlers/views_handler_sort_date.test";i:249;s:38:"tests/handlers/views_handler_sort.test";i:250;s:60:"tests/test_plugins/views_test_plugin_access_test_dynamic.inc";i:251;s:59:"tests/test_plugins/views_test_plugin_access_test_static.inc";i:252;s:46:"tests/styles/views_plugin_style_jump_menu.test";i:253;s:36:"tests/styles/views_plugin_style.test";i:254;s:23:"tests/views_access.test";i:255;s:24:"tests/views_analyze.test";i:256;s:22:"tests/views_basic.test";i:257;s:33:"tests/views_argument_default.test";i:258;s:35:"tests/views_argument_validator.test";i:259;s:29:"tests/views_exposed_form.test";i:260;s:25:"tests/views_glossary.test";i:261;s:24:"tests/views_groupby.test";i:262;s:25:"tests/views_handlers.test";i:263;s:23:"tests/views_module.test";i:264;s:22:"tests/views_pager.test";i:265;s:40:"tests/views_plugin_localization_test.inc";i:266;s:29:"tests/views_translatable.test";i:267;s:22:"tests/views_query.test";i:268;s:24:"tests/views_upgrade.test";i:269;s:34:"tests/views_test.views_default.inc";i:270;s:58:"tests/comment/views_handler_argument_comment_user_uid.test";i:271;s:56:"tests/comment/views_handler_filter_comment_user_uid.test";i:272;s:45:"tests/user/views_handler_field_user_name.test";i:273;s:43:"tests/user/views_user_argument_default.test";i:274;s:44:"tests/user/views_user_argument_validate.test";i:275;s:26:"tests/user/views_user.test";i:276;s:22:"tests/views_cache.test";i:277;s:21:"tests/views_view.test";i:278;s:19:"tests/views_ui.test";}s:7:"version";s:7:"7.x-3.3";s:7:"project";s:5:"views";s:9:"datestamp";s:10:"1329946249";s:9:"bootstrap";i:0;}'),
('sites/all/modules/views/views_ui.module', 'views_ui', 'module', '', '0', '0', -1, '0', 'a:12:{s:4:"name";s:8:"Views UI";s:11:"description";s:93:"Administrative interface to views. Without this module, you cannot create or edit your views.";s:7:"package";s:5:"Views";s:4:"core";s:3:"7.x";s:9:"configure";s:21:"admin/structure/views";s:12:"dependencies";a:1:{i:0;s:5:"views";}s:5:"files";a:2:{i:0;s:15:"views_ui.module";i:1;s:57:"plugins/views_wizard/views_ui_base_views_wizard.class.php";}s:7:"version";s:7:"7.x-3.3";s:7:"project";s:5:"views";s:9:"datestamp";s:10:"1329946249";s:3:"php";s:5:"5.2.4";s:9:"bootstrap";i:0;}'),
('themes/bartik/bartik.info', 'bartik', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '1', '0', -1, '0', 'a:18:{s:4:"name";s:6:"Bartik";s:11:"description";s:48:"A flexible, recolorable theme with many regions.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:3:{s:14:"css/layout.css";s:28:"themes/bartik/css/layout.css";s:13:"css/style.css";s:27:"themes/bartik/css/style.css";s:14:"css/colors.css";s:28:"themes/bartik/css/colors.css";}s:5:"print";a:1:{s:13:"css/print.css";s:27:"themes/bartik/css/print.css";}}s:7:"regions";a:20:{s:6:"header";s:6:"Header";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:11:"highlighted";s:11:"Highlighted";s:8:"featured";s:8:"Featured";s:7:"content";s:7:"Content";s:13:"sidebar_first";s:13:"Sidebar first";s:14:"sidebar_second";s:14:"Sidebar second";s:14:"triptych_first";s:14:"Triptych first";s:15:"triptych_middle";s:15:"Triptych middle";s:13:"triptych_last";s:13:"Triptych last";s:18:"footer_firstcolumn";s:19:"Footer first column";s:19:"footer_secondcolumn";s:20:"Footer second column";s:18:"footer_thirdcolumn";s:19:"Footer third column";s:19:"footer_fourthcolumn";s:20:"Footer fourth column";s:6:"footer";s:6:"Footer";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"settings";a:1:{s:20:"shortcut_module_link";s:1:"0";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:28:"themes/bartik/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}'),
('themes/garland/garland.info', 'garland', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '0', '0', -1, '0', 'a:18:{s:4:"name";s:7:"Garland";s:11:"description";s:111:"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:2:{s:3:"all";a:1:{s:9:"style.css";s:24:"themes/garland/style.css";}s:5:"print";a:1:{s:9:"print.css";s:24:"themes/garland/print.css";}}s:8:"settings";a:1:{s:13:"garland_width";s:5:"fluid";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:7:"regions";a:12:{s:13:"sidebar_first";s:12:"Left sidebar";s:14:"sidebar_second";s:13:"Right sidebar";s:7:"content";s:7:"Content";s:6:"header";s:6:"Header";s:6:"footer";s:6:"Footer";s:11:"highlighted";s:11:"Highlighted";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:29:"themes/garland/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}'),
('themes/seven/seven.info', 'seven', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '1', '0', -1, '0', 'a:18:{s:4:"name";s:5:"Seven";s:11:"description";s:65:"A simple one-column, tableless, fluid width administration theme.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:1:{s:6:"screen";a:2:{s:9:"reset.css";s:22:"themes/seven/reset.css";s:9:"style.css";s:22:"themes/seven/style.css";}}s:8:"settings";a:1:{s:20:"shortcut_module_link";s:1:"1";}s:7:"regions";a:8:{s:7:"content";s:7:"Content";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:13:"sidebar_first";s:13:"First sidebar";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:14:"regions_hidden";a:3:{i:0;s:13:"sidebar_first";i:1;s:8:"page_top";i:2;s:11:"page_bottom";}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:27:"themes/seven/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}'),
('themes/stark/stark.info', 'stark', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '0', '0', -1, '0', 'a:17:{s:4:"name";s:5:"Stark";s:11:"description";s:208:"This theme demonstrates Drupal''s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal''s default code, see the <a href="http://drupal.org/theme-guide">Theming Guide</a>.";s:7:"package";s:4:"Core";s:7:"version";s:4:"7.12";s:4:"core";s:3:"7.x";s:11:"stylesheets";a:1:{s:3:"all";a:1:{s:10:"layout.css";s:23:"themes/stark/layout.css";}}s:7:"project";s:6:"drupal";s:9:"datestamp";s:10:"1328134560";s:6:"engine";s:11:"phptemplate";s:7:"regions";a:12:{s:13:"sidebar_first";s:12:"Left sidebar";s:14:"sidebar_second";s:13:"Right sidebar";s:7:"content";s:7:"Content";s:6:"header";s:6:"Header";s:6:"footer";s:6:"Footer";s:11:"highlighted";s:11:"Highlighted";s:4:"help";s:4:"Help";s:8:"page_top";s:8:"Page top";s:11:"page_bottom";s:11:"Page bottom";s:14:"dashboard_main";s:16:"Dashboard (main)";s:17:"dashboard_sidebar";s:19:"Dashboard (sidebar)";s:18:"dashboard_inactive";s:20:"Dashboard (inactive)";}s:8:"features";a:9:{i:0;s:4:"logo";i:1;s:7:"favicon";i:2;s:4:"name";i:3;s:6:"slogan";i:4;s:17:"node_user_picture";i:5;s:20:"comment_user_picture";i:6;s:25:"comment_user_verification";i:7;s:9:"main_menu";i:8;s:14:"secondary_menu";}s:10:"screenshot";s:27:"themes/stark/screenshot.png";s:3:"php";s:5:"5.2.4";s:7:"scripts";a:0:{}s:15:"overlay_regions";a:5:{i:0;s:14:"dashboard_main";i:1;s:17:"dashboard_sidebar";i:2;s:18:"dashboard_inactive";i:3;s:7:"content";i:4;s:4:"help";}s:14:"regions_hidden";a:2:{i:0;s:8:"page_top";i:1;s:11:"page_bottom";}s:28:"overlay_supplemental_regions";a:1:{i:0;s:8:"page_top";}}');
/*!40000 ALTER TABLE system ENABLE KEYS */;

--
-- Table structure for table 'taxonomy_index'
--

CREATE TABLE IF NOT EXISTS `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Maintains denormalized information about node/term...';

--
-- Dumping data for table 'taxonomy_index'
--

/*!40000 ALTER TABLE taxonomy_index DISABLE KEYS */;
INSERT INTO `taxonomy_index` VALUES
('2', '5', '0', '1331574365'),
('27', '5', '0', '1330126442'),
('27', '9', '0', '1330126442'),
('28', '5', '0', '1329872515'),
('28', '6', '0', '1329872515'),
('29', '5', '0', '1329985661'),
('29', '6', '0', '1329985661'),
('30', '5', '0', '1329252976'),
('30', '10', '0', '1329252976'),
('31', '5', '0', '1329353650'),
('31', '6', '0', '1329353650'),
('32', '5', '0', '1331345127'),
('32', '8', '0', '1331345127'),
('33', '5', '0', '1329900144'),
('33', '6', '0', '1329900144'),
('34', '5', '0', '1331050751'),
('34', '9', '0', '1331050751'),
('35', '5', '0', '1330001654'),
('35', '6', '0', '1330001654'),
('36', '5', '0', '1330403466'),
('36', '8', '0', '1330403466'),
('37', '5', '0', '1331527564'),
('37', '6', '0', '1331527564'),
('38', '5', '0', '1330689814'),
('38', '7', '0', '1330689814'),
('39', '5', '0', '1329645032'),
('39', '6', '0', '1329645032'),
('40', '5', '0', '1331075063'),
('40', '10', '0', '1331075063'),
('41', '5', '0', '1330238212'),
('41', '6', '0', '1330238212'),
('42', '5', '0', '1331081742'),
('42', '6', '0', '1331081742'),
('43', '5', '0', '1330596709'),
('43', '6', '0', '1330596709'),
('44', '5', '0', '1331468534'),
('44', '6', '0', '1331468534'),
('45', '5', '0', '1330073747'),
('45', '6', '0', '1330073747'),
('46', '5', '0', '1331012992'),
('46', '6', '0', '1331012992'),
('47', '5', '0', '1330251381'),
('47', '6', '0', '1330251381'),
('48', '5', '0', '1330574602'),
('48', '6', '0', '1330574602'),
('49', '5', '0', '1331148018'),
('49', '6', '0', '1331148018'),
('50', '5', '0', '1329085967'),
('50', '6', '0', '1329085967'),
('51', '5', '0', '1329821183'),
('51', '7', '0', '1329821183');
/*!40000 ALTER TABLE taxonomy_index ENABLE KEYS */;

--
-- Table structure for table 'taxonomy_term_data'
--

CREATE TABLE IF NOT EXISTS `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores term information.';

--
-- Dumping data for table 'taxonomy_term_data'
--

/*!40000 ALTER TABLE taxonomy_term_data DISABLE KEYS */;
INSERT INTO `taxonomy_term_data` VALUES
('1', '2', 'Sports', 'Sports news at Drupal High - keep up with the "Blue Drops"!', 'filtered_html', '4'),
('2', '2', 'Scholastic', 'Learn by the Drop - hey it''s why you''re here!', 'filtered_html', '3'),
('3', '2', 'Clubs', 'The extracurricular side of Drupal', 'filtered_html', '2'),
('4', '2', 'Arts & Music', 'Drupal Drupal Drupal Drupal Druuuupal...', 'filtered_html', '1'),
('5', '2', 'General Announcements', 'A home for all announcements', 'filtered_html', '0'),
('6', '3', '2010', '', 'filtered_html', '0'),
('7', '3', '2011', '', 'filtered_html', '0'),
('8', '3', '2012', '', 'filtered_html', '0'),
('9', '3', '2013', '', 'filtered_html', '0'),
('10', '3', '2014', '', 'filtered_html', '0');
/*!40000 ALTER TABLE taxonomy_term_data ENABLE KEYS */;

--
-- Table structure for table 'taxonomy_term_hierarchy'
--

CREATE TABLE IF NOT EXISTS `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores the hierarchical relationship between terms.';

--
-- Dumping data for table 'taxonomy_term_hierarchy'
--

/*!40000 ALTER TABLE taxonomy_term_hierarchy DISABLE KEYS */;
INSERT INTO `taxonomy_term_hierarchy` VALUES
('1', '0'),
('2', '0'),
('3', '0'),
('4', '0'),
('5', '0'),
('6', '0'),
('7', '0'),
('8', '0'),
('9', '0'),
('10', '0');
/*!40000 ALTER TABLE taxonomy_term_hierarchy ENABLE KEYS */;

--
-- Table structure for table 'taxonomy_vocabulary'
--

CREATE TABLE IF NOT EXISTS `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores vocabulary information.';

--
-- Dumping data for table 'taxonomy_vocabulary'
--

/*!40000 ALTER TABLE taxonomy_vocabulary DISABLE KEYS */;
INSERT INTO `taxonomy_vocabulary` VALUES
('1', 'Tags', 'tags', 'Use tags to group articles on similar topics into categories.', '0', 'taxonomy', '0'),
('2', 'News Section', 'news_section', 'Which news section should this story be published in?', '0', 'taxonomy', '0'),
('3', 'School Year', 'school_year', 'To which school year does a content item apply', '0', 'taxonomy', '0');
/*!40000 ALTER TABLE taxonomy_vocabulary ENABLE KEYS */;

--
-- Table structure for table 'url_alias'
--

CREATE TABLE IF NOT EXISTS `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of URL aliases for Drupal paths; a user may visit...';

--
-- Dumping data for table 'url_alias'
--

/*!40000 ALTER TABLE url_alias DISABLE KEYS */;
/*!40000 ALTER TABLE url_alias ENABLE KEYS */;

--
-- Table structure for table 'users'
--

CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores user data.';

--
-- Dumping data for table 'users'
--

/*!40000 ALTER TABLE users DISABLE KEYS */;
INSERT INTO `users` VALUES
('0', '', '', '', '', '', NULL, '0', '0', '0', '0', NULL, '', '0', '', NULL),
('1', 'demo', '$S$DUuVkBoYpqU4hDCXsT6SEP/1paLNNXIZbQjtCZxUJ0JsI9a6J2Ui', 'demo.119x@bleen.net', '', '', NULL, '1331568466', '1331586378', '1331580686', '1', 'America/New_York', '', '0', 'demo.119x@bleen.net', 'b:0;');
/*!40000 ALTER TABLE users ENABLE KEYS */;

--
-- Table structure for table 'users_roles'
--

CREATE TABLE IF NOT EXISTS `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Maps users to roles.';

--
-- Dumping data for table 'users_roles'
--

/*!40000 ALTER TABLE users_roles DISABLE KEYS */;
INSERT INTO `users_roles` VALUES
('1', '3');
/*!40000 ALTER TABLE users_roles ENABLE KEYS */;

--
-- Table structure for table 'variable'
--

CREATE TABLE IF NOT EXISTS `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Named variable/value pairs created by Drupal core or any...';

--
-- Dumping data for table 'variable'
--

/*!40000 ALTER TABLE variable DISABLE KEYS */;
INSERT INTO `variable` VALUES
('admin_theme', 's:5:"seven";'),
('clean_url', 's:1:"1";'),
('comment_page', 'i:0;'),
('cron_key', 's:43:"dcGbzX_rlveu71PLnhqYoSb31fkK_tkRxn3bcmPNS-4";'),
('cron_last', 'i:1331580033;'),
('css_js_query_string', 's:6:"m0si9u";'),
('date_default_timezone', 's:16:"America/New_York";'),
('default_nodes_main', 's:2:"10";'),
('drupal_http_request_fails', 'b:0;'),
('drupal_private_key', 's:43:"Z4m7cRt7XuiLV3VzytHv7KFoiWnMTHNLU7UlexkgyrI";'),
('field_bundle_settings', 'a:1:{s:4:"node";a:1:{s:7:"article";a:2:{s:10:"view_modes";a:0:{}s:12:"extra_fields";a:2:{s:4:"form";a:1:{s:5:"title";a:1:{s:6:"weight";s:1:"0";}}s:7:"display";a:0:{}}}}}'),
('file_default_scheme', 's:6:"public";'),
('file_private_path', 's:27:"sites/default/private-files";'),
('file_public_path', 's:19:"sites/default/files";'),
('file_temporary_path', 's:4:"/tmp";'),
('filter_fallback_format', 's:10:"plain_text";'),
('install_profile', 's:8:"standard";'),
('install_task', 's:4:"done";'),
('install_time', 'i:1331568544;'),
('menu_expanded', 'a:0:{}'),
('menu_main_links_source', 's:9:"main-menu";'),
('menu_masks', 'a:35:{i:0;i:501;i:1;i:493;i:2;i:250;i:3;i:247;i:4;i:246;i:5;i:245;i:6;i:125;i:7;i:123;i:8;i:122;i:9;i:121;i:10;i:117;i:11;i:63;i:12;i:62;i:13;i:61;i:14;i:60;i:15;i:59;i:16;i:58;i:17;i:44;i:18;i:31;i:19;i:30;i:20;i:29;i:21;i:28;i:22;i:27;i:23;i:24;i:24;i:21;i:25;i:15;i:26;i:14;i:27;i:13;i:28;i:11;i:29;i:7;i:30;i:6;i:31;i:5;i:32;i:3;i:33;i:2;i:34;i:1;}'),
('menu_secondary_links_source', 's:9:"main-menu";'),
('node_admin_theme', 's:1:"1";'),
('node_cron_last', 's:10:"1331579025";'),
('node_options_page', 'a:1:{i:0;s:6:"status";}'),
('node_submitted_page', 'b:0;'),
('path_alias_whitelist', 'a:0:{}'),
('site_403', 's:0:"";'),
('site_404', 's:0:"";'),
('site_default_country', 's:2:"US";'),
('site_frontpage', 's:4:"node";'),
('site_mail', 's:19:"demo.119x@bleen.net";'),
('site_name', 's:11:"Drupal High";'),
('site_slogan', 's:97:"Our slogan at Drupal High School is to development the next generation of leaders Drupal Leaders!";'),
('theme_default', 's:6:"bartik";'),
('user_admin_role', 's:1:"3";'),
('user_block_max_list_count', 's:2:"10";'),
('user_block_seconds_online', 's:3:"900";'),
('user_block_whois_new_count', 's:1:"5";'),
('user_pictures', 's:1:"1";'),
('user_picture_dimensions', 's:9:"1024x1024";'),
('user_picture_file_size', 's:3:"800";'),
('user_picture_style', 's:9:"thumbnail";'),
('user_register', 'i:2;');
/*!40000 ALTER TABLE variable ENABLE KEYS */;

--
-- Table structure for table 'watchdog'
--

CREATE TABLE IF NOT EXISTS `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example `user` or `page not found.`',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Table that contains logs of all system events.';

SET FOREIGN_KEY_CHECKS = 1;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION;

